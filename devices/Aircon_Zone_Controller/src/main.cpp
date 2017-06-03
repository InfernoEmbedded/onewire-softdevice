#include "mbed.h"

#include <ACZoneController.h>
#include "hal_tick.h"
#define WANT_TRACE 1
#include "trace.h"

using namespace infernoembedded;

#if WANT_TRACE
Serial trace(USBTX, USBRX, "trace", 921600);
#endif

Timer timer;

typedef struct Zone {
	DigitalOut open;
	DigitalOut close;
	uint16_t timeout;
	uint8_t desired;
	uint8_t current;
	Timer	lastActivated;
} Zone;

#define PF_8 ((PinName)0x57)

class Listener : public ACZoneListener {
protected:
#define ZONE_COUNT	8
	Zone _zones[ZONE_COUNT] = {
					{PB_14, PB_15, 30, 0, 0},
					{PC_6, PC_7, 30, 0, 0},
					{PC_9, PA_9, 30, 0, 0},
					{PA_11, PF_8, 30, 0, 0},
					{PC_10, PC_12, 30, 0, 0},
					{PB_4, PB_6, 30, 0, 0},
					{PF_4, PF_5, 30, 0, 0},
					{PB_12, PB_13, 30, 0, 0},
	};

public:
	uint8_t countZones() {
		return ZONE_COUNT;
	}

	void setTimeout(uint8_t zone, uint8_t timeout) {
		if (zone >= ZONE_COUNT) {
			return;
		}

		_zones[zone].timeout = timeout * 1000; // Convert to ms
	}

	void setState(uint8_t zone, uint8_t state) {
		if (zone >= ZONE_COUNT) {
			return;
		}

		_zones[zone].desired = state;

		bool shouldOpen = state > _zones[zone].current;

		if (shouldOpen) {
			_zones[zone].open = 1;
			_zones[zone].close = 0;
		} else {
			_zones[zone].open = 0;
			_zones[zone].close = 1;
		}

		_zones[zone].lastActivated.reset();
		_zones[zone].lastActivated.start();

		TRACE("Enabling damper for zone %d to %s", zone, shouldOpen ? "open" : "close");
	}

	/**
	 * Disable any outputs that have timed out
	 */
	void poll() {
		for (uint8_t zone = 0; zone < ZONE_COUNT; zone++) {
			int delta = _zones[zone].desired - _zones[zone].current;

			if (delta == 0) {
				continue;
			}

			if (delta < 0) {
				delta *= -1;
			}

			int elapsed = _zones[zone].lastActivated.read_ms();

			if (elapsed > ((float)delta / 255) * _zones[zone].timeout) {
				_zones[zone].lastActivated.stop();
				_zones[zone].lastActivated.reset();
				_zones[zone].open = 0;
				_zones[zone].close = 0;
				_zones[zone].current = _zones[zone].desired;

				TRACE("Stopping actuator for zone %d after %d ms", zone, elapsed);
			}
		}
	}
};

Listener listener;

OneWireAddress address;
ACZoneController dev(PB_0, address, listener);


int main() {
	TRACE("AC Zone Controller Online, SystemCoreClock = %ld Hz", SystemCoreClock);
	dev.getAddress(address); // populate the family & CRC

	TRACE("Address = %02x.%02x%02x%02x%02x%02x%02x.%02x", address.bytes[0], address.bytes[1], address.bytes[2],
					address.bytes[3], address.bytes[4], address.bytes[5], address.bytes[6], address.bytes[7]);

    while (1) {
    	dev.poll();
    	listener.poll();
    }
}

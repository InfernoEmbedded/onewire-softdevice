/* Inferno Embedded Aircon Zone Controller
 * Copyright (C) 2017 Inferno Embedded
 *
 *  This program is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation, either version 3 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

#include "mbed.h"

#include <SwitchMaster.h>
#define WANT_TRACE 1
#include "trace.h"

using namespace infernoembedded;

#if WANT_TRACE
Serial trace(USBTX, USBRX, "trace", 921600);
#endif

class MySwitchListener : public SwitchListener {
	void setMode(uint8_t port, uint8_t channel, SwitchMode mode) {}
	bool getState(uint8_t port, uint8_t channel) {
		return false;
	}
	uint64_t getActivations(uint8_t port) {
		return 0;
	}
};

class myLEDListener : public LEDListener {
	void setState(uint8_t port, uint8_t channel, bool on) {}
	uint64_t getState(uint8_t port) {return 0;}
};

#define PF_8 ((PinName)0x57)

class myRelayListener : public RelayListener {
protected:
#define ZONE_COUNT	8
	DigitalOut _channels[ZONE_COUNT][2] = {
					{PB_14, PB_15},
					{PC_6, PC_7},
					{PC_9, PA_9},
					{PA_11, PF_8},
					{PC_10, PC_12},
					{PB_4, PB_6},
					{PF_4, PF_5},
					{PB_12, PB_13},
	};

public:
	void setState(uint8_t port, uint8_t channel, bool state) {
		if (port >= ZONE_COUNT) {
			return;
		}

		if (channel >= 2) {
			return;
		}

		_channels[port][channel] = state ? 1 : 0;

		TRACE("Setting %d:%d %s", port, channel, state ? "on" : "off");
	}

	bool getState(uint8_t port, uint8_t channel) {
		return !!_channels[port][channel].read();
	}
};

MySwitchListener switchListener;
myLEDListener ledListener;
myRelayListener relayListener;

OneWireAddress address;
SwitchMaster<0, 0, 0, 0, 8, 2> dev(PB_0, address, switchListener, ledListener, relayListener);


int main() {
	TRACE("AC Zone Controller Online, SystemCoreClock = %ld Hz", SystemCoreClock);

	for (uint8_t port = 0; port < ZONE_COUNT; port++) {
		dev.setRelayMode(port, 0, RelayMode::OPEN_CLOSE_PAIR);
	}

	dev.getAddress(address); // populate the family & CRC
	TRACE("Address = %02x.%02x%02x%02x%02x%02x%02x.%02x", address.bytes[0], address.bytes[1], address.bytes[2],
					address.bytes[3], address.bytes[4], address.bytes[5], address.bytes[6], address.bytes[7]);

    while (1) {
    	dev.poll();
    }
}

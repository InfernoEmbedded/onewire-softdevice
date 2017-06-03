#include <ACZoneController.h>
#include "trace.h"

namespace infernoembedded {

SoftDeviceCommandMetadata ACZoneControllerMetadata[] = {
				{"COUNT_ZONES",		0x01, 0, 0},
				{"SET_TIMEOUT",		0x02, 2, 0},
				{"SET_STATE",		0x03, 2, 0},
};

/**
 * Constructor
 * @param pin	the pin the 1wire interface is on
 * @param address	the 1wire address of the device (only the lowest 48 bits are considered)
 */
ACZoneController::ACZoneController(PinName pin, OneWireAddress &address, ACZoneListener &listener) : SoftDevice(pin, address, AC_ZONE_CONTROLLER, 1, ACZoneControllerMetadata), _listener(listener) {}

void ACZoneController::commandDespatch(uint8_t command) {
	switch(command) {
	case 0x01:
		commandCountZones();
		break;
	case 0x02:
		commandSetTimeout();
		break;
	case 0x03:
		commandSetState();
		break;
	}
}

void ACZoneController::commandCountZones() {
	masterToRead(_listener.countZones());
}

void ACZoneController::commandSetTimeout() {
	uint8_t port = _data & 0xFF;
	uint8_t timeout = (_data >> 8) & 0xFF;

	_listener.setTimeout(port, timeout);
}

void ACZoneController::commandSetState() {
	uint8_t port = _data & 0xFF;
	uint8_t state = (_data >> 8) & 0xFF;

	_listener.setState(port, state);
}

void ACZoneController::masterToReadCompleted() {
}

} /* namespace infernoembedded */

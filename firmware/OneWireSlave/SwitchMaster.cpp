#include <SwitchMaster.h>
#include "trace.h"

namespace infernoembedded {

SoftDeviceCommandMetadata switchMasterMetadata[] = {
				{"COUNT_SWITCHES",		0x01, 0, 0},
				{"COUNT_LEDS",			0x02, 0, 0},
				{"SWITCH_TYPE",			0x03, 2, 0},
				{"GET_SWITCH_STATE",	0x04, 0, 0},
				{"GET_ACTIVATED_STATE",	0x05, 0, 0},
				{"SET_LED",				0x06, 2, 0},
				{"GET_LED",				0x07, 1, 0},
};

/**
 * Constructor
 * @param pin	the pin the 1wire interface is on
 * @param address	the 1wire address of the device (only the lowest 48 bits are considered)
 * @param switchListener	a listener for switch commands
 * @param ledListener		a listener for LED commands
 */
SwitchMaster::SwitchMaster(PinName pin, OneWireAddress &address, SwitchListener &switchListener, LEDListener &ledListener) : SoftDevice(pin, address, SWITCH_MASTER, 1, switchMasterMetadata),
				_switchListener(switchListener), _ledListener(ledListener) {}

void SwitchMaster::commandDespatch(uint8_t command) {
	switch(command) {
	case 0x01:
		commandCountSwitches();
		break;
	case 0x02:
		commandCountLEDs();
		break;
	case 0x03:
		commandSwitchType();
		break;
	case 0x04:
		commandGetSwitchState();
		break;
	case 0x05:
		commandGetActivatedState();
		break;
	case 0x06:
		commandSetLED();
		break;
	case 0x07:
		commandGetLED();
		break;
	}
}

/**
 * Count the numbers of switches on the device
 * Writes:
 * 	1 byte containing the number of ports
 * 	1 byte containing the number of switches
 */
void SwitchMaster::commandCountSwitches() {
	masterToRead(_switchListener.countPorts());
	masterToRead(_switchListener.countChannelsPerPort());
}

/**
 * Count the numbers of LEDs on the device
 * Sends 1 byte containing the number of LEDs, maximum of 64
 */
void SwitchMaster::commandCountLEDs() {
	masterToRead(_ledListener.countPorts());
	masterToRead(_ledListener.countChannelsPerPort());
}

/**
 * Set the type of a switch
 * Reads: 	1 byte - switch port
 * 			1 byte - switch channel
 * 			1 byte - switch type (see SwitchMode)
 */
void SwitchMaster::commandSwitchType() {
	uint8_t port = _data & 0xFF;
	uint8_t channel = (_data >> 8) & 0xFF;
	uint8_t mode = (_data >> 18) & 0xFF;

	_switchListener.setMode(port, channel, (SwitchMode)mode);
}

/**
 * Get the state of a single switch
 * Reads: 	1 byte - switch port
 * 			1 byte - switch channel
 * Writes:  1 byte - 0 or 1, the current raw state of the switch
 */
void SwitchMaster::commandGetSwitchState() {
	uint8_t port = _data & 0xFF;
	uint8_t channel = (_data >> 8) & 0xFF;
	masterToRead(_switchListener.getState(port, channel));
}

/**
 * Get the activated state of all switches
 * Writes:  N ports of M bytes, where N is the number of ports, and M being the minimum number of bytes to fit all channels
 */
void SwitchMaster::commandGetActivatedState() {
	_currentPort = 0;

	// continued in masterToReadCompleted()
	masterToReadCompleted();
}

/**
 * Set 1 LED
 * Reads: 	1 byte - led port
 * 			1 byte - led channel
 * 			1 byte 0 or 1, turn the channel off or on
 */
void SwitchMaster::commandSetLED() {
	uint8_t port = _data & 0xFF;
	uint8_t channel = (_data >> 8) & 0xFF;
	uint8_t state = (_data >> 16) & 0xFF;

	_ledListener.setState(port, channel, !!state);
}

/**
 * Get  full port of LEDs
 * Reads: 	1 byte - led port
 * Writes:	N bytes, representing a bitmask of the LEDs on the port (up to 8 bytes)
 */
void SwitchMaster::commandGetLED() {
	uint8_t port = _data & 0xFF;

	masterToRead(_ledListener.getState(port), (_ledListener.countChannelsPerPort() + 7)/ 8);
}

/**
 * Notify the library that a switch has been activated
 */
void SwitchMaster::switchHasBeenActivated() {
	setStatus(0x01 << 1);
}

void SwitchMaster::masterToReadCompleted() {
	switch (_currentCommand) {
	case 0x05: /* GET_ACTIVATED_STATE */
		if (_currentPort >= _switchListener.countPorts()) {
			break;
		}

		uint8_t channels = _switchListener.countChannelsPerPort();
		uint8_t byteCount = (channels + 7) / 8;
		masterToRead(_switchListener.getActivations(_currentPort), byteCount);

		_currentPort++;

		break;
	}
}

} /* namespace infernoembedded */

/* Inferno Embedded Switch Master
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

#ifndef SWITCHMASTER_H_
#define SWITCHMASTER_H_

#include "mbed.h"
#include <stdint.h>

#define WANT_TRACE 1
#include "trace.h"

#include "SoftDevice.h"

namespace infernoembedded {

enum class SwitchMode : uint8_t {
	TOGGLE_PULL_DOWN = 0,
	TOGGLE_PULL_UP = 1,
	MOMENTARY_PULL_DOWN = 2,
	MOMENTARY_PULL_UP = 3,
};

class SwitchListener {
public:
	/**
	 * Set a switch's mode
	 * @param port the port of the switch
	 * @param channel the channel of the switch
	 * @param mode the new mode of the switch
	 */
	virtual void setMode(uint8_t port, uint8_t channel, SwitchMode mode) =0;

	/**
	 * Read the raw state of a switch
	 * @param port the port of the switch
	 * @param channel the channel of the switch
	 * @return true if the switch is currently engaged
	 */
	virtual bool getState(uint8_t port, uint8_t channel) =0;

	/**
	 * Read the activated state of all switches on a port. An activation depends on the type of switch.
	 * For toggle switches, the switch should have been toggled. For momentary switches, it must have been pressed.
	 *
	 * The activated state should be cleared after reading
	 *
	 * @param port the port of the switch
	 * @return a bitmap marking the activated switches on the port
	 */
	virtual uint64_t getActivations(uint8_t port) =0;

};

class LEDListener {
public:
	/**
	 * Set an LED's mode
	 * @param port the port of the LED
	 * @param channel the channel of the LED
	 * @param on true if the LED should be on
	 */
	virtual void setState(uint8_t port, uint8_t channel, bool on) =0;

	/**
	 * Get a ports worth of LED states
	 * @param port the port to get
	 */
	virtual uint64_t getState(uint8_t port) =0;
};

enum class RelayMode : uint8_t {
	INDEPENDENT = 0, /**< Channel operates independently */
	OPEN_CLOSE_PAIR = 1, /**< Channel operates as an open/close pair */
};

class RelayListener {
public:
	/**
	 * Set the state for a channel
	 * @param port the port the relay belongs to
	 * @param channel The channel to operate on (must be even for an open/close pair)
	 * @param on true to turn the channel on
	 */
	virtual void setState(uint8_t port, uint8_t channel, bool on) =0;

	/**
	 * Get the state of a relay
	 * @param port the port to get
	 * @param channel the channel to get
	 */
	virtual bool getState(uint8_t port, uint8_t channel) =0;
};

typedef struct RelayChannel {
	uint8_t timeout;
	RelayMode mode;
	uint8_t current;
	uint8_t desired;
	Timer lastActivated;
} RelayChannel;

SoftDeviceCommandMetadata switchMasterMetadata[] = {
				{"COUNT_SWITCHES",		0x01, 0, 0},
				{"COUNT_LEDS",			0x02, 0, 0},
				{"COUNT_RELAYS",		0x03, 0, 0},
				{"SWITCH_TYPE",			0x04, 3, 0},
				{"GET_SWITCH_STATE",	0x05, 0, 0},
				{"GET_ACTIVATED_STATE",	0x06, 0, 0},
				{"SET_LED",				0x07, 3, 0},
				{"GET_LEDS",			0x08, 1, 0},
				{"SET_RELAY_MODE",		0x09, 3, 0},
				{"SET_RELAY_TIMEOUT",	0x0A, 3, 0},
				{"SET_RELAY_STATE",		0x0B, 3, 0},
				{"GET_RELAY_STATES",	0x0C, 0, 0},
				{"GET_RELAY_MODES",		0x0D, 0, 0},
				{"GET_RELAY_TIMEOUTS",	0x0E, 0, 0},
};


/**
 * SwitchMaster base class
 */
template<uint8_t switchPorts, uint8_t switchChannels, uint8_t ledPorts, uint8_t ledChannels, uint8_t relayPorts, uint8_t relayChannels>
	class SwitchMaster : public SoftDevice {
protected:
	SwitchListener &_switchListener;
	LEDListener &_ledListener;
	RelayListener &_relayListener;
	uint8_t _currentPort = 0;
	uint8_t _currentChannel = 0;
	RelayChannel _relayChannels[relayPorts][relayChannels];

	void commandDespatch(uint8_t command) {
		switch(command) {
		case 0x01:
			commandCountSwitches();
			break;
		case 0x02:
			commandCountLEDs();
			break;
		case 0x03:
			commandCountRelays();
			break;
		case 0x04:
			commandSwitchType();
			break;
		case 0x05:
			commandGetSwitchState();
			break;
		case 0x06:
			commandGetActivatedState();
			break;
		case 0x07:
			commandSetLED();
			break;
		case 0x08:
			commandGetLED();
			break;
		case 0x09:
			commandSetRelayMode();
			break;
		case 0x0A:
			commandSetRelayTimeout();
			break;
		case 0x0B:
			commandSetRelayState();
			break;
		case 0x0C:
			commandGetRelayStates();
			break;
		case 0x0D:
			commandGetRelayModes();
			break;
		case 0x0E:
			commandGetRelayTimeouts();
			break;
		}
	}

	/**
	 * Set the mode of a relay channel
	 */
	void commandSetRelayMode() {
		uint8_t port = _data & 0xFF;
		uint8_t channel = (_data >> 8) & 0xFF;
		RelayMode mode = (RelayMode)((_data >> 16) & 0xFF);

		setRelayMode(port, channel, mode);
	}

	/**
	 * Set the timeout for an open/close relay channel
	 */
	void commandSetRelayTimeout() {
		uint8_t port = _data & 0xFF;
		uint8_t channel = (_data >> 8) & 0xFF;
		uint8_t timeout = (_data >> 16) & 0xFF;

		if (channel & 0x01) {
			return; // Not an even channel
		}

		if (port >= relayPorts) {
			return;
		}

		if (channel >= relayChannels) {
			return;
		}

		_relayChannels[port][channel].timeout = timeout;

		TRACE("Set timeout of %d:%d to %d", port, channel, timeout);
	}

	void commandSetRelayState() {
		uint8_t port = _data & 0xFF;
		uint8_t channel = (_data >> 8) & 0xFF;
		uint8_t state = (_data >> 16) & 0xFF;

		if (port >= relayPorts) {
			return;
		}

		if (channel >= relayChannels) {
			return;
		}

		if ((channel & 0x01) && _relayChannels[port][channel-1].mode == RelayMode::OPEN_CLOSE_PAIR) {
			return; // Slave channel for an on/off pair
		}

		if (_relayChannels[port][channel].mode == RelayMode::INDEPENDENT) {
			_relayListener.setState(port, channel, !!state);
			return;
		}

		if (channel & 0x01) {
			return; // Not an even channel
		}

		if (channel == relayChannels - 1) {
			return; // Don't have a higher channel
		}

		// Mode is Open/Close pair
		_relayChannels[port][channel].desired = state;

		bool shouldOpen = state > _relayChannels[port][channel].current;

		if (shouldOpen) {
			_relayListener.setState(port, channel+1, false);
			_relayListener.setState(port, channel, true);
		} else {
			_relayListener.setState(port, channel, false);
			_relayListener.setState(port, channel+1, true);
		}

		_relayChannels[port][channel].lastActivated.reset();
		_relayChannels[port][channel].lastActivated.start();
	}

	/**
	 * Get all relay states
	 * Writes:	N bytes, where each byte represents a channel on a port
	 */
	void commandGetRelayStates() {
		_currentPort = 0;
		_currentChannel = 0;

		// continued in masterToReadCompleted()
		masterToReadCompleted();
	}

	/**
	 * Get all relay modes
	 * Writes:	N bytes, where each byte represents a channel on a port
	 */
	void commandGetRelayModes() {
		_currentPort = 0;
		_currentChannel = 0;

		// continued in masterToReadCompleted()
		masterToReadCompleted();
	}

	/**
	 * Get all relay timeouts
	 * Writes:	N bytes, where each byte represents a channel on a port
	 */
	void commandGetRelayTimeouts() {
		_currentPort = 0;
		_currentChannel = 0;

		// continued in masterToReadCompleted()
		masterToReadCompleted();
	}

	/**
	 * Count the numbers of switches on the device
	 * Writes:
	 * 	1 byte containing the number of ports
	 * 	1 byte containing the number of switches
	 */
	void commandCountSwitches() {
		masterToRead(switchPorts);
		masterToRead(switchChannels);
	}

	/**
	 * Count the numbers of LEDs on the device
	 * Sends 1 byte containing the number of LEDs, maximum of 64
	 */
	void commandCountLEDs() {
		masterToRead(ledPorts);
		masterToRead(ledChannels);
	}

	/**
	 * Count the numbers of LEDs on the device
	 * Sends 1 byte containing the number of LEDs, maximum of 64
	 */
	void commandCountRelays() {
		masterToRead(relayPorts);
		masterToRead(relayChannels);
	}

	/**
	 * Set the type of a switch
	 * Reads: 	1 byte - switch port
	 * 			1 byte - switch channel
	 * 			1 byte - switch type (see SwitchMode)
	 */
	void commandSwitchType() {
		uint8_t port = _data & 0xFF;
		uint8_t channel = (_data >> 8) & 0xFF;
		uint8_t mode = (_data >> 16) & 0xFF;

		_switchListener.setMode(port, channel, (SwitchMode)mode);
	}

	/**
	 * Get the state of a single switch
	 * Reads: 	1 byte - switch port
	 * 			1 byte - switch channel
	 * Writes:  1 byte - 0 or 1, the current raw state of the switch
	 */
	void commandGetSwitchState() {
		uint8_t port = _data & 0xFF;
		uint8_t channel = (_data >> 8) & 0xFF;
		masterToRead(_switchListener.getState(port, channel));
	}

	/**
	 * Get the activated state of all switches
	 * Writes:  N ports of M bytes, where N is the number of ports, and M being the minimum number of bytes to fit all channels
	 */
	void commandGetActivatedState() {
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
	void commandSetLED() {
		uint8_t port = _data & 0xFF;
		uint8_t channel = (_data >> 8) & 0xFF;
		uint8_t state = (_data >> 16) & 0xFF;

		if (port >= ledPorts) {
			return;
		}

		if (channel >= ledChannels) {
			return;
		}

		_ledListener.setState(port, channel, !!state);
	}

	/**
	 * Get  full port of LEDs
	 * Reads: 	1 byte - led port
	 * Writes:	N bytes, representing a bitmask of the LEDs on the port (up to 8 bytes)
	 */
	void commandGetLED() {
		uint8_t port = _data & 0xFF;

		masterToRead(_ledListener.getState(port), (ledChannels + 7)/ 8);
	}

	void masterToReadCompleted() {
		uint8_t byteCount;
		uint8_t val;

		switch (_currentCommand) {
		case 0x06: /* GET_ACTIVATED_STATE */
			if (_currentPort >= switchPorts) {
				break;
			}

			byteCount = (switchChannels + 7) / 8;
			masterToRead(_switchListener.getActivations(_currentPort), byteCount);

			_currentPort++;

			break;

		case 0x0C: /* GET_RELAY_STATES */
			if (_currentChannel >= relayChannels) {
				_currentChannel = 0;
				_currentPort++;
			}

			if (_currentPort >= relayPorts) {
				break;
			}

			val = 0;
			switch (_relayChannels[_currentPort][_currentChannel].mode) {
			case RelayMode::INDEPENDENT:
				val = _relayListener.getState(_currentPort, _currentChannel) ? 1 : 0;
				break;
			case RelayMode::OPEN_CLOSE_PAIR:
				val = _relayChannels[_currentPort][_currentChannel].current;
				break;
			}
			masterToRead(val);

			_currentChannel++;

			break;

		case 0x0D: /* GET_RELAY_MODES */
			if (_currentChannel >= relayChannels) {
				_currentChannel = 0;
				_currentPort++;
			}

			if (_currentPort >= relayPorts) {
				break;
			}

			masterToRead((uint8_t)_relayChannels[_currentPort][_currentChannel].mode);

			_currentChannel++;

			break;

		case 0x0E: /* GET_RELAY_TIMEOUTS */
			if (_currentChannel >= relayChannels) {
				_currentChannel = 0;
				_currentPort++;
			}

			if (_currentPort >= relayPorts) {
				break;
			}

			masterToRead((uint8_t)_relayChannels[_currentPort][_currentChannel].timeout);

			_currentChannel++;

			break;
		}
	}

public:
	/**
	 * Constructor
	 * @param pin	the pin the 1wire interface is on
	 * @param address	the 1wire address of the device (only the lowest 48 bits are considered)
	 * @param switchListener	a listener for switch commands
	 * @param ledListener		a listener for LED commands
	 */
	SwitchMaster(PinName pin, OneWireAddress &address, SwitchListener &switchListener, LEDListener &ledListener, RelayListener &relayListener)
		: SoftDevice(pin, address, SWITCH_MASTER, 1, switchMasterMetadata), _switchListener(switchListener), _ledListener(ledListener), _relayListener(relayListener) {
		for (uint8_t relayPort = 0; relayPort < relayPorts; relayPort++) {
			for (uint8_t relayChannel = 0; relayChannel < relayChannels; relayChannel++) {
				_relayChannels[relayPort][relayChannel].timeout = 30;
				_relayChannels[relayPort][relayChannel].mode = RelayMode::INDEPENDENT;
				_relayChannels[relayPort][relayChannel].current = 0;
				_relayChannels[relayPort][relayChannel].desired = 0;
			}
		}
	}

	/**
	 * Notify the library that a switch has been activated
	 */
	void switchHasBeenActivated() {
		setStatus(0x01 << 1);
	}

	/**
	 * Set the mode of a relay channel
	 * @param port the port of the relay
	 * @param channel the channel of the relay
	 * @param mode the desired mode
	 */
	void setRelayMode(uint8_t port, uint8_t channel, RelayMode mode) {
		if (channel & 0x01) {
			return; // Not an even channel
		}

		if (port >= relayPorts) {
			return;
		}

		if (channel >= relayChannels) {
			return;
		}

		_relayChannels[port][channel].mode = mode;
	}

	/**
	 * Override the poll() method to deal with the timeouts
	 */
	void poll() {
		OneWireSlave::poll();

		for (uint8_t relayPort = 0; relayPort < relayPorts; relayPort++) {
			for (uint8_t relayChannel = 0; relayChannel < relayChannels; relayChannel++) {
				if (_relayChannels[relayPort][relayChannel].mode == RelayMode::INDEPENDENT) {
					return;
				}

				int delta = _relayChannels[relayPort][relayChannel].desired - _relayChannels[relayPort][relayChannel].current;

				if (delta == 0) {
					continue;
				}

				if (delta < 0) {
					delta *= -1;
				}

				int elapsed = _relayChannels[relayPort][relayChannel].lastActivated.read_ms();

				if (elapsed >= ((float)delta * 1000 / 255) * _relayChannels[relayPort][relayChannel].timeout) {
					_relayChannels[relayPort][relayChannel].lastActivated.stop();
					_relayChannels[relayPort][relayChannel].lastActivated.reset();
					_relayListener.setState(relayPort, relayChannel, false);
					_relayListener.setState(relayPort, relayChannel+1, false);
					_relayChannels[relayPort][relayChannel].current = _relayChannels[relayPort][relayChannel].desired;

					TRACE("Stopping relays for %d:%d after %d ms", relayPort, relayChannel, elapsed);
				}
			}
		}
	}
};

} /* namespace infernoembedded */

#endif /* SWITCHMASTER_H_ */

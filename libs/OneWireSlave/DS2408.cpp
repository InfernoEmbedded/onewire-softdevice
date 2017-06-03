/* DS2408 Emulation
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

#include "DS2408.h"

#include "trace.h"

namespace infernoembedded {

/**
 * Constructor
 * @param pin	the pin the 1wire interface is on
 * @param listener	a listener who will receive pin changes
 * @param address	the 1wire address of the device (only the lowest 48 bits are considered)
 */
DS2408::DS2408(PinName pin, DS2408Listener &listener, OneWireAddress &address) : OneWireSlave(pin, 0x29, address), _listener(listener)  {
	TRACE("Clearing listener");
	_listener.gpioOut(0);

	_gpioBitsForMaster = 0xf0;
}

/**
 * Handle a 1 Wire reset
 */
void DS2408::reset() {
	OneWireSlave::reset();
	_deviceState = DS2408State::READY;
}

/**
 * Is the device in a 1wire alarm state?
 * @return true if it is alarmed
 */
bool DS2408::alarmed() {
	uint8_t data;

	if (_control & (1 << PLS)) {
		// Alarm on activity latch
		data = _latchedActivity;
	} else {
		// Alarm on GPIO level
		data = _gpioBitsForMaster;
	}

	// Mask off the bits we care about
	data = data & _conditionalSearchSelection;

	uint8_t polarity = _conditionalSearchPolarity & _conditionalSearchSelection;

	if (_control & (1 << CT)) {
		// bits are ANDed
		return data == polarity;
	} else {
		// bits are ORed
		return !!(data | polarity);
	}
}

/**
 * Handle a DS2408 command
 */
void DS2408::handleCommand(DS2408Command command) {
	uint8_t byte;

	switch (command) {
	case DS2408Command::RESET_ACTIVITY_LATCH:
		TRACE("RESET_ACTIVITY_LATCH");
		_latchedActivity = 0;
		masterToRead((uint8_t)0xAA);
		_deviceState = DS2408State::RESET_ACTIVITY_LATCH;
		break;
	case DS2408Command::WRITE_CONDITIONAL_SEARCH:
		TRACE("WRITE_CONDITIONAL_SEARCH");
		_deviceState = DS2408State::WRITE_CONDITIONAL_SEARCH;
		break;
	case DS2408Command::READ_PIO:
		TRACE("READ_PIO");
		_deviceState = DS2408State::READ_PIO;
		break;
	case DS2408Command::CHANNEL_READ:
		TRACE("CHANNEL_READ");
		_deviceState = DS2408State::CHANNEL_READ;
		byte = DS2408Command::CHANNEL_READ;
		_crc16 = crc16(&byte, 1, 0);
		byte = _gpioBitsForMaster;
		_crc16 = crc16(&byte, 1, _crc16);
		masterToRead(byte);
		_channelOpsRemaining = 30;
		break;
	case DS2408Command::CHANNEL_WRITE:
		TRACE("CHANNEL_WRITE");
		_deviceState = DS2408State::CHANNEL_WRITE;
		break;
	case DS2408Command::DISABLE_TEST_MODE:
		TRACE("DISABLE_TEST_MODE");
		idle();
	default:
		TRACE("Unknown command 0x%02x, %d %d %d %d %d %d %d %d", (uint8_t)command,
						_times[0], _times[1], _times[2], _times[3], _times[4], _times[5], _times[6], _times[7]);
		break;
	}
}

/**
 * Read a GPIO register and write it back to the GPIO bus
 */
void DS2408::readRegister() {
	uint8_t byte;
	_deviceState = DS2408State::READ_PIO_REGISTER;

//	TRACE("0x%04x", _registerAddress);

	if (_registerAddress < 0x88) {
		byte = 0;
	} else if (_registerAddress < 0x8e) {
		switch (_registerAddress) {
		case DS2408Register::PIO_LOGIC_STATE:
			byte = _gpioBitsForMaster;
			break;
		case DS2408Register::PIO_OUTPUT_LATCH:
			byte = _latchedState;
			break;
		case DS2408Register::PIO_ACTIVITY_LATCH:
			byte = _latchedActivity;
			break;
		}
	} else if (_registerAddress == 0x90) {
		masterToRead(~(uint64_t)_crc16, 2);
		_registerAddress++;
		return;
	} else { // Includes 0x8e & 0x8f
		byte = 0xFF;
	}

	_crc16 = crc16(&byte, 1, _crc16);
	masterToRead(byte);
	_registerAddress++;
}

/**
 * Called whenever the master has completed a read operation and there is no more data to send
 */
void DS2408::masterToReadCompleted() {
	uint8_t byte;

	switch (_deviceState) {
	case DS2408State::READ_PIO:
	case DS2408State::READ_PIO_REGISTER:
		readRegister();

		break;
	case DS2408State::CHANNEL_READ:
		byte = _gpioBitsForMaster;
		_crc16 = crc16(&byte, 1, _crc16);
		masterToRead(byte);
		_channelOpsRemaining--;

		if (_channelOpsRemaining == 0) {
			uint64_t data = _crc16;
			masterToRead(data, 2);
			_crc16 = 0;
			_channelOpsRemaining = 32;
		}
		break;
	default:
		break;
	}
}

/**
 * Called when we receive a byte from the bus
 */
void DS2408::deviceReceive() {
	uint8_t byte;
	uint16_t bytes;

	switch (_deviceState) {
	case DS2408State::READY:
		byte = getByteFromMaster();
		handleCommand((DS2408Command)byte);
		break;
	case DS2408State::READ_PIO:
		if (_hasBytesFromMaster < 2) {
			return; // need 2 bytes for address
		}
		_registerAddress = get2BytesFromMaster();
		byte = DS2408Command::READ_PIO;
		_crc16 = crc16(&byte, 1, 0);
		byte = _registerAddress & 0xFF;
		_crc16 = crc16(&byte, 1, _crc16);
		byte = _registerAddress >> 8;
		_crc16 = crc16(&byte, 1, _crc16);
		readRegister();
		break;

	case DS2408State::WRITE_CONDITIONAL_SEARCH:
		if (_hasBytesFromMaster < 2) {
			return; // need 2 bytes for address
		}
		_registerAddress = get2BytesFromMaster();
		if (_registerAddress < 0x8B || _registerAddress > 0x8D) {
			_deviceState = DS2408State::IDLE;
			return;
		}
		_deviceState = DS2408State::WRITE_CONDITIONAL_SEARCH_DATA;
		break;
	case DS2408State::WRITE_CONDITIONAL_SEARCH_DATA:
		if (_registerAddress > 0x8D) {
			_deviceState = DS2408State::IDLE;
			return;
		}

		switch (_registerAddress++) {
		case 0x8B:
			_conditionalSearchSelection = getByteFromMaster();
			break;
		case 0x8C:
			_conditionalSearchPolarity = getByteFromMaster();
			break;
		case 0x8D:
			uint8_t data = getByteFromMaster();
			if (!(_control & (1 << PORL))) {
				data &= ~(1 << PORL);
			}
			_control = data | (1 << VCCP); // VCCP is always 1, we are always self powered
			break;
		}

		break;
	case DS2408State::CHANNEL_WRITE:
		if (_hasBytesFromMaster < 2) {
			return; // need 2 bytes
		}

		bytes = get2BytesFromMaster();
		byte = bytes & 0xFF;
		if ((byte) != (0xFF & ~(bytes >> 8))) {
			TRACE("bad write 0x%04x", bytes);
			return;
		}

		_latchedActivity |= _latchedState ^ byte;
		_latchedState = byte;
		_gpioBitsFromMaster = byte;
		masterToRead((uint8_t)0xAA);
		_listener.gpioOut(byte);
		break;
	default:
		break;
	}
}

/**
 * Set a GPIO bit to report back up the 1wire bus
 * @param bit the bit to operate on (0-7)
 * @param value the bit value
 */
void DS2408::setGpioReported(uint8_t bit, bool value) {
	if (bit > 7) {
		return;
	}

	uint8_t old = _gpioBitsForMaster;

	if (value) {
		_gpioBitsForMaster |= 1 << bit;
	} else {
		_gpioBitsForMaster &= ~(1 << bit);
	}

	_latchedActivity |= _gpioBitsForMaster ^ old;
}

/**
 * Get the current gpio state that will be reported back up the 1wire bus
 * @param bit the bit to operate on
 */
bool DS2408::getGpioReported(uint8_t bit) {
	if (bit > 7) {
		return false;
	}

	return !!(_gpioBitsForMaster & (1 << bit));
}

/**
 * Get the current gpio state that will be reported back up the 1wire bus
 * @param bit the bit to operate on
 */
bool DS2408::getGpioFromMaster(uint8_t bit) {
	if (bit > 7) {
		return false;
	}

	return !!(_gpioBitsFromMaster & (1 << bit));
}


} /* namespace infernoembedded */

/* Inferno Embedded SoftDevice implementation
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

#include "SoftDevice.h"
#define WANT_TRACE 0
#include "trace.h"

namespace infernoembedded {

/**
 * Constructor
 * @param pin	the pin the 1wire interface is on
 * @param address	the 1wire address of the device (only the lowest 48 bits are considered)
 * @param device	the device type
 * @param version	the device version
 * @param metadata	the command metadata
 */
SoftDevice::SoftDevice(PinName pin, OneWireAddress &address, SoftDeviceType device, uint32_t version, SoftDeviceCommandMetadata *metadata) :
				OneWireSlave(pin, 0xFE, address), _version(version), _device(device), _commandMetadata(metadata)  {
	_addressCRC = crc8(_address.bytes, 8, 0);
}

/**
 * Handle a 1 Wire reset
 */
void SoftDevice::reset() {
	OneWireSlave::reset();
	_state = SoftDeviceState::READY;
}

/**
 * Is the device in a 1wire alarm state?
 * @return true if it is alarmed
 */
bool SoftDevice::alarmed() {
	if (_status) {
		return true;
	} else {
		return false;
	}
}

/**
 * Handle a command
 * @param command the command
 * @return true if the command was handled
 */
bool SoftDevice::handleCommand(uint8_t command) {
	switch ((SoftDeviceCommand)command) {
	case SoftDeviceCommand::DEVICE:
		masterToRead((uint64_t)_device, 4);
		TRACE("DEVICE returning %d", _device);
		return true;
	case SoftDeviceCommand::VERSION:
		masterToRead((uint64_t)_version, 4);
		TRACE("VERSION, returning %ld", _version);
		return true;
	case SoftDeviceCommand::STATUS:
		masterToRead(_status, 8);
		TRACE("STATUS, returning 0x%08lx%08lx", (uint32_t)(_status >> 32), (uint32_t)(_status & 0xFFFF));
		_status = 0x00;
		return true;
	case SoftDeviceCommand::FIRMWARE_UPDATE:
		TRACE("FIRMWARE_UPDATE");
		enterBootloader();
		return true;
	}

	return false;
}

/**
 * Set additional status bits
 * These will activate a conditional search and can be retrieved by the STATUS command
 * @param status the additional bits to set
 */
void SoftDevice::setStatus(uint64_t status) {
	_status |= status;
}

/**
 * Clear status bits
 * @param status the bits to clear
 */
void SoftDevice::clearStatus(uint64_t status) {
	_status &= (status & _status) ^ _status;
}

/**
 * Called when we receive a byte from the bus
 */
void SoftDevice::deviceReceive() {
	switch (_state) {
	case SoftDeviceState::READY:
		_currentCommand = getByteFromMaster();
		if (handleCommand(_currentCommand)) {
			return;
		}

		for (_currentCommandMetadata = _commandMetadata; _currentCommandMetadata->name != NULL; _currentCommandMetadata++) {
			if (_currentCommand == _currentCommandMetadata->command) {
				break;
			}
		}

		if (_currentCommandMetadata->name == NULL) {
			TRACE("Unknown command 0x%02x", _currentCommand);
			idle();
			break;
		}

		_state = _currentCommandMetadata->readBytes ? SoftDeviceState::RECV_DATA : SoftDeviceState::RECV_CRC;
		break;
	case SoftDeviceState::RECV_DATA:
		if (_hasBytesFromMaster < _currentCommandMetadata->readBytes) {
			return;
		}

		_data = getBytesFromMaster(_currentCommandMetadata->readBytes);
		_state = SoftDeviceState::RECV_CRC;
		break;

	case SoftDeviceState::RECV_CRC: {
		uint8_t crc = getByteFromMaster();
		uint8_t crcCalculated = _addressCRC;
		crcCalculated = crc8(&_currentCommand, 1, crcCalculated);
		crcCalculated = crc8((uint8_t *)&_data, _currentCommandMetadata->readBytes, crcCalculated);

		if (crc == crcCalculated) {
			// Good CRC
			masterToRead((uint8_t)0x00);
			commandDespatch(_currentCommand);
		} else {
			// Bad CRC
			masterToRead((uint8_t)0x01);
			TRACE("Bad CRC %d != %d", crc, crcCalculated);
		}

		if (_currentCommandMetadata->streamingSize) {
			_state = SoftDeviceState::STREAMING_READ;
			break;
		}

		_state = SoftDeviceState::READY;
		break;
	}
	case SoftDeviceState::STREAMING_READ:
		if (_hasBytesFromMaster < _currentCommandMetadata->streamingSize) {
			return;
		}

		_data = getBytesFromMaster(_currentCommandMetadata->streamingSize);
		stream();
		break;
	}
}

void SoftDevice::enterBootloader() {
	TRACE("Entering bootloader");

    NVIC_SystemReset();
}


} /* namespace infernoembedded */

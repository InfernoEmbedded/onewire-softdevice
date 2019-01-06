/* Inferno Embedded Firmware Updater
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

#include <FirmwareUpdater.h>
#define WANT_TRACE 0
#include "trace.h"

/* Status bits */
#define STATUS_OPERATION_FAIL		1
#define STATUS_OPERATION_SUCCESS	2

namespace infernoembedded {

SoftDeviceCommandMetadata firmwareUpdaterMetadata[] = {
				{"BOOTLOADER_SIZE",	0x00, 0, 0},
				{"ERASE_APP",		0x01, 0, 0},
				{"WRITE", 			0x02, 8, 0},
				{"READ", 			0x03, 4, 0},
				{"APPLICATION_RANGE", 0x04, 0, 0},
				{"BOOT_APPLICATION", 0x05, 0, 0},
				{"WRITE_BLOCK",		0x06, 8, 4},
				{"CRC",				0x07, 8, 0},
				{"ERASE_PAGE",		0x08, 4, 0},
};

/**
 * Constructor
 * @param pin	the pin the 1wire interface is on
 * @param address	the 1wire address of the device (only the lowest 48 bits are considered)
 * @param listener	the interface to pass commands to
 */
FirmwareUpdater::FirmwareUpdater(PinName pin, OneWireAddress &address, FirmwareListener &listener) : SoftDevice(pin, address, FIRMWARE_UPDATER, 1, firmwareUpdaterMetadata), _listener(listener) {}

/**
 * Reset the internal state
 */
void FirmwareUpdater::resetState() {
	_address = 0;
	_size = 0;
	_offset = 0;
}

/**
 * Handle an incoming command
 * @param command the command
 */
void FirmwareUpdater::commandDespatch(uint8_t command) {
	resetState();

	switch(command) {
	case 0x00:
		commandBootloaderSize();
		break;
	case 0x01:
		commandEraseApplication();
		break;
	case 0x02:
		commandWrite();
		break;
	case 0x03:
		commandRead();
		break;
	case 0x04:
		commandApplicationRange();
		break;
	case 0x05:
		commandBootApplication();
		break;
	case 0x06:
		commandWriteBlock();
		break;
	case 0x07:
		commandCRC();
		break;
	case 0x08:
		commandErasePage();
	}
}

/**
 * Clear the status bits
 */
inline void FirmwareUpdater::resetStatus() {
	clearStatus(bit(STATUS_OPERATION_FAIL) | bit(STATUS_OPERATION_SUCCESS));
}

/**
 * Mark the operation as success
 */
inline void FirmwareUpdater::setStatusSuccess() {
	setStatus(bit(STATUS_OPERATION_SUCCESS));
	TRACE("Success");
}

/**
 * Mark the operation as fail
 */
inline void FirmwareUpdater::setStatusFail() {
	setStatus(bit(STATUS_OPERATION_FAIL));
	TRACE("Fail");
}


/**
 * Get the size of the bootloader
 */
void FirmwareUpdater::commandBootloaderSize() {
	uint32_t size = _listener.bootloaderSize();
	masterToRead(size, 4);
	TRACE("Bootloader size is %ld", size);
}

/**
 * Erase the application area of flash (Set status bit 1 on success, 2 on failure)
 */
void FirmwareUpdater::commandEraseApplication() {
	resetStatus();

	TRACE("Erasing application");

	/* Continued in masterToReadCompleted, as this takes too long and results
	 * in missed communications with the master
	 */
}

/**
 * Erase a page of flash (Set status bit 1 on success, 2 on failure)
 */
void FirmwareUpdater::commandErasePage() {
	uint32_t address = _data & 0xFFFFFFFFUL;

	resetStatus();

	TRACE("Erasing application");

	if (_listener.erasePages(address, 1)) {
		setStatusFail();
	} else {
		setStatusSuccess();
	}
}


/**
 * Write data to application flash (Set status bit 1 on success, 2 on failure)
 */
void FirmwareUpdater::commandWrite() {
	uint32_t address = _data & 0xFFFFFFFFUL;
	uint32_t data = _data >> 32;

	resetStatus();

	TRACE("Writing data: 0x%08lx:0x%08lx", address, data);

	if (_listener.write(address, data)) {
		setStatusFail();
	} else {
		setStatusSuccess();
	}
}

/**
 * Read 4 bytes at the requested address
 */
void FirmwareUpdater::commandRead() {
	uint32_t address = _data & 0xFFFFFFFFUL;
	uint32_t data;

	resetStatus();

	TRACE("Reading data from 0x%08lx", address);

	if (_listener.read(address, &data)) {
		setStatusFail();
	} else {
		masterToRead(data, 4);
		setStatusSuccess();
	}
}

/**
 * Boot into the user application
 */
void FirmwareUpdater::commandBootApplication() {
	TRACE("Booting application");
	_listener.bootApplication();
}

/**
 * Get the start & end addresses of the user application
 */
void FirmwareUpdater::commandApplicationRange() {
	/* continued in masterToReadCompleted as otherwise we will overflow the transmit buffer */
}

/**
 * Write a block of data
 */
void FirmwareUpdater::commandWriteBlock() {
	_address = _data & 0xFFFFFFFFUL;
	_size = _data >> 32;

	if (_size > FLASH_PAGE_SIZE) {
		_size = FLASH_PAGE_SIZE;
	}

	TRACE("Writing block of %lu bytes at 0x%08lx", _size, _address);

	resetStatus();
	_blockCRC = 0;

	// Continued in stream
}

/**
 * Stream data from the master
 */
void FirmwareUpdater::stream() {
	switch(_currentCommand) {
	case 0x06: // WRITE_BLOCK
		streamCommandWriteBlock();
		break;
	}
}

/**
 * Stream in a word for writeBlock()
 */
void FirmwareUpdater::streamCommandWriteBlock() {
	uint32_t data = _data & 0xFFFFFFFFUL;
	if (_offset < _size / 4) {
		_block[_offset++] = data;
		_blockCRC = crc16((uint8_t *)&data, 4, _blockCRC);
	} else {
		// check the CRC
		uint16_t crcReceived = data & 0xFFFF;

		if (crcReceived == _blockCRC) {
			masterToRead((uint8_t)0);
			TRACE("Streamed block of %lu bytes, the CRC matched", _size);
			if (_listener.write(_address, _size / 4, _block)) {
				setStatusFail();
			} else {
				setStatusSuccess();
			}
		} else {
			TRACE("CRC mismatch, received='%d', calculated='%d', size=%ld", crcReceived, _blockCRC, _size);
			masterToRead((uint8_t)1);
		}
	}
}

/**
 * Calculate the CRC for a block of memory
 */
void FirmwareUpdater::commandCRC() {
	uint32_t start = (_data & 0XFFFFFFFF);
	uint32_t size = (_data >> 32);

	uint64_t crc = _listener.crc(start, size);
	masterToRead(crc, 2);
}

void FirmwareUpdater::masterToReadCompleted() {
	switch (_currentCommand) {
	case 0x01: /* erase application */
		if (_listener.eraseApplication()) {
			setStatusFail();
		} else {
			setStatusSuccess();
		}
		break;

	case 0x04: /* Application range */
		{
			uint32_t start;
			uint32_t end;

			_listener.applicationRange(&start, &end);

			TRACE("Application range is 0x%08lx - 0x%08lx", start, end);
			masterToRead(start, 4);
			masterToRead(end, 4);

			_currentCommand = 0xFF; // ensure we don't retrigger
		}

		break;
	}
}

} /* namespace infernoembedded */

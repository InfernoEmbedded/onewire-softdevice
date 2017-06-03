/*
 * FirmwareUpdater.h
 *
 *  Created on: 20Nov.,2016
 *      Author: Alastair
 */

#ifndef FIRMWAREUPDATER_H_
#define FIRMWAREUPDATER_H_

#define NDEBUG
#include "mbed.h"
#include <stdint.h>

#include "SoftDevice.h"

namespace infernoembedded {

class FirmwareListener {
public:
	/**
	 * Called to write data to flash
	 * @param address the start address to write to
	 * @param data the data to write (a 32 bit word)
	 * @return true on failure
	 */
	virtual bool write(uint32_t address, uint32_t data) = 0;

	/**
	 * Write a block of data
	 * @param address the start address to write to
	 * @param length the number of 32bit words to write
	 * @param data the data to write
	 * @return true on failure
	 */
	virtual bool write(uint32_t address, uint32_t length, uint32_t *data) = 0;

	/**
	 * Called to read data to flash
	 * @param address the start address to write to
	 * @param data the data to write (a 32 bit word)
	 * @return true on failure
	 */
	virtual bool read(uint32_t address, uint32_t *data) = 0;

	/**
	 * Get the size of the bootloader reserved area
	 * @return the size
	 */
	virtual uint32_t bootloaderSize() =0;

	/**
	 * Erase the application area of flash
	 * @return true on failure
	 */
	virtual bool eraseApplication() =0;

	/**
	 * Boot into the application
	 */
	virtual void bootApplication() =0;

	/**
	 * Get the start & end addresses of the application space
	 * @param start the start address (inclusive)
	 * @param end the end address (exclusive)
	 */
	virtual void applicationRange(uint32_t *start, uint32_t *end) =0;

	/**
	 * Calculate the CRC for a range of memory
	 * @param address the address of the range
	 * @param size the size of range
	 * @return the 16 bit CRC
	 */
	virtual uint16_t crc(uint32_t address, uint32_t size) =0;
};

/**
 * FirmwareUpdater base class
 */
class FirmwareUpdater: public SoftDevice {
protected:
	FirmwareListener &_listener;

	uint32_t _address;
	uint32_t _size; // bytes
	uint32_t _block[FLASH_PAGE_SIZE / 4];
	uint16_t _blockCRC;
	uint32_t _offset;

	void resetStatus();
	void setStatusFail();
	void setStatusSuccess();
	void resetState();

public:
	FirmwareUpdater(PinName pin, OneWireAddress &address, FirmwareListener &listener);
	void commandDespatch(uint8_t command);
	void commandBootloaderSize();
	void commandEraseApplication();
	void commandWrite();
	void commandRead();
	void commandBootApplication();
	void commandApplicationRange();
	void commandWriteBlock();
	void commandCRC();
	void stream();
	void streamCommandWriteBlock();
	void masterToReadCompleted();
};

} /* namespace infernoembedded */

#endif /* FIRMWAREUPDATER_H_ */

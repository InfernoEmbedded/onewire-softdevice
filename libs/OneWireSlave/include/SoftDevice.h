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

#ifndef SOFTDEVICE_H_
#define SOFTDEVICE_H_

#define NDEBUG
#include "mbed.h"
#include <stdint.h>

#include "OneWireSlave.h"

namespace infernoembedded {

enum SoftDeviceState : uint8_t {
	READY,
	RECV_DATA,
	RECV_CRC,
	STREAMING_READ,
};

enum SoftDeviceCommand
	: uint8_t {
		DEVICE = 0xFF,
		VERSION = 0xFE,
		STATUS = 0xFD,
		FIRMWARE_UPDATE = 0xFC,
};

enum SoftDeviceType
	: uint32_t {
		RGBW_CONTROLLER		= 0x0001,
		FIRMWARE_UPDATER	= 0x0002,
		SWITCH_MASTER		= 0x0003,
		AC_ZONE_CONTROLLER	= 0x0004,
};

typedef struct SoftDeviceCommandMetadata {
	 const char *name;
	 uint8_t command;
	 uint8_t readBytes; // Bytes to read from master, 0, 1, 2, 4, 8 bytes
//	 uint8_t writeBytes; // Bytes to write back to master
	 uint8_t streamingSize; // Chunk size for streaming, 0 to disable, up to 8 bytes
} SoftDeviceCommandMetadata;

/**
 * 1Wire Soft Device base class
 */
class SoftDevice: public OneWireSlave {
protected:
	uint32_t _version;
	SoftDeviceType _device;
	uint64_t _status = 0x01ULL; // Bit 0 = Power on/reset, rest are implementation specific
	uint8_t _currentCommand = 0;
	SoftDeviceCommandMetadata *_currentCommandMetadata = NULL;
	SoftDeviceCommandMetadata *_commandMetadata; // Terminated with a NULL name
	SoftDeviceState _state = SoftDeviceState::READY;
	uint64_t _data = 0;
	uint8_t _addressCRC = 0;

public:
	SoftDevice(PinName pin, OneWireAddress &address, SoftDeviceType device, uint32_t version, SoftDeviceCommandMetadata *metadata);
	static bool wantBootloader();
	static void setBootloaderMode();
	static void clearBootloaderMode();

protected:
	bool alarmed();
	void deviceReceive();
	bool handleCommand(uint8_t command);
	virtual void commandDespatch(uint8_t command) =0;
	virtual void stream() {}; // Called when the stream buffer is full
	void reset();
	void handleDeviceCommand(uint8_t command, uint64_t data);
	void setStatus(uint64_t status);
	void clearStatus(uint64_t status);
	void enterBootloader();

	/**
	 * Create a bitmask
	 * @param bit the the to set in the mask
	 * @return the mask
	 */
	inline uint64_t bit(uint8_t bit) {
		return 0x01ULL << bit;
	}
};

} /* namespace infernoembedded */

#endif /* SOFTDEVICE_H_ */

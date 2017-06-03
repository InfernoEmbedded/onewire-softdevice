/*
 * OneWireSlave.h
 *
 *  Created on: 16Nov.,2016
 *      Author: Alastair
 */

#ifndef ONEWIRESLAVE_H_
#define ONEWIRESLAVE_H_

#define NDEBUG
#include "mbed.h"
#include <stdint.h>

namespace infernoembedded {

enum class OneWireState {
	PRESENCE,
	RESET,
	READ_ROM,
	MATCH_ROM,
	SEARCH_ROM,
	READY,
	IDLE,
	ACTIVE
};

enum OneWireCommand : uint8_t {
	READ_ROM = 0x33,
	OVERDRIVE_SKIP_ROM = 0x3C,
	MATCH_ROM = 0x55,
	OVERDRIVE_MATCH_ROM = 0x69,
	RESUME = 0xA5,
	SKIP_ROM = 0xCC,
	CONDITIONAL_SEARCH_ROM = 0xEC,
	SEARCH_ROM = 0xF0,
};

union OneWireAddress {
	uint8_t bytes[8];
	struct {
		uint8_t family;
		uint8_t id[6];
		uint8_t crc;
	} parsed;
	uint64_t value;
};

class OneWireSlave {
private:
	volatile uint64_t _bitsToWrite = 0;
	volatile uint64_t _bitsToWriteNext = 0;
	volatile uint8_t _writeToMaster = 0; /* number of bits to write */
	TIM_HandleTypeDef _timer;
	OneWireState _state = OneWireState::IDLE;
    gpio_t _gpio;
    gpio_irq_t _gpio_irq;
	volatile uint8_t _searchRomBit;
	bool _active = false;
	bool _overdrive = false;
	volatile bool _ignoreRead = true;
	volatile bool _masterToReadCompleted = false;

public:
	static uint16_t crc16(const uint8_t* input, uint16_t len, uint16_t initialCRC = 0);
	static uint8_t crc8(const uint8_t *buf, uint8_t len, uint8_t initialCRC = 0);

protected:
	uint64_t _bytesFromMaster;
	int8_t _hasBytesFromMaster = 0;
	uint16_t _crc16;
#define ONEWIRESLAVE_TIME_COUNT 128
	volatile uint16_t _times[ONEWIRESLAVE_TIME_COUNT];
	volatile uint32_t _timeCount = 0;
	OneWireAddress _address;

private:
	static void gpioIrqHandler(uint32_t id, gpio_irq_event event);
	void searchRomWrite();
	void active();
	void masterWrote(bool bit);
	void masterWrote(uint8_t byte);
	void stashByte(uint8_t byte);
	bool parseBit(uint32_t us);
	uint8_t parseByte();
	void matchRom();

protected:
	OneWireSlave(PinName pin, uint8_t family, OneWireAddress &address);
	virtual ~OneWireSlave() {};
	void idle();
	void generateAddress();
	void masterToRead(bool bit);
	void masterToRead(uint8_t byte);
	void masterToRead(uint64_t data, uint8_t bytes);
	uint8_t getByteFromMaster();
	uint16_t get2BytesFromMaster();
	uint32_t get4BytesFromMaster();
	uint64_t get8BytesFromMaster();
	uint64_t getBytesFromMaster(uint8_t count);
	void handleCommand(OneWireCommand byte);
	void searchRom(bool bit);
/* Virtual functions - override these in your device class */
	virtual bool alarmed();
	virtual void deviceReceive() =0;
	virtual void masterToReadCompleted() =0;
	virtual void reset();

public:
	void poll();
	void getAddress(OneWireAddress &address);

	void pinFall();
	void pinRise();
};

} /* namespace infernoembedded */

#endif /* ONEWIRESLAVE_H_ */

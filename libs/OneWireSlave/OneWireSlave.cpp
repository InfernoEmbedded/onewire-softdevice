/*
 * OneWireSlave.cpp
 *
 * References:
 * https://www.maximintegrated.com/en/products/1-wire/flash/overview/
 *
 *  Created on: 16 Nov 2016
 *      Author: Alastair D'Silva (alastair@d-silva.org)
 */

#include <OneWireSlave.h>
#define WANT_TRACE 0
#include "trace.h"
#include "stm32f0xx_ll_utils.h"

#define RESET_THRESHOLD 400 // us
#if WANT_TRACE
#define PRESENCE_DELAY 5 // actually 15us, accounts for some infrastructure delay
#else
#define PRESENCE_DELAY 15
#endif
#define PRESENCE_DURATION 104 // plus some infrastructure delay

infernoembedded::OneWireSlave *oneWireInstance;

/**
 * This function is executed if an error occurs
 */
void Error_Handler(void) {
	TRACE("Failed");

	while (1) {
	}
}

/* TIMER init function */
static void MX_TIMER_Init(TIM_HandleTypeDef &timer) {
	TIM_ClockConfigTypeDef sClockSourceConfig;
	TIM_MasterConfigTypeDef sMasterConfig;

	__HAL_RCC_TIM6_CLK_ENABLE();

	timer.Instance = TIM6;
	timer.Init.Prescaler = (SystemCoreClock / 1000000) - 1;
	timer.Init.CounterMode = TIM_COUNTERMODE_UP;
	timer.Init.Period = 65535;
	timer.Init.ClockDivision = TIM_CLOCKDIVISION_DIV1;
	if (HAL_TIM_Base_Init(&timer) != HAL_OK) {
		Error_Handler();
	}

	sClockSourceConfig.ClockSource = TIM_CLOCKSOURCE_INTERNAL;
	if (HAL_TIM_ConfigClockSource(&timer, &sClockSourceConfig) != HAL_OK) {
		Error_Handler();
	}

	if (HAL_TIM_Base_Start(&timer) != HAL_OK) {
		Error_Handler();
	}

	sMasterConfig.MasterOutputTrigger = TIM_TRGO_RESET;
	sMasterConfig.MasterSlaveMode = TIM_MASTERSLAVEMODE_DISABLE;
	if (HAL_TIMEx_MasterConfigSynchronization(&timer, &sMasterConfig) != HAL_OK) {
		Error_Handler();
	}
}

namespace infernoembedded {

/**
 * Handle incoming GPIO interrupts
 * @param id
 * @param event
 */
void OneWireSlave::gpioIrqHandler(uint32_t id, gpio_irq_event event) {
	OneWireSlave *slave = (OneWireSlave *) id;

	if (event == IRQ_FALL) {
		slave->pinFall();
	} else {
		slave->pinRise();
	}
}

/**
 * Generate an address based on the device ID of this chip
 */
void OneWireSlave::generateAddress() {
	uint32_t val = LL_GetUID_Word0() ^ LL_GetUID_Word1() ^ LL_GetUID_Word2();
	srand(val);

	val = rand();
	uint64_t val2 = rand();

	_address.value = (val2 << 32) | val;
}

/**
 * Create a new Onewire slave
 * @param pin the pin we are interfaced to the 1wire bus with
 * @param family the One Wire family
 * @param the 1 wire address (only the lowest 48 bits are used, we will generate one if not set)
 */
OneWireSlave::OneWireSlave(PinName pin, uint8_t family, OneWireAddress &address) :
				_address(address) {
	if (!_address.parsed.id[0] && !_address.parsed.id[0] && !_address.parsed.id[0] &&
					!_address.parsed.id[0] && !_address.parsed.id[0] && !_address.parsed.id[0]) {
		generateAddress();
	}

	_address.parsed.family = family;

	_address.parsed.crc = crc8(_address.bytes, 7);

	oneWireInstance = this;

	HAL_Init();
	MX_TIMER_Init(_timer);

	gpio_irq_init(&_gpio_irq, pin, (&OneWireSlave::gpioIrqHandler), (uint32_t) this);
	gpio_init(&_gpio, pin);
	gpio_dir(&_gpio, PIN_INPUT);
	gpio_irq_set(&_gpio_irq, IRQ_FALL, 1);
	gpio_irq_set(&_gpio_irq, IRQ_RISE, 1);
	gpio_irq_enable(&_gpio_irq);
}

/**
 * Get the address of the device
 */
void OneWireSlave::getAddress(OneWireAddress &address) {
	for (int i = 0; i < 8; i++) {
		address.bytes[i] = _address.bytes[i];
	}
}

/**
 * Handle a falling edge on the 1wire line
 */
void OneWireSlave::pinFall() {
	_timer.Instance->CNT = 0;

	if (_writeToMaster) {
		bool bit = _bitsToWrite & 0x01;
		_writeToMaster--;
		_bitsToWrite = _bitsToWrite >> 1;
		_ignoreRead = true;

		if (!bit) {
			gpio_dir(&_gpio, PIN_OUTPUT);
			gpio_write(&_gpio, 0);
			wait_us(20);

			gpio_dir(&_gpio, PIN_INPUT);
		}

		if (_writeToMaster >= 63) {
			_bitsToWrite |= (_bitsToWriteNext & 0x01) << 63;
			_bitsToWriteNext >> 1;
		}

		if (_writeToMaster == 0 && _state == OneWireState::ACTIVE) {
			_masterToReadCompleted = 1;
		}
	} else {
		_ignoreRead = false;
	}
}

/**
 * Handle a rising edge on the 1wire line
 */
void OneWireSlave::pinRise() {
	uint32_t us = _timer.Instance->CNT;

	if (_ignoreRead && us < RESET_THRESHOLD) {
		return;
	}

	if (us >= RESET_THRESHOLD) {
		if (_timeCount < ONEWIRESLAVE_TIME_COUNT) {
			_times[_timeCount++] = us;
		} else {
			_timeCount = 0;
			_times[_timeCount] = us;
		}

		return;
	}

	if (_state == OneWireState::SEARCH_ROM) {
		bool bit = parseBit(us);

		bool addressBit = (bool)((_address.value >> _searchRomBit) & 0x01);

		if (bit == addressBit) {
			if (_searchRomBit < 63) {
				_searchRomBit++;
				searchRomWrite();
			} else {
//				TRACE("Search completed & matched");
				active();
				return;
			}
		} else {
//			TRACE("search terminated on bit %d (%d != %d)", _searchRomBit, bit, addressBit);
			idle();
		}
	} else if (_state == OneWireState::PRESENCE) {
		_state = OneWireState::RESET;
		return;
	} else if (_state == OneWireState::IDLE) {
		return;
	} else if (_timeCount < ONEWIRESLAVE_TIME_COUNT) {
		_times[_timeCount++] = us;
	} else {
		idle();
	}
}

/**
 * Interpret a time as a bit
 * @param us the time in microseconds
 * @return the value of the bit
 */
inline bool OneWireSlave::parseBit(uint32_t us) {
	return (us < (_overdrive ? 6 : 20));
}

/**
 * Interpret 8 times as a byte
 */
uint8_t OneWireSlave::parseByte() {
	uint8_t byte = 0;

	for (int i = 0; i < 8; i++) {
		byte |= (((uint8_t) parseBit(_times[i])) << i);
	}
	_timeCount = 0;

	return byte;
}

/**
 * Handle the MATCH_ROM command
 */
void OneWireSlave::matchRom() {
	OneWireAddress requestedAddress = {.value = 0};

	for (int i = 0; i < 64; i++) {
		requestedAddress.value |= (((uint64_t) parseBit(_times[i])) << i);
	}

	if (memcmp(&requestedAddress, &_address, sizeof(_address))) {
		TRACE("Addresses do not match");
		idle();
	} else {
//		TRACE("MATCH_ROM matched address");
		active();
	}

	_timeCount = 0;
}

/**
 * Poll the OneWire device and handle any outstanding pulses
 */
void OneWireSlave::poll() {
	if (_masterToReadCompleted) {
		_masterToReadCompleted = false;

		masterToReadCompleted();
	}

	if (!_timeCount) {
		return;
	}

	if (_timeCount && _times[_timeCount - 1] > RESET_THRESHOLD) {
		reset();
		_timeCount = 0;
		return;
	}

	switch (_state) {
	case OneWireState::IDLE:
		_timeCount = 0;
		break;
	case OneWireState::RESET:
		if (_timeCount == 8) {
			handleCommand((OneWireCommand) parseByte());
		}
		break;
	case OneWireState::SEARCH_ROM:
		/* handled in the interrupt handler */
		break;
	case OneWireState::MATCH_ROM:
		if (_timeCount == 64) {
			matchRom();
		}
		break;
	case OneWireState::ACTIVE:
		if (_timeCount == 8) {
			stashByte(parseByte());
			deviceReceive();
		}
		break;
	default:
		break;
	}
}

/**
 * Handle a 1 wire bus reset
 */
void OneWireSlave::reset() {
	_state = OneWireState::PRESENCE;

	_hasBytesFromMaster = 0;
	_bitsToWrite = 0;
	_writeToMaster = 0;
	_bytesFromMaster = 0;
	_ignoreRead = false;

	_overdrive = false;

	_searchRomBit = 0;

	// Emit the presence pulse
	gpio_irq_disable(&_gpio_irq);
	gpio_dir(&_gpio, PIN_OUTPUT);
	gpio_write(&_gpio, 0);

	wait_us(PRESENCE_DURATION);
//	TRACE("RESET with %d times, reset time is %d, %d %d %d %d %d %d %d %d", _timeCount, _times[_timeCount - 1],
//					_times[0], _times[1], _times[2], _times[3], _times[4], _times[5], _times[6], _times[7]);

	gpio_irq_enable(&_gpio_irq);
	wait_us(1);
	gpio_dir(&_gpio, PIN_INPUT);

	TRACE("Reset");

	_timeCount = 0;
}

/**
 * Drop to the idle state
 */
void OneWireSlave::idle() {
	_bitsToWrite = 0;
	_writeToMaster = 0;
	_active = false;
	_ignoreRead = true;

	_state = OneWireState::IDLE;

//	TRACE("idle");
}

/**
 * Pass data down to the device implementation
 */
void OneWireSlave::active() {
	_active = true;
	_state = OneWireState::ACTIVE;
	TRACE("Active");
}

/**
 * Implement the search ROM algorithm
 */
void OneWireSlave::searchRomWrite() {
	bool bit = ((_address.value >> _searchRomBit) & 0x01);
	masterToRead(bit);
	masterToRead(!bit);
}


/**
 * Stash a byte for later
 * @param byte
 */
void OneWireSlave::stashByte(uint8_t byte) {
	_bytesFromMaster = _bytesFromMaster | (uint64_t)byte << (_hasBytesFromMaster * 8);
	_hasBytesFromMaster++;
}

/**
 * Grab a stashed byte
 * @return the byte
 */
uint8_t OneWireSlave::getByteFromMaster() {
	if (_hasBytesFromMaster < 1) {
		return 0;
	}

	_hasBytesFromMaster--;

	uint8_t data = _bytesFromMaster & 0xFF;
	_bytesFromMaster = _bytesFromMaster >> 8;

	return data;
}

/**
 * Grab a stashed pair of bytes
 * @return the bytes
 */
uint16_t OneWireSlave::get2BytesFromMaster() {
	if (_hasBytesFromMaster < 2) {
		return 0;
	}

	_hasBytesFromMaster -= 2;

	uint16_t data = (uint16_t) _bytesFromMaster;
	_bytesFromMaster = _bytesFromMaster >> 16;

	return data;
}

/**
 * Grab 4 stashed bytes
 * @return the bytes
 */
uint32_t OneWireSlave::get4BytesFromMaster() {
	if (_hasBytesFromMaster < 4) {
		return 0;
	}

	_hasBytesFromMaster -= 4;

	uint32_t data = (uint32_t) _bytesFromMaster;
	_bytesFromMaster = _bytesFromMaster >> 32;

	return data;
}

/**
 * Grab 8 stashed bytes
 * @return the bytes
 */
uint64_t OneWireSlave::get8BytesFromMaster() {
	if (_hasBytesFromMaster < 8) {
		return 0;
	}

	_hasBytesFromMaster -= 8;

	uint64_t data = _bytesFromMaster;
	_bytesFromMaster = 0;

	return data;
}

/**
 * Grab up to 8 stashed bytes
 * @param count the number of bytes
 * @return the bytes
 */
uint64_t OneWireSlave::getBytesFromMaster(uint8_t count) {
	if (_hasBytesFromMaster < count) {
		return 0;
	}

	_hasBytesFromMaster -= count;

	uint64_t data = _bytesFromMaster;
	_bytesFromMaster = _bytesFromMaster >> (8 * count);

	return data;
}



/**
 * Handle a 1 wire command from the master
 * @param command the command that was issued
 */
void OneWireSlave::handleCommand(OneWireCommand command) {
//	TRACE("Command='%02x'", (uint8_t)command);

	switch (command) {
	case OneWireCommand::READ_ROM:
		TRACE("READ_ROM");
		masterToRead(_address.value, 8);
		_state = OneWireState::READ_ROM;
		break;
	case OneWireCommand::OVERDRIVE_MATCH_ROM:
		_overdrive = true;
		// no break
	case OneWireCommand::MATCH_ROM:
		TRACE("MATCH_ROM");
		_state = OneWireState::MATCH_ROM;
		break;
	case OneWireCommand::CONDITIONAL_SEARCH_ROM:
		TRACE("CONDITIONAL_SEARCH_ROM");
		if (alarmed()) {
			_searchRomBit = 0;
			_state = OneWireState::SEARCH_ROM;
			searchRomWrite();
		} else {
			idle();
		}
		break;
	case OneWireCommand::SEARCH_ROM:
//		TRACE("SEARCH_ROM");
		_searchRomBit = 0;
		_state = OneWireState::SEARCH_ROM;
		searchRomWrite();
		break;
	case OneWireCommand::OVERDRIVE_SKIP_ROM:
		_overdrive = true;
		// no break
	case OneWireCommand::SKIP_ROM:
		TRACE("SKIP_ROM");
		_state = OneWireState::READY;
		break;
	case OneWireCommand::RESUME:
		TRACE("RESUME");
		if (_active) {
			_state = OneWireState::READY;
		} else {
			idle();
		}
		break;
	default:
		TRACE("Unknown command='%02x'", (uint8_t)command);
		break;
	}
}

/**
 * Write a bit back to the master
 * @param bit the bit to write
 */
void OneWireSlave::masterToRead(bool bit) {
	_masterToReadCompleted = 0;
	_bitsToWrite = _bitsToWrite | ((uint64_t) bit << _writeToMaster);
	_writeToMaster++;

	/* continues on a falling edge from the master */
}

/**
 * Write a byte back to the master
 * @param byte the byte to write
 */
void OneWireSlave::masterToRead(uint8_t byte) {
	TRACE("%x", byte);

	_masterToReadCompleted = 0;
	_bitsToWrite = _bitsToWrite | ((uint64_t)byte << _writeToMaster);

	_writeToMaster += 8;

	/* continues on a falling edge from the master */
}

/**
 * Write bytes back to the master (LSB first)
 * @param data the data to write
 * @param bytes the number of bytes to write
 */
void OneWireSlave::masterToRead(uint64_t data, uint8_t bytes) {
	_masterToReadCompleted = 0;
	_bitsToWrite = _bitsToWrite | (data << _writeToMaster);
	_writeToMaster += 8 * bytes;

	/* continues on a falling edge from the master */
}

/**
 * Compute a Dallas Semiconductor 8 bit CRC directly.
 * @param buf the buffer to calculate the CRC of
 * @param len the buffer length
 * @param initialCRC The crc starting value (optional)
 */
uint8_t OneWireSlave::crc8(const uint8_t *buf, uint8_t len, uint8_t initialCRC) {
	uint8_t crc = initialCRC;

	while (len--) {
		uint8_t inbyte = *buf++;
		for (uint8_t i = 8; i; i--) {
			uint8_t mix = (crc ^ inbyte) & 0x01;
			crc >>= 1;
			if (mix)
				crc ^= 0x8C;
			inbyte >>= 1;
		}
	}
	return crc;
}

/**
 * Compute a Dallas Semiconductor 16 bit CRC.  This is required to check the integrity of data received from many 1-Wire devices.
 * Note that the CRC computed here is *not* what you'll get from the 1-Wire network, for two reasons:
 *   1) The CRC is transmitted bitwise inverted
 *   2) Depending on the endian-ness of your processor, the binary representation of the two-byte return value may have a different
 *      byte order than the two bytes you get from 1-Wire
 * @param input - Array of bytes to checksum
 * @param len - How many bytes to use
 * @param crc - The crc starting value (optional)
 * @param initialCRC The crc starting value (optional)
 */
uint16_t OneWireSlave::crc16(const uint8_t* input, uint16_t len, uint16_t initialCRC) {
	static const uint8_t oddparity[16] = { 0, 1, 1, 0, 1, 0, 0, 1, 1, 0, 0, 1, 0, 1, 1, 0 };
	uint16_t crc = initialCRC;

	for (uint16_t i = 0; i < len; i++) {
		// Even though we're just copying a byte from the input,
		// we'll be doing 16-bit computation with it.
		uint16_t cdata = input[i];
		cdata = (cdata ^ crc) & 0xFF;
		crc >>= 8;

		if (oddparity[cdata & 0x0F] ^ oddparity[cdata >> 4])
			crc ^= 0xC001;

		cdata <<= 6;
		crc ^= cdata;
		cdata <<= 1;
		crc ^= cdata;
	}
	return crc;
}

/**
 * Is the device in the alarm state
 * Override this to implement the alarm feature
 * @return true if it is
 */
bool OneWireSlave::alarmed() {
	return false;
}

} /* namespace infernoembedded */

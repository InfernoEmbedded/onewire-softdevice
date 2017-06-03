/*
 * DS2408.h
 *
 *  Created on: 20Nov.,2016
 *      Author: Alastair
 */

#ifndef DS2408_H_
#define DS2408_H_

#define NDEBUG
#include "mbed.h"
#include <stdint.h>

#include "OneWireSlave.h"

namespace infernoembedded {

enum class DS2408State {
	READY,
	READ_PIO,
	READ_PIO_REGISTER,
	RESET_ACTIVITY_LATCH,
	WRITE_CONDITIONAL_SEARCH,
	WRITE_CONDITIONAL_SEARCH_DATA,
	CHANNEL_READ,
	CHANNEL_WRITE,
	IDLE,
};

enum DS2408Command : uint8_t {
	CHANNEL_WRITE = 0x5A,
	DISABLE_TEST_MODE = 0x96,
	RESET_ACTIVITY_LATCH = 0xC3,
	WRITE_CONDITIONAL_SEARCH = 0xCC,
	READ_PIO = 0xF0,
	CHANNEL_READ = 0xF5,
};

enum DS2408Register : uint8_t {
	PIO_LOGIC_STATE = 0x88,
	PIO_OUTPUT_LATCH = 0x89,
	PIO_ACTIVITY_LATCH = 0x8a,
	CONDITIONAL_SEARCH_CHANNEL_SELECTION = 0x8b,
	CONDITIONAL_SEARCH_CHANNEL_POLARITY = 0x8c,


};

enum DS2408ControlRegisterBits : uint8_t {
	PLS = 0,
	CT = 1,
	ROS = 2,
	PORL = 3,
	VCCP = 7,
};

class DS2408Listener {
public:

	virtual ~DS2408Listener() {}

	/**
	 * A listener which will be called when the master changes the GPIO state
	 * @param bits
	 */
	virtual void gpioOut(uint8_t bits) =0;
};

/**
 * DS2408 One Wire emulation
 */
class DS2408: public OneWireSlave {

protected:
	DS2408State _deviceState = DS2408State::READY;
	uint8_t _gpioBitsForMaster = 0;
	uint8_t _gpioBitsFromMaster = 0;
	DS2408Listener &_listener;
	uint8_t _registerAddress = 0;
	uint8_t _latchedState = 0;
	uint8_t _latchedActivity = 0;
	uint8_t _conditionalSearchSelection = 0;
	uint8_t _conditionalSearchPolarity = 0;
	uint8_t _control = (1 << VCCP) | (1 << PORL);
	int8_t _channelOpsRemaining = 0;

public:
	DS2408(PinName pin, DS2408Listener &listener, OneWireAddress &address);
	void setGpioReported(uint8_t bit, bool value);
	bool getGpioReported(uint8_t bit);
	bool getGpioFromMaster(uint8_t bit);

protected:
	bool alarmed();
	void readRegister();
	void handleCommand(DS2408Command command);
	void deviceReceive();
	void masterToReadCompleted();
	void reset();


};

} /* namespace infernoembedded */

#endif /* DS2408_H_ */

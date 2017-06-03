#ifndef SWITCHMASTER_H_
#define SWITCHMASTER_H_

#define NDEBUG
#include "mbed.h"
#include <stdint.h>

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
	 * Get the number of switch channels per port (max 64)
	 * @return the number of channels
	 */
	virtual uint8_t countChannelsPerPort() =0;

	/**
	 * Get the number of switch ports
	 * @return the number of ports
	 */
	virtual uint8_t countPorts() =0;

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
	 * Get the number of led channels per port
	 * @return the number of channels
	 */
	virtual uint8_t countChannelsPerPort() =0;

	/**
	 * Get the number of led ports
	 * @return the number of ports
	 */
	virtual uint8_t countPorts() =0;

	/**
	 * Set an LED's mode
	 * @param port the port of the LED
	 * @param channel the channel of the LED
	 * @param on true if the LED should be on
	 */
	virtual void setState(uint8_t port, uint8_t channel, bool on) =0;

	/**
	 * Get the state of all LEDs on a port
	 * @param port the port of the LED
	 * @return the bitfield of all the LEDs on the port
	 */
	virtual uint64_t getState(uint8_t port) =0;
};


/**
 * SwitchMaster base class
 */
class SwitchMaster : public SoftDevice {
protected:
	SwitchListener &_switchListener;
	LEDListener &_ledListener;
	uint64_t _activatedState;
	uint8_t _currentPort;

public:
	SwitchMaster(PinName pin, OneWireAddress &address, SwitchListener &switchListener, LEDListener &ledListener);
	void commandDespatch(uint8_t command);
	void commandCountSwitches();
	void commandCountLEDs();
	void commandSwitchType();
	void commandGetSwitchState();
	void commandGetActivatedState();
	void commandSetLEDs();
	void commandSetLED();
	void commandGetLED();
	void switchHasBeenActivated();
	void masterToReadCompleted();
};

} /* namespace infernoembedded */

#endif /* SWITCHMASTER_H_ */

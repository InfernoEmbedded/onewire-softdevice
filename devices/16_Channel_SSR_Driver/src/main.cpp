/* Inferno Embedded 16 Channel SSR Driver
 * Copyright (C) 2018 Inferno Embedded
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

#include "mbed.h"

#include <SwitchMaster.h>
#define WANT_TRACE 1
#include "trace.h"

using namespace infernoembedded;

#if WANT_TRACE
Serial trace(USBTX, USBRX, "trace", 921600);
#endif

#define DEBOUNCE_PERIOD 100 // milliseconds
Timer timer;

#define NUM_CHANNELS ((uint8_t)2)
#define NUM_PORTS			8

class MySwitchMaster : public SwitchMaster<NUM_PORTS, NUM_CHANNELS, 0, 0, NUM_PORTS, NUM_CHANNELS> {
protected:
	uint8_t _relayPorts = 0;
	uint8_t _switchPorts = 0;

	/**
	 * Override the switch master count
	 * Writes:
	 * 	1 byte containing the number of ports
	 * 	1 byte containing the number of switches
	 */
	void commandCountSwitches() {
		masterToRead(_switchPorts);
		masterToRead(NUM_CHANNELS);
	}

	/**
	 * Override the switch master count
	 * Writes:
	 * 	1 byte containing the number of ports
	 * 	1 byte containing the number of switches
	 */
	void commandCountRelays() {
		masterToRead(_relayPorts);
		masterToRead(NUM_CHANNELS);
	}

public:
	/**
	 * Constructor
	 * @param pin	the pin the 1wire interface is on
	 * @param address	the 1wire address of the device (only the lowest 48 bits are considered)
	 * @param switchListener	a listener for switch commands
	 * @param ledListener		a listener for LED commands
	 */
	MySwitchMaster(PinName pin, OneWireAddress &address, SwitchListener &switchListener, LEDListener &ledListener, RelayListener &relayListener)
		: SwitchMaster(pin, address, switchListener, ledListener, relayListener) {}

	void setRelayPorts(uint8_t ports) {
		_relayPorts = ports;
	}

	void setSwitchPorts(uint8_t ports) {
		_switchPorts = ports;
	}
};

static void gpioIrqHandler(uint32_t id, gpio_irq_event event);

typedef struct switchPin {
    gpio_t gpio;
    gpio_irq_t gpio_irq;
    int lastActivation = 0;
    SwitchMode mode = SwitchMode::TOGGLE_PULL_DOWN;
} SwitchPin;

/**
 * Represents a switch port
 */
class Port {
protected:
	MySwitchMaster &_master;
	uint8_t _switchCount;
	uint64_t _activations = 0;
	uint8_t _id;
	SwitchPin _channels[NUM_CHANNELS];
	PinName *_pins;

public:
	/**
	 * Constructor
	 * @param id the port id
	 * @param master the master to notify that a switch has been activated
	 * @param pins an array on pinCount switches
	 * @param switchCount the number of switches (maximum of 8)
	 */
	Port(uint8_t id, MySwitchMaster &master, PinName *pins, uint8_t switchCount) :
		_master(master), _switchCount(switchCount), _id(id), _pins(pins) {
	}

	/**
	 * Get the number of switches on this port
	 * @return the number of switches
	 */
	uint8_t countSwitches() {
		return _switchCount;
	}

	/**
	 * Get the metadata for a channel
	 * @param channel which channel to get
	 * @return a pointer to the metadata
	 */
	SwitchPin *getChannel(uint8_t channel) {
		return &(_channels[channel]);
	}

	/**
	 * Activate a switch
	 * @param switchChannel the channel of the switch
	 */
	void activateSwitch(uint8_t switchChannel) {
		int now = timer.read_ms();
		int delta = now - _channels[switchChannel].lastActivation;
		if (delta > 0 && delta < DEBOUNCE_PERIOD) {
			_channels[switchChannel].lastActivation = now;
			return;
		}

		TRACE("activate port %d channel %d", _id, switchChannel);

		_activations |= 1 << switchChannel;
		_master.switchHasBeenActivated();
	}

	/**
	 * Set the mode of a switch
	 * @param channel the switch channel
	 * @param mode the mode of the switch
	 */
	void setMode(uint8_t channel, SwitchMode mode) {
		if (channel >= _switchCount) {
			return;
		}

		gpio_init(&_channels[channel].gpio, _pins[channel]);
		gpio_dir(&_channels[channel].gpio, PIN_INPUT);

		uint32_t chan = (uint32_t)channel << 16;

		gpio_irq_init(&_channels[channel].gpio_irq, _pins[channel], (&gpioIrqHandler), (uint32_t) this + 0x40000000 + chan); // Distinguish this from the OneWireSlave interrupt
		gpio_irq_set(&_channels[channel].gpio_irq, IRQ_FALL, 1);
		gpio_irq_set(&_channels[channel].gpio_irq, IRQ_RISE, 1);
		gpio_irq_enable(&_channels[channel].gpio_irq);

		switch (mode) {
		case SwitchMode::TOGGLE_PULL_UP:
		case SwitchMode::MOMENTARY_PULL_UP:
			gpio_mode(&_channels[channel].gpio, PinMode::PullUp);
			break;
		case SwitchMode::MOMENTARY_PULL_DOWN:
		case SwitchMode::TOGGLE_PULL_DOWN:
			gpio_mode(&_channels[channel].gpio, PinMode::PullDown);
			break;
		}

		_channels[channel].mode = mode;
	}

	/**
	 * Get the raw state of a switch
	 * @param channel, the channel of the switch
	 */
	bool getState(uint8_t channel) {
		if (channel >= _switchCount) {
			return false;
		}
		return gpio_read(&_channels[channel].gpio);
	}

	/**
	 * Get the switch activations for this port
	 */
	uint64_t getActivations() {
		uint64_t activations = _activations;
		_activations &= ~activations;

		if (_activations) {
			_master.switchHasBeenActivated();
		}

		return activations;
	}
};


PinName portPins[NUM_PORTS][NUM_CHANNELS] = {
		{PC_9, PC_8},
		{PC_7, PC_6},
		{PB_15, PB_14},
		{PB_13, PB_12},
		{PB_11, PB_2},
		{PB_1, PB_0},
		{PC_5, PC_4},
		{PA_7, PA_6},  // PA_6 not connected on Rev 1.1 boards
};


class MySwitchListener : public SwitchListener {
protected:
	Port *_ports[NUM_PORTS] = {NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL};
	uint8_t _portCount;

public:
	MySwitchListener(uint8_t portCount): _portCount(portCount) {};

	/**
	 * Tell the listener about a port
	 * @param index	the index of the port
	 * @param port a pointer to the port
	 */
	void setPort(uint8_t index, Port *port) {
		_ports[index] = port;
	}

	void setMode(uint8_t port, uint8_t channel, SwitchMode mode) {
		if (port >= _portCount || NULL == _ports[port]) {
			return;
		}

		_ports[port]->setMode(channel, mode);
	}

	bool getState(uint8_t port, uint8_t channel) {
		if (port >= _portCount || NULL == _ports[port]) {
			return false;
		}

		return _ports[port]->getState(channel);
	}

	uint64_t getActivations(uint8_t port) {
		if (port >= _portCount || NULL == _ports[port]) {
			return 0;
		}

		return _ports[port]->getActivations();
	}
};

class MyLEDListener : public LEDListener {
	void setState(uint8_t port __attribute__((unused)), uint8_t channel __attribute__((unused)), bool on __attribute__((unused))) {}
	uint64_t getState(uint8_t port __attribute__((unused))) {return 0;}
};

class MyRelayListener : public RelayListener {
protected:
	DigitalOut _channels[NUM_PORTS][NUM_CHANNELS] = {
					{portPins[0][0], portPins[0][1]},
					{portPins[1][0], portPins[1][1]},
					{portPins[2][0], portPins[2][1]},
					{portPins[3][0], portPins[3][1]},
					{portPins[4][0], portPins[4][1]},
					{portPins[5][0], portPins[5][1]},
					{portPins[6][0], portPins[6][1]},
					{portPins[7][0], portPins[7][1]},
	};

	uint8_t _portCount;


public:
	MyRelayListener(uint8_t portCount): _portCount(portCount) {};

	void setState(uint8_t port, uint8_t channel, bool state) {
		if (port >= _portCount) {
			return;
		}

		if (channel >= NUM_CHANNELS) {
			return;
		}

		_channels[port][channel] = state ? 1 : 0;

		TRACE("Setting %d:%d %s", port, channel, state ? "on" : "off");
	}

	bool getState(uint8_t port, uint8_t channel) {
		if (port >= _portCount) {
			return false;
		}

		return !!_channels[port][channel].read();
	}
};

/**
 * Handle incoming GPIO interrupts
 * @param id
 * @param event
 */
static void gpioIrqHandler(uint32_t id, gpio_irq_event event) {
	if (!(id & 0x40000000)) {
		MySwitchMaster *slave = (MySwitchMaster *) id;

		// We have intercepted the OneWire slave handler - send it back
		if (event == IRQ_FALL) {
			slave->pinFall();
		} else {
			slave->pinRise();
		}
		return;
	}

	uint8_t channel = (id >> 16) & 0xFF;
	Port *port = (Port *) (id & 0x2F00FFFF);

	SwitchPin *pin = port->getChannel(channel);


	switch (pin->mode) {
	case SwitchMode::TOGGLE_PULL_UP:
	case SwitchMode::TOGGLE_PULL_DOWN:
		port->activateSwitch(channel);
		break;
	case SwitchMode::MOMENTARY_PULL_UP:
		if (event == IRQ_FALL) {
			port->activateSwitch(channel);
		}
		break;
	case SwitchMode::MOMENTARY_PULL_DOWN:
		if (event == IRQ_RISE) {
			port->activateSwitch(channel);
		}
		break;
	}
}

DigitalIn inputCountBit0(PA_8, PullUp);
DigitalIn inputCountBit1(PA_9, PullUp);
DigitalIn inputCountBit2(PA_10, PullUp);

int main() __attribute__((used));
int main() {
	timer.start();

	for (uint8_t port = 0; port < NUM_PORTS; port++) {
		for (uint8_t channel = 0; channel < NUM_CHANNELS; channel++) {
		}
	}

	uint8_t inputPortCount = 0;
	if (!inputCountBit2){
		inputPortCount += 4;
	}
	if (!inputCountBit1){
		inputPortCount += 2;
	}
	if (!inputCountBit0){
		inputPortCount += 1;
	}

	if (inputPortCount) {
		TRACE("Binding ports %d-%d as inputs", NUM_PORTS - inputPortCount, NUM_PORTS - 1);
	}

	MySwitchListener switchListener(inputPortCount);
	MyLEDListener ledListener;
	MyRelayListener relayListener(NUM_PORTS - inputPortCount);

	OneWireAddress address = {.value = 0};
	MySwitchMaster dev(PF_0, address, switchListener, ledListener, relayListener);
	dev.setSwitchPorts(inputPortCount);
	dev.setRelayPorts(NUM_PORTS - inputPortCount);

	for (uint8_t port = 0; port < inputPortCount; port++) {
		uint8_t portOffset = NUM_PORTS - inputPortCount + port; // Leave the first N ports as outputs

		Port *portInstance = new Port(port, dev, portPins[portOffset], NUM_CHANNELS);
		switchListener.setPort(port, portInstance);
		portInstance->setMode(0, SwitchMode::TOGGLE_PULL_UP); // Default inputs to toggle switches with internal pullups
		portInstance->setMode(1, SwitchMode::TOGGLE_PULL_UP);
	}

	TRACE("16 Channel SSR online, built " __DATE__ " " __TIME__);
	TRACE("SystemCoreClock = %ld Hz", SystemCoreClock);
	dev.getAddress(address);
	TRACE("Address = %02x.%02x%02x%02x%02x%02x%02x.%02x", address.bytes[0], address.bytes[1], address.bytes[2],
					address.bytes[3], address.bytes[4], address.bytes[5], address.bytes[6], address.bytes[7]);

    while (1) {
    	dev.poll();
    }
}

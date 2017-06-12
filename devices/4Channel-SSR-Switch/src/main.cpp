/* Inferno Embedded 4 Channel SSR
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

#include "mbed.h"

#include <SwitchMaster.h>
#include "hal_tick.h"
#define WANT_TRACE 1
#include "trace.h"

using namespace infernoembedded;

#if WANT_TRACE
Serial trace(USBTX, USBRX, "trace", 921600);
#endif

#define DEBOUNCE_PERIOD 100 // milliseconds
Timer timer;

#define MAX_SWITCH_CHANNELS 4
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
	SwitchMaster<2, 4, 0, 0, 2, 2> &_master;
	uint8_t _switchCount;
	uint64_t _activations = 0;
	uint8_t _id;

public:
	SwitchPin _channels[MAX_SWITCH_CHANNELS];

	/**
	 * Constructor
	 * @param id the port id
	 * @param master the master to notify that a switch has been activated
	 * @param switches an array on pinCount switches
	 * @param switchCount the number of switches (maximum of 8)
	 */
	Port(uint8_t id, SwitchMaster<2, 4, 0, 0, 2, 2> &master, PinName *switches, uint8_t switchCount) : _master(master), _switchCount(switchCount), _id(id) {
		for (uint8_t channel = 0; channel < _switchCount; channel++) {
			gpio_init(&_channels[channel].gpio, switches[channel]);
			gpio_dir(&_channels[channel].gpio, PIN_INPUT);

			setMode(channel, SwitchMode::TOGGLE_PULL_UP);
			uint32_t chan = (uint32_t)channel << 16;

			gpio_irq_init(&_channels[channel].gpio_irq, switches[channel], (&gpioIrqHandler), (uint32_t) this + 0x40000000 + chan); // Distinguish this from the OneWireSlave interrupt
			gpio_irq_set(&_channels[channel].gpio_irq, IRQ_FALL, 1);
			gpio_irq_set(&_channels[channel].gpio_irq, IRQ_RISE, 1);
			gpio_irq_enable(&_channels[channel].gpio_irq);
		}
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

		TRACE("Setting mode %d on channel %u", (int)mode, channel);

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

// P2
PinName port0Pins[] = {PC_0, PC_2, PC_5, PA_0};

// P3
PinName port1Pins[] = {PF_5, PA_5, PA_7, PB_1};


class MySwitchListener : public SwitchListener {
protected:
	Port *_ports[2] = {NULL, NULL};

public:
	/**
	 * Tell the listener about a port
	 * @param index	the index of the port
	 * @param port a pointer to the port
	 */
	void setPort(uint8_t index, Port *port) {
		_ports[index] = port;
	}

	void setMode(uint8_t port, uint8_t channel, SwitchMode mode) {
		if (port >= 8 || NULL == _ports[port]) {
			return;
		}

		_ports[port]->setMode(channel, mode);
	}

	bool getState(uint8_t port, uint8_t channel) {
		if (port >= 8 || NULL == _ports[port]) {
			return false;
		}

		return _ports[port]->getState(channel);
	}

	uint64_t getActivations(uint8_t port) {
		if (port >= 8 || NULL == _ports[port]) {
			return 0;
		}

		return _ports[port]->getActivations();
	}
};

class myLEDListener : public LEDListener {
	void setState(uint8_t port, uint8_t channel, bool on) {}
	uint64_t getState(uint8_t port) {return 0;}
};

class myRelayListener : public RelayListener {
protected:
#define PORT_COUNT	2
	DigitalOut _channels[PORT_COUNT][2] = {
					{PB_9, PB_7},
					{PB_5, PB_3},
	};

public:
	void setState(uint8_t port, uint8_t channel, bool state) {
		if (port >= PORT_COUNT) {
			return;
		}

		if (channel >= 2) {
			return;
		}

		_channels[port][channel] = state ? 1 : 0;

		TRACE("Setting %d:%d %s", port, channel, state ? "on" : "off");
	}

	bool getState(uint8_t port, uint8_t channel) {
		return !!_channels[port][channel].read();
	}
};

MySwitchListener switchListener;
myLEDListener ledListener;
myRelayListener relayListener;

OneWireAddress address;
SwitchMaster<2, 4, 0, 0, 2, 2> dev(PB_0, address, switchListener, ledListener, relayListener);

/**
 * Handle incoming GPIO interrupts
 * @param id
 * @param event
 */
static void gpioIrqHandler(uint32_t id, gpio_irq_event event) {
	if ((id & 0xF0000000) == 0x20000000) {
		OneWireSlave *slave = (OneWireSlave *) id;

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

Port port0(0, dev, port0Pins, 6);
Port port1(1, dev, port1Pins, 6);


int main() {
	TRACE("Binding ports");

	timer.start();

	switchListener.setPort(0, &port0);
	switchListener.setPort(1, &port1);

	TRACE("4 Channel SSR Online, SystemCoreClock = %ld Hz", SystemCoreClock);

	dev.getAddress(address); // populate the family & CRC
	TRACE("Address = %02x.%02x%02x%02x%02x%02x%02x.%02x", address.bytes[0], address.bytes[1], address.bytes[2],
					address.bytes[3], address.bytes[4], address.bytes[5], address.bytes[6], address.bytes[7]);

    while (1) {
    	dev.poll();
    }
}

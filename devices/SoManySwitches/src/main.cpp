#include "mbed.h"

#include <SwitchMaster.h>
#include "hal_tick.h"
#define WANT_TRACE 1
#include "trace.h"

#include "gpio_api.h"
#include "gpio_irq_api.h"

using namespace infernoembedded;

#if WANT_TRACE
Serial trace(USBTX, USBRX, "trace", 921600);
#endif

#define DEBOUNCE_PERIOD 100 // milliseconds

Timer timer;

#define MAX_SWITCH_CHANNELS 8

class Port;
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
	SwitchMaster &_master;
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
	Port(uint8_t id, SwitchMaster &master, PinName *switches, uint8_t switchCount) : _id(id), _master(master), _switchCount(switchCount) {
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


// J3
PinName port0Pins[] = {PF_5, PA_4, PA_5, PA_6, PA_7, PC_5};

// J4
PinName port1Pins[] = {PC_1, PC_2, PC_3, PA_0, PA_1, PF_4};

// J5
PinName port2Pins[] = {PC_13, PC_14, PC_15, PF_0, PF_1, PC_0};

// J6
PinName port3Pins[] = {PC_12, PB_3, PB_4, PB_5, PB_6, PB_7};

#define PF_8 ((PinName)0x58)
// J7
PinName port4Pins[] = {PF_6, PF_8, PA_14, PA_15, PC_10, PC_11};

// J8
PinName port5Pins[] = {PA_8, PA_9, PA_10, PA_11, PA_12, PA_13};

// J9
PinName port6Pins[] = {PB_14, PB_15, PC_6, PC_7, PC_8, PC_9};

// J10
PinName port7Pins[] = {PB_1, PB_2, PB_10, PB_11, PB_12, PB_13};

class MySwitchListener : public SwitchListener {
protected:
	Port *_ports[8] = {NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL};

public:
	/**
	 * Tell the listener about a port
	 * @param index	the index of the port
	 * @param port a pointer to the port
	 */
	void setPort(uint8_t index, Port *port) {
		_ports[index] = port;
	}

	uint8_t countChannelsPerPort() {
		return 6;
	}

	uint8_t countPorts() {
		return 8;
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

class MyLEDListener : public LEDListener {
public:
	uint8_t countChannelsPerPort() {
		return 0;
	}

	uint8_t countPorts() {
		return 0;
	}

	void setState(uint8_t port, uint8_t channel, bool on) {}

	uint64_t getState(uint8_t port) {
		return 0;
	}

};


MySwitchListener switchListener;
MyLEDListener ledListener;

OneWireAddress address;
SwitchMaster dev(PB_0, address, switchListener, ledListener);

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
Port port2(2, dev, port2Pins, 6);
Port port3(3, dev, port3Pins, 6);
Port port4(4, dev, port4Pins, 6);
Port port5(5, dev, port5Pins, 6);
Port port6(6, dev, port6Pins, 6);
Port port7(7, dev, port7Pins, 6);

int main() {
	TRACE("Binding ports");

	timer.start();

	switchListener.setPort(0, &port0);
	switchListener.setPort(1, &port1);
	switchListener.setPort(2, &port2);
	switchListener.setPort(3, &port3);
	switchListener.setPort(4, &port4);
	switchListener.setPort(5, &port5);
	switchListener.setPort(6, &port6);
	switchListener.setPort(7, &port7);

	/* We seem to clobber the OneWireSlave IRQ handler when we deal with Px_0 GPIO IRQS, so
	 * we'll just set it up here to our own IRQ handler and deal with the pinRise/pinFall calls ourselves.
	 * We identity the switch GPIOs from the OneWire one by adding 0x40000000 to the address.
	 */
	gpio_irq_t dev_irq;
	gpio_irq_init(&dev_irq, PB_0, (&gpioIrqHandler), (uint32_t) &dev);
	gpio_irq_set(&dev_irq, IRQ_FALL, 1);
	gpio_irq_set(&dev_irq, IRQ_RISE, 1);
	gpio_irq_enable(&dev_irq);

	TRACE("SoManySwitches Online, SystemCoreClock = %ld Hz", SystemCoreClock);
	dev.getAddress(address); // populate the family & CRC

	TRACE("Address = %02x.%02x%02x%02x%02x%02x%02x.%02x", address.bytes[0], address.bytes[1], address.bytes[2],
					address.bytes[3], address.bytes[4], address.bytes[5], address.bytes[6], address.bytes[7]);

    while (1) {
    	dev.poll();
    }
}

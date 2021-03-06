/* Inferno Embedded RGBW Controller
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

#include <RGBWController.h>
#define WANT_TRACE 1
#include "trace.h"
#include "SoftwarePWM.h"

using namespace infernoembedded;

#define PWM_PERIOD 10000 // microseconds
#define FADE_UPDATE_PERIOD  40 // milliseconds
#define FADE_UPDATE_PWM_TICKS ((FADE_UPDATE_PERIOD * 1000 * 512) / PWM_PERIOD)
#define PWM_CHANNELS 16

#if WANT_TRACE
#if CHANNELS_4
Serial trace(USBTX, USBRX, "trace", 921600);
#endif
#endif

static TIM_HandleTypeDef htim15;
static uint16_t fadeCounter;

class Fader {
private:
	SoftwarePWMPin &_red;
	SoftwarePWMPin &_green;
	SoftwarePWMPin &_blue;
	SoftwarePWMPin &_white;

#define COUNTER_OFF	UINT32_MAX
	volatile uint32_t _counter = COUNTER_OFF;
	uint32_t _lastUpdate;

	ChannelData _target;

	uint8_t _startRed;
	uint8_t _startGreen;
	uint8_t _startBlue;
	uint8_t _startWhite;

	int16_t _deltaRed;
	int16_t _deltaGreen;
	int16_t _deltaBlue;
	int16_t _deltaWhite;

	bool _active; // true if the channel needs power

public:
	Fader(SoftwarePWM<PWM_CHANNELS> &pwm, SoftwarePWMPin &red, SoftwarePWMPin &green, SoftwarePWMPin &blue, SoftwarePWMPin &white) : _red(red), _green(green), _blue(blue), _white(white) {
		pwm.addListener(red);
		pwm.addListener(green);
		pwm.addListener(blue);
		pwm.addListener(white);
	}

	/**
	 * Start fading to a new colour over a period of time
	 * @param data the colour & fade time
	 */
	void fadeTo(ChannelData &data) {
		_active = true;

		_startRed = _target.red;
		_startGreen = _target.green;
		_startBlue = _target.blue;
		_startWhite = _target.white;

		_deltaRed = data.red - _startRed;
		_deltaGreen = data.green - _startGreen;
		_deltaBlue = data.blue - _startBlue;
		_deltaWhite = data.white - _startWhite;

		_target.red = data.red;
		_target.green = data.green;
		_target.blue = data.blue;
		_target.white = data.white;
		_target.fadeTime = data.fadeTime;

		TRACE("Start=%d,%d,%d,%d", _startRed, _startGreen, _startBlue, _startWhite);
		TRACE("Delta=%d,%d,%d,%d", _deltaRed, _deltaGreen, _deltaBlue, _deltaWhite);
		TRACE("Target=%d,%d,%d,%d", _target.red, _target.green, _target.blue, _target.white);

		_counter = 0;
		_lastUpdate = 0;
	}

	/**
	 * Tick the counter
	 */
	void tick() {
		if (_counter != COUNTER_OFF) {
			_counter += FADE_UPDATE_PERIOD;
		}
	}

	/**
	 * Update the colours to implement the fade
	 */
	void poll() {
		if (_counter == COUNTER_OFF || _counter <= _lastUpdate) {
			return;
		}

		// deal with the end case
		if (_counter >= _target.fadeTime) {
			TRACE("%ld >= %ld", _counter, _target.fadeTime);

			_red.setDutyCycle(_target.red);
			_green.setDutyCycle(_target.green);
			_blue.setDutyCycle(_target.blue);
			_white.setDutyCycle(_target.white);

			_target.fadeTime = 0;

			_counter = COUNTER_OFF;

			if ((_target.red == 0) && (_target.green == 0) && (_target.blue == 0) && (_target.white == 0)) {
				_active = false;
			}

			TRACE("Fade completed");

			return;
		}

		int32_t val = _counter * _deltaRed;
		int32_t delta = val / (int32_t)_target.fadeTime;
		_red.setDutyCycle(_startRed + delta);

		val = _counter * _deltaGreen;
		delta = val / (int32_t)_target.fadeTime;
		_green.setDutyCycle(_startGreen + delta);

		val = _counter * _deltaBlue;
		delta = val / (int32_t)_target.fadeTime;
		_blue.setDutyCycle(_startBlue + delta);

		val = _counter * _deltaWhite;
		delta = val / (int32_t)_target.fadeTime;
		_white.setDutyCycle(_startWhite + delta);

//		TRACE("Fade %d %d %d %d %lums remaining",
//				_red.getDutyCycle(), _green.getDutyCycle(), _blue.getDutyCycle(), _white.getDutyCycle(),
//				_target.fadeTime - _counter);

		_lastUpdate = _counter;
	}

	/**
	 * Get the current colour & time remaining
	 * @param data the colour & time data
	 */
	void getCurrent(ChannelData &data) {
		data.red = _red.getDutyCycle();
		data.green = _green.getDutyCycle();
		data.blue = _blue.getDutyCycle();
		data.white = _white.getDutyCycle();

		if (_counter != COUNTER_OFF && _counter < _target.fadeTime) {
			data.fadeTime = _target.fadeTime - _counter;
		} else {
			data.fadeTime = 0;
		}
	}

	/**
	 * Check if the channel is active
	 * @return true if the channel is active
	 */
	bool isActive() {
		return _active;
	}
};


gpio_t mainsPin;
SoftwarePWM<PWM_CHANNELS> pwm;

#if CHANNELS_4
SoftwarePWMPin white0(PB_7);
SoftwarePWMPin blue0(PB_5);
SoftwarePWMPin red0(PB_3);
SoftwarePWMPin green0(PC_12);

SoftwarePWMPin white1(PF_7);
SoftwarePWMPin blue1(PA_11);
SoftwarePWMPin red1(PA_9);
SoftwarePWMPin green1(PC_9);

SoftwarePWMPin white2(PC_7);
SoftwarePWMPin blue2(PB_15);
SoftwarePWMPin red2(PB_13);
SoftwarePWMPin green2(PB_12);

SoftwarePWMPin white3(PB_10);
SoftwarePWMPin blue3(PB_1);
SoftwarePWMPin red3(PC_5);
SoftwarePWMPin green3(PA_7);

Fader channel0(pwm, red0, green0, blue0, white0);
Fader channel1(pwm, red1, green1, blue1, white1);
Fader channel2(pwm, red2, green2, blue2, white2);
Fader channel3(pwm, red3, green3, blue3, white3);

class Listener : public CountedRGBWListener<4> {
#else
SoftwarePWMPin white0(PA_8);
SoftwarePWMPin blue0(PA_9);
SoftwarePWMPin red0(PA_10);
SoftwarePWMPin green0(PA_11);

SoftwarePWMPin white1(PC_6);
SoftwarePWMPin blue1(PC_7);
SoftwarePWMPin red1(PC_8);
SoftwarePWMPin green1(PC_9);

Fader channel0(pwm, red0, green0, blue0, white0);
Fader channel1(pwm, red1, green1, blue1, white1);

class Listener : public CountedRGBWListener<2> {
#endif
	void setChannel(ChannelData &data) {
		switch (data.channel) {
		case 0:
			channel0.fadeTo(data);
			break;
		case 1:
			channel1.fadeTo(data);
			break;
#if CHANNELS_4
		case 2:
			channel2.fadeTo(data);
			break;
		case 3:
			channel3.fadeTo(data);
			break;
#endif
		default:
			TRACE("unknown channel");
			break;
		}
		TRACE("%d: %d %d %d %d %ldms", data.channel, data.red, data.green, data.blue, data.white, data.fadeTime);
	}

	void getChannel(uint8_t channel, ChannelData &data) {
		switch (channel) {
		case 0:
			channel0.getCurrent(data);
			break;
		case 1:
			channel1.getCurrent(data);
			break;
#if CHANNELS_4
		case 2:
			channel2.getCurrent(data);
			break;
		case 3:
			channel3.getCurrent(data);
			break;
#endif
		default:
			TRACE("Unknown channel");
		}
	}
};

Listener listener;
OneWireAddress address;
#if CHANNELS_4
RGBWController dev(PF_0, address, listener);
#else
RGBWController dev(PB_2, address, listener);
#endif

/**
 * Turn on the SSR for mains control
 */
void mainsOn() {
	TRACE("mains on");
	gpio_write(&mainsPin, 0);
}

/**
 * Turn off the SSR for mains control
 */
void mainsOff() {
	TRACE("mains off");
	gpio_write(&mainsPin, 1);
}

extern "C" {
static void TIM15_IRQHandler() __attribute__((used));
static void TIM15_IRQHandler() {
	__HAL_TIM_CLEAR_IT(&htim15, TIM_IT_UPDATE);

	pwm.tick();

	if (++fadeCounter == FADE_UPDATE_PWM_TICKS) {
		channel0.tick();
		channel1.tick();
#if CHANNELS_4
		channel2.tick();
		channel3.tick();
#endif
		fadeCounter = 0;
	}
}
} // extern "C"

/**
 * Trigger the TIM15 update interrupt periodically
 * @param period the cycle time in us
 */
void tim15Ticker(uint32_t period) {
	TIM_ClockConfigTypeDef sClockSourceConfig;
	TIM_MasterConfigTypeDef sMasterConfig;

	/* Peripheral clock enable */
	__HAL_RCC_TIM15_CLK_ENABLE();

	htim15.Instance = TIM15;
	htim15.Init.Prescaler = (uint32_t)(SystemCoreClock / 1000000) - 1; // 1 us tick
	htim15.Init.CounterMode = TIM_COUNTERMODE_UP;
	htim15.Init.Period = period;
	htim15.Init.ClockDivision = TIM_CLOCKDIVISION_DIV1;
#ifdef TARGET_STM32F0
    htim15.Init.AutoReloadPreload = TIM_AUTORELOAD_PRELOAD_DISABLE;
#endif

	if (HAL_TIM_Base_Init(&htim15) != HAL_OK) {
		TRACE("Timer redirect failure");
		for (;;) {}
	}

	sClockSourceConfig.ClockSource = TIM_CLOCKSOURCE_INTERNAL;

	if (HAL_TIM_ConfigClockSource(&htim15, &sClockSourceConfig) != HAL_OK) {
		TRACE("Timer redirect failure");
		for (;;) {}
	}

	sMasterConfig.MasterOutputTrigger = TIM_TRGO_UPDATE;
	sMasterConfig.MasterSlaveMode = TIM_MASTERSLAVEMODE_DISABLE;
	if (HAL_TIMEx_MasterConfigSynchronization(&htim15, &sMasterConfig) != HAL_OK) {
		TRACE("Timer redirect failure");
		for (;;) {}
	}

	NVIC_SetPriority(TIM15_IRQn, 1);
	NVIC_SetVector(TIM15_IRQn, (uint32_t)&TIM15_IRQHandler);
	NVIC_EnableIRQ(TIM15_IRQn);

	__HAL_TIM_ENABLE_IT(&htim15, TIM_IT_UPDATE);
	__HAL_TIM_ENABLE(&htim15);
	HAL_TIM_Base_Start(&htim15);
}

int main() __attribute__((used));
int main() {
	bool mains;

#if !CHANNELS_4
	extern serial_t stdio_uart;
	extern int stdio_uart_inited;

	serial_init(&stdio_uart, PB_6, PB_7);
	stdio_uart_inited = 1;
	serial_baud(&stdio_uart, 921600);
#endif

#if CHANNELS_4
	gpio_init(&mainsPin, PC_2);
#else
	gpio_init(&mainsPin, PF_4);
#endif
	gpio_dir(&mainsPin, PIN_OUTPUT);
	gpio_mode(&mainsPin, OpenDrain);

	tim15Ticker(PWM_PERIOD / 512);

	TRACE("Online, SystemCoreClock = %ld Hz", SystemCoreClock);
	dev.getAddress(address); // populate the family & CRC

	TRACE("Address = %02x.%02x%02x%02x%02x%02x%02x.%02x", address.bytes[0], address.bytes[1], address.bytes[2],
					address.bytes[3], address.bytes[4], address.bytes[5], address.bytes[6], address.bytes[7]);

    while (1) {
    	dev.poll();
    	channel0.poll();
    	channel1.poll();
#if CHANNELS_4
    	channel2.poll();
    	channel3.poll();
#endif
    	if (channel0.isActive() || channel1.isActive()
#if CHANNELS_4
    					|| channel2.isActive() || channel3.isActive()
#endif
    					) {
    		if (!mains) {
    			mainsOn();
    			mains = true;
    		}
    	} else {
    		if (mains) {
    			mainsOff();
    			mains = false;
    		}
    	}
    }
}

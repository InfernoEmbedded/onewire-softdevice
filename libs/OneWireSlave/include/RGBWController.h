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


#ifndef FIRMWARE_UPDATER_H_
#define FIRMWARE_UPDATER_H_

#include "mbed.h"
#include <stdint.h>

#include "SoftDevice.h"

namespace infernoembedded {

typedef struct channelData {
#define INVALID_CHANNEL 0xFF
	uint8_t channel;
	uint8_t red;
	uint8_t green;
	uint8_t blue;
	uint8_t white;
	uint32_t fadeTime;
} ChannelData;

class RGBWListener {
public:
	/**
	 * Called to fade a channel to a new colour when committed
	 * @param data the channel data
	 */
	virtual void saveChannel(ChannelData &data) = 0;

	/**
	 * Called to count the number of available channels
	 * @return the number of channels
	 */
	virtual uint8_t getChannelCount() =0;

	/**
	 * Get the current state of a channel
	 * @param channel the channel to get
	 * @param data[out] the channel data
	 */
	virtual void getChannel(uint8_t channel, ChannelData &data) =0;

	/**
	 * Commit the saved operations
	 */
	virtual void commit() =0;
};

template<uint8_t channelCount> class CountedRGBWListener : public RGBWListener {
protected:
	ChannelData _channels[channelCount];

public:
	CountedRGBWListener() {
		for (uint8_t channel = 0; channel < channelCount; channel++) {
			_channels[channel].channel = INVALID_CHANNEL;
		}
	}

	/**
	 * Called to count the number of available channels
	 * @return the number of channels
	 */
	uint8_t getChannelCount() {
		return channelCount;
	}

	/**
	 * Called to fade a channel to a new colour when committed
	 * @param data the channel data
	 */
	void saveChannel(ChannelData &data) {
		if (data.channel < channelCount) {
			_channels[data.channel].channel = data.channel;
			_channels[data.channel].red = data.red;
			_channels[data.channel].green = data.green;
			_channels[data.channel].blue = data.blue;
			_channels[data.channel].white = data.white;
			_channels[data.channel].fadeTime = data.fadeTime;
		}
	}

	/**
	 * Commit the saved operations
	 */
	void commit() {
		for (uint8_t channel = 0; channel < channelCount; channel++) {
			if (_channels[channel].channel != INVALID_CHANNEL) {
				setChannel(_channels[channel]);
				_channels[channel].channel = INVALID_CHANNEL;
			}
		}
	}

	/**
	 * Called when committed to fade a channel to a new colour
	 * @param data the channel data
	 */
	virtual void setChannel(ChannelData &data) =0;


};

/**
 * RGBWController base class
 */
class RGBWController: public SoftDevice {
protected:
	RGBWListener &_listener;

public:
	RGBWController(PinName pin, OneWireAddress &address, RGBWListener &listener);
	void commandDespatch(uint8_t command);
	void commandAllOff();
	void commandSetChannel();
	void commandGetChannel();
	void commandCountChannels();
	void commandCommit();
	void masterToReadCompleted();
};

} /* namespace infernoembedded */

#endif /* FIRMWARE_UPDATER_H_ */

/*
 * DS2408.cpp
 *
 *  Created on: 20Nov.,2016
 *      Author: Alastair
 */

#include <RGBWController.h>
#include "trace.h"

namespace infernoembedded {

SoftDeviceCommandMetadata rgbwControllerMetadata[] = {
				{"ALL_OFF", 		0x01, 0, 0},
				{"COUNT_CHANNELS",	0x02, 0, 0},
				{"SET_CHANNEL",		0x03, 8, 0},
				{"GET_CHANNEL",		0x04, 1, 0},
				{"COMMIT",			0x05, 0, 0},
};

/**
 * Constructor
 * @param pin	the pin the 1wire interface is on
 * @param address	the 1wire address of the device (only the lowest 48 bits are considered)
 */
RGBWController::RGBWController(PinName pin, OneWireAddress &address, RGBWListener &listener) : SoftDevice(pin, address, RGBW_CONTROLLER, 1, rgbwControllerMetadata), _listener(listener) {}

void RGBWController::commandDespatch(uint8_t command) {
	switch(command) {
	case 0x01:
		commandAllOff();
		break;
	case 0x02:
		commandCountChannels();
		break;
	case 0x03:
		commandSetChannel();
		break;
	case 0x04:
		commandGetChannel();
		break;
	case 0x05:
		commandCommit();
		break;
	}
}

void RGBWController::commandAllOff() {
	uint8_t channelCount = _listener.getChannelCount();
	ChannelData channelData = {0, 0, 0, 0, 0};

	for (int channel = 0; channel < channelCount; channel++) {
		channelData.channel = channel;
		_listener.saveChannel(channelData);
		_listener.commit();
	}
}

void RGBWController::commandSetChannel() {
	ChannelData channelData;

	channelData.channel =  (uint8_t)(_data);
	_data >>= 8;
	channelData.red =      (uint8_t)(_data);
	_data >>= 8;
	channelData.green =    (uint8_t)(_data);
	_data >>= 8;
	channelData.blue =     (uint8_t)(_data);
	_data >>= 8;
	channelData.white =    (uint8_t)(_data);
	_data >>= 8;
	channelData.fadeTime = _data;

	_listener.saveChannel(channelData);
}

void RGBWController::commandGetChannel() {
	uint8_t channel = _data & 0xFF;

	ChannelData channelData;

	_listener.getChannel(channel, channelData);

	masterToRead(channelData.red);
	masterToRead(channelData.green);
	masterToRead(channelData.blue);
	masterToRead(channelData.white);
	masterToRead((uint64_t)channelData.fadeTime, 3);
}

void RGBWController::commandCountChannels() {
	masterToRead(_listener.getChannelCount());
}

void RGBWController::commandCommit() {
	_listener.commit();
}

void RGBWController::masterToReadCompleted() {
}

} /* namespace infernoembedded */

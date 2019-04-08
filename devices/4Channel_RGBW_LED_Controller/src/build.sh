#!/bin/sh

set -e

mbed compile --source . --source ../../../mbed-os --source ../../../libs/OneWireSlave --color --profile=./4channel.json -N 4ChannelRGBWLED
cp BUILD/INFERNOEMBEDDED_SOFTDEVICE/GCC_ARM-4CHANNEL/4ChannelRGBWLED.bin ../../../firmware

mbed compile --source . --source ../../../mbed-os --source ../../../libs/OneWireSlave --color --profile=./2channel.json -N 2ChannelRGBWLED
cp BUILD/INFERNOEMBEDDED_SOFTDEVICE/GCC_ARM-2CHANNEL/2ChannelRGBWLED.bin ../../../firmware

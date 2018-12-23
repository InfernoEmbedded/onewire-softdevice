#!/bin/sh

set -e

mbed compile --source . --source ../../../mbed-os --source ../../../libs/OneWireSlave --color --profile=./release.json -N 4ChannelSSR

cp BUILD/INFERNOEMBEDDED_SOFTDEVICE/GCC_ARM-RELEASE/4ChannelSSR.bin ../../../firmware


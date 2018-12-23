#!/bin/sh

set -e

mbed compile --source . --source ../../../mbed-os --source ../../../libs/OneWireSlave --color --profile=./release.json -N DS2408Emulator

cp BUILD/INFERNOEMBEDDED_SOFTDEVICE/GCC_ARM-RELEASE/DS2408Emulator.bin ../../../firmware


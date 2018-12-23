#!/bin/sh

set -e

mbed compile --source . --source ../../../mbed-os --source ../../../libs/OneWireSlave --color --profile=./release.json -N AirconZoneController

cp BUILD/INFERNOEMBEDDED_SOFTDEVICE/GCC_ARM-RELEASE/AirconZoneController.bin ../../../firmware


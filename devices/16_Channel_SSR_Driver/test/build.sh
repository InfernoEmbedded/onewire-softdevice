#!/bin/sh

set -e

mbed compile --source . --source ../../../mbed-os --color --profile=./release.json -N 16ChannelSSRTest

cp BUILD/NUCLEO_F030R8/GCC_ARM-RELEASE/16ChannelSSRTest.bin ../../../firmware


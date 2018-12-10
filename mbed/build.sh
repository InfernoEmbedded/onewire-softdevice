#!/bin/bash

set -e

export MBED_GCC_ARM_PATH="`pwd`/../toolchain/x-tool/arm-none-eabi/bin/"

cd mbed-os

python2 tools/build.py -c -v -m INFERNOEMBEDDED_SOFTDEVICE_BOOTLOADER -t GCC_ARM -j 4 --profile release
python2 tools/build.py -c -v -m INFERNOEMBEDDED_SOFTDEVICE -t GCC_ARM -j 4 --profile release

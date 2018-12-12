#!/bin/bash

set -e

export MBED_GCC_ARM_PATH="`pwd`/../toolchain/gcc-arm-none-eabi-7-2018-q2-update/bin/"

cd mbed-os

python2 tools/build.py -c -v -m INFERNOEMBEDDED_SOFTDEVICE_BOOTLOADER -t GCC_ARM -j 4 --profile release
#"$MBED_GCC_ARM_PATH/bin/arm-none-eabi-gcc-ranlib BUILD/mbed/TARGET_INFERNOEMBEDDED_SOFTDEVICE_BOOTLOADER/TOOLCHAIN_GCC_ARM/libmbed.a"

python2 tools/build.py -c -v -m INFERNOEMBEDDED_SOFTDEVICE -t GCC_ARM -j 4 --profile release
#"$MBED_GCC_ARM_PATH/bin/arm-none-eabi-gcc-ranlib BUILD/mbed/TARGET_INFERNOEMBEDDED_SOFTDEVICE_BOOTLOADER/TOOLCHAIN_GCC_ARM/libmbed.a"

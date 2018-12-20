#!/bin/sh

set -e

test -z "$1" && {
	echo "Usage: ./flash.sh <onewire pin>"
	echo "	eg. ./flash.sh PF0"
	exit 1
}

st-flash write "./BUILD/INFERNOEMBEDDED_SOFTDEVICE_BOOTLOADER/GCC_ARM-PIN_$1/FirmwareUpdater.bin" 0x8000000


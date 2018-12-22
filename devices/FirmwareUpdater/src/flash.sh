#!/bin/sh

set -e

test -z "$1" && {
	echo "Usage: ./flash.sh <onewire pin>"
	echo "	eg. ./flash.sh PF0"
	exit 1
}

st-flash write "../../../firmware/FirmwareUpdater-$1.bin" 0x8000000


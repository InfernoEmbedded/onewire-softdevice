#!/bin/sh

set -e

file="`mktemp`.bin"

firmware=../../../firmware/16ChannelSSRTest.bin

test -f "$firmware" || {
	echo Firmware '$firmware' not built
	exit 1
}

st-flash write "$firmware" 0x8000000



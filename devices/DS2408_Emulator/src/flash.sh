#!/bin/sh

set -e

file="`mktemp`.bin"

firmware=../../../firmware/DS2408Emulator.bin
bootloader=../../../firmware/FirmwareUpdater-PB2.bin

test -f "$firmware" || {
	echo Firmware '$firmware' not built
	exit 1
}

test -f "$bootloader" || {
	echo Bootloader '$bootloader' not built
	exit 1
}

cp "$bootloader" "$file"
truncate -s 16384 "$file"
cat "$firmware" >> "$file"

st-flash write "$file" 0x8000000

rm "$file"


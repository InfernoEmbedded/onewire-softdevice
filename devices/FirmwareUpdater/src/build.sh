#!/bin/sh

set -e

mbed compile --source . --source ../../../mbed-os --source ../../../libs/OneWireSlave --color --profile=./pin_pb0.json -N FirmwareUpdater
mbed compile --source . --source ../../../mbed-os --source ../../../libs/OneWireSlave --color --profile=./pin_pb2.json -N FirmwareUpdater
mbed compile --source . --source ../../../mbed-os --source ../../../libs/OneWireSlave --color --profile=./pin_pf0.json -N FirmwareUpdater

cp BUILD/INFERNOEMBEDDED_SOFTDEVICE_BOOTLOADER/GCC_ARM-PIN_PB0/FirmwareUpdater.bin ../../../firmware/FirmwareUpdater-PB0.bin
cp BUILD/INFERNOEMBEDDED_SOFTDEVICE_BOOTLOADER/GCC_ARM-PIN_PB2/FirmwareUpdater.bin ../../../firmware/FirmwareUpdater-PB2.bin
cp BUILD/INFERNOEMBEDDED_SOFTDEVICE_BOOTLOADER/GCC_ARM-PIN_PF0/FirmwareUpdater.bin ../../../firmware/FirmwareUpdater-PF0.bin


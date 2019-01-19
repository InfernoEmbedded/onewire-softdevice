#!/bin/sh

set -e

for dir in 4Channel-SSR-Switch/src 4Channel_RGBW_LED_Controller/src Aircon_Zone_Controller/src DS2408_Emulator/src FirmwareUpdater/src SoManySwitches/src 16_Channel_SSR_Driver/src 16_Channel_SSR_Driver/test; do
	rm -rf devices/$dir/BUILD
	pushd devices/$dir
	./build.sh
	popd
done


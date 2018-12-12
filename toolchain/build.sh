#!/bin/bash

set -euo pipefail

pwd=`pwd`

cd crosstool-ng
./bootstrap
./configure --enable-local
make -j $(nproc)

./ct-ng arm-nano-eabi
sed -i 's/CT_TARGET_VENDOR="nano"/CT_TARGET_VENDOR="none"/' .config
sed -i 's/.*CT_EXPERIMENTAL.*/CT_EXPERIMENTAL=y/' .config
sed -i 's/.*CT_ARCH_ARM_MODE.*/CT_ARCH_ARM_MODE="thumb"/' .config
sed -i 's/.*CT_NEWLIB_V_2_5_0=y.*/CT_NEWLIB_V_3_0_0=y/' .config
sed -i 's/.*CT_NEWLIB_VERSION.*/CT_NEWLIB_VERSION="3.0.0.20180831"/' .config

echo CT_ARCH_ARM_MODE_THUMB=y >> .config

./ct-ng "CT_PREFIX=$pwd/x-tool" build



#!/bin/bash

set -euo pipefail

pwd=`pwd`

cd crosstool-ng
./bootstrap
./configure --enable-local
make -j $(nproc)

./ct-ng arm-nano-eabi
sed -i 's/CT_TARGET_VENDOR="nano"/CT_TARGET_VENDOR="none"/' .config

./ct-ng "CT_PREFIX=$pwd/x-tool" build



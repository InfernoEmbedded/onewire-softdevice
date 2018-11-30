#!/bin/bash

set -euo pipefail

cd crosstool-ng
./bootstrap
./configure --enable-local
make -j $(nproc)

./ct-ng arm-nano-eabi
./ct-ng build



setlocal

cd mbed-os
c:\Python27\python.exe tools\build.py -c -v -m INFERNOEMBEDDED_SOFTDEVICE_BOOTLOADER -t GCC_ARM -j 4 --profile release
c:\Python27\python.exe tools\build.py -c -v -m INFERNOEMBEDDED_SOFTDEVICE -t GCC_ARM -j 4 --profile release

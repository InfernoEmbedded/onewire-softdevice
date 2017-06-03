setlocal

cd tools
c:\Python27\python.exe build.py -c -v -m NUCLEO_F030R8 -t GCC_ARM -j 4 --profile release -D DEVICE_SERIAL=0 -D USE_PLL_HSE_EXTC=0 -D USE_PLL_HSE_XTAL=0 -D DEVICE_STDIO_MESSAGES=0

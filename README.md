# About
This repository contains hardware designs and software for implementing slave devices using the [Maxim 1-Wire®](https://www.maximintegrated.com/en/products/digital/one-wire.html) protocol on the STM32 microcontrollers.

# Licensing
Hardware is licensed under the The [TAPR Open Hardware License Version 1.0](http://www.tapr.org/ohl.html)

Software & Firmware is licensed under [GPLv3](https://www.gnu.org/licenses/gpl-3.0.en.html)

# Prerequisites
## Hardware Design
- [Kicad](http://kicad-pcb.org/)
- [ThisIsNotRocketScience Gerber Panelizer](https://github.com/ThisIsNotRocketScience/GerberTools)
- [OpenSCAD](http://www.openscad.org/)
- [Fusion 360](https://www.autodesk.com/products/fusion-360/overview)

## Firmware
- [Eclipse](http://www.eclipse.org/) on Windows (may work on Linux, untested)
- [System Workbench for STM32](http://www.openstm32.org/System+Workbench+for+STM32)
- [MBed](https://github.com/ARMmbed/mbed-os)

# Layout
The libs directory contains source code for the OneWireSlave library.

The devices directory contains schematics, PCBs & firmware for the client devices.

# Devices
## Template
A template schematic with the basics wired up.

## Splitter
A passive Y splitter that allows short CAT5 runs to be broken off the main bus. A typical use would be to allow a short run to be dropped down a wall to a sensor or switch panel. Optionally includes a DS18B20 for temperature sensing.

## DS2408 Emulator
A partial implementation of the DS2408 in software, used for initial testing of the 1-Wire® protocol, but is otherwise unmaintained and unsupported.

## DS2408 4 Channel Switch
A device that accepts 4 switches, and provides 4 solid state relays. A jumper allows the relays to operate independently, or forced to operate in on/off pairs (for roller shutter/projector screen control). Somewhat obsoleted by SoManySwitches.

## Fimware Updater
A sub-16KB bootloader which allows devices that implement the Inferno Embedded commands to update firmware over the bus. The included STM32F030X8.ld linker file stores the bootloader at the start of the flash region. Firmware that is designed to be flashed with this uses a modified linker file that stores the firmware with a 16kB offset.

Inferno Embedded commands allow the device to be rebooted into the bootloader so that they can be updated. The device can also be forced to remain in bootloader mode by shorting SWDAT on the SWD header to GND with a jumper.

## SoManySwitches
A device with 8 RJ45 jacks, which each permit 6 toggle or momentary switches to be connected to the 1-Wire® network. The device will be alarmed when a switch is activated, and can then be polled to identify which switch was activated.

## SoManySwitches Clientboard
A daughterboard for SoManySwitches, designed to be installed at the switch point. The RJ45 socket is broken out into pairs of Gnd/Switch, and pullup/pulldowns are provided to suppress spurious switch activations.

## Aircon Zone Controller
A device that controls up to 8 24VAC air conditioning dampers, following the PolyAire pinout:

| RJ45 Pin  | Signal |
| :-------: | :----- |
| 1         | N/C    |
| 2         | Open   |
| 3         | Open   |
| 4         | Neutral|
| 5         | Neutral|
| 6         | Close  |
| 7         | Close  |
| 8         | N/C    |

By setting the transition time for each damper, the controller can partially open them, allowing balancing to be achieved via software control.

## 4 Channel RGBW LED Controller
A device to control up to 4 channels of common-anode RGBW LED strips, at up to 48V. Fading from the current colour to a new one is handled locally. An external relay can be driven via the Inline SSR board, allowing the LED power supply to be shut down when no strips require power.

## Inline SSR
A small board with a solid state relay installed, designed to be mounted inline in a power cord. It connects to other boards via a headphone cable.

# Hardware Design
## Microcontroller
This software has been developed and tested on the [STM32F030R8 microcontroller](http://www.st.com/en/microcontrollers/stm32f030r8.html), an ARM Cortex-M0 with 64kB of flash & 8kB of RAM. We are running it at 48MHz using the internal RC oscillator. It may be possible to reduce the clock speed, but this is untested. They can be purchased for around AUD$1 each on [Aliexpress](https://www.aliexpress.com/item/20Pcs-STM32F030R8T6-STM32F030-LQFP64-ARM-new/32793433764.html).

Prototype testing can be performed on a [Nucleo-F030R8](https://developer.mbed.org/platforms/ST-Nucleo-F030R8/).



## Microcontroller Pin Usage
A single GPIO from the microcontroller is used to communicate over the 1-Wire® protocol. This is typically pin F0.

## RJ45 Pinout
| RJ45 Pin  | Signal |
| :-------: | :----- |
| 1         | Gnd    |
| 2         | +5V    |
| 3         | Gnd    |
| 4         | 1W Data|
| 5         | Gnd    |
| 6         | N/C    |
| 7         | +24V   |
| 8         | Gnd    |

# Software Design
# Runtime
The library sits on top of the Mbed runtime, altough it is more reliant on the lower level HAL APIs than the Mbed constructs. The bootloader uses a cut-down version of the runtime to allow it to fit within 16kB, however, the cost is that it cannot print to the serial port.

## Low Level (OneWireSlave.cpp)
This file contains the base class for implementing 1-Wire® protocol devices. It provides methods to send and receive data on the bus, and handles device enumeration. It consumes Timer6 which it uses to maintain a 1 uS timer for signal timing. It uses the low level HAL APIs for catching state changes on the GPIO line, as the InterruptIn class added too much latency.

## Protocol Level (SoftDevice.cpp)
This file defines how InfernoEmbedded devices communicate over 1wire. Each device reports a 64 bit type and 64 bit version, so only a single 1-Wire® family code is used (FE).

1wire commands are issued as follows:
Master:
Command Code (1 byte), Command data (up to 8 bytes), CRC8

Slave:
Command good/bad (1 byte)

Slave:
device response (chunks of up to 8 bytes)

Or...

Master:
Streaming data

A 64 bit status register is provided, and the device will show up in alarm scans if any bits are set. On powerup, bit 0 is set (Power-on), allowing the devices to be reinitialised if they need state from the master. The status register is cleared automatically after each read.

## Device Level (SwitchMaster.cpp & friends)
These files provide the device specific implementations. They define the 1-Wire® commands that are accepted, and interact with the user code via Listener classes. to allow designs to scale, the driver will report the number of implementations it supports (eg. switches), so that many physical variants can share the same code.

# Getting Started
## Development Environment
- Install Eclipse for C/C++ development
- Install [System Workbench for STM32 Eclipse plugins](http://www.openstm32.org/Installing+System+Workbench+for+STM32+from+Eclipse?structure=Documentation)
- Clone the mbed sources
`git clone https://github.com/ARMmbed/mbed-os.git`
- use the scripts build.(bat|sh) and build-trace.(bat|sh) in the mbed directory to build the thin or trace-enabled builds of Mbed
- Build the arm-nano-eabi toolchain by running build.sh in the toolchain directory
- Import the mbed-os Eclipse project
- Import the Eclipse projects from this repository

## Hardware Tools
These will be useful during development
- [SWD Programmer](https://www.aliexpress.com/item/FREE-SHIPPING-ST-Link-V2-stlink-mini-STM8STM32-STLINK-simulator-download-programming-With-Cover/32237636491.html)
- [Sigrok](https://sigrok.org/wiki/PulseView) compatible [logic analyser](https://www.aliexpress.com/item/Free-Shipping-10sets-100-New-Arrival-USB-Logic-Analyze-24M-8CH-MCU-ARM-FPGA-DSP-debug/32234091842.html)
- [Nucleo-F030R8](http://au.element14.com/stmicroelectronics/nucleo-f030r8/nucleo-board-mcu/dp/2394225)

## Adding a new device
First, consider whether one of the existing device level drivers will do what you need, or can be expanded to achieve your goals (without straying too far from the intent of the driver). If you need to expand it, increment the version so that the client software (eg. OWFS) can identify what commands are available.

Next, create a frontend project that interacts with the device level driver. You may initially want to use a listener that uses the TRACE() macro rather than interacting with the hardware until you are happy with the protocol.

Finally, submit patches to OWFS that implement the new device driver. You can look at owfs/owlib/src/c/ow_ie_*.c to see how the existing drivers work. Important to note are the visibility functions, which allow a single family code to appear as many different devices.


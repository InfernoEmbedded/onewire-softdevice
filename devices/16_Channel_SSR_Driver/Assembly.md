# Assembly Instructions for the 16 Channel SSR Driver

## Tools
- Reflow Oven or Hot Air Rework station
- Fine tip soldering iron
- Fine tip tweezers
- Fresh solder paste
- Solder squeegee
- Solder mask stencil
- SWD Programmer
- USB to 3.3V TTL serial widget
- Multimeter

## Process
- Align the stencil with your board, it will help if you fabricate alignment holes.
- Squeegee the solder paste across your stencil.
- Place the surface mount components onto the board. The direction of the text on the board should match the direction of the text on the components.
- Reflow the board using the oven or reflow station.
- Inspect the the joints and rework if necessary. Pay careful attention to the RJ45 and microcontroller pins, looking for shorts.
- (Optional) solder in the 1x5 debug header. You can skip this step and insert a header into the cable instead.

## Testing
- Plug the SWD programmer into your PC and note the LED on it lights.
- Plug the SWD programmer into the programming header on the board (3.3V, Gnd, SWDIO & SWCLK, the pins are labelled on the underside of the board), the LED on the programmer should remain lit.
    - If the LED goes out, there is a short between 3.3V and ground. Inspect the power pins on the microcontroller and rework as necessary.
- Connect the serial port on the debug header to the USB to TTL widget, 921600,8,n,1
- Flash the test firmware onto the device (`./flash.sh` in the `test` directory).
    - If the device fails to detect, check for connectivity on the SWDIO ang SWCLK lines.
    - If the device still fails to detect, run the flash script in a loop and use a flying lead to briefly short the NRST line to ground (you may need to try a few times to get the right timing).
    - If the device still fails to detect, check the microcontroller orientation and replace the microcontroller.
- The test firmware scans the I/O pins for shorts and reports them.
    - Inspect the relevant microcontroller pins for shorts.
    - The short may be caused by unmelted solder under pin header (fix with hot air rework).
- Flash the distribution firmware onto the device (`./flash.sh` in the `src` directory).
- Disconnect the programmer from the device.
- Connect the device via 1Wire to a machine running owserver in debug mode, with a known good device on the bus.
- `owdir /uncached` should list the known good device, and a device with family code 'ED'.
    - If no devices are detected, check the following:
        - 1Wire line is not shorted to ground.
        - Correct diode behaviour between DS9503 data and ground pins.
    - If the known good device is detected, but the 16 channel SSR board is not:
        - Input voltage on the voltage regulator is 5V, if not check the RJ45 jack for dry joints or shorts, and the SMF05C for shorts & correct diode behaviour.
        - Output voltage is 3.3V, if not replace the voltage regulator.
        - DS9503 Input and output pins measure ~5Ohm for both data and ground pairs.
        - Look at the owserver log and see if the SEARCH_ROM command terminates after the first device (data not reaching the microcontroller), or some other reason (eg. CRC error).
        - Use a debug build of the firmware and instrument OneWireSlave::pinRise & pinFall, and confirm they are called, if not, the microcontroller is not receiving data.
       
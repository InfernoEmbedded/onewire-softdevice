#define DEVICE_SERIAL_ASYNCH 1

#include "mbed.h"

#include "DS2408.h"
#define WANT_TRACE 0
#include "trace.h"

using namespace infernoembedded;

#if WANT_TRACE
Serial pc(USBTX, USBRX, 921600);
#endif

class Listener : public DS2408Listener {
	void gpioOut(uint8_t bits) {
		TRACE("Set output to 0x%02x", bits);
	}
};

DigitalOut led(LED1);
Listener listener;
OneWireAddress address = {.value = 0xEFBEEDA5CEDE00};
DS2408 dev(PB_2, listener, address);

int main() {
	TRACE("Online, SystemCoreClock = %ld Hz", SystemCoreClock);
	dev.getAddress(address); // populate the family & CRC

	TRACE("Address = %02x.%02x%02x%02x%02x%02x%02x.%02x", address.bytes[0], address.bytes[1], address.bytes[2],
					address.bytes[3], address.bytes[4], address.bytes[5], address.bytes[6], address.bytes[7]);

	led = 1;

    while (1) {
    	dev.poll();
    }
}

/* Inferno Embedded 15 Channel SSR Driver
 * Copyright (C) 2018 Inferno Embedded
 *
 *  This program is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation, either version 3 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

#include "mbed.h"

Serial trace(USBTX, USBRX, "trace", 921600);

#define PIN_COUNT 16

DigitalInOut pins[] = {PC_9, PC_8, PC_7, PC_6, PB_15, PB_14, PB_13, PB_12,
		       PB_11, PB_2, PB_1, PB_0, PC_5, PC_4, PA_7, PA_6};

const char *pinNames[] = {"PC_9 0/0", "PC_8 0/1", "PC_7 1/0", "PC_6 1/1",
			  "PB_15 2/0", "PB_14 2/1", "PB_13 3/0", "PB_12 3/1",
			  "PB_11 4/0", "PB_2 4/1", "PB_1 5/0", "PB_0 5/1",
			  "PC_5 6/0", "PC_4 6/1", "PA_7 7/0", "PA_6 7/1"};

int main() __attribute__((used));
int main() {
	printf("16 Channel SSR tester, built " __DATE__ " " __TIME__ "\r\n");

	bool good = true;

	for (int pinUnderTest = 0; pinUnderTest < PIN_COUNT; pinUnderTest++) {
		printf("Testing pin %d %s\r\n", pinUnderTest, pinNames[pinUnderTest]);

		for (int pin = 0; pin < PIN_COUNT; pin++) {
			pins[pin].input();
			pins[pin].mode(PinMode::PullDown);
		}

		pins[pinUnderTest].output();
		pins[pinUnderTest].write(1);

		for (int pin = 0; pin < PIN_COUNT; pin++) {
			if (pin == pinUnderTest) {
				continue;
			}
			if (pins[pin].read()) {
				printf("Pin %d %s shorted to %d %s\r\n",
					pinUnderTest, pinNames[pinUnderTest],
					pin, pinNames[pin]);
				good = false;
			}
		}
	}

	if (good) {
		printf("Board tested successfully\r\n");
	} else {
		printf("Board failed\r\n");
	}

	bool val = false;
	pins[0].output();
	while (1) {
		pins[0].write(val);
		val = !val;

		if (good) {
			wait(1.1f);
		} else {
			wait(0.1);
		}
	}
}

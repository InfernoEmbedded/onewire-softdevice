/* Inferno Embedded Aircon Zone Controller
 * Copyright (C) 2017 Inferno Embedded
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

#ifndef ACZONECONTROLLER_H_
#define ACZONECONTROLLER_H_

#define NDEBUG
#include "mbed.h"
#include <stdint.h>

#include "SoftDevice.h"

namespace infernoembedded {

class ACZoneListener {
public:
	/**
	 * Get the number of zone ports
	 * @return the number of ports
	 */
	virtual uint8_t countZones() =0;

	/**
	 * Set the timeout for a zone
	 * @param zone the port of the zone damper
	 * @param timeout the timeout for a zone (in seconds) - the port will be depowered after this time
	 */
	virtual void setTimeout(uint8_t zone, uint8_t timeout) =0;

	/**
	 * Set the state for a zone
	 * @param zone the port of the zone damper
	 * @param open 255 to fully open the port, 0 to close it
	 */
	virtual void setState(uint8_t zone, uint8_t open) =0;
};

/**
 * AC Zone Controller base class
 */
class ACZoneController : public SoftDevice {
protected:
	ACZoneListener &_listener;

public:
	ACZoneController(PinName pin, OneWireAddress &address, ACZoneListener &listener);
	void commandDespatch(uint8_t command);
	void commandCountZones();
	void commandSetTimeout();
	void commandSetState();
	void masterToReadCompleted();
};

} /* namespace infernoembedded */

#endif /* ACZONECONTROLLER_H_ */

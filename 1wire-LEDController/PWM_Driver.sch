EESchema Schematic File Version 2
LIBS:power
LIBS:device
LIBS:transistors
LIBS:conn
LIBS:linear
LIBS:regul
LIBS:74xx
LIBS:cmos4000
LIBS:adc-dac
LIBS:memory
LIBS:xilinx
LIBS:microcontrollers
LIBS:dsp
LIBS:microchip
LIBS:analog_switches
LIBS:motorola
LIBS:texas
LIBS:intel
LIBS:audio
LIBS:interface
LIBS:digital-audio
LIBS:philips
LIBS:display
LIBS:cypress
LIBS:siliconi
LIBS:opto
LIBS:atmel
LIBS:contrib
LIBS:valves
LIBS:74xgxx
LIBS:ac-dc
LIBS:actel
LIBS:Altera
LIBS:analog_devices
LIBS:battery_management
LIBS:bbd
LIBS:brooktre
LIBS:cmos_ieee
LIBS:dc-dc
LIBS:diode
LIBS:elec-unifil
LIBS:ESD_Protection
LIBS:ftdi
LIBS:gennum
LIBS:graphic
LIBS:hc11
LIBS:ir
LIBS:Lattice
LIBS:logo
LIBS:maxim
LIBS:microchip_dspic33dsc
LIBS:microchip_pic10mcu
LIBS:microchip_pic12mcu
LIBS:microchip_pic16mcu
LIBS:microchip_pic18mcu
LIBS:microchip_pic32mcu
LIBS:motor_drivers
LIBS:motors
LIBS:msp430
LIBS:nordicsemi
LIBS:nxp_armmcu
LIBS:onsemi
LIBS:Oscillators
LIBS:Power_Management
LIBS:powerint
LIBS:pspice
LIBS:references
LIBS:relays
LIBS:rfcom
LIBS:sensors
LIBS:silabs
LIBS:stm8
LIBS:supertex
LIBS:switches
LIBS:transf
LIBS:ttl_ieee
LIBS:video
LIBS:wiznet
LIBS:Worldsemi
LIBS:Xicor
LIBS:Zilog
LIBS:automotive-light-controller-cache
LIBS:lp2950
LIBS:G3MB-SSR
LIBS:1Wire-LEDController-cache
EELAYER 25 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 2 2
Title "1 Wire LED Controller"
Date "2016-11-13"
Rev "1.0"
Comp "Inferno Embedded"
Comment1 "Licensed under the TAPR Open Hardware License (www.tapr.org/OHL)"
Comment2 "Copyright © 2016 Inferno Embedded"
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L CONN_01X05 P3
U 1 1 58246252
P 8700 1500
F 0 "P3" H 8700 1800 50  0000 C CNN
F 1 "CONN_01X05" V 8800 1500 50  0000 C CNN
F 2 "2EDCK-Screw-Connectors:2EDCK-5.08-5PIN" H 8700 1500 50  0001 C CNN
F 3 "" H 8700 1500 50  0000 C CNN
	1    8700 1500
	1    0    0    -1  
$EndComp
$Comp
L CONN_01X02 P4
U 1 1 58246327
P 8850 2250
F 0 "P4" H 8850 2400 50  0000 C CNN
F 1 "DC_IN" V 8950 2250 50  0000 C CNN
F 2 "2EDCK-Screw-Connectors:2EDCK-5.08-2PIN" H 8850 2250 50  0001 C CNN
F 3 "" H 8850 2250 50  0000 C CNN
	1    8850 2250
	1    0    0    -1  
$EndComp
$Comp
L BARREL_JACK CON1
U 1 1 5824638C
P 9000 2800
F 0 "CON1" H 9000 3050 50  0000 C CNN
F 1 "BARREL_JACK" H 9000 2600 50  0000 C CNN
F 2 "Connect:BARREL_JACK" H 9000 2800 50  0001 C CNN
F 3 "" H 9000 2800 50  0000 C CNN
	1    9000 2800
	-1   0    0    1   
$EndComp
Wire Wire Line
	8650 2200 8500 2200
Wire Wire Line
	8500 2200 8500 3000
Wire Wire Line
	8500 2700 8700 2700
Wire Wire Line
	8500 2800 8700 2800
Connection ~ 8500 2700
Wire Wire Line
	8650 2300 8600 2300
Wire Wire Line
	8600 2100 8600 2900
Wire Wire Line
	8600 2900 8700 2900
$Comp
L GND #PWR16
U 1 1 58246457
P 8500 3000
F 0 "#PWR16" H 8500 2750 50  0001 C CNN
F 1 "GND" H 8500 2850 50  0000 C CNN
F 2 "" H 8500 3000 50  0000 C CNN
F 3 "" H 8500 3000 50  0000 C CNN
	1    8500 3000
	1    0    0    -1  
$EndComp
Connection ~ 8500 2800
$Comp
L +48V #PWR17
U 1 1 5824648B
P 8600 2100
F 0 "#PWR17" H 8600 1950 50  0001 C CNN
F 1 "+48V" H 8600 2240 50  0000 C CNN
F 2 "" H 8600 2100 50  0000 C CNN
F 3 "" H 8600 2100 50  0000 C CNN
	1    8600 2100
	1    0    0    -1  
$EndComp
Connection ~ 8600 2300
Wire Wire Line
	7600 1600 8500 1600
Wire Wire Line
	6950 1500 8500 1500
Wire Wire Line
	6300 1400 8500 1400
$Comp
L Q_NMOS_GDS Q1
U 1 1 58246620
P 5550 1500
F 0 "Q1" H 5850 1550 50  0000 R CNN
F 1 "IRLZ44NS" H 6100 1450 50  0000 R CNN
F 2 "kicad-open-modules:D2PAK" H 5750 1600 50  0001 C CNN
F 3 "" H 5550 1500 50  0000 C CNN
	1    5550 1500
	1    0    0    -1  
$EndComp
Wire Wire Line
	5650 1300 8500 1300
$Comp
L STM32F030R8 U2
U 3 1 58246695
P 1600 700
F 0 "U2" H 1700 750 50  0000 C CNN
F 1 "STM32F030R8" H 1900 850 50  0001 C CNN
F 2 "Housings_QFP:LQFP-64_10x10mm_Pitch0.5mm" H 1800 950 50  0001 C CIN
F 3 "" H 4900 -1800 50  0000 C CNN
	3    1600 700 
	1    0    0    -1  
$EndComp
Wire Wire Line
	3650 1500 5350 1500
Wire Wire Line
	6000 1600 6000 1800
Wire Wire Line
	6000 1800 5350 1800
Wire Wire Line
	5350 1800 5350 1600
Wire Wire Line
	5350 1600 3650 1600
Wire Wire Line
	6650 1700 6650 1900
Wire Wire Line
	6650 1900 5250 1900
Wire Wire Line
	5250 1900 5250 1700
Wire Wire Line
	5250 1700 3650 1700
Wire Wire Line
	7300 1800 7300 2000
Wire Wire Line
	7300 2000 5150 2000
Wire Wire Line
	5150 2000 5150 1800
Wire Wire Line
	5150 1800 3650 1800
$Comp
L +48V #PWR15
U 1 1 582469D7
P 8450 1100
F 0 "#PWR15" H 8450 950 50  0001 C CNN
F 1 "+48V" H 8450 1240 50  0000 C CNN
F 2 "" H 8450 1100 50  0000 C CNN
F 3 "" H 8450 1100 50  0000 C CNN
	1    8450 1100
	1    0    0    -1  
$EndComp
Wire Wire Line
	8500 1700 8450 1700
Wire Wire Line
	8450 1700 8450 1100
$Comp
L GND #PWR14
U 1 1 58246A23
P 7600 2300
F 0 "#PWR14" H 7600 2050 50  0001 C CNN
F 1 "GND" H 7600 2150 50  0000 C CNN
F 2 "" H 7600 2300 50  0000 C CNN
F 3 "" H 7600 2300 50  0000 C CNN
	1    7600 2300
	1    0    0    -1  
$EndComp
Wire Wire Line
	7600 2000 7600 2300
Wire Wire Line
	6950 1900 6950 2200
Wire Wire Line
	5650 2200 7600 2200
Connection ~ 7600 2200
Wire Wire Line
	6300 1800 6300 2200
Connection ~ 6950 2200
Wire Wire Line
	5650 1700 5650 2200
Connection ~ 6300 2200
$Comp
L Q_NMOS_GDS Q2
U 1 1 582577B9
P 6200 1600
F 0 "Q2" H 6500 1650 50  0000 R CNN
F 1 "IRLZ44NS" H 6750 1550 50  0000 R CNN
F 2 "kicad-open-modules:D2PAK" H 6400 1700 50  0001 C CNN
F 3 "" H 6200 1600 50  0000 C CNN
	1    6200 1600
	1    0    0    -1  
$EndComp
$Comp
L Q_NMOS_GDS Q4
U 1 1 582577F3
P 6850 1700
F 0 "Q4" H 7150 1750 50  0000 R CNN
F 1 "IRLZ44NS" H 7400 1650 50  0000 R CNN
F 2 "kicad-open-modules:D2PAK" H 7050 1800 50  0001 C CNN
F 3 "" H 6850 1700 50  0000 C CNN
	1    6850 1700
	1    0    0    -1  
$EndComp
$Comp
L Q_NMOS_GDS Q6
U 1 1 58257824
P 7500 1800
F 0 "Q6" H 7800 1850 50  0000 R CNN
F 1 "IRLZ44NS" H 8050 1750 50  0000 R CNN
F 2 "kicad-open-modules:D2PAK" H 7700 1900 50  0001 C CNN
F 3 "" H 7500 1800 50  0000 C CNN
	1    7500 1800
	1    0    0    -1  
$EndComp
$Comp
L STM32F030R8 U2
U 1 1 58257933
P 1200 3400
F 0 "U2" H 1300 3450 50  0000 C CNN
F 1 "STM32F030R8" H 1500 3550 50  0001 C CNN
F 2 "Housings_QFP:LQFP-64_10x10mm_Pitch0.5mm" H 1400 3650 50  0001 C CIN
F 3 "" H 4500 900 50  0000 C CNN
	1    1200 3400
	1    0    0    -1  
$EndComp
Wire Wire Line
	4650 4900 4950 4900
Wire Wire Line
	4650 5000 4950 5000
$Comp
L CONN_01X05 P5
U 1 1 58257B4D
P 9700 4400
F 0 "P5" H 9700 4700 50  0000 C CNN
F 1 "CONN_01X05" V 9800 4400 50  0000 C CNN
F 2 "2EDCK-Screw-Connectors:2EDCK-5.08-5PIN" H 9700 4400 50  0001 C CNN
F 3 "" H 9700 4400 50  0000 C CNN
	1    9700 4400
	1    0    0    -1  
$EndComp
Wire Wire Line
	8600 4500 9500 4500
Wire Wire Line
	7950 4400 9500 4400
Wire Wire Line
	7300 4300 9500 4300
$Comp
L Q_NMOS_GDS Q3
U 1 1 58257B78
P 6550 4400
F 0 "Q3" H 6850 4450 50  0000 R CNN
F 1 "IRLZ44NS" H 7100 4350 50  0000 R CNN
F 2 "kicad-open-modules:D2PAK" H 6750 4500 50  0001 C CNN
F 3 "" H 6550 4400 50  0000 C CNN
	1    6550 4400
	1    0    0    -1  
$EndComp
Wire Wire Line
	6650 4200 9500 4200
Wire Wire Line
	4650 4400 6350 4400
Wire Wire Line
	7000 4500 7000 4700
Wire Wire Line
	7000 4700 6350 4700
Wire Wire Line
	6350 4700 6350 4500
Wire Wire Line
	6350 4500 4650 4500
Wire Wire Line
	7650 4600 7650 4800
Wire Wire Line
	7650 4800 6250 4800
Wire Wire Line
	6250 4800 6250 4600
Wire Wire Line
	6250 4600 4650 4600
Wire Wire Line
	8300 4700 8300 4900
Wire Wire Line
	8300 4900 6150 4900
Wire Wire Line
	6150 4900 6150 4700
Wire Wire Line
	6150 4700 4650 4700
$Comp
L +48V #PWR19
U 1 1 58257B8C
P 9450 4000
F 0 "#PWR19" H 9450 3850 50  0001 C CNN
F 1 "+48V" H 9450 4140 50  0000 C CNN
F 2 "" H 9450 4000 50  0000 C CNN
F 3 "" H 9450 4000 50  0000 C CNN
	1    9450 4000
	1    0    0    -1  
$EndComp
Wire Wire Line
	9500 4600 9450 4600
Wire Wire Line
	9450 4600 9450 4000
$Comp
L GND #PWR18
U 1 1 58257B94
P 8600 5200
F 0 "#PWR18" H 8600 4950 50  0001 C CNN
F 1 "GND" H 8600 5050 50  0000 C CNN
F 2 "" H 8600 5200 50  0000 C CNN
F 3 "" H 8600 5200 50  0000 C CNN
	1    8600 5200
	1    0    0    -1  
$EndComp
Wire Wire Line
	8600 4900 8600 5200
Wire Wire Line
	7950 4800 7950 5100
Wire Wire Line
	6650 5100 8600 5100
Connection ~ 8600 5100
Wire Wire Line
	7300 4700 7300 5100
Connection ~ 7950 5100
Wire Wire Line
	6650 4600 6650 5100
Connection ~ 7300 5100
$Comp
L Q_NMOS_GDS Q5
U 1 1 58257BA2
P 7200 4500
F 0 "Q5" H 7500 4550 50  0000 R CNN
F 1 "IRLZ44NS" H 7750 4450 50  0000 R CNN
F 2 "kicad-open-modules:D2PAK" H 7400 4600 50  0001 C CNN
F 3 "" H 7200 4500 50  0000 C CNN
	1    7200 4500
	1    0    0    -1  
$EndComp
$Comp
L Q_NMOS_GDS Q7
U 1 1 58257BA8
P 7850 4600
F 0 "Q7" H 8150 4650 50  0000 R CNN
F 1 "IRLZ44NS" H 8400 4550 50  0000 R CNN
F 2 "kicad-open-modules:D2PAK" H 8050 4700 50  0001 C CNN
F 3 "" H 7850 4600 50  0000 C CNN
	1    7850 4600
	1    0    0    -1  
$EndComp
$Comp
L Q_NMOS_GDS Q8
U 1 1 58257BAE
P 8500 4700
F 0 "Q8" H 8800 4750 50  0000 R CNN
F 1 "IRLZ44NS" H 9050 4650 50  0000 R CNN
F 2 "kicad-open-modules:D2PAK" H 8700 4800 50  0001 C CNN
F 3 "" H 8500 4700 50  0000 C CNN
	1    8500 4700
	1    0    0    -1  
$EndComp
Text HLabel 4950 4900 2    60   Input ~ 0
SWDAT
Text HLabel 4950 5000 2    60   Input ~ 0
SWCLK
Text HLabel 5000 3800 2    60   Input ~ 0
UART_TX
Text HLabel 5000 3900 2    60   Input ~ 0
UART_RX
Wire Wire Line
	5000 3900 4650 3900
Wire Wire Line
	4650 3800 5000 3800
$EndSCHEMATC

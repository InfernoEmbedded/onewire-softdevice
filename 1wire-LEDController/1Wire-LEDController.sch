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
Sheet 1 2
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
L RJ45 J1
U 1 1 5824359A
P 2300 1800
F 0 "J1" H 2500 2300 50  0000 C CNN
F 1 "RJ45" H 2150 2300 50  0000 C CNN
F 2 "RJ45:RJ45-ChinaSMD" H 2300 1800 50  0001 C CNN
F 3 "" H 2300 1800 50  0000 C CNN
	1    2300 1800
	1    0    0    -1  
$EndComp
$Comp
L STM32F030R8 U2
U 4 1 58244F90
P 3800 6150
F 0 "U2" H 3900 6200 50  0000 C CNN
F 1 "STM32F030R8" H 4100 6300 50  0001 C CNN
F 2 "Housings_QFP:LQFP-64_10x10mm_Pitch0.5mm" H 4000 6400 50  0001 C CIN
F 3 "" H 7100 3650 50  0000 C CNN
	4    3800 6150
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR01
U 1 1 5824517A
P 2650 2750
F 0 "#PWR01" H 2650 2500 50  0001 C CNN
F 1 "GND" H 2650 2600 50  0000 C CNN
F 2 "" H 2650 2750 50  0000 C CNN
F 3 "" H 2650 2750 50  0000 C CNN
	1    2650 2750
	1    0    0    -1  
$EndComp
Wire Wire Line
	1950 2250 1950 2400
Wire Wire Line
	1950 2400 3900 2400
Wire Wire Line
	2650 2250 2650 2750
Connection ~ 2650 2400
Wire Wire Line
	2150 2250 2150 2400
Connection ~ 2150 2400
Wire Wire Line
	2350 2250 2350 2400
Connection ~ 2350 2400
$Comp
L +5V #PWR02
U 1 1 582452BF
P 1550 2000
F 0 "#PWR02" H 1550 1850 50  0001 C CNN
F 1 "+5V" H 1550 2140 50  0000 C CNN
F 2 "" H 1550 2000 50  0000 C CNN
F 3 "" H 1550 2000 50  0000 C CNN
	1    1550 2000
	1    0    0    -1  
$EndComp
Wire Wire Line
	2050 2250 2050 2350
Wire Wire Line
	1550 2350 3100 2350
Wire Wire Line
	1550 2350 1550 2000
$Comp
L GND #PWR03
U 1 1 58245334
P 4500 7250
F 0 "#PWR03" H 4500 7000 50  0001 C CNN
F 1 "GND" H 4500 7100 50  0000 C CNN
F 2 "" H 4500 7250 50  0000 C CNN
F 3 "" H 4500 7250 50  0000 C CNN
	1    4500 7250
	1    0    0    -1  
$EndComp
Wire Wire Line
	4500 6950 4500 7250
Wire Wire Line
	4200 6950 4200 7050
Wire Wire Line
	3650 7050 4500 7050
Connection ~ 4500 7050
Wire Wire Line
	4300 6950 4300 7050
Connection ~ 4300 7050
$Comp
L +3.3V #PWR04
U 1 1 582453EE
P 5050 5650
F 0 "#PWR04" H 5050 5500 50  0001 C CNN
F 1 "+3.3V" H 5050 5790 50  0000 C CNN
F 2 "" H 5050 5650 50  0000 C CNN
F 3 "" H 5050 5650 50  0000 C CNN
	1    5050 5650
	1    0    0    -1  
$EndComp
Wire Wire Line
	5050 5650 5050 6000
Wire Wire Line
	4850 6000 4850 5800
Connection ~ 5050 5800
Wire Wire Line
	4750 6000 4750 5800
Connection ~ 4850 5800
Wire Wire Line
	4650 6000 4650 5800
Connection ~ 4750 5800
$Comp
L CONN_02X05 P1
U 1 1 58245605
P 1650 5000
F 0 "P1" H 1650 5300 50  0000 C CNN
F 1 "CONN_02X05" H 1650 4700 50  0000 C CNN
F 2 "Pin_Headers:Pin_Header_Straight_SMT_02x05" H 1650 3800 50  0001 C CNN
F 3 "" H 1650 3800 50  0000 C CNN
	1    1650 5000
	1    0    0    -1  
$EndComp
Wire Wire Line
	1900 4800 3000 4800
Wire Wire Line
	1900 4900 2700 4900
$Comp
L +3.3V #PWR05
U 1 1 582456BE
P 1250 4700
F 0 "#PWR05" H 1250 4550 50  0001 C CNN
F 1 "+3.3V" H 1250 4840 50  0000 C CNN
F 2 "" H 1250 4700 50  0000 C CNN
F 3 "" H 1250 4700 50  0000 C CNN
	1    1250 4700
	1    0    0    -1  
$EndComp
Wire Wire Line
	1250 4700 1250 4800
Wire Wire Line
	1250 4800 1400 4800
$Comp
L GND #PWR06
U 1 1 58245733
P 1300 5300
F 0 "#PWR06" H 1300 5050 50  0001 C CNN
F 1 "GND" H 1300 5150 50  0000 C CNN
F 2 "" H 1300 5300 50  0000 C CNN
F 3 "" H 1300 5300 50  0000 C CNN
	1    1300 5300
	1    0    0    -1  
$EndComp
Wire Wire Line
	1400 4900 1300 4900
Wire Wire Line
	1300 4900 1300 5300
Wire Wire Line
	1400 5000 1300 5000
Connection ~ 1300 5000
Wire Wire Line
	1400 5200 1300 5200
Connection ~ 1300 5200
Wire Wire Line
	1900 5200 2300 5200
Wire Wire Line
	2250 2250 2250 2600
Wire Wire Line
	1750 2600 3300 2600
Text Label 1750 2600 0    60   ~ 0
1W-DATA
$Sheet
S 3000 4550 1100 800 
U 582461B9
F0 "PWM_Driver" 60
F1 "PWM_Driver.sch" 60
F2 "SWDAT" I L 3000 4800 60 
F3 "SWCLK" I L 3000 4950 60 
F4 "UART_TX" I R 4100 4800 60 
F5 "UART_RX" I R 4100 4900 60 
$EndSheet
$Comp
L LP2950 U1
U 1 1 582584AD
P 5150 1550
F 0 "U1" H 5300 1354 60  0000 C CNN
F 1 "LP2950" H 5150 1750 60  0000 C CNN
F 2 "TO_SOT_Packages_SMD:TO-252-2Lead" H 5150 1550 60  0001 C CNN
F 3 "" H 5150 1550 60  0001 C CNN
	1    5150 1550
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR07
U 1 1 5825857A
P 5150 1900
F 0 "#PWR07" H 5150 1650 50  0001 C CNN
F 1 "GND" H 5150 1750 50  0000 C CNN
F 2 "" H 5150 1900 50  0000 C CNN
F 3 "" H 5150 1900 50  0000 C CNN
	1    5150 1900
	1    0    0    -1  
$EndComp
$Comp
L +5V #PWR08
U 1 1 5825859A
P 4550 1100
F 0 "#PWR08" H 4550 950 50  0001 C CNN
F 1 "+5V" H 4550 1240 50  0000 C CNN
F 2 "" H 4550 1100 50  0000 C CNN
F 3 "" H 4550 1100 50  0000 C CNN
	1    4550 1100
	1    0    0    -1  
$EndComp
$Comp
L +3.3V #PWR09
U 1 1 582585BA
P 5650 1400
F 0 "#PWR09" H 5650 1250 50  0001 C CNN
F 1 "+3.3V" H 5650 1540 50  0000 C CNN
F 2 "" H 5650 1400 50  0000 C CNN
F 3 "" H 5650 1400 50  0000 C CNN
	1    5650 1400
	1    0    0    -1  
$EndComp
Wire Wire Line
	5550 1500 5650 1500
Wire Wire Line
	5650 1500 5650 1400
Wire Wire Line
	4750 1500 4550 1500
Wire Wire Line
	4550 1500 4550 1400
$Comp
L CP C1
U 1 1 582587E1
P 4550 1650
F 0 "C1" H 4575 1750 50  0000 L CNN
F 1 "100uF" H 4575 1550 50  0000 L CNN
F 2 "Capacitors_SMD:c_elec_8x6.7" H 4588 1500 50  0001 C CNN
F 3 "" H 4550 1650 50  0000 C CNN
	1    4550 1650
	1    0    0    -1  
$EndComp
Wire Wire Line
	4550 1800 4550 1850
Wire Wire Line
	4550 1850 5650 1850
Wire Wire Line
	5650 1850 5650 1800
Connection ~ 5150 1850
$Comp
L C C3
U 1 1 582589CF
P 5450 6000
F 0 "C3" H 5475 6100 50  0000 L CNN
F 1 "100nF" H 5475 5900 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603" H 5488 5850 50  0001 C CNN
F 3 "" H 5450 6000 50  0000 C CNN
	1    5450 6000
	1    0    0    -1  
$EndComp
$Comp
L C C4
U 1 1 58258CB3
P 5800 6000
F 0 "C4" H 5825 6100 50  0000 L CNN
F 1 "100nF" H 5825 5900 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603" H 5838 5850 50  0001 C CNN
F 3 "" H 5800 6000 50  0000 C CNN
	1    5800 6000
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR010
U 1 1 58258D67
P 5450 6250
F 0 "#PWR010" H 5450 6000 50  0001 C CNN
F 1 "GND" H 5450 6100 50  0000 C CNN
F 2 "" H 5450 6250 50  0000 C CNN
F 3 "" H 5450 6250 50  0000 C CNN
	1    5450 6250
	1    0    0    -1  
$EndComp
Wire Wire Line
	5450 6150 5450 6250
Wire Wire Line
	5800 6150 5800 6200
Connection ~ 5450 6200
Wire Wire Line
	5800 5800 5800 5850
Wire Wire Line
	5450 5850 5450 5800
Connection ~ 5450 5800
$Comp
L C C2
U 1 1 58259010
P 5650 1650
F 0 "C2" H 5675 1750 50  0000 L CNN
F 1 "4.7uF" H 5675 1550 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603" H 5688 1500 50  0001 C CNN
F 3 "" H 5650 1650 50  0000 C CNN
	1    5650 1650
	1    0    0    -1  
$EndComp
Wire Wire Line
	2700 4900 2700 4950
Wire Wire Line
	2700 4950 3000 4950
$Comp
L STM32F030R8 U2
U 2 1 5825A3AF
P 6600 700
F 0 "U2" H 6700 750 50  0000 C CNN
F 1 "STM32F030R8" H 6900 850 50  0001 C CNN
F 2 "Housings_QFP:LQFP-64_10x10mm_Pitch0.5mm" H 6800 950 50  0001 C CIN
F 3 "" H 9900 -1800 50  0000 C CNN
	2    6600 700 
	1    0    0    -1  
$EndComp
Text Label 9400 1100 0    60   ~ 0
1W-DATA
Wire Wire Line
	2850 2400 2850 1450
$Comp
L +3.3V #PWR011
U 1 1 5827B1CE
P 4450 4600
F 0 "#PWR011" H 4450 4450 50  0001 C CNN
F 1 "+3.3V" H 4450 4740 50  0000 C CNN
F 2 "" H 4450 4600 50  0000 C CNN
F 3 "" H 4450 4600 50  0000 C CNN
	1    4450 4600
	1    0    0    -1  
$EndComp
Wire Wire Line
	4550 4700 4450 4700
Wire Wire Line
	4450 4700 4450 4600
$Comp
L GND #PWR012
U 1 1 5827B41B
P 4500 5050
F 0 "#PWR012" H 4500 4800 50  0001 C CNN
F 1 "GND" H 4500 4900 50  0000 C CNN
F 2 "" H 4500 5050 50  0000 C CNN
F 3 "" H 4500 5050 50  0000 C CNN
	1    4500 5050
	1    0    0    -1  
$EndComp
Wire Wire Line
	4550 5000 4500 5000
Wire Wire Line
	4500 5000 4500 5050
$Comp
L RJ45 J2
U 1 1 5827B786
P 3350 1800
F 0 "J2" H 3550 2300 50  0000 C CNN
F 1 "RJ45" H 3200 2300 50  0000 C CNN
F 2 "RJ45:RJ45-ChinaSMD" H 3350 1800 50  0001 C CNN
F 3 "" H 3350 1800 50  0000 C CNN
	1    3350 1800
	1    0    0    -1  
$EndComp
Wire Wire Line
	3900 2400 3900 1450
Connection ~ 2850 2400
Wire Wire Line
	3000 2250 3000 2400
Connection ~ 3000 2400
Wire Wire Line
	3200 2250 3200 2400
Connection ~ 3200 2400
Wire Wire Line
	3400 2250 3400 2400
Connection ~ 3400 2400
Wire Wire Line
	3700 2250 3700 2400
Connection ~ 3700 2400
Wire Wire Line
	3100 2350 3100 2250
Connection ~ 2050 2350
Wire Wire Line
	3650 6550 3650 7050
Connection ~ 4200 7050
Wire Wire Line
	2300 6450 3650 6450
Wire Wire Line
	2300 5200 2300 6450
Wire Wire Line
	4650 5800 6150 5800
Wire Wire Line
	5450 6200 6150 6200
$Comp
L C C5
U 1 1 5827DCB8
P 6150 6000
F 0 "C5" H 6175 6100 50  0000 L CNN
F 1 "100nF" H 6175 5900 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603" H 6188 5850 50  0001 C CNN
F 3 "" H 6150 6000 50  0000 C CNN
	1    6150 6000
	1    0    0    -1  
$EndComp
Wire Wire Line
	6150 5800 6150 5850
Connection ~ 5800 5800
Wire Wire Line
	6150 6200 6150 6150
Connection ~ 5800 6200
Wire Wire Line
	3300 2600 3300 2250
Connection ~ 2250 2600
Wire Wire Line
	2450 2250 2450 2450
Wire Wire Line
	2450 2450 3500 2450
Wire Wire Line
	3500 2450 3500 2250
Wire Wire Line
	2550 2250 2550 2500
Wire Wire Line
	2550 2500 3600 2500
Wire Wire Line
	3600 2500 3600 2250
Wire Wire Line
	5150 1900 5150 1800
$Comp
L STM32F030R8 U2
U 5 1 582835BD
P 6150 4000
F 0 "U2" H 6250 4050 50  0000 C CNN
F 1 "STM32F030R8" H 6450 4150 50  0001 C CNN
F 2 "Housings_QFP:LQFP-64_10x10mm_Pitch0.5mm" H 6350 4250 50  0001 C CIN
F 3 "" H 9450 1500 50  0000 C CNN
	5    6150 4000
	1    0    0    -1  
$EndComp
$Comp
L CONN_01X02 P2
U 1 1 58283946
P 9500 4850
F 0 "P2" H 9500 5000 50  0000 C CNN
F 1 "Power Enable" V 9600 4850 50  0000 C CNN
F 2 "2EDCK-Screw-Connectors:2EDCK-5.08-2PIN" H 9500 4850 50  0001 C CNN
F 3 "" H 9500 4850 50  0000 C CNN
	1    9500 4850
	1    0    0    -1  
$EndComp
$Comp
L G3MB_SSR U3
U 1 1 5828394D
P 8550 5000
F 0 "U3" H 8750 5300 60  0000 C CNN
F 1 "G3MB_SSR" H 8650 4700 60  0000 C CNN
F 2 "SSR:G3MB" H 8550 5000 60  0000 C CNN
F 3 "" H 8550 5000 60  0000 C CNN
	1    8550 5000
	1    0    0    -1  
$EndComp
Wire Wire Line
	9300 4800 9150 4800
Wire Wire Line
	9300 4900 9150 4900
Wire Wire Line
	9150 4900 9150 5200
$Comp
L +5V #PWR013
U 1 1 58283957
P 7850 4700
F 0 "#PWR013" H 7850 4550 50  0001 C CNN
F 1 "+5V" H 7850 4840 50  0000 C CNN
F 2 "" H 7850 4700 50  0000 C CNN
F 3 "" H 7850 4700 50  0000 C CNN
	1    7850 4700
	1    0    0    -1  
$EndComp
Wire Wire Line
	7850 4700 7850 4800
Wire Wire Line
	7850 4800 7900 4800
Wire Wire Line
	7150 4400 7650 4400
Wire Wire Line
	7650 4400 7650 5200
Wire Wire Line
	7650 5200 7900 5200
Wire Wire Line
	9150 1100 9400 1100
Wire Wire Line
	4100 4800 4550 4800
Wire Wire Line
	4550 4900 4100 4900
Connection ~ 4550 1500
Connection ~ 5650 1500
$Comp
L R R1
U 1 1 58B28CDC
P 4550 1250
F 0 "R1" V 4630 1250 50  0000 C CNN
F 1 "33R" V 4550 1250 50  0000 C CNN
F 2 "Resistors_SMD:R_0603" V 4480 1250 50  0001 C CNN
F 3 "" H 4550 1250 50  0000 C CNN
	1    4550 1250
	1    0    0    -1  
$EndComp
$Comp
L CONN_01X05 P6
U 1 1 58B297A3
P 4750 4800
F 0 "P6" H 4750 5100 50  0000 C CNN
F 1 "CONN_01X05" V 4850 4800 50  0000 C CNN
F 2 "" H 4750 4800 50  0000 C CNN
F 3 "" H 4750 4800 50  0000 C CNN
	1    4750 4800
	1    0    0    -1  
$EndComp
Wire Wire Line
	4550 4600 4550 4250
Text Label 4550 4250 0    60   ~ 0
1W-DATA
$EndSCHEMATC

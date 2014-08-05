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
LIBS:special
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
LIBS:1wire
LIBS:CNT-RJ45
LIBS:1wire-roof-module-cache
EELAYER 27 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title ""
Date "8 apr 2014"
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
Wire Wire Line
	5300 3300 5300 3200
Wire Wire Line
	2800 3300 5300 3300
Wire Wire Line
	2800 3300 2800 3200
Wire Wire Line
	4050 3200 4050 3300
Connection ~ 4050 3300
Wire Wire Line
	2900 3200 2900 3400
Wire Wire Line
	2900 3400 6300 3400
Wire Wire Line
	5400 3400 5400 3200
Wire Wire Line
	4150 3200 4150 3400
Connection ~ 4150 3400
Wire Wire Line
	3000 3200 3000 3500
Wire Wire Line
	3000 3500 5500 3500
Wire Wire Line
	5500 3500 5500 3200
Wire Wire Line
	4250 3200 4250 3500
Connection ~ 4250 3500
Wire Wire Line
	3100 3200 3100 3600
Wire Wire Line
	3100 3600 6500 3600
Wire Wire Line
	5600 3600 5600 3200
Wire Wire Line
	4350 3200 4350 3600
Connection ~ 4350 3600
Wire Wire Line
	3200 3200 3200 3700
Wire Wire Line
	3200 3700 5700 3700
Wire Wire Line
	5700 3700 5700 3200
Wire Wire Line
	4450 3200 4450 3700
Connection ~ 4450 3700
Wire Wire Line
	3300 3200 3300 3800
Wire Wire Line
	3300 3800 5800 3800
Wire Wire Line
	5800 3800 5800 3200
Wire Wire Line
	4550 3200 4550 3800
Connection ~ 4550 3800
Wire Wire Line
	3400 3200 3400 3900
Wire Wire Line
	3400 3900 5900 3900
Wire Wire Line
	5900 3900 5900 3200
Wire Wire Line
	4650 3200 4650 3900
Connection ~ 4650 3900
Wire Wire Line
	3500 3200 3500 4000
Wire Wire Line
	3500 4000 6000 4000
Wire Wire Line
	6000 4000 6000 3200
Wire Wire Line
	4750 3200 4750 4000
Connection ~ 4750 4000
Text Label 2600 3300 0    60   ~ 0
Gnd
Text Label 2650 3400 0    60   ~ 0
+5V
Text Label 2800 3500 0    60   ~ 0
Gnd
Text Label 2950 3600 0    60   ~ 0
1+
Text Label 3050 3700 0    60   ~ 0
1-
Text Label 3100 3800 0    60   ~ 0
N/C
Text Label 3150 3900 0    60   ~ 0
+24V
Text Label 3300 4000 0    60   ~ 0
Gnd
$Comp
L DS18B20 IC1
U 1 1 533D3BB9
P 7050 3550
F 0 "IC1" H 7275 3575 50  0000 L BNN
F 1 "DS18B20" H 7275 3475 50  0000 L BNN
F 2 "1wire-TO92-" H 7050 3700 50  0001 C CNN
F 3 "" H 7050 3550 60  0000 C CNN
	1    7050 3550
	1    0    0    -1  
$EndComp
Connection ~ 5600 3600
Wire Wire Line
	6500 3500 5700 3500
Connection ~ 5700 3500
Wire Wire Line
	6300 3400 6300 3700
Wire Wire Line
	6300 3700 6500 3700
Connection ~ 5400 3400
$Comp
L CNT-RJ45-8 P1
U 1 1 533D436B
P 3450 2850
F 0 "P1" V 3400 3150 60  0000 C CNN
F 1 "CNT-RJ45-8" V 3500 3100 60  0000 C CNN
F 2 "" H 3450 2850 60  0000 C CNN
F 3 "" H 3450 2850 60  0000 C CNN
	1    3450 2850
	0    -1   -1   0   
$EndComp
$Comp
L CNT-RJ45-8 P2
U 1 1 533D4378
P 4700 2850
F 0 "P2" V 4650 3150 60  0000 C CNN
F 1 "CNT-RJ45-8" V 4750 3100 60  0000 C CNN
F 2 "" H 4700 2850 60  0000 C CNN
F 3 "" H 4700 2850 60  0000 C CNN
	1    4700 2850
	0    -1   -1   0   
$EndComp
$Comp
L CNT-RJ45-8 P3
U 1 1 533D437E
P 5950 2850
F 0 "P3" V 5900 3150 60  0000 C CNN
F 1 "CNT-RJ45-8" V 6000 3100 60  0000 C CNN
F 2 "" H 5950 2850 60  0000 C CNN
F 3 "" H 5950 2850 60  0000 C CNN
	1    5950 2850
	0    -1   -1   0   
$EndComp
Text Notes 10650 7650 0    60   ~ 0
1
Text Notes 7300 7550 0    60   ~ 0
1 Wire roof module
Text Notes 7000 7100 0    60   ~ 0
Licensed under the TAPR Open Hardware License (www.tapr.org/OHL)
$EndSCHEMATC

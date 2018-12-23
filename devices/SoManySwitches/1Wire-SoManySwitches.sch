EESchema Schematic File Version 4
LIBS:1Wire-SoManySwitches-cache
EELAYER 26 0
EELAYER END
$Descr A3 16535 11693
encoding utf-8
Sheet 1 1
Title "1 Wire So Many Switches"
Date "2018-12-23"
Rev "1.2"
Comp "Inferno Embedded"
Comment1 "Licensed under the TAPR Open Hardware License (www.tapr.org/OHL)"
Comment2 "Copyright © 2018 Inferno Embedded"
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L 1Wire-SoManySwitches-rescue:RJ45 J1
U 1 1 5824359A
P 1450 1400
F 0 "J1" H 1650 1900 50  0000 C CNN
F 1 "RJ45" H 1300 1900 50  0000 C CNN
F 2 "RJ45:RJ45-ChinaSMD" H 1450 1400 50  0001 C CNN
F 3 "" H 1450 1400 50  0000 C CNN
	1    1450 1400
	1    0    0    -1  
$EndComp
$Comp
L 1Wire-SoManySwitches-rescue:STM32F030R8 U2
U 4 1 58244F90
P 7950 1300
F 0 "U2" H 8050 1350 50  0000 C CNN
F 1 "STM32F030R8" H 8250 1450 50  0001 C CNN
F 2 "Housings_QFP:LQFP-64_10x10mm_Pitch0.5mm" H 8150 1550 50  0001 C CIN
F 3 "" H 11250 -1200 50  0000 C CNN
	4    7950 1300
	1    0    0    -1  
$EndComp
$Comp
L 1Wire-SoManySwitches-rescue:GND #PWR01
U 1 1 5824517A
P 1800 2350
F 0 "#PWR01" H 1800 2100 50  0001 C CNN
F 1 "GND" H 1800 2200 50  0000 C CNN
F 2 "" H 1800 2350 50  0000 C CNN
F 3 "" H 1800 2350 50  0000 C CNN
	1    1800 2350
	1    0    0    -1  
$EndComp
Wire Wire Line
	1100 1850 1100 2000
Wire Wire Line
	1100 2000 1300 2000
Wire Wire Line
	1800 1850 1800 2000
Connection ~ 1800 2000
Wire Wire Line
	1300 1850 1300 2000
Connection ~ 1300 2000
Wire Wire Line
	1500 1850 1500 2000
Connection ~ 1500 2000
$Comp
L 1Wire-SoManySwitches-rescue:+5V #PWR02
U 1 1 582452BF
P 700 1600
F 0 "#PWR02" H 700 1450 50  0001 C CNN
F 1 "+5V" H 700 1740 50  0000 C CNN
F 2 "" H 700 1600 50  0000 C CNN
F 3 "" H 700 1600 50  0000 C CNN
	1    700  1600
	1    0    0    -1  
$EndComp
Wire Wire Line
	1200 1850 1200 1950
Wire Wire Line
	700  1950 1200 1950
Wire Wire Line
	700  1950 700  1600
$Comp
L 1Wire-SoManySwitches-rescue:GND #PWR03
U 1 1 58245334
P 8650 2400
F 0 "#PWR03" H 8650 2150 50  0001 C CNN
F 1 "GND" H 8650 2250 50  0000 C CNN
F 2 "" H 8650 2400 50  0000 C CNN
F 3 "" H 8650 2400 50  0000 C CNN
	1    8650 2400
	1    0    0    -1  
$EndComp
Wire Wire Line
	8650 2100 8650 2200
Wire Wire Line
	8350 2100 8350 2200
Wire Wire Line
	7800 2200 8350 2200
Connection ~ 8650 2200
Wire Wire Line
	8450 2100 8450 2200
Connection ~ 8450 2200
$Comp
L 1Wire-SoManySwitches-rescue:+3.3V #PWR04
U 1 1 582453EE
P 9200 800
F 0 "#PWR04" H 9200 650 50  0001 C CNN
F 1 "+3.3V" H 9200 940 50  0000 C CNN
F 2 "" H 9200 800 50  0000 C CNN
F 3 "" H 9200 800 50  0000 C CNN
	1    9200 800 
	1    0    0    -1  
$EndComp
Wire Wire Line
	9200 800  9200 950 
Wire Wire Line
	9000 1150 9000 950 
Connection ~ 9200 950 
Wire Wire Line
	8900 1150 8900 950 
Connection ~ 9000 950 
Wire Wire Line
	8800 1150 8800 950 
Connection ~ 8900 950 
$Comp
L 1Wire-SoManySwitches-rescue:CONN_02X05 P1
U 1 1 58245605
P 6150 1650
F 0 "P1" H 6150 1950 50  0000 C CNN
F 1 "CONN_02X05" H 6150 1350 50  0000 C CNN
F 2 "Pin_Headers:Pin_Header_Straight_SMT_02x05" H 6150 450 50  0001 C CNN
F 3 "" H 6150 450 50  0000 C CNN
	1    6150 1650
	1    0    0    -1  
$EndComp
$Comp
L 1Wire-SoManySwitches-rescue:+3.3V #PWR05
U 1 1 582456BE
P 5750 1350
F 0 "#PWR05" H 5750 1200 50  0001 C CNN
F 1 "+3.3V" H 5750 1490 50  0000 C CNN
F 2 "" H 5750 1350 50  0000 C CNN
F 3 "" H 5750 1350 50  0000 C CNN
	1    5750 1350
	1    0    0    -1  
$EndComp
Wire Wire Line
	5750 1350 5750 1450
Wire Wire Line
	5750 1450 5900 1450
$Comp
L 1Wire-SoManySwitches-rescue:GND #PWR06
U 1 1 58245733
P 5800 1950
F 0 "#PWR06" H 5800 1700 50  0001 C CNN
F 1 "GND" H 5800 1800 50  0000 C CNN
F 2 "" H 5800 1950 50  0000 C CNN
F 3 "" H 5800 1950 50  0000 C CNN
	1    5800 1950
	1    0    0    -1  
$EndComp
Wire Wire Line
	5900 1550 5800 1550
Wire Wire Line
	5800 1550 5800 1650
Wire Wire Line
	5900 1650 5800 1650
Connection ~ 5800 1650
Wire Wire Line
	5900 1850 5800 1850
Connection ~ 5800 1850
Wire Wire Line
	1400 1850 1400 2200
Wire Wire Line
	900  2200 1400 2200
Text Label 900  2200 0    60   ~ 0
1W-DATA
$Comp
L 1Wire-SoManySwitches-rescue:LP2950 U1
U 1 1 582584AD
P 4300 1150
F 0 "U1" H 4450 954 60  0000 C CNN
F 1 "LP2950" H 4300 1350 60  0000 C CNN
F 2 "TO_SOT_Packages_SMD:TO-252-2Lead" H 4300 1150 60  0001 C CNN
F 3 "" H 4300 1150 60  0001 C CNN
	1    4300 1150
	1    0    0    -1  
$EndComp
$Comp
L 1Wire-SoManySwitches-rescue:GND #PWR07
U 1 1 5825857A
P 4300 1500
F 0 "#PWR07" H 4300 1250 50  0001 C CNN
F 1 "GND" H 4300 1350 50  0000 C CNN
F 2 "" H 4300 1500 50  0000 C CNN
F 3 "" H 4300 1500 50  0000 C CNN
	1    4300 1500
	1    0    0    -1  
$EndComp
$Comp
L 1Wire-SoManySwitches-rescue:+5V #PWR08
U 1 1 5825859A
P 3700 900
F 0 "#PWR08" H 3700 750 50  0001 C CNN
F 1 "+5V" H 3700 1040 50  0000 C CNN
F 2 "" H 3700 900 50  0000 C CNN
F 3 "" H 3700 900 50  0000 C CNN
	1    3700 900 
	1    0    0    -1  
$EndComp
$Comp
L 1Wire-SoManySwitches-rescue:+3.3V #PWR09
U 1 1 582585BA
P 4800 1000
F 0 "#PWR09" H 4800 850 50  0001 C CNN
F 1 "+3.3V" H 4800 1140 50  0000 C CNN
F 2 "" H 4800 1000 50  0000 C CNN
F 3 "" H 4800 1000 50  0000 C CNN
	1    4800 1000
	1    0    0    -1  
$EndComp
Wire Wire Line
	4700 1100 4800 1100
Wire Wire Line
	4800 1100 4800 1000
Wire Wire Line
	3900 1100 3700 1100
$Comp
L 1Wire-SoManySwitches-rescue:CP C1
U 1 1 582587E1
P 3700 1250
F 0 "C1" H 3725 1350 50  0000 L CNN
F 1 "100uF" H 3725 1150 50  0000 L CNN
F 2 "Capacitors_SMD:c_elec_8x6.7" H 3738 1100 50  0001 C CNN
F 3 "" H 3700 1250 50  0000 C CNN
	1    3700 1250
	1    0    0    -1  
$EndComp
Wire Wire Line
	3700 1400 3700 1450
Wire Wire Line
	3700 1450 4300 1450
Wire Wire Line
	4800 1450 4800 1400
Connection ~ 4300 1450
$Comp
L 1Wire-SoManySwitches-rescue:C C3
U 1 1 582589CF
P 9600 1150
F 0 "C3" H 9625 1250 50  0000 L CNN
F 1 "100nF" H 9625 1050 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603" H 9638 1000 50  0001 C CNN
F 3 "" H 9600 1150 50  0000 C CNN
	1    9600 1150
	1    0    0    -1  
$EndComp
$Comp
L 1Wire-SoManySwitches-rescue:C C4
U 1 1 58258CB3
P 9950 1150
F 0 "C4" H 9975 1250 50  0000 L CNN
F 1 "100nF" H 9975 1050 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603" H 9988 1000 50  0001 C CNN
F 3 "" H 9950 1150 50  0000 C CNN
	1    9950 1150
	1    0    0    -1  
$EndComp
$Comp
L 1Wire-SoManySwitches-rescue:GND #PWR010
U 1 1 58258D67
P 9600 1400
F 0 "#PWR010" H 9600 1150 50  0001 C CNN
F 1 "GND" H 9600 1250 50  0000 C CNN
F 2 "" H 9600 1400 50  0000 C CNN
F 3 "" H 9600 1400 50  0000 C CNN
	1    9600 1400
	1    0    0    -1  
$EndComp
Wire Wire Line
	9600 1300 9600 1350
Wire Wire Line
	9950 1300 9950 1350
Connection ~ 9600 1350
Wire Wire Line
	9950 950  9950 1000
Wire Wire Line
	9600 1000 9600 950 
Connection ~ 9600 950 
$Comp
L 1Wire-SoManySwitches-rescue:C C2
U 1 1 58259010
P 4800 1250
F 0 "C2" H 4825 1350 50  0000 L CNN
F 1 "4.7uF" H 4825 1150 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603" H 4838 1100 50  0001 C CNN
F 3 "" H 4800 1250 50  0000 C CNN
	1    4800 1250
	1    0    0    -1  
$EndComp
Wire Wire Line
	2000 2000 2000 1050
$Comp
L 1Wire-SoManySwitches-rescue:+3.3V #PWR011
U 1 1 5827B1CE
P 11150 1250
F 0 "#PWR011" H 11150 1100 50  0001 C CNN
F 1 "+3.3V" H 11150 1390 50  0000 C CNN
F 2 "" H 11150 1250 50  0000 C CNN
F 3 "" H 11150 1250 50  0000 C CNN
	1    11150 1250
	1    0    0    -1  
$EndComp
Wire Wire Line
	11250 1350 11150 1350
Wire Wire Line
	11150 1350 11150 1250
$Comp
L 1Wire-SoManySwitches-rescue:GND #PWR012
U 1 1 5827B41B
P 11200 1700
F 0 "#PWR012" H 11200 1450 50  0001 C CNN
F 1 "GND" H 11200 1550 50  0000 C CNN
F 2 "" H 11200 1700 50  0000 C CNN
F 3 "" H 11200 1700 50  0000 C CNN
	1    11200 1700
	1    0    0    -1  
$EndComp
Wire Wire Line
	11250 1650 11200 1650
Wire Wire Line
	11200 1650 11200 1700
$Comp
L 1Wire-SoManySwitches-rescue:RJ45 J2
U 1 1 5827B786
P 2500 1400
F 0 "J2" H 2700 1900 50  0000 C CNN
F 1 "RJ45" H 2350 1900 50  0000 C CNN
F 2 "RJ45:RJ45-ChinaSMD" H 2500 1400 50  0001 C CNN
F 3 "" H 2500 1400 50  0000 C CNN
	1    2500 1400
	1    0    0    -1  
$EndComp
Wire Wire Line
	3050 2000 3050 1050
Connection ~ 2000 2000
Wire Wire Line
	2150 1850 2150 2000
Connection ~ 2150 2000
Wire Wire Line
	2350 1850 2350 2000
Connection ~ 2350 2000
Wire Wire Line
	2550 1850 2550 2000
Connection ~ 2550 2000
Wire Wire Line
	2850 1850 2850 2000
Connection ~ 2850 2000
Wire Wire Line
	2250 1950 2250 1850
Connection ~ 1200 1950
Wire Wire Line
	7800 1700 7800 2200
Connection ~ 8350 2200
Wire Wire Line
	8800 950  8900 950 
Wire Wire Line
	9600 1350 9950 1350
$Comp
L 1Wire-SoManySwitches-rescue:C C5
U 1 1 5827DCB8
P 10300 1150
F 0 "C5" H 10325 1250 50  0000 L CNN
F 1 "100nF" H 10325 1050 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603" H 10338 1000 50  0001 C CNN
F 3 "" H 10300 1150 50  0000 C CNN
	1    10300 1150
	1    0    0    -1  
$EndComp
Wire Wire Line
	10300 950  10300 1000
Connection ~ 9950 950 
Wire Wire Line
	10300 1350 10300 1300
Connection ~ 9950 1350
Wire Wire Line
	2450 2200 2450 1850
Connection ~ 1400 2200
Wire Wire Line
	1600 1850 1600 2050
Wire Wire Line
	1600 2050 2650 2050
Wire Wire Line
	2650 2050 2650 1850
Wire Wire Line
	1700 1850 1700 2100
Wire Wire Line
	1700 2100 2750 2100
Wire Wire Line
	2750 2100 2750 1850
Wire Wire Line
	4300 1500 4300 1450
Wire Wire Line
	10800 1450 11250 1450
Wire Wire Line
	11250 1550 10800 1550
Connection ~ 3700 1100
Connection ~ 4800 1100
$Comp
L 1Wire-SoManySwitches-rescue:R R1
U 1 1 58B28CDC
P 7700 1300
F 0 "R1" V 7780 1300 50  0000 C CNN
F 1 "10K" V 7700 1300 50  0000 C CNN
F 2 "Resistors_SMD:R_0603" V 7630 1300 50  0001 C CNN
F 3 "" H 7700 1300 50  0000 C CNN
	1    7700 1300
	1    0    0    -1  
$EndComp
$Comp
L 1Wire-SoManySwitches-rescue:CONN_01X05 P6
U 1 1 58B297A3
P 11450 1450
F 0 "P6" H 11450 1750 50  0000 C CNN
F 1 "CONN_01X05" V 11550 1450 50  0000 C CNN
F 2 "Pin_Headers:Pin_Header_Straight_1x05_Pitch2.54mm" H 11450 1450 50  0001 C CNN
F 3 "" H 11450 1450 50  0000 C CNN
	1    11450 1450
	1    0    0    -1  
$EndComp
Wire Wire Line
	11250 1250 11250 900 
Text Label 11250 900  0    60   ~ 0
1W-DATA
$Comp
L 1Wire-SoManySwitches-rescue:STM32F030R8 U2
U 1 1 58BE5DEB
P 650 3000
F 0 "U2" H 750 3050 50  0000 C CNN
F 1 "STM32F030R8" H 950 3150 50  0001 C CNN
F 2 "LQFP-64" H 850 3250 50  0001 C CIN
F 3 "" H 3950 500 50  0000 C CNN
	1    650  3000
	1    0    0    -1  
$EndComp
$Comp
L 1Wire-SoManySwitches-rescue:STM32F030R8 U2
U 2 1 58BE5E38
P 1550 5100
F 0 "U2" H 1650 5150 50  0000 C CNN
F 1 "STM32F030R8" H 1850 5250 50  0001 C CNN
F 2 "Housings_QFP:LQFP-64_10x10mm_Pitch0.5mm" H 1750 5350 50  0001 C CIN
F 3 "" H 4850 2600 50  0000 C CNN
	2    1550 5100
	1    0    0    -1  
$EndComp
$Comp
L 1Wire-SoManySwitches-rescue:STM32F030R8 U2
U 3 1 58BE5EB3
P 2050 7200
F 0 "U2" H 2150 7250 50  0000 C CNN
F 1 "STM32F030R8" H 2350 7350 50  0001 C CNN
F 2 "LQFP-64" H 2250 7450 50  0001 C CIN
F 3 "" H 5350 4700 50  0000 C CNN
	3    2050 7200
	1    0    0    -1  
$EndComp
$Comp
L 1Wire-SoManySwitches-rescue:STM32F030R8 U2
U 5 1 58BE5F0E
P 3100 9300
F 0 "U2" H 3200 9350 50  0000 C CNN
F 1 "STM32F030R8" H 3400 9450 50  0001 C CNN
F 2 "LQFP-64" H 3300 9550 50  0001 C CIN
F 3 "" H 6400 6800 50  0000 C CNN
	5    3100 9300
	1    0    0    -1  
$EndComp
Text Label 6850 1450 0    60   ~ 0
SWDAT
Text Label 6850 1550 0    60   ~ 0
SWCLK
Wire Wire Line
	7800 1600 7700 1600
Wire Wire Line
	7650 1600 7650 1850
Wire Wire Line
	7650 1850 6400 1850
Text Label 10800 1450 0    60   ~ 0
UART_TX
Text Label 10800 1550 0    60   ~ 0
UART_RX
Wire Wire Line
	6400 1550 6850 1550
Wire Wire Line
	6850 1450 6400 1450
$Comp
L 1Wire-SoManySwitches-rescue:RJ45 J7
U 1 1 58BE89F3
P 9800 3300
F 0 "J7" H 10000 3800 50  0000 C CNN
F 1 "RJ45" H 9650 3800 50  0000 C CNN
F 2 "RJ45:RJ45-ChinaSMD" H 9800 3300 50  0001 C CNN
F 3 "" H 9800 3300 50  0000 C CNN
	1    9800 3300
	0    1    1    0   
$EndComp
Wire Wire Line
	9350 3050 9050 3050
Wire Wire Line
	9350 3150 9050 3150
Wire Wire Line
	9350 3250 9050 3250
Wire Wire Line
	9350 3350 9050 3350
Wire Wire Line
	9350 3450 9050 3450
Wire Wire Line
	9350 3550 9050 3550
Wire Wire Line
	8900 3650 9350 3650
Text Label 9050 3050 0    60   ~ 0
J7_0
Text Label 9050 3150 0    60   ~ 0
J7_1
Text Label 9050 3250 0    60   ~ 0
J7_2
Text Label 9050 3350 0    60   ~ 0
J7_3
Text Label 9050 3450 0    60   ~ 0
J7_4
Text Label 9050 3550 0    60   ~ 0
J7_5
Wire Wire Line
	4100 8400 4300 8400
Wire Wire Line
	4100 8500 4300 8500
Wire Wire Line
	4100 8600 4300 8600
$Comp
L 1Wire-SoManySwitches-rescue:RJ45 J8
U 1 1 58BEA0CC
P 9800 4450
F 0 "J8" H 10000 4950 50  0000 C CNN
F 1 "RJ45" H 9650 4950 50  0000 C CNN
F 2 "RJ45:RJ45-ChinaSMD" H 9800 4450 50  0001 C CNN
F 3 "" H 9800 4450 50  0000 C CNN
	1    9800 4450
	0    1    1    0   
$EndComp
Wire Wire Line
	9350 4200 9050 4200
Wire Wire Line
	9350 4300 9050 4300
Wire Wire Line
	9350 4400 9050 4400
Wire Wire Line
	9350 4500 9050 4500
Wire Wire Line
	9350 4600 9050 4600
Wire Wire Line
	9350 4700 9050 4700
Wire Wire Line
	8900 4800 9350 4800
Text Label 9050 4200 0    60   ~ 0
J8_0
Text Label 9050 4300 0    60   ~ 0
J8_1
Text Label 9050 4400 0    60   ~ 0
J8_2
Text Label 9050 4500 0    60   ~ 0
J8_3
Text Label 9050 4600 0    60   ~ 0
J8_4
Text Label 9050 4700 0    60   ~ 0
J8_5
Wire Wire Line
	4100 8700 4300 8700
Wire Wire Line
	4100 8800 4300 8800
Wire Wire Line
	4100 8900 4300 8900
Wire Wire Line
	4100 9500 4300 9500
Wire Wire Line
	4100 9600 4300 9600
Wire Wire Line
	4100 7400 4300 7400
Wire Wire Line
	4100 7500 4300 7500
$Comp
L 1Wire-SoManySwitches-rescue:RJ45 J5
U 1 1 58BEAA5E
P 8150 3300
F 0 "J5" H 8350 3800 50  0000 C CNN
F 1 "RJ45" H 8000 3800 50  0000 C CNN
F 2 "RJ45:RJ45-ChinaSMD" H 8150 3300 50  0001 C CNN
F 3 "" H 8150 3300 50  0000 C CNN
	1    8150 3300
	0    1    1    0   
$EndComp
Wire Wire Line
	7700 3050 7400 3050
Wire Wire Line
	7700 3150 7400 3150
Wire Wire Line
	7700 3250 7400 3250
Wire Wire Line
	7700 3350 7400 3350
Wire Wire Line
	7700 3450 7400 3450
Wire Wire Line
	7700 3550 7400 3550
Wire Wire Line
	7300 3650 7700 3650
Text Label 7400 3050 0    60   ~ 0
J5_0
Text Label 7400 3150 0    60   ~ 0
J5_1
Text Label 7400 3250 0    60   ~ 0
J5_2
Text Label 7400 3350 0    60   ~ 0
J5_3
Text Label 7400 3450 0    60   ~ 0
J5_4
Text Label 7400 3550 0    60   ~ 0
J5_5
$Comp
L 1Wire-SoManySwitches-rescue:RJ45 J6
U 1 1 58BEAA72
P 8150 4450
F 0 "J6" H 8350 4950 50  0000 C CNN
F 1 "RJ45" H 8000 4950 50  0000 C CNN
F 2 "RJ45:RJ45-ChinaSMD" H 8150 4450 50  0001 C CNN
F 3 "" H 8150 4450 50  0000 C CNN
	1    8150 4450
	0    1    1    0   
$EndComp
Wire Wire Line
	7700 4200 7400 4200
Wire Wire Line
	7700 4300 7400 4300
Wire Wire Line
	7700 4400 7400 4400
Wire Wire Line
	7700 4500 7400 4500
Wire Wire Line
	7700 4600 7400 4600
Wire Wire Line
	7700 4700 7400 4700
Wire Wire Line
	7300 4800 7700 4800
Text Label 7400 4200 0    60   ~ 0
J6_0
Text Label 7400 4300 0    60   ~ 0
J6_1
Text Label 7400 4400 0    60   ~ 0
J6_2
Text Label 7400 4500 0    60   ~ 0
J6_3
Text Label 7400 4600 0    60   ~ 0
J6_4
Text Label 7400 4700 0    60   ~ 0
J6_5
$Comp
L 1Wire-SoManySwitches-rescue:RJ45 J3
U 1 1 58BEAB14
P 6600 3300
F 0 "J3" H 6800 3800 50  0000 C CNN
F 1 "RJ45" H 6450 3800 50  0000 C CNN
F 2 "RJ45:RJ45-ChinaSMD" H 6600 3300 50  0001 C CNN
F 3 "" H 6600 3300 50  0000 C CNN
	1    6600 3300
	0    1    1    0   
$EndComp
Wire Wire Line
	6150 3050 5850 3050
Wire Wire Line
	6150 3150 5850 3150
Wire Wire Line
	6150 3250 5850 3250
Wire Wire Line
	6150 3350 5850 3350
Wire Wire Line
	6150 3450 5850 3450
Wire Wire Line
	6150 3550 5850 3550
Wire Wire Line
	5700 3650 6150 3650
Text Label 5850 3050 0    60   ~ 0
J3_0
Text Label 5850 3150 0    60   ~ 0
J3_1
Text Label 5850 3250 0    60   ~ 0
J3_2
Text Label 5850 3350 0    60   ~ 0
J3_3
Text Label 5850 3450 0    60   ~ 0
J3_4
Text Label 5850 3550 0    60   ~ 0
J3_5
$Comp
L 1Wire-SoManySwitches-rescue:RJ45 J4
U 1 1 58BEAB28
P 6600 4450
F 0 "J4" H 6800 4950 50  0000 C CNN
F 1 "RJ45" H 6450 4950 50  0000 C CNN
F 2 "RJ45:RJ45-ChinaSMD" H 6600 4450 50  0001 C CNN
F 3 "" H 6600 4450 50  0000 C CNN
	1    6600 4450
	0    1    1    0   
$EndComp
Wire Wire Line
	6150 4200 5850 4200
Wire Wire Line
	6150 4300 5850 4300
Wire Wire Line
	6150 4400 5850 4400
Wire Wire Line
	6150 4500 5850 4500
Wire Wire Line
	6150 4600 5850 4600
Wire Wire Line
	6150 4700 5850 4700
Wire Wire Line
	5700 4800 6150 4800
Text Label 5850 4200 0    60   ~ 0
J4_0
Text Label 5850 4300 0    60   ~ 0
J4_1
Text Label 5850 4400 0    60   ~ 0
J4_2
Text Label 5850 4500 0    60   ~ 0
J4_3
Text Label 5850 4600 0    60   ~ 0
J4_4
Text Label 5850 4700 0    60   ~ 0
J4_5
Wire Wire Line
	4100 6500 4300 6500
Wire Wire Line
	4100 6400 4300 6400
Wire Wire Line
	4100 6300 4300 6300
Wire Wire Line
	4100 6200 4300 6200
Wire Wire Line
	4100 6100 4300 6100
Wire Wire Line
	4100 6000 4300 6000
Wire Wire Line
	4100 9700 4300 9700
Wire Wire Line
	4100 9800 4300 9800
Wire Wire Line
	4100 9900 4300 9900
Wire Wire Line
	4100 10000 4300 10000
Wire Wire Line
	4100 8300 4300 8300
Wire Wire Line
	4100 8200 4300 8200
Wire Wire Line
	4100 8100 4300 8100
Wire Wire Line
	4100 8000 4300 8000
Wire Wire Line
	4100 7900 4300 7900
Wire Wire Line
	4100 7700 4300 7700
Wire Wire Line
	4100 7600 4300 7600
Wire Wire Line
	4100 6800 4300 6800
Wire Wire Line
	4100 6700 4300 6700
Wire Wire Line
	4100 6600 4300 6600
Wire Wire Line
	4100 5900 4300 5900
Wire Wire Line
	4100 5800 4300 5800
Wire Wire Line
	4100 5700 4300 5700
Wire Wire Line
	4100 5600 4300 5600
Wire Wire Line
	4100 5500 4300 5500
Wire Wire Line
	4100 5400 4300 5400
Wire Wire Line
	4100 5300 4300 5300
Wire Wire Line
	4100 4700 4300 4700
Wire Wire Line
	4100 4600 4750 4600
Wire Wire Line
	4100 4500 4750 4500
Wire Wire Line
	4100 4400 4300 4400
Wire Wire Line
	4100 4300 4300 4300
Wire Wire Line
	4100 4200 4300 4200
Wire Wire Line
	4100 4100 4300 4100
Wire Wire Line
	4100 4000 4300 4000
Wire Wire Line
	4100 3900 4300 3900
Wire Wire Line
	4100 3800 4300 3800
Wire Wire Line
	4100 3700 4300 3700
Wire Wire Line
	4100 3600 4300 3600
Wire Wire Line
	4100 3500 4300 3500
Wire Wire Line
	4100 3400 4300 3400
Wire Wire Line
	4100 3300 4300 3300
Wire Wire Line
	4100 3200 4300 3200
Text Label 4300 8700 0    60   ~ 0
J5_0
Text Label 4300 8800 0    60   ~ 0
J5_1
Text Label 4300 8900 0    60   ~ 0
J5_2
Text Label 4300 9500 0    60   ~ 0
J5_3
Text Label 4300 9600 0    60   ~ 0
J5_4
Text Label 4300 7400 0    60   ~ 0
J5_5
Text Label 4300 7500 0    60   ~ 0
J4_0
Text Label 4300 7600 0    60   ~ 0
J4_1
Text Label 4300 7700 0    60   ~ 0
J4_2
Text Label 4300 3200 0    60   ~ 0
J4_3
Text Label 4300 3300 0    60   ~ 0
J4_4
Text Label 4300 3400 0    60   ~ 0
UART_TX
Text Label 4300 3500 0    60   ~ 0
UART_RX
Text Label 4300 3600 0    60   ~ 0
J3_1
Text Label 4300 3700 0    60   ~ 0
J3_2
Text Label 4300 3800 0    60   ~ 0
J3_3
Text Label 4300 3900 0    60   ~ 0
J3_4
Text Label 4300 7900 0    60   ~ 0
J3_5
Text Label 4300 5300 0    60   ~ 0
1W-DATA
Text Label 4300 9700 0    60   ~ 0
J4_5
Text Label 4300 9800 0    60   ~ 0
J3_0
Text Label 4300 5400 0    60   ~ 0
J10_0
Text Label 4300 5500 0    60   ~ 0
J10_1
Text Label 4300 6300 0    60   ~ 0
J10_2
Text Label 4300 6400 0    60   ~ 0
J10_3
Text Label 4300 6500 0    60   ~ 0
J10_4
Text Label 4300 6600 0    60   ~ 0
J10_5
Text Label 4300 6700 0    60   ~ 0
J9_0
Text Label 4300 6800 0    60   ~ 0
J9_1
Text Label 4300 8000 0    60   ~ 0
J9_2
Text Label 4300 8100 0    60   ~ 0
J9_3
Text Label 4300 8200 0    60   ~ 0
J9_4
Text Label 4300 8300 0    60   ~ 0
J9_5
Text Label 4300 4000 0    60   ~ 0
J8_0
Text Label 4300 4100 0    60   ~ 0
J8_1
Text Label 4300 4200 0    60   ~ 0
J8_2
Text Label 4300 4300 0    60   ~ 0
J8_3
Text Label 4300 4400 0    60   ~ 0
J8_4
Text Label 4300 4500 0    60   ~ 0
SWDAT
Text Label 4300 9900 0    60   ~ 0
J7_0
Text Label 4300 10000 0    60   ~ 0
J7_1
Text Label 4300 4600 0    60   ~ 0
SWCLK
Text Label 4300 4700 0    60   ~ 0
J7_3
Text Label 4300 8400 0    60   ~ 0
J7_4
Text Label 4300 8500 0    60   ~ 0
J7_5
Text Label 4300 8600 0    60   ~ 0
J6_0
Text Label 4300 5600 0    60   ~ 0
J6_1
Text Label 4300 5700 0    60   ~ 0
J6_2
Text Label 4300 5800 0    60   ~ 0
J6_3
Text Label 4300 5900 0    60   ~ 0
J6_4
Text Label 4300 6000 0    60   ~ 0
J6_5
$Comp
L 1Wire-SoManySwitches-rescue:RJ45 J9
U 1 1 58BEEA9A
P 11400 3300
F 0 "J9" H 11600 3800 50  0000 C CNN
F 1 "RJ45" H 11250 3800 50  0000 C CNN
F 2 "RJ45:RJ45-ChinaSMD" H 11400 3300 50  0001 C CNN
F 3 "" H 11400 3300 50  0000 C CNN
	1    11400 3300
	0    1    1    0   
$EndComp
Wire Wire Line
	10950 3050 10650 3050
Wire Wire Line
	10950 3150 10650 3150
Wire Wire Line
	10950 3250 10650 3250
Wire Wire Line
	10950 3350 10650 3350
Wire Wire Line
	10950 3450 10650 3450
Wire Wire Line
	10950 3550 10650 3550
Wire Wire Line
	10500 3650 10950 3650
Text Label 10650 3050 0    60   ~ 0
J9_0
Text Label 10650 3150 0    60   ~ 0
J9_1
Text Label 10650 3250 0    60   ~ 0
J9_2
Text Label 10650 3350 0    60   ~ 0
J9_3
Text Label 10650 3450 0    60   ~ 0
J9_4
Text Label 10650 3550 0    60   ~ 0
J9_5
$Comp
L 1Wire-SoManySwitches-rescue:RJ45 J10
U 1 1 58BEEAAE
P 11400 4450
F 0 "J10" H 11600 4950 50  0000 C CNN
F 1 "RJ45" H 11250 4950 50  0000 C CNN
F 2 "RJ45:RJ45-ChinaSMD" H 11400 4450 50  0001 C CNN
F 3 "" H 11400 4450 50  0000 C CNN
	1    11400 4450
	0    1    1    0   
$EndComp
Wire Wire Line
	10950 4200 10650 4200
Wire Wire Line
	10950 4300 10650 4300
Wire Wire Line
	10950 4400 10650 4400
Wire Wire Line
	10950 4500 10650 4500
Wire Wire Line
	10950 4600 10650 4600
Wire Wire Line
	10950 4700 10650 4700
Wire Wire Line
	10500 4800 10950 4800
Text Label 10650 4200 0    60   ~ 0
J10_0
Text Label 10650 4300 0    60   ~ 0
J10_1
Text Label 10650 4400 0    60   ~ 0
J10_2
Text Label 10650 4500 0    60   ~ 0
J10_3
Text Label 10650 4600 0    60   ~ 0
J10_4
Text Label 10650 4700 0    60   ~ 0
J10_5
$Comp
L 1Wire-SoManySwitches-rescue:GND #PWR013
U 1 1 58BEEDA0
P 12100 5200
F 0 "#PWR013" H 12100 4950 50  0001 C CNN
F 1 "GND" H 12100 5050 50  0000 C CNN
F 2 "" H 12100 5200 50  0000 C CNN
F 3 "" H 12100 5200 50  0000 C CNN
	1    12100 5200
	1    0    0    -1  
$EndComp
Wire Wire Line
	6150 3850 6950 3850
Connection ~ 8500 3850
Connection ~ 10150 3850
Wire Wire Line
	12100 2750 12100 3850
Connection ~ 11750 3850
Wire Wire Line
	6950 5000 8500 5000
Connection ~ 8500 5000
Connection ~ 10150 5000
Connection ~ 12100 5000
Connection ~ 11750 5000
Wire Wire Line
	6150 2950 6150 2750
Wire Wire Line
	6150 2750 7700 2750
Connection ~ 12100 3850
Wire Wire Line
	10950 2950 10950 2750
Connection ~ 10950 2750
Wire Wire Line
	9350 2950 9350 2750
Connection ~ 9350 2750
Wire Wire Line
	7700 2950 7700 2750
Connection ~ 7700 2750
Wire Wire Line
	7700 4100 7700 3850
Connection ~ 7700 3850
Wire Wire Line
	9350 4100 9350 3850
Connection ~ 9350 3850
Wire Wire Line
	10950 4100 10950 3850
Connection ~ 10950 3850
Wire Wire Line
	6150 4100 6150 3850
Connection ~ 6950 3850
Text Label 4750 4500 0    60   ~ 0
J8_5
Text Label 4750 4600 0    60   ~ 0
J7_2
$Comp
L 1Wire-SoManySwitches-rescue:+5V #PWR014
U 1 1 58BF2FA2
P 5700 2600
F 0 "#PWR014" H 5700 2450 50  0001 C CNN
F 1 "+5V" H 5700 2740 50  0000 C CNN
F 2 "" H 5700 2600 50  0000 C CNN
F 3 "" H 5700 2600 50  0000 C CNN
	1    5700 2600
	1    0    0    -1  
$EndComp
Wire Wire Line
	5700 2600 5700 2650
Connection ~ 5700 3650
Wire Wire Line
	7300 4800 7300 3650
Wire Wire Line
	5700 2650 7300 2650
Connection ~ 5700 2650
Wire Wire Line
	10500 2650 10500 3650
Connection ~ 7300 2650
Connection ~ 10500 3650
Wire Wire Line
	8900 4800 8900 3650
Connection ~ 8900 3650
Connection ~ 7300 3650
Wire Wire Line
	1800 2000 2000 2000
Wire Wire Line
	1800 2000 1800 2350
Wire Wire Line
	1300 2000 1500 2000
Wire Wire Line
	1500 2000 1800 2000
Wire Wire Line
	8650 2200 8650 2400
Wire Wire Line
	8450 2200 8650 2200
Wire Wire Line
	9200 950  9200 1150
Wire Wire Line
	9200 950  9600 950 
Wire Wire Line
	9000 950  9200 950 
Wire Wire Line
	8900 950  9000 950 
Wire Wire Line
	5800 1650 5800 1850
Wire Wire Line
	5800 1850 5800 1950
Wire Wire Line
	4300 1450 4800 1450
Wire Wire Line
	4300 1450 4300 1400
Wire Wire Line
	9600 1350 9600 1400
Wire Wire Line
	9600 950  9950 950 
Wire Wire Line
	2000 2000 2150 2000
Wire Wire Line
	2150 2000 2350 2000
Wire Wire Line
	2350 2000 2550 2000
Wire Wire Line
	2550 2000 2850 2000
Wire Wire Line
	2850 2000 3050 2000
Wire Wire Line
	1200 1950 2250 1950
Wire Wire Line
	8350 2200 8450 2200
Wire Wire Line
	9950 950  10300 950 
Wire Wire Line
	9950 1350 10300 1350
Wire Wire Line
	1400 2200 2450 2200
Wire Wire Line
	8500 3850 9350 3850
Wire Wire Line
	10150 3850 10950 3850
Wire Wire Line
	11750 3850 12100 3850
Wire Wire Line
	8500 5000 10150 5000
Wire Wire Line
	10150 5000 11750 5000
Wire Wire Line
	12100 5000 12100 5200
Wire Wire Line
	11750 5000 12100 5000
Wire Wire Line
	12100 3850 12100 5000
Wire Wire Line
	10950 2750 12100 2750
Wire Wire Line
	9350 2750 10950 2750
Wire Wire Line
	7700 2750 9350 2750
Wire Wire Line
	7700 3850 8500 3850
Wire Wire Line
	9350 3850 10150 3850
Wire Wire Line
	10950 3850 11750 3850
Wire Wire Line
	6950 3850 7700 3850
Wire Wire Line
	5700 3650 5700 4800
Wire Wire Line
	5700 2650 5700 3650
Wire Wire Line
	10500 3650 10500 4800
Wire Wire Line
	8900 3650 8900 2650
Wire Wire Line
	7300 3650 7300 2650
Wire Wire Line
	7300 2650 10500 2650
$Comp
L 1Wire-SoManySwitches-rescue:+3.3V #PWR?
U 1 1 5C231738
P 7700 1050
F 0 "#PWR?" H 7700 900 50  0001 C CNN
F 1 "+3.3V" H 7700 1190 50  0000 C CNN
F 2 "" H 7700 1050 50  0000 C CNN
F 3 "" H 7700 1050 50  0000 C CNN
	1    7700 1050
	1    0    0    -1  
$EndComp
Wire Wire Line
	3700 900  3700 1100
Wire Wire Line
	7700 1450 7700 1600
Connection ~ 7700 1600
Wire Wire Line
	7700 1600 7650 1600
Wire Wire Line
	7700 1150 7700 1050
$EndSCHEMATC

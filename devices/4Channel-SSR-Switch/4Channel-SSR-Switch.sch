EESchema Schematic File Version 4
LIBS:4Channel-SSR-Switch-cache
EELAYER 26 0
EELAYER END
$Descr A3 16535 11693
encoding utf-8
Sheet 1 1
Title "4 Channel SSR Switch"
Date "2018-12-23"
Rev "1.2"
Comp "Inferno Embedded"
Comment1 "Licensed under the TAPR Open Hardware License (www.tapr.org/OHL)"
Comment2 "Copyright © 2018 Inferno Embedded"
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L 4Channel-SSR-Switch-rescue:RJ45 J1
U 1 1 5824359A
P 12050 5900
F 0 "J1" H 12250 6400 50  0000 C CNN
F 1 "RJ45" H 11900 6400 50  0000 C CNN
F 2 "RJ45:RJ45-ChinaSMD" H 12050 5900 50  0001 C CNN
F 3 "" H 12050 5900 50  0000 C CNN
	1    12050 5900
	1    0    0    -1  
$EndComp
$Comp
L 4Channel-SSR-Switch-rescue:STM32F030R8 U2
U 4 1 58244F90
P 13250 8400
F 0 "U2" H 13350 8450 50  0000 C CNN
F 1 "STM32F030R8" H 13550 8550 50  0001 C CNN
F 2 "Housings_QFP:LQFP-64_10x10mm_Pitch0.5mm" H 13450 8650 50  0001 C CIN
F 3 "" H 16550 5900 50  0000 C CNN
	4    13250 8400
	1    0    0    -1  
$EndComp
$Comp
L 4Channel-SSR-Switch-rescue:GND #PWR01
U 1 1 5824517A
P 10750 6950
F 0 "#PWR01" H 10750 6700 50  0001 C CNN
F 1 "GND" H 10750 6800 50  0000 C CNN
F 2 "" H 10750 6950 50  0000 C CNN
F 3 "" H 10750 6950 50  0000 C CNN
	1    10750 6950
	1    0    0    -1  
$EndComp
$Comp
L 4Channel-SSR-Switch-rescue:+5V #PWR02
U 1 1 582452BF
P 11300 6100
F 0 "#PWR02" H 11300 5950 50  0001 C CNN
F 1 "+5V" H 11300 6240 50  0000 C CNN
F 2 "" H 11300 6100 50  0000 C CNN
F 3 "" H 11300 6100 50  0000 C CNN
	1    11300 6100
	1    0    0    -1  
$EndComp
$Comp
L 4Channel-SSR-Switch-rescue:GND #PWR03
U 1 1 58245334
P 13950 9500
F 0 "#PWR03" H 13950 9250 50  0001 C CNN
F 1 "GND" H 13950 9350 50  0000 C CNN
F 2 "" H 13950 9500 50  0000 C CNN
F 3 "" H 13950 9500 50  0000 C CNN
	1    13950 9500
	1    0    0    -1  
$EndComp
$Comp
L 4Channel-SSR-Switch-rescue:+3.3V #PWR04
U 1 1 582453EE
P 14500 7900
F 0 "#PWR04" H 14500 7750 50  0001 C CNN
F 1 "+3.3V" H 14500 8040 50  0000 C CNN
F 2 "" H 14500 7900 50  0000 C CNN
F 3 "" H 14500 7900 50  0000 C CNN
	1    14500 7900
	1    0    0    -1  
$EndComp
$Comp
L 4Channel-SSR-Switch-rescue:CONN_02X05 P1
U 1 1 58245605
P 11750 8500
F 0 "P1" H 11750 8800 50  0000 C CNN
F 1 "CONN_02X05" H 11750 8200 50  0000 C CNN
F 2 "Pin_Headers:Pin_Header_Straight_2x05_Pitch2.54mm_SMD" H 11750 7300 50  0001 C CNN
F 3 "" H 11750 7300 50  0000 C CNN
	1    11750 8500
	1    0    0    -1  
$EndComp
$Comp
L 4Channel-SSR-Switch-rescue:GND #PWR05
U 1 1 58245733
P 11400 8800
F 0 "#PWR05" H 11400 8550 50  0001 C CNN
F 1 "GND" H 11400 8650 50  0000 C CNN
F 2 "" H 11400 8800 50  0000 C CNN
F 3 "" H 11400 8800 50  0000 C CNN
	1    11400 8800
	1    0    0    -1  
$EndComp
$Comp
L 4Channel-SSR-Switch-rescue:LP2950 U1
U 1 1 582584AD
P 14900 5650
F 0 "U1" H 15050 5454 60  0000 C CNN
F 1 "LP2950" H 14900 5850 60  0000 C CNN
F 2 "TO_SOT_Packages_SMD:TO-252-2" H 14900 5650 60  0001 C CNN
F 3 "" H 14900 5650 60  0001 C CNN
	1    14900 5650
	1    0    0    -1  
$EndComp
$Comp
L 4Channel-SSR-Switch-rescue:GND #PWR06
U 1 1 5825857A
P 14900 6000
F 0 "#PWR06" H 14900 5750 50  0001 C CNN
F 1 "GND" H 14900 5850 50  0000 C CNN
F 2 "" H 14900 6000 50  0000 C CNN
F 3 "" H 14900 6000 50  0000 C CNN
	1    14900 6000
	1    0    0    -1  
$EndComp
$Comp
L 4Channel-SSR-Switch-rescue:+5V #PWR07
U 1 1 5825859A
P 14300 5200
F 0 "#PWR07" H 14300 5050 50  0001 C CNN
F 1 "+5V" H 14300 5340 50  0000 C CNN
F 2 "" H 14300 5200 50  0000 C CNN
F 3 "" H 14300 5200 50  0000 C CNN
	1    14300 5200
	1    0    0    -1  
$EndComp
$Comp
L 4Channel-SSR-Switch-rescue:+3.3V #PWR08
U 1 1 582585BA
P 15400 5500
F 0 "#PWR08" H 15400 5350 50  0001 C CNN
F 1 "+3.3V" H 15400 5640 50  0000 C CNN
F 2 "" H 15400 5500 50  0000 C CNN
F 3 "" H 15400 5500 50  0000 C CNN
	1    15400 5500
	1    0    0    -1  
$EndComp
$Comp
L 4Channel-SSR-Switch-rescue:CP C1
U 1 1 582587E1
P 14300 5750
F 0 "C1" H 14325 5850 50  0000 L CNN
F 1 "100uF" H 14325 5650 50  0000 L CNN
F 2 "Capacitors_SMD:C_1206" H 14338 5600 50  0001 C CNN
F 3 "" H 14300 5750 50  0000 C CNN
	1    14300 5750
	1    0    0    -1  
$EndComp
$Comp
L 4Channel-SSR-Switch-rescue:C C3
U 1 1 582589CF
P 14900 8250
F 0 "C3" H 14925 8350 50  0000 L CNN
F 1 "100nF" H 14925 8150 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603" H 14938 8100 50  0001 C CNN
F 3 "" H 14900 8250 50  0000 C CNN
	1    14900 8250
	1    0    0    -1  
$EndComp
$Comp
L 4Channel-SSR-Switch-rescue:C C4
U 1 1 58258CB3
P 15250 8250
F 0 "C4" H 15275 8350 50  0000 L CNN
F 1 "100nF" H 15275 8150 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603" H 15288 8100 50  0001 C CNN
F 3 "" H 15250 8250 50  0000 C CNN
	1    15250 8250
	1    0    0    -1  
$EndComp
$Comp
L 4Channel-SSR-Switch-rescue:GND #PWR09
U 1 1 58258D67
P 14900 8500
F 0 "#PWR09" H 14900 8250 50  0001 C CNN
F 1 "GND" H 14900 8350 50  0000 C CNN
F 2 "" H 14900 8500 50  0000 C CNN
F 3 "" H 14900 8500 50  0000 C CNN
	1    14900 8500
	1    0    0    -1  
$EndComp
$Comp
L 4Channel-SSR-Switch-rescue:C C2
U 1 1 58259010
P 15400 5750
F 0 "C2" H 15425 5850 50  0000 L CNN
F 1 "4.7uF" H 15425 5650 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603" H 15438 5600 50  0001 C CNN
F 3 "" H 15400 5750 50  0000 C CNN
	1    15400 5750
	1    0    0    -1  
$EndComp
$Comp
L 4Channel-SSR-Switch-rescue:+3.3V #PWR010
U 1 1 5827B1CE
P 14950 6850
F 0 "#PWR010" H 14950 6700 50  0001 C CNN
F 1 "+3.3V" H 14950 6990 50  0000 C CNN
F 2 "" H 14950 6850 50  0000 C CNN
F 3 "" H 14950 6850 50  0000 C CNN
	1    14950 6850
	1    0    0    -1  
$EndComp
$Comp
L 4Channel-SSR-Switch-rescue:GND #PWR011
U 1 1 5827B41B
P 15000 7300
F 0 "#PWR011" H 15000 7050 50  0001 C CNN
F 1 "GND" H 15000 7150 50  0000 C CNN
F 2 "" H 15000 7300 50  0000 C CNN
F 3 "" H 15000 7300 50  0000 C CNN
	1    15000 7300
	1    0    0    -1  
$EndComp
$Comp
L 4Channel-SSR-Switch-rescue:RJ45 J2
U 1 1 5827B786
P 13100 5900
F 0 "J2" H 13300 6400 50  0000 C CNN
F 1 "RJ45" H 12950 6400 50  0000 C CNN
F 2 "RJ45:RJ45-ChinaSMD" H 13100 5900 50  0001 C CNN
F 3 "" H 13100 5900 50  0000 C CNN
	1    13100 5900
	1    0    0    -1  
$EndComp
$Comp
L 4Channel-SSR-Switch-rescue:C C5
U 1 1 5827DCB8
P 15600 8250
F 0 "C5" H 15625 8350 50  0000 L CNN
F 1 "100nF" H 15625 8150 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603" H 15638 8100 50  0001 C CNN
F 3 "" H 15600 8250 50  0000 C CNN
	1    15600 8250
	1    0    0    -1  
$EndComp
$Comp
L 4Channel-SSR-Switch-rescue:STM32F030R8 U2
U 5 1 582835BD
P 1800 9350
F 0 "U2" H 1900 9400 50  0000 C CNN
F 1 "STM32F030R8" H 2100 9500 50  0001 C CNN
F 2 "Housings_QFP:LQFP-64_10x10mm_Pitch0.5mm" H 2000 9600 50  0001 C CIN
F 3 "" H 5100 6850 50  0000 C CNN
	5    1800 9350
	1    0    0    -1  
$EndComp
$Comp
L 4Channel-SSR-Switch-rescue:CONN_01X05 P6
U 1 1 58B297A3
P 15250 7050
F 0 "P6" H 15250 7350 50  0000 C CNN
F 1 "CONN_01X05" V 15350 7050 50  0000 C CNN
F 2 "Pin_Headers:Pin_Header_Straight_1x05_Pitch2.54mm" H 15250 7050 50  0001 C CNN
F 3 "" H 15250 7050 50  0000 C CNN
	1    15250 7050
	1    0    0    -1  
$EndComp
Text Label 15050 6500 0    60   ~ 0
1W-DATA
$Comp
L 4Channel-SSR-Switch-rescue:STM32F030R8 U?
U 3 1 58C1BA89
P 1700 3900
AR Path="/582461B9/58C1BA89" Ref="U?"  Part="3" 
AR Path="/58C1BA89" Ref="U2"  Part="3" 
F 0 "U2" H 1800 3950 50  0000 C CNN
F 1 "STM32F030R8" H 2000 4050 50  0001 C CNN
F 2 "Housings_QFP:LQFP-64_10x10mm_Pitch0.5mm" H 1900 4150 50  0001 C CIN
F 3 "" H 5000 1400 50  0000 C CNN
	3    1700 3900
	1    0    0    -1  
$EndComp
$Comp
L 4Channel-SSR-Switch-rescue:STM32F030R8 U?
U 1 1 58C1BAC0
P 1150 6250
AR Path="/582461B9/58C1BAC0" Ref="U?"  Part="1" 
AR Path="/58C1BAC0" Ref="U2"  Part="1" 
F 0 "U2" H 1250 6300 50  0000 C CNN
F 1 "STM32F030R8" H 1450 6400 50  0001 C CNN
F 2 "Housings_QFP:LQFP-64_10x10mm_Pitch0.5mm" H 1350 6500 50  0001 C CIN
F 3 "" H 4450 3750 50  0000 C CNN
	1    1150 6250
	1    0    0    -1  
$EndComp
$Comp
L 4Channel-SSR-Switch-rescue:STM32F030R8 U?
U 2 1 58C1BBAE
P 1200 1650
AR Path="/582461B9/58C1BBAE" Ref="U?"  Part="2" 
AR Path="/58C1BBAE" Ref="U2"  Part="2" 
F 0 "U2" H 1300 1700 50  0000 C CNN
F 1 "STM32F030R8" H 1500 1800 50  0001 C CNN
F 2 "Housings_QFP:LQFP-64_10x10mm_Pitch0.5mm" H 1400 1900 50  0001 C CIN
F 3 "" H 4500 -850 50  0000 C CNN
	2    1200 1650
	1    0    0    -1  
$EndComp
Text Label 12350 8300 0    60   ~ 0
SWDAT
Text Label 12350 8400 0    60   ~ 0
SWCLK
Text Label 14600 7050 0    60   ~ 0
UART_TX
Text Label 14600 7150 0    60   ~ 0
UART_RX
Text Label 3050 9550 0    60   ~ 0
1W-DATA
Text Label 4950 6650 0    60   ~ 0
UART_TX
Text Label 4950 6750 0    60   ~ 0
UART_RX
Text Label 4900 7750 0    60   ~ 0
SWDAT
Text Label 4900 7850 0    60   ~ 0
SWCLK
$Comp
L 4Channel-SSR-Switch-rescue:+3.3V #PWR012
U 1 1 58C3775D
P 11350 8200
F 0 "#PWR012" H 11350 8050 50  0001 C CNN
F 1 "+3.3V" H 11350 8340 50  0000 C CNN
F 2 "" H 11350 8200 50  0000 C CNN
F 3 "" H 11350 8200 50  0000 C CNN
	1    11350 8200
	1    0    0    -1  
$EndComp
$Comp
L 4Channel-SSR-Switch-rescue:G3MB_SSR U3
U 1 1 593927A7
P 13150 1100
F 0 "U3" H 13350 1400 60  0000 C CNN
F 1 "G3MB_SSR" H 13250 800 60  0000 C CNN
F 2 "SSR-OmronG3MB:G3MB" H 13150 1100 60  0001 C CNN
F 3 "" H 13150 1100 60  0000 C CNN
	1    13150 1100
	1    0    0    -1  
$EndComp
$Comp
L 4Channel-SSR-Switch-rescue:G3MB_SSR U4
U 1 1 59392948
P 13150 1850
F 0 "U4" H 13350 2150 60  0000 C CNN
F 1 "G3MB_SSR" H 13250 1550 60  0000 C CNN
F 2 "SSR-OmronG3MB:G3MB" H 13150 1850 60  0001 C CNN
F 3 "" H 13150 1850 60  0000 C CNN
	1    13150 1850
	1    0    0    -1  
$EndComp
$Comp
L 4Channel-SSR-Switch-rescue:G3MB_SSR U5
U 1 1 593929A9
P 13150 2600
F 0 "U5" H 13350 2900 60  0000 C CNN
F 1 "G3MB_SSR" H 13250 2300 60  0000 C CNN
F 2 "SSR-OmronG3MB:G3MB" H 13150 2600 60  0001 C CNN
F 3 "" H 13150 2600 60  0000 C CNN
	1    13150 2600
	1    0    0    -1  
$EndComp
$Comp
L 4Channel-SSR-Switch-rescue:+5V #PWR013
U 1 1 593931CA
P 12200 700
F 0 "#PWR013" H 12200 550 50  0001 C CNN
F 1 "+5V" H 12200 840 50  0000 C CNN
F 2 "" H 12200 700 50  0000 C CNN
F 3 "" H 12200 700 50  0000 C CNN
	1    12200 700 
	1    0    0    -1  
$EndComp
Text Label 11700 1300 0    60   ~ 0
SSR0
Text Label 11700 2050 0    60   ~ 0
SSR1
Text Label 11750 2800 0    60   ~ 0
SSR2
Text Label 11800 3550 0    60   ~ 0
SSR3
Text Label 4250 2150 0    60   ~ 0
SSR3
Text Label 4250 2350 0    60   ~ 0
SSR2
Text Label 4250 2550 0    60   ~ 0
SSR1
Text Label 4250 2750 0    60   ~ 0
SSR0
$Comp
L 4Channel-SSR-Switch-rescue:+3.3V #PWR014
U 1 1 59395F00
P 7950 1550
F 0 "#PWR014" H 7950 1400 50  0001 C CNN
F 1 "+3.3V" H 7950 1690 50  0000 C CNN
F 2 "" H 7950 1550 50  0000 C CNN
F 3 "" H 7950 1550 50  0000 C CNN
	1    7950 1550
	1    0    0    -1  
$EndComp
$Comp
L 4Channel-SSR-Switch-rescue:G3MB_SSR U6
U 1 1 59396B70
P 13150 3350
F 0 "U6" H 13350 3650 60  0000 C CNN
F 1 "G3MB_SSR" H 13250 3050 60  0000 C CNN
F 2 "SSR-OmronG3MB:G3MB" H 13150 3350 60  0001 C CNN
F 3 "" H 13150 3350 60  0000 C CNN
	1    13150 3350
	1    0    0    -1  
$EndComp
$Comp
L 4Channel-SSR-Switch-rescue:CONN_01X05 P4
U 1 1 59397650
P 14700 1000
F 0 "P4" H 14700 1300 50  0000 C CNN
F 1 "CONN_01X05" V 14800 1000 50  0000 C CNN
F 2 "2EDCK-Screw-Connectors:2EDCK-5.08-5PIN" H 14700 1000 50  0001 C CNN
F 3 "" H 14700 1000 50  0000 C CNN
	1    14700 1000
	1    0    0    -1  
$EndComp
$Comp
L 4Channel-SSR-Switch-rescue:R_PACK4 RP1
U 1 1 5939D58D
P 8250 2700
F 0 "RP1" H 8250 3150 50  0000 C CNN
F 1 "10K" H 8250 2650 50  0000 C CNN
F 2 "0603-pack4:0603_Pack4" H 8250 2700 50  0001 C CNN
F 3 "" H 8250 2700 50  0000 C CNN
	1    8250 2700
	0    1    1    0   
$EndComp
$Comp
L 4Channel-SSR-Switch-rescue:R_PACK4 RP2
U 1 1 5939D668
P 9200 2700
F 0 "RP2" H 9200 3150 50  0000 C CNN
F 1 "10K" H 9200 2650 50  0000 C CNN
F 2 "0603-pack4:0603_Pack4" H 9200 2700 50  0001 C CNN
F 3 "" H 9200 2700 50  0000 C CNN
	1    9200 2700
	0    -1   1    0   
$EndComp
$Comp
L 4Channel-SSR-Switch-rescue:GND #PWR015
U 1 1 5939D7B3
P 9150 3000
F 0 "#PWR015" H 9150 2750 50  0001 C CNN
F 1 "GND" H 9150 2850 50  0000 C CNN
F 2 "" H 9150 3000 50  0000 C CNN
F 3 "" H 9150 3000 50  0000 C CNN
	1    9150 3000
	1    0    0    -1  
$EndComp
$Comp
L 4Channel-SSR-Switch-rescue:CONN_01X05 P2
U 1 1 5939DF08
P 8400 1700
F 0 "P2" H 8400 2000 50  0000 C CNN
F 1 "CONN_01X05" V 8500 1700 50  0000 C CNN
F 2 "Sockets_MOLEX_KK-System:Socket_MOLEX-KK-RM3-96mm_Lock_5pin_straight" H 8400 1700 50  0001 C CNN
F 3 "" H 8400 1700 50  0000 C CNN
	1    8400 1700
	0    -1   -1   0   
$EndComp
$Comp
L 4Channel-SSR-Switch-rescue:CONN_01X05 P3
U 1 1 5939E040
P 8950 1700
F 0 "P3" H 8950 2000 50  0000 C CNN
F 1 "CONN_01X05" V 9050 1700 50  0000 C CNN
F 2 "Sockets_MOLEX_KK-System:Socket_MOLEX-KK-RM3-96mm_Lock_5pin_straight" H 8950 1700 50  0001 C CNN
F 3 "" H 8950 1700 50  0000 C CNN
	1    8950 1700
	0    -1   -1   0   
$EndComp
Text Label 10250 2200 0    60   ~ 0
SW5
Text Label 10250 2300 0    60   ~ 0
SW6
Text Label 10250 2400 0    60   ~ 0
SW7
Text Label 4200 4100 0    60   ~ 0
SW0
Text Label 4200 4300 0    60   ~ 0
SW1
Text Label 4200 4600 0    60   ~ 0
SW2
Text Label 4950 6450 0    60   ~ 0
SW3
Text Label 4950 6950 0    60   ~ 0
SW5
Text Label 4950 7150 0    60   ~ 0
SW6
Text Label 3050 9850 0    60   ~ 0
SW4
Text Label 4250 1950 0    60   ~ 0
SW7
Text Label 10250 2100 0    60   ~ 0
SW4
Text Label 7150 2400 0    60   ~ 0
SW3
Text Label 7150 2300 0    60   ~ 0
SW2
Text Label 7150 2200 0    60   ~ 0
SW1
Text Label 7150 2100 0    60   ~ 0
SW0
$Comp
L 4Channel-SSR-Switch-rescue:R_PACK4 RP3
U 1 1 593A2B77
P 7500 2450
F 0 "RP3" H 7500 2900 50  0000 C CNN
F 1 "10K" H 7500 2400 50  0000 C CNN
F 2 "0603-pack4:0603_Pack4" H 7500 2450 50  0001 C CNN
F 3 "" H 7500 2450 50  0000 C CNN
	1    7500 2450
	-1   0    0    -1  
$EndComp
$Comp
L 4Channel-SSR-Switch-rescue:R_PACK4 RP4
U 1 1 593A30AD
P 9850 2050
F 0 "RP4" H 9850 2500 50  0000 C CNN
F 1 "10K" H 9850 2000 50  0000 C CNN
F 2 "0603-pack4:0603_Pack4" H 9850 2050 50  0001 C CNN
F 3 "" H 9850 2050 50  0000 C CNN
	1    9850 2050
	-1   0    0    1   
$EndComp
Wire Wire Line
	11700 6350 11700 6500
Wire Wire Line
	11700 6500 11900 6500
Wire Wire Line
	12400 6350 12400 6500
Connection ~ 12400 6500
Wire Wire Line
	11900 6350 11900 6500
Connection ~ 11900 6500
Wire Wire Line
	12100 6350 12100 6500
Connection ~ 12100 6500
Wire Wire Line
	11800 6350 11800 6450
Wire Wire Line
	11300 6450 11800 6450
Wire Wire Line
	11300 6450 11300 6100
Wire Wire Line
	13950 9200 13950 9300
Wire Wire Line
	13650 9200 13650 9300
Wire Wire Line
	13100 9300 13650 9300
Connection ~ 13950 9300
Wire Wire Line
	13750 9200 13750 9300
Connection ~ 13750 9300
Wire Wire Line
	14500 7900 14500 8050
Wire Wire Line
	14300 8250 14300 8050
Connection ~ 14500 8050
Wire Wire Line
	14200 8250 14200 8050
Connection ~ 14300 8050
Wire Wire Line
	14100 8250 14100 8050
Connection ~ 14200 8050
Wire Wire Line
	11350 8200 11350 8300
Wire Wire Line
	11350 8300 11500 8300
Wire Wire Line
	11500 8400 11400 8400
Wire Wire Line
	11400 8400 11400 8500
Wire Wire Line
	11500 8500 11400 8500
Connection ~ 11400 8500
Wire Wire Line
	11500 8700 11400 8700
Connection ~ 11400 8700
Wire Wire Line
	12000 6350 12000 6700
Wire Wire Line
	11500 6700 12000 6700
Wire Wire Line
	15300 5600 15400 5600
Wire Wire Line
	15400 5600 15400 5500
Wire Wire Line
	14500 5600 14300 5600
Wire Wire Line
	14300 5900 14300 5950
Wire Wire Line
	14300 5950 14900 5950
Wire Wire Line
	15400 5950 15400 5900
Connection ~ 14900 5950
Wire Wire Line
	14900 8400 14900 8450
Wire Wire Line
	15250 8400 15250 8450
Connection ~ 14900 8450
Wire Wire Line
	15250 8050 15250 8100
Wire Wire Line
	14900 8100 14900 8050
Connection ~ 14900 8050
Wire Wire Line
	12600 6500 12600 5550
Wire Wire Line
	15050 6950 14950 6950
Wire Wire Line
	14950 6950 14950 6850
Wire Wire Line
	15050 7250 15000 7250
Wire Wire Line
	15000 7250 15000 7300
Wire Wire Line
	13650 6500 13650 5550
Connection ~ 12600 6500
Wire Wire Line
	12750 6350 12750 6500
Connection ~ 12750 6500
Wire Wire Line
	12950 6350 12950 6500
Connection ~ 12950 6500
Wire Wire Line
	13150 6350 13150 6500
Connection ~ 13150 6500
Wire Wire Line
	13450 6350 13450 6500
Connection ~ 13450 6500
Wire Wire Line
	12850 6450 12850 6350
Connection ~ 11800 6450
Wire Wire Line
	13100 8800 13100 9300
Connection ~ 13650 9300
Wire Wire Line
	14100 8050 14200 8050
Wire Wire Line
	14900 8450 15250 8450
Wire Wire Line
	15600 8050 15600 8100
Connection ~ 15250 8050
Wire Wire Line
	15600 8450 15600 8400
Connection ~ 15250 8450
Wire Wire Line
	13050 6700 13050 6350
Connection ~ 12000 6700
Wire Wire Line
	12200 6350 12200 6550
Wire Wire Line
	12200 6550 13250 6550
Wire Wire Line
	13250 6550 13250 6350
Wire Wire Line
	12300 6350 12300 6600
Wire Wire Line
	12300 6600 13350 6600
Wire Wire Line
	13350 6600 13350 6350
Wire Wire Line
	14900 6000 14900 5950
Wire Wire Line
	14600 7050 15050 7050
Wire Wire Line
	15050 7150 14600 7150
Connection ~ 14300 5600
Connection ~ 15400 5600
Wire Wire Line
	15050 6850 15050 6500
Wire Wire Line
	4600 7750 4900 7750
Wire Wire Line
	4600 7850 4900 7850
Wire Wire Line
	4950 6750 4600 6750
Wire Wire Line
	4600 6650 4950 6650
Wire Wire Line
	12000 8300 12350 8300
Wire Wire Line
	12000 8400 12350 8400
Wire Wire Line
	2800 9550 3050 9550
Wire Wire Line
	14500 800  14050 800 
Wire Wire Line
	14050 800  14050 1300
Wire Wire Line
	13750 2800 14050 2800
Connection ~ 14050 2800
Wire Wire Line
	13750 2050 14050 2050
Connection ~ 14050 2050
Wire Wire Line
	13750 1300 14050 1300
Connection ~ 14050 1300
Wire Wire Line
	13750 900  14500 900 
Wire Wire Line
	13750 1650 14100 1650
Wire Wire Line
	14100 1650 14100 1000
Wire Wire Line
	14100 1000 14500 1000
Wire Wire Line
	14500 1100 14150 1100
Wire Wire Line
	14150 1100 14150 2400
Wire Wire Line
	14150 2400 13750 2400
Wire Wire Line
	14200 3150 14200 1200
Wire Wire Line
	14200 1200 14500 1200
Wire Wire Line
	12200 900  12500 900 
Wire Wire Line
	12200 1650 12500 1650
Connection ~ 12200 900 
Wire Wire Line
	12200 2400 12500 2400
Connection ~ 12200 1650
Connection ~ 12200 2400
Wire Wire Line
	12500 2050 11700 2050
Wire Wire Line
	12500 2800 11750 2800
Wire Wire Line
	12500 1300 11700 1300
Wire Wire Line
	12200 3150 12500 3150
Wire Wire Line
	13750 3150 14200 3150
Wire Wire Line
	11800 3550 12500 3550
Wire Wire Line
	12200 3150 12200 2400
Wire Wire Line
	14050 3550 13750 3550
Wire Wire Line
	8300 2900 8300 2950
Wire Wire Line
	8300 2950 8400 2950
Wire Wire Line
	9150 2900 9150 2950
Connection ~ 9150 2950
Wire Wire Line
	9050 2900 9050 2950
Connection ~ 9050 2950
Wire Wire Line
	8950 2900 8950 2950
Connection ~ 8950 2950
Wire Wire Line
	8850 2900 8850 2950
Connection ~ 8850 2950
Wire Wire Line
	8600 2900 8600 2950
Connection ~ 8600 2950
Wire Wire Line
	8500 2900 8500 2950
Connection ~ 8500 2950
Wire Wire Line
	8400 2900 8400 2950
Connection ~ 8400 2950
Wire Wire Line
	7950 1550 7950 2000
Wire Wire Line
	7950 2000 8200 2000
Wire Wire Line
	8750 2000 8750 1900
Wire Wire Line
	8200 1900 8200 2000
Connection ~ 8200 2000
Wire Wire Line
	8300 1900 8300 2100
Wire Wire Line
	8400 1900 8400 2200
Wire Wire Line
	8500 1900 8500 2300
Wire Wire Line
	8600 1900 8600 2400
Wire Wire Line
	8850 1900 8850 2400
Wire Wire Line
	8950 1900 8950 2300
Wire Wire Line
	9050 1900 9050 2200
Wire Wire Line
	9150 1900 9150 2100
Wire Wire Line
	8300 2100 7700 2100
Connection ~ 8300 2100
Wire Wire Line
	8400 2200 7700 2200
Connection ~ 8400 2200
Wire Wire Line
	8500 2300 7700 2300
Connection ~ 8500 2300
Wire Wire Line
	8600 2400 7700 2400
Connection ~ 8600 2400
Connection ~ 9150 2100
Wire Wire Line
	9050 2200 9650 2200
Connection ~ 9050 2200
Wire Wire Line
	8950 2300 9650 2300
Connection ~ 8950 2300
Wire Wire Line
	8850 2400 9650 2400
Connection ~ 8850 2400
Wire Wire Line
	3750 4100 4200 4100
Wire Wire Line
	3750 4300 4200 4300
Wire Wire Line
	4600 6450 4950 6450
Wire Wire Line
	2800 9850 3050 9850
Wire Wire Line
	4600 6950 4950 6950
Wire Wire Line
	4600 7150 4950 7150
Wire Wire Line
	3750 4600 4200 4600
Wire Wire Line
	3750 1950 4250 1950
Wire Wire Line
	3750 2750 4250 2750
Wire Wire Line
	3750 2550 4250 2550
Wire Wire Line
	3750 2350 4250 2350
Wire Wire Line
	3750 2150 4250 2150
Wire Wire Line
	7300 2100 7150 2100
Wire Wire Line
	7300 2200 7150 2200
Wire Wire Line
	7300 2300 7150 2300
Wire Wire Line
	7300 2400 7150 2400
Wire Wire Line
	10050 2100 10250 2100
Wire Wire Line
	10050 2200 10250 2200
Wire Wire Line
	10050 2300 10250 2300
Wire Wire Line
	10050 2400 10250 2400
Wire Wire Line
	9650 2100 9150 2100
Text Label 14150 800  0    60   ~ 0
MAINS
Text Label 14150 900  0    60   ~ 0
OUT0
Text Label 14150 1000 0    60   ~ 0
OUT1
Text Label 14150 1100 0    60   ~ 0
OUT2
Text Label 14200 1200 0    60   ~ 0
OUT3
Wire Wire Line
	12400 6500 12600 6500
Wire Wire Line
	11900 6500 12100 6500
Wire Wire Line
	12100 6500 12400 6500
Wire Wire Line
	13950 9300 13950 9500
Wire Wire Line
	13750 9300 13950 9300
Wire Wire Line
	14500 8050 14500 8250
Wire Wire Line
	14500 8050 14900 8050
Wire Wire Line
	14300 8050 14500 8050
Wire Wire Line
	14200 8050 14300 8050
Wire Wire Line
	11400 8500 11400 8700
Wire Wire Line
	11400 8700 11400 8800
Wire Wire Line
	14900 5950 15400 5950
Wire Wire Line
	14900 5950 14900 5900
Wire Wire Line
	14900 8450 14900 8500
Wire Wire Line
	14900 8050 15250 8050
Wire Wire Line
	12600 6500 12750 6500
Wire Wire Line
	12750 6500 12950 6500
Wire Wire Line
	12950 6500 13150 6500
Wire Wire Line
	13150 6500 13450 6500
Wire Wire Line
	13450 6500 13650 6500
Wire Wire Line
	11800 6450 12850 6450
Wire Wire Line
	13650 9300 13750 9300
Wire Wire Line
	15250 8050 15600 8050
Wire Wire Line
	15250 8450 15600 8450
Wire Wire Line
	12000 6700 13050 6700
Wire Wire Line
	14050 2800 14050 3550
Wire Wire Line
	14050 2050 14050 2800
Wire Wire Line
	14050 1300 14050 2050
Wire Wire Line
	12200 900  12200 700 
Wire Wire Line
	12200 1650 12200 900 
Wire Wire Line
	12200 2400 12200 1650
Wire Wire Line
	9150 2950 9150 3000
Wire Wire Line
	9050 2950 9150 2950
Wire Wire Line
	8950 2950 9050 2950
Wire Wire Line
	8850 2950 8950 2950
Wire Wire Line
	8600 2950 8850 2950
Wire Wire Line
	8500 2950 8600 2950
Wire Wire Line
	8400 2950 8500 2950
Wire Wire Line
	8200 2000 8750 2000
Wire Wire Line
	8300 2100 8300 2500
Wire Wire Line
	8400 2200 8400 2500
Wire Wire Line
	8500 2300 8500 2500
Wire Wire Line
	8600 2400 8600 2500
Wire Wire Line
	9150 2100 9150 2500
Wire Wire Line
	9050 2200 9050 2500
Wire Wire Line
	8950 2300 8950 2500
Wire Wire Line
	8850 2400 8850 2500
$Comp
L SMF05C:SMF05C D1
U 1 1 5C06D891
P 10950 4650
F 0 "D1" H 10516 4646 50  0000 R CNN
F 1 "SMF05C" H 10516 4555 50  0000 R CNN
F 2 "SMF05C:SC70-6" H 10950 4650 50  0001 L BNN
F 3 "Semtech" H 10950 4650 50  0001 L BNN
F 4 "DIODE, TVS, 5 CH, BIDIR, 5V, SC70; Clamping Voltage Vc Max: 12.5V; Diode Case Style: SOT-323; No. of Pins: 6" H 10950 4650 50  0001 L BNN "Field4"
F 5 "None" H 10950 4650 50  0001 L BNN "Field5"
F 6 "Unavailable" H 10950 4650 50  0001 L BNN "Field6"
F 7 "SMF05C" H 10950 4650 50  0001 L BNN "Field7"
F 8 "SC-70-6 Semtech" H 10950 4650 50  0001 L BNN "Field8"
	1    10950 4650
	1    0    0    -1  
$EndComp
$Comp
L 4Channel-SSR-Switch-rescue:+5V #PWR016
U 1 1 5C06D97A
P 11050 4500
F 0 "#PWR016" H 11050 4350 50  0001 C CNN
F 1 "+5V" H 11050 4640 50  0000 C CNN
F 2 "" H 11050 4500 50  0000 C CNN
F 3 "" H 11050 4500 50  0000 C CNN
	1    11050 4500
	1    0    0    -1  
$EndComp
$Comp
L 4Channel-SSR-Switch-rescue:GND #PWR017
U 1 1 5C06D9BD
P 11050 4850
F 0 "#PWR017" H 11050 4600 50  0001 C CNN
F 1 "GND" H 11050 4700 50  0000 C CNN
F 2 "" H 11050 4850 50  0000 C CNN
F 3 "" H 11050 4850 50  0000 C CNN
	1    11050 4850
	1    0    0    -1  
$EndComp
Wire Wire Line
	10650 4550 10850 4550
Connection ~ 10850 4550
Wire Wire Line
	10850 4550 11050 4550
Connection ~ 11050 4550
Wire Wire Line
	11050 4550 11250 4550
Connection ~ 11250 4550
Wire Wire Line
	11250 4550 11450 4550
Wire Wire Line
	11050 4550 11050 4500
$Comp
L DS9503:DS9503 ZD1
U 1 1 5C084068
P 11200 6800
F 0 "ZD1" H 11200 7167 50  0000 C CNN
F 1 "DS9503" H 11200 7076 50  0000 C CNN
F 2 "DS9503:TSOC6" H 11200 6800 50  0001 L BNN
F 3 "None" H 11200 6800 50  0001 L BNN
F 4 "this ds9503 is an esd protection device for 1-wire interfaces. in contrast to the ds9502, the ds9503 includes two 5? ..." H 11200 6800 50  0001 L BNN "Field4"
F 5 "DS9503" H 11200 6800 50  0001 L BNN "Field5"
F 6 "None" H 11200 6800 50  0001 L BNN "Field6"
F 7 "Amphenol" H 11200 6800 50  0001 L BNN "Field7"
F 8 "Unavailable" H 11200 6800 50  0001 L BNN "Field8"
	1    11200 6800
	1    0    0    -1  
$EndComp
Wire Wire Line
	10900 6900 10750 6900
Wire Wire Line
	10750 6900 10750 6950
Wire Wire Line
	12400 6500 12400 6900
Wire Wire Line
	11500 6900 12400 6900
Wire Wire Line
	10900 6700 10500 6700
Text Label 10500 6700 0    50   ~ 0
1W-DATA
$Comp
L 4Channel-SSR-Switch-rescue:R R1
U 1 1 58B28CDC
P 12850 8450
F 0 "R1" V 12930 8450 50  0000 C CNN
F 1 "10k" V 12850 8450 50  0000 C CNN
F 2 "Resistors_SMD:R_0603" V 12780 8450 50  0001 C CNN
F 3 "" H 12850 8450 50  0000 C CNN
	1    12850 8450
	1    0    0    -1  
$EndComp
Wire Wire Line
	12000 8700 12850 8700
Wire Wire Line
	12850 8600 12850 8700
Connection ~ 12850 8700
Wire Wire Line
	12850 8700 13100 8700
$Comp
L 4Channel-SSR-Switch-rescue:+3.3V #PWR?
U 1 1 5C262187
P 12850 8250
F 0 "#PWR?" H 12850 8100 50  0001 C CNN
F 1 "+3.3V" H 12850 8390 50  0000 C CNN
F 2 "" H 12850 8250 50  0000 C CNN
F 3 "" H 12850 8250 50  0000 C CNN
	1    12850 8250
	1    0    0    -1  
$EndComp
Wire Wire Line
	12850 8250 12850 8300
Wire Wire Line
	14300 5200 14300 5600
$EndSCHEMATC

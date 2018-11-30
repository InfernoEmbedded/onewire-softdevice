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
LIBS:dc-dc_regulator
LIBS:lp2950
LIBS:OrangePi
LIBS:stm32
LIBS:ControlBoard-cache
EELAYER 25 0
EELAYER END
$Descr A3 16535 11693
encoding utf-8
Sheet 1 2
Title "1Wire Master Control Board"
Date "2017-06-18"
Rev "1.0"
Comp "Inferno Embedded"
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Sheet
S 14650 8750 950  650 
U 594691E7
F0 "PowerSupply" 60
F1 "PowerSupply.sch" 60
$EndSheet
$Comp
L GND #PWR01
U 1 1 5947AF34
P 13800 1200
F 0 "#PWR01" H 13800 950 50  0001 C CNN
F 1 "GND" H 13800 1050 50  0000 C CNN
F 2 "" H 13800 1200 50  0000 C CNN
F 3 "" H 13800 1200 50  0000 C CNN
	1    13800 1200
	1    0    0    -1  
$EndComp
$Comp
L +24V #PWR02
U 1 1 5947AF53
P 15100 950
F 0 "#PWR02" H 15100 800 50  0001 C CNN
F 1 "+24V" H 15100 1090 50  0000 C CNN
F 2 "" H 15100 950 50  0000 C CNN
F 3 "" H 15100 950 50  0000 C CNN
	1    15100 950 
	1    0    0    -1  
$EndComp
$Comp
L +5V #PWR03
U 1 1 5947AF69
P 15300 950
F 0 "#PWR03" H 15300 800 50  0001 C CNN
F 1 "+5V" H 15300 1090 50  0000 C CNN
F 2 "" H 15300 950 50  0000 C CNN
F 3 "" H 15300 950 50  0000 C CNN
	1    15300 950 
	1    0    0    -1  
$EndComp
Text Label 14000 1250 0    60   ~ 0
DRIVE_B0
Text Label 14000 1350 0    60   ~ 0
DRIVE_B1
Text Label 14000 1450 0    60   ~ 0
DRIVE_B2
Text Label 14000 1550 0    60   ~ 0
DRIVE_B3
Text Label 14000 1650 0    60   ~ 0
DRIVE_B4
Text Label 14000 1750 0    60   ~ 0
DRIVE_B5
Text Label 14000 1850 0    60   ~ 0
DRIVE_B6
Text Label 14000 1950 0    60   ~ 0
DRIVE_B7
Text Label 14000 2050 0    60   ~ 0
DPU_B0
Text Label 14000 2150 0    60   ~ 0
DPU_B1
Text Label 14000 2250 0    60   ~ 0
DPU_B2
Text Label 14000 2350 0    60   ~ 0
DPU_B3
Text Label 14000 2450 0    60   ~ 0
DPU_B4
Text Label 15050 2450 0    60   ~ 0
DPU_B5
Text Label 15050 2350 0    60   ~ 0
DPU_B6
Text Label 15050 2250 0    60   ~ 0
DPU_B7
Text Label 15050 2150 0    60   ~ 0
SENSE_B0
Text Label 15050 2050 0    60   ~ 0
SENSE_B1
Text Label 15050 1950 0    60   ~ 0
SENSE_B2
Text Label 15050 1850 0    60   ~ 0
SENSE_B3
Text Label 15050 1750 0    60   ~ 0
SENSE_B4
Text Label 15050 1650 0    60   ~ 0
SENSE_B5
Text Label 15050 1550 0    60   ~ 0
SENSE_B6
Text Label 15050 1450 0    60   ~ 0
SENSE_B7
$Comp
L GND #PWR04
U 1 1 5947B4E8
P 13800 3200
F 0 "#PWR04" H 13800 2950 50  0001 C CNN
F 1 "GND" H 13800 3050 50  0000 C CNN
F 2 "" H 13800 3200 50  0000 C CNN
F 3 "" H 13800 3200 50  0000 C CNN
	1    13800 3200
	1    0    0    -1  
$EndComp
$Comp
L +24V #PWR05
U 1 1 5947B4F0
P 15100 2950
F 0 "#PWR05" H 15100 2800 50  0001 C CNN
F 1 "+24V" H 15100 3090 50  0000 C CNN
F 2 "" H 15100 2950 50  0000 C CNN
F 3 "" H 15100 2950 50  0000 C CNN
	1    15100 2950
	1    0    0    -1  
$EndComp
$Comp
L +5V #PWR06
U 1 1 5947B4F6
P 15300 2950
F 0 "#PWR06" H 15300 2800 50  0001 C CNN
F 1 "+5V" H 15300 3090 50  0000 C CNN
F 2 "" H 15300 2950 50  0000 C CNN
F 3 "" H 15300 2950 50  0000 C CNN
	1    15300 2950
	1    0    0    -1  
$EndComp
Text Label 14000 3250 0    60   ~ 0
DRIVE_D0
Text Label 14000 3350 0    60   ~ 0
DRIVE_D1
Text Label 14000 3450 0    60   ~ 0
DRIVE_D2
Text Label 14000 3550 0    60   ~ 0
DRIVE_D3
Text Label 14000 3650 0    60   ~ 0
DRIVE_D4
Text Label 14000 3750 0    60   ~ 0
DRIVE_D5
Text Label 14000 3850 0    60   ~ 0
DRIVE_D6
Text Label 14000 3950 0    60   ~ 0
DRIVE_D7
Text Label 14000 4050 0    60   ~ 0
DPU_D0
Text Label 14000 4150 0    60   ~ 0
DPU_D1
Text Label 14000 4250 0    60   ~ 0
DPU_D2
Text Label 14000 4350 0    60   ~ 0
DPU_D3
Text Label 14000 4450 0    60   ~ 0
DPU_D4
Text Label 15050 4450 0    60   ~ 0
DPU_D5
Text Label 15050 4350 0    60   ~ 0
DPU_D6
Text Label 15050 4250 0    60   ~ 0
DPU_D7
Text Label 15050 4150 0    60   ~ 0
SENSE_D0
Text Label 15050 4050 0    60   ~ 0
SENSE_D1
Text Label 15050 3950 0    60   ~ 0
SENSE_D2
Text Label 15050 3850 0    60   ~ 0
SENSE_D3
Text Label 15050 3750 0    60   ~ 0
SENSE_D4
Text Label 15050 3650 0    60   ~ 0
SENSE_D5
Text Label 15050 3550 0    60   ~ 0
SENSE_D6
Text Label 15050 3450 0    60   ~ 0
SENSE_D7
$Comp
L GND #PWR07
U 1 1 5947B5BD
P 11750 1200
F 0 "#PWR07" H 11750 950 50  0001 C CNN
F 1 "GND" H 11750 1050 50  0000 C CNN
F 2 "" H 11750 1200 50  0000 C CNN
F 3 "" H 11750 1200 50  0000 C CNN
	1    11750 1200
	1    0    0    -1  
$EndComp
$Comp
L +24V #PWR08
U 1 1 5947B5C5
P 13050 950
F 0 "#PWR08" H 13050 800 50  0001 C CNN
F 1 "+24V" H 13050 1090 50  0000 C CNN
F 2 "" H 13050 950 50  0000 C CNN
F 3 "" H 13050 950 50  0000 C CNN
	1    13050 950 
	1    0    0    -1  
$EndComp
$Comp
L +5V #PWR09
U 1 1 5947B5CB
P 13250 950
F 0 "#PWR09" H 13250 800 50  0001 C CNN
F 1 "+5V" H 13250 1090 50  0000 C CNN
F 2 "" H 13250 950 50  0000 C CNN
F 3 "" H 13250 950 50  0000 C CNN
	1    13250 950 
	1    0    0    -1  
$EndComp
Text Label 11950 1250 0    60   ~ 0
DRIVE_A0
Text Label 11950 1350 0    60   ~ 0
DRIVE_A1
Text Label 11950 1450 0    60   ~ 0
DRIVE_A2
Text Label 11950 1550 0    60   ~ 0
DRIVE_A3
Text Label 11950 1650 0    60   ~ 0
DRIVE_A4
Text Label 11950 1750 0    60   ~ 0
DRIVE_A5
Text Label 11950 1850 0    60   ~ 0
DRIVE_A6
Text Label 11950 1950 0    60   ~ 0
DRIVE_A7
Text Label 11950 2050 0    60   ~ 0
DPU_A0
Text Label 11950 2150 0    60   ~ 0
DPU_A1
Text Label 11950 2250 0    60   ~ 0
DPU_A2
Text Label 11950 2350 0    60   ~ 0
DPU_A3
Text Label 11950 2450 0    60   ~ 0
DPU_A4
Text Label 13000 2450 0    60   ~ 0
DPU_A5
Text Label 13000 2350 0    60   ~ 0
DPU_A6
Text Label 13000 2250 0    60   ~ 0
DPU_A7
Text Label 13000 2150 0    60   ~ 0
SENSE_A0
Text Label 13000 2050 0    60   ~ 0
SENSE_A1
Text Label 13000 1950 0    60   ~ 0
SENSE_A2
Text Label 13000 1850 0    60   ~ 0
SENSE_A3
Text Label 13000 1750 0    60   ~ 0
SENSE_A4
Text Label 13000 1650 0    60   ~ 0
SENSE_A5
Text Label 13000 1550 0    60   ~ 0
SENSE_A6
Text Label 13000 1450 0    60   ~ 0
SENSE_A7
$Comp
L GND #PWR010
U 1 1 5947B610
P 11750 3200
F 0 "#PWR010" H 11750 2950 50  0001 C CNN
F 1 "GND" H 11750 3050 50  0000 C CNN
F 2 "" H 11750 3200 50  0000 C CNN
F 3 "" H 11750 3200 50  0000 C CNN
	1    11750 3200
	1    0    0    -1  
$EndComp
$Comp
L +24V #PWR011
U 1 1 5947B618
P 13050 2950
F 0 "#PWR011" H 13050 2800 50  0001 C CNN
F 1 "+24V" H 13050 3090 50  0000 C CNN
F 2 "" H 13050 2950 50  0000 C CNN
F 3 "" H 13050 2950 50  0000 C CNN
	1    13050 2950
	1    0    0    -1  
$EndComp
$Comp
L +5V #PWR012
U 1 1 5947B61E
P 13250 2950
F 0 "#PWR012" H 13250 2800 50  0001 C CNN
F 1 "+5V" H 13250 3090 50  0000 C CNN
F 2 "" H 13250 2950 50  0000 C CNN
F 3 "" H 13250 2950 50  0000 C CNN
	1    13250 2950
	1    0    0    -1  
$EndComp
Text Label 11950 3250 0    60   ~ 0
DRIVE_C0
Text Label 11950 3350 0    60   ~ 0
DRIVE_C1
Text Label 11950 3450 0    60   ~ 0
DRIVE_C2
Text Label 11950 3550 0    60   ~ 0
DRIVE_C3
Text Label 11950 3650 0    60   ~ 0
DRIVE_C4
Text Label 11950 3750 0    60   ~ 0
DRIVE_C5
Text Label 11950 3850 0    60   ~ 0
DRIVE_C6
Text Label 11950 3950 0    60   ~ 0
DRIVE_C7
Text Label 11950 4050 0    60   ~ 0
DPU_C0
Text Label 11950 4150 0    60   ~ 0
DPU_C1
Text Label 11950 4250 0    60   ~ 0
DPU_C2
Text Label 11950 4350 0    60   ~ 0
DPU_C3
Text Label 11950 4450 0    60   ~ 0
DPU_C4
Text Label 13000 4450 0    60   ~ 0
DPU_C5
Text Label 13000 4350 0    60   ~ 0
DPU_C6
Text Label 13000 4250 0    60   ~ 0
DPU_C7
Text Label 13000 4150 0    60   ~ 0
SENSE_C0
Text Label 13000 4050 0    60   ~ 0
SENSE_C1
Text Label 13000 3950 0    60   ~ 0
SENSE_C2
Text Label 13000 3850 0    60   ~ 0
SENSE_C3
Text Label 13000 3750 0    60   ~ 0
SENSE_C4
Text Label 13000 3650 0    60   ~ 0
SENSE_C5
Text Label 13000 3550 0    60   ~ 0
SENSE_C6
Text Label 13000 3450 0    60   ~ 0
SENSE_C7
$Comp
L STM32F412Z(E-G)Tx_u U1
U 1 1 5947E5BF
P 2750 1500
F 0 "U1" H 1350 2300 50  0000 C CNN
F 1 "STM32F412Z(E-G)Tx_u" H 1000 2200 50  0000 C CNN
F 2 "Housings_QFP:LQFP-144_20x20mm_Pitch0.5mm" H 750 2300 50  0000 C CIN
F 3 "" H 2750 1500 50  0000 C CNN
	1    2750 1500
	1    0    0    -1  
$EndComp
$Comp
L STM32F412Z(E-G)Tx_u U1
U 2 1 5947E646
P 3550 3250
F 0 "U1" H 1350 4050 50  0000 C CNN
F 1 "STM32F412Z(E-G)Tx_u" H 1000 3950 50  0000 C CNN
F 2 "Housings_QFP:LQFP-144_20x20mm_Pitch0.5mm" H 750 4050 50  0000 C CIN
F 3 "" H 3550 3250 50  0000 C CNN
	2    3550 3250
	1    0    0    -1  
$EndComp
$Comp
L STM32F412Z(E-G)Tx_u U1
U 3 1 5947E789
P 2650 5050
F 0 "U1" H 1400 5850 50  0000 C CNN
F 1 "STM32F412Z(E-G)Tx_u" H 1050 5750 50  0000 C CNN
F 2 "Housings_QFP:LQFP-144_20x20mm_Pitch0.5mm" H 800 5850 50  0000 C CIN
F 3 "" H 2650 5050 50  0000 C CNN
	3    2650 5050
	1    0    0    -1  
$EndComp
$Comp
L STM32F412Z(E-G)Tx_u U1
U 4 1 5947E911
P 2450 6850
F 0 "U1" H 1400 7650 50  0000 C CNN
F 1 "STM32F412Z(E-G)Tx_u" H 1050 7550 50  0000 C CNN
F 2 "Housings_QFP:LQFP-144_20x20mm_Pitch0.5mm" H 800 7650 50  0000 C CIN
F 3 "" H 2450 6850 50  0000 C CNN
	4    2450 6850
	1    0    0    -1  
$EndComp
$Comp
L STM32F412Z(E-G)Tx_u U1
U 5 1 5947EBBA
P 2350 8650
F 0 "U1" H 1350 9500 50  0000 C CNN
F 1 "STM32F412Z(E-G)Tx_u" H 1000 9400 50  0000 C CNN
F 2 "Housings_QFP:LQFP-144_20x20mm_Pitch0.5mm" H 750 9500 50  0000 C CIN
F 3 "" H 2350 8650 50  0000 C CNN
	5    2350 8650
	1    0    0    -1  
$EndComp
$Comp
L STM32F412Z(E-G)Tx_u U1
U 6 1 5947EC7F
P 1550 10400
F 0 "U1" H 1350 11250 50  0000 C CNN
F 1 "STM32F412Z(E-G)Tx_u" H 1000 11150 50  0000 C CNN
F 2 "Housings_QFP:LQFP-144_20x20mm_Pitch0.5mm" H 750 11250 50  0000 C CIN
F 3 "" H 1550 10400 50  0000 C CNN
	6    1550 10400
	1    0    0    -1  
$EndComp
$Comp
L STM32F412Z(E-G)Tx_u U1
U 7 1 5947ED5A
P 8900 6200
F 0 "U1" H 8500 7000 50  0000 C CNN
F 1 "STM32F412Z(E-G)Tx_u" H 8150 6900 50  0000 C CNN
F 2 "Housings_QFP:LQFP-144_20x20mm_Pitch0.5mm" H 7900 7000 50  0000 C CIN
F 3 "" H 8900 6200 50  0000 C CNN
	7    8900 6200
	1    0    0    -1  
$EndComp
$Comp
L OrangePiPrime J1
U 2 1 5947F75D
P 11850 5950
F 0 "J1" H 12750 7050 60  0000 C CNN
F 1 "OrangePiPrime" H 12200 7050 60  0000 C CNN
F 2 "OrangePi:OrangePiPrime" H 11850 5950 60  0001 C CNN
F 3 "" H 11850 5950 60  0000 C CNN
	2    11850 5950
	1    0    0    -1  
$EndComp
$Comp
L OrangePiPrime J1
U 3 1 5947F7F8
P 13600 5950
F 0 "J1" H 14500 7050 60  0000 C CNN
F 1 "OrangePiPrime" H 13950 7050 60  0000 C CNN
F 2 "OrangePi:OrangePiPrime" H 13600 5950 60  0001 C CNN
F 3 "" H 13600 5950 60  0000 C CNN
	3    13600 5950
	1    0    0    -1  
$EndComp
$Comp
L OrangePiPrime J1
U 4 1 5947F8B3
P 11850 7900
F 0 "J1" H 12750 9000 60  0000 C CNN
F 1 "OrangePiPrime" H 12200 9000 60  0000 C CNN
F 2 "OrangePi:OrangePiPrime" H 11850 7900 60  0001 C CNN
F 3 "" H 11850 7900 60  0000 C CNN
	4    11850 7900
	1    0    0    -1  
$EndComp
Text Label 13250 5050 0    60   ~ 0
SDA
Text Label 13250 5150 0    60   ~ 0
SCL
Text Label 14800 5000 0    60   ~ 0
UART_RX
Text Label 14800 5100 0    60   ~ 0
UART_TX
Text Label 13200 6950 0    60   ~ 0
SPI_MOSI
Text Label 13200 7050 0    60   ~ 0
SPI_MISO
Text Label 13200 7150 0    60   ~ 0
SPI_CLK
Text Label 13200 7250 0    60   ~ 0
SPI_CS
Text Label 7000 3050 0    60   ~ 0
SCL
Text Label 7000 3150 0    60   ~ 0
SDA
Text Label 5450 1600 0    60   ~ 0
UART_RX
Text Label 5450 1700 0    60   ~ 0
UART_TX
Text Label 5450 1200 0    60   ~ 0
SPI_CLK
Text Label 5450 1300 0    60   ~ 0
SPI_MISO
Text Label 5450 1400 0    60   ~ 0
SPI_MOSI
Text Label 5450 1100 0    60   ~ 0
SPI_CS
$Comp
L STM32F412Z(E-G)Tx_u U1
U 9 1 59481AB4
P 8400 7850
F 0 "U1" H 8100 8200 50  0000 C CNN
F 1 "STM32F412Z(E-G)Tx_u" H 8450 8300 50  0000 C CNN
F 2 "Housings_QFP:LQFP-144_20x20mm_Pitch0.5mm" V 8250 8050 50  0000 C CIN
F 3 "" H 8400 7850 50  0000 C CNN
	9    8400 7850
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR013
U 1 1 59481DC3
P 9200 8250
F 0 "#PWR013" H 9200 8000 50  0001 C CNN
F 1 "GND" H 9200 8100 50  0000 C CNN
F 2 "" H 9200 8250 50  0000 C CNN
F 3 "" H 9200 8250 50  0000 C CNN
	1    9200 8250
	1    0    0    -1  
$EndComp
$Comp
L CONN_02X15 P2
U 1 1 5949172D
P 12600 1750
F 0 "P2" H 12600 2550 50  0000 C CNN
F 1 "CONN_02X15" V 12600 1750 50  0000 C CNN
F 2 "Pin_Headers:Pin_Header_Straight_2x15_Pitch2.54mm_SMD" H 12600 600 50  0001 C CNN
F 3 "" H 12600 600 50  0000 C CNN
	1    12600 1750
	1    0    0    -1  
$EndComp
$Comp
L CONN_02X15 P4
U 1 1 59491AAC
P 14650 1750
F 0 "P4" H 14650 2550 50  0000 C CNN
F 1 "CONN_02X15" V 14650 1750 50  0000 C CNN
F 2 "Pin_Headers:Pin_Header_Straight_2x15_Pitch2.54mm_SMD" H 14650 600 50  0001 C CNN
F 3 "" H 14650 600 50  0000 C CNN
	1    14650 1750
	1    0    0    -1  
$EndComp
$Comp
L CONN_02X15 P3
U 1 1 59491AF7
P 12600 3750
F 0 "P3" H 12600 4550 50  0000 C CNN
F 1 "CONN_02X15" V 12600 3750 50  0000 C CNN
F 2 "Pin_Headers:Pin_Header_Straight_2x15_Pitch2.54mm_SMD" H 12600 2600 50  0001 C CNN
F 3 "" H 12600 2600 50  0000 C CNN
	1    12600 3750
	1    0    0    -1  
$EndComp
$Comp
L CONN_02X15 P5
U 1 1 59491B53
P 14650 3750
F 0 "P5" H 14650 4550 50  0000 C CNN
F 1 "CONN_02X15" V 14650 3750 50  0000 C CNN
F 2 "Pin_Headers:Pin_Header_Straight_2x15_Pitch2.54mm_SMD" H 14650 2600 50  0001 C CNN
F 3 "" H 14650 2600 50  0000 C CNN
	1    14650 3750
	1    0    0    -1  
$EndComp
Text Label 4750 8050 0    60   ~ 0
DPU_A5
Text Label 4750 8150 0    60   ~ 0
DPU_A4
Text Label 4750 8250 0    60   ~ 0
DPU_A6
Text Label 4750 8350 0    60   ~ 0
DPU_A3
Text Label 4750 8450 0    60   ~ 0
DPU_A7
Text Label 5250 5550 0    60   ~ 0
DPU_A2
Text Label 5250 5650 0    60   ~ 0
SENSE_A0
Text Label 5250 5750 0    60   ~ 0
DPU_A1
$Comp
L CONN_02X05 P1
U 1 1 59493A6F
P 9950 7750
F 0 "P1" H 9950 8050 50  0000 C CNN
F 1 "CONN_02X05" H 9950 7450 50  0000 C CNN
F 2 "Pin_Headers:Pin_Header_Straight_2x05_Pitch2.54mm_SMD" H 9950 6550 50  0001 C CNN
F 3 "" H 9950 6550 50  0000 C CNN
	1    9950 7750
	1    0    0    -1  
$EndComp
Wire Wire Line
	14900 1150 15100 1150
Wire Wire Line
	14350 900  14350 1150
Wire Wire Line
	13800 1150 14400 1150
Wire Wire Line
	13800 1150 13800 1200
Connection ~ 14350 1150
Wire Wire Line
	14900 1250 15100 1250
Wire Wire Line
	15100 1250 15100 950 
Wire Wire Line
	14900 1350 15300 1350
Wire Wire Line
	15300 1350 15300 950 
Wire Wire Line
	14000 1250 14400 1250
Wire Wire Line
	14000 1350 14400 1350
Wire Wire Line
	14000 1450 14400 1450
Wire Wire Line
	14000 1550 14400 1550
Wire Wire Line
	14000 1650 14400 1650
Wire Wire Line
	14000 1750 14400 1750
Wire Wire Line
	14000 1850 14400 1850
Wire Wire Line
	14000 1950 14400 1950
Wire Wire Line
	14000 2050 14400 2050
Wire Wire Line
	14000 2150 14400 2150
Wire Wire Line
	14000 2250 14400 2250
Wire Wire Line
	14000 2350 14400 2350
Wire Wire Line
	14000 2450 14400 2450
Wire Wire Line
	14900 1450 15050 1450
Wire Wire Line
	14900 1550 15050 1550
Wire Wire Line
	14900 1650 15050 1650
Wire Wire Line
	14900 1750 15050 1750
Wire Wire Line
	14900 1850 15050 1850
Wire Wire Line
	14900 1950 15050 1950
Wire Wire Line
	14900 2050 15050 2050
Wire Wire Line
	14900 2150 15050 2150
Wire Wire Line
	14900 2250 15050 2250
Wire Wire Line
	14900 2350 15050 2350
Wire Wire Line
	14900 2450 15050 2450
Wire Wire Line
	14900 3150 15100 3150
Wire Wire Line
	14350 2900 14350 3150
Wire Wire Line
	13800 3150 14400 3150
Wire Wire Line
	13800 3150 13800 3200
Connection ~ 14350 3150
Wire Wire Line
	14900 3250 15100 3250
Wire Wire Line
	15100 3250 15100 2950
Wire Wire Line
	14900 3350 15300 3350
Wire Wire Line
	15300 3350 15300 2950
Wire Wire Line
	14000 3250 14400 3250
Wire Wire Line
	14000 3350 14400 3350
Wire Wire Line
	14000 3450 14400 3450
Wire Wire Line
	14000 3550 14400 3550
Wire Wire Line
	14000 3650 14400 3650
Wire Wire Line
	14000 3750 14400 3750
Wire Wire Line
	14000 3850 14400 3850
Wire Wire Line
	14000 3950 14400 3950
Wire Wire Line
	14000 4050 14400 4050
Wire Wire Line
	14000 4150 14400 4150
Wire Wire Line
	14000 4250 14400 4250
Wire Wire Line
	14000 4350 14400 4350
Wire Wire Line
	14000 4450 14400 4450
Wire Wire Line
	14900 3450 15050 3450
Wire Wire Line
	14900 3550 15050 3550
Wire Wire Line
	14900 3650 15050 3650
Wire Wire Line
	14900 3750 15050 3750
Wire Wire Line
	14900 3850 15050 3850
Wire Wire Line
	14900 3950 15050 3950
Wire Wire Line
	14900 4050 15050 4050
Wire Wire Line
	14900 4150 15050 4150
Wire Wire Line
	14900 4250 15050 4250
Wire Wire Line
	14900 4350 15050 4350
Wire Wire Line
	14900 4450 15050 4450
Wire Wire Line
	12850 1150 13050 1150
Wire Wire Line
	12300 900  12300 1150
Wire Wire Line
	11750 1150 12350 1150
Wire Wire Line
	11750 1150 11750 1200
Connection ~ 12300 1150
Wire Wire Line
	12850 1250 13050 1250
Wire Wire Line
	13050 1250 13050 950 
Wire Wire Line
	12850 1350 13250 1350
Wire Wire Line
	13250 1350 13250 950 
Wire Wire Line
	11950 1250 12350 1250
Wire Wire Line
	11950 1350 12350 1350
Wire Wire Line
	11950 1450 12350 1450
Wire Wire Line
	11950 1550 12350 1550
Wire Wire Line
	11950 1650 12350 1650
Wire Wire Line
	11950 1750 12350 1750
Wire Wire Line
	11950 1850 12350 1850
Wire Wire Line
	11950 1950 12350 1950
Wire Wire Line
	11950 2050 12350 2050
Wire Wire Line
	11950 2150 12350 2150
Wire Wire Line
	11950 2250 12350 2250
Wire Wire Line
	11950 2350 12350 2350
Wire Wire Line
	11950 2450 12350 2450
Wire Wire Line
	12850 1450 13000 1450
Wire Wire Line
	12850 1550 13000 1550
Wire Wire Line
	12850 1650 13000 1650
Wire Wire Line
	12850 1750 13000 1750
Wire Wire Line
	12850 1850 13000 1850
Wire Wire Line
	12850 1950 13000 1950
Wire Wire Line
	12850 2050 13000 2050
Wire Wire Line
	12850 2150 13000 2150
Wire Wire Line
	12850 2250 13000 2250
Wire Wire Line
	12850 2350 13000 2350
Wire Wire Line
	12850 2450 13000 2450
Wire Wire Line
	12850 3150 13050 3150
Wire Wire Line
	12300 2900 12300 3150
Wire Wire Line
	11750 3150 12350 3150
Wire Wire Line
	11750 3150 11750 3200
Connection ~ 12300 3150
Wire Wire Line
	12850 3250 13050 3250
Wire Wire Line
	13050 3250 13050 2950
Wire Wire Line
	12850 3350 13250 3350
Wire Wire Line
	13250 3350 13250 2950
Wire Wire Line
	11950 3250 12350 3250
Wire Wire Line
	11950 3350 12350 3350
Wire Wire Line
	11950 3450 12350 3450
Wire Wire Line
	11950 3550 12350 3550
Wire Wire Line
	11950 3650 12350 3650
Wire Wire Line
	11950 3750 12350 3750
Wire Wire Line
	11950 3850 12350 3850
Wire Wire Line
	11950 3950 12350 3950
Wire Wire Line
	11950 4050 12350 4050
Wire Wire Line
	11950 4150 12350 4150
Wire Wire Line
	11950 4250 12350 4250
Wire Wire Line
	11950 4350 12350 4350
Wire Wire Line
	11950 4450 12350 4450
Wire Wire Line
	12850 3450 13000 3450
Wire Wire Line
	12850 3550 13000 3550
Wire Wire Line
	12850 3650 13000 3650
Wire Wire Line
	12850 3750 13000 3750
Wire Wire Line
	12850 3850 13000 3850
Wire Wire Line
	12850 3950 13000 3950
Wire Wire Line
	12850 4050 13000 4050
Wire Wire Line
	12850 4150 13000 4150
Wire Wire Line
	12850 4250 13000 4250
Wire Wire Line
	12850 4350 13000 4350
Wire Wire Line
	12850 4450 13000 4450
Wire Wire Line
	13050 5050 13250 5050
Wire Wire Line
	13050 5150 13250 5150
Wire Wire Line
	13050 6950 13200 6950
Wire Wire Line
	13050 7050 13200 7050
Wire Wire Line
	13050 7150 13200 7150
Wire Wire Line
	13050 7250 13200 7250
Wire Wire Line
	6850 3050 7000 3050
Wire Wire Line
	6850 3150 7000 3150
Wire Wire Line
	5250 1600 5450 1600
Wire Wire Line
	5250 1700 5450 1700
Wire Wire Line
	5250 1200 5450 1200
Wire Wire Line
	5250 1300 5450 1300
Wire Wire Line
	5250 1400 5450 1400
Wire Wire Line
	5250 1100 5450 1100
Wire Wire Line
	8900 7550 9200 7550
Wire Wire Line
	9200 7550 9200 8250
Wire Wire Line
	12850 1050 12850 900 
Wire Wire Line
	12850 900  12300 900 
Wire Wire Line
	12350 1050 12300 1050
Connection ~ 12300 1050
Connection ~ 13050 1150
Connection ~ 15100 1150
Connection ~ 15100 3150
Connection ~ 13050 3150
Wire Wire Line
	12850 3050 12850 2900
Wire Wire Line
	12850 2900 12300 2900
Wire Wire Line
	12350 3050 12300 3050
Connection ~ 12300 3050
Wire Wire Line
	14900 3050 14900 2900
Wire Wire Line
	14900 2900 14350 2900
Wire Wire Line
	14400 3050 14350 3050
Connection ~ 14350 3050
Wire Wire Line
	14900 1050 14900 900 
Wire Wire Line
	14900 900  14350 900 
Wire Wire Line
	14400 1050 14350 1050
Connection ~ 14350 1050
Wire Wire Line
	4450 8050 4750 8050
Wire Wire Line
	4450 8150 4750 8150
Wire Wire Line
	4450 8250 4750 8250
Wire Wire Line
	4450 8350 4750 8350
Wire Wire Line
	4450 8450 4750 8450
Wire Wire Line
	5050 5550 5250 5550
Wire Wire Line
	5050 5650 5250 5650
Wire Wire Line
	5050 5750 5250 5750
Wire Wire Line
	2850 9600 3100 9600
Wire Wire Line
	2850 9700 3100 9700
Wire Wire Line
	2850 9800 3100 9800
Wire Wire Line
	2850 9900 3100 9900
Wire Wire Line
	2850 10000 3100 10000
Wire Wire Line
	2850 10100 3100 10100
Wire Wire Line
	9700 7650 9200 7650
Connection ~ 9200 7650
Wire Wire Line
	9700 7750 9200 7750
Connection ~ 9200 7750
Wire Wire Line
	9700 7950 9200 7950
Connection ~ 9200 7950
Wire Wire Line
	10200 7550 10350 7550
Wire Wire Line
	10200 7650 10350 7650
Wire Wire Line
	10200 7950 10350 7950
Wire Wire Line
	10350 7950 10350 8500
Wire Wire Line
	10350 8500 9050 8500
Wire Wire Line
	9050 8500 9050 7650
Wire Wire Line
	9050 7650 8900 7650
Text Label 10350 7550 0    60   ~ 0
SWDAT
Text Label 10350 7650 0    60   ~ 0
SWCLK
$Comp
L +3.3V #PWR014
U 1 1 594942F4
P 9600 7450
F 0 "#PWR014" H 9600 7300 50  0001 C CNN
F 1 "+3.3V" H 9600 7590 50  0000 C CNN
F 2 "" H 9600 7450 50  0000 C CNN
F 3 "" H 9600 7450 50  0000 C CNN
	1    9600 7450
	1    0    0    -1  
$EndComp
Wire Wire Line
	9700 7550 9600 7550
Wire Wire Line
	9600 7550 9600 7450
Wire Wire Line
	5250 2000 5450 2000
Wire Wire Line
	5250 2100 5450 2100
Text Label 5450 2000 0    60   ~ 0
SWDAT
Text Label 5450 2100 0    60   ~ 0
SWCLK
Wire Wire Line
	2850 10200 3100 10200
Wire Wire Line
	2850 10300 3100 10300
Text Label 3100 9600 0    60   ~ 0
SENSE_A1
Text Label 3100 9700 0    60   ~ 0
DPU_A0
Text Label 3100 9800 0    60   ~ 0
SENSE_A2
Text Label 3100 9900 0    60   ~ 0
DRIVE_A7
Text Label 3100 10000 0    60   ~ 0
SENSE_A3
Text Label 3100 10100 0    60   ~ 0
DRIVE_A6
Text Label 3100 10200 0    60   ~ 0
SENSE_A4
Text Label 3100 10300 0    60   ~ 0
DRIVE_A5
Wire Wire Line
	2850 10400 3100 10400
Wire Wire Line
	2850 10500 3100 10500
Wire Wire Line
	2850 10600 3100 10600
Wire Wire Line
	5050 4250 5250 4250
Wire Wire Line
	5050 4350 5250 4350
Wire Wire Line
	5050 4450 5250 4450
Wire Wire Line
	5050 4550 5250 4550
Wire Wire Line
	5250 700  5450 700 
Text Label 3100 10400 0    60   ~ 0
SENSE_A5
Text Label 3100 10500 0    60   ~ 0
DRIVE_A4
Text Label 3100 10600 0    60   ~ 0
SENSE_A6
Text Label 5250 4250 0    60   ~ 0
DRIVE_A3
Text Label 5250 4350 0    60   ~ 0
SENSE_A7
Text Label 5250 4450 0    60   ~ 0
DRIVE_A2
Text Label 5250 4550 0    60   ~ 0
DRIVE_A1
Text Label 5450 700  0    60   ~ 0
DRIVE_A0
Wire Wire Line
	5250 800  5450 800 
Wire Wire Line
	5250 900  5450 900 
Wire Wire Line
	5250 1000 5450 1000
Wire Wire Line
	5050 4650 5250 4650
Wire Wire Line
	5050 4750 5250 4750
Wire Wire Line
	2850 10700 3100 10700
Wire Wire Line
	6850 2450 7000 2450
Wire Wire Line
	6850 2550 7000 2550
Wire Wire Line
	6850 2650 7000 2650
Text Label 5450 800  0    60   ~ 0
DRIVE_B0
Text Label 5450 900  0    60   ~ 0
DRIVE_B1
Text Label 5450 1000 0    60   ~ 0
DRIVE_B2
Text Label 5250 4650 0    60   ~ 0
SENSE_B7
Text Label 5250 4750 0    60   ~ 0
DRIVE_B3
Text Label 7000 2450 0    60   ~ 0
SENSE_B6
Text Label 7000 2550 0    60   ~ 0
DRIVE_B4
Text Label 7000 2650 0    60   ~ 0
SENSE_B5
Wire Wire Line
	2850 10800 3100 10800
Wire Wire Line
	2850 10900 3100 10900
Wire Wire Line
	2850 11000 3100 11000
Wire Wire Line
	2850 11100 3100 11100
Wire Wire Line
	10400 5400 10650 5400
Wire Wire Line
	10400 5500 10650 5500
Wire Wire Line
	4450 8550 4750 8550
Text Label 3100 10700 0    60   ~ 0
DRIVE_B5
Text Label 3100 10800 0    60   ~ 0
SENSE_B4
Text Label 3100 10900 0    60   ~ 0
DRIVE_B6
Text Label 3100 11000 0    60   ~ 0
SENSE_B3
Text Label 3100 11100 0    60   ~ 0
DRIVE_B7
Text Label 10650 5400 0    60   ~ 0
SENSE_B2
Text Label 10650 5500 0    60   ~ 0
DPU_B0
Text Label 4750 8550 0    60   ~ 0
SENSE_B1
Wire Wire Line
	4450 8650 4750 8650
Wire Wire Line
	4450 8750 4750 8750
Wire Wire Line
	4450 8850 4750 8850
Wire Wire Line
	4450 8950 4750 8950
Wire Wire Line
	4450 9050 4750 9050
Wire Wire Line
	4450 9150 4750 9150
Wire Wire Line
	4450 9250 4750 9250
Wire Wire Line
	4450 9350 4750 9350
Text Label 4750 8650 0    60   ~ 0
DPU_B1
Text Label 4750 8750 0    60   ~ 0
SENSE_B0
Text Label 4750 8850 0    60   ~ 0
DPU_B2
Text Label 4750 8950 0    60   ~ 0
DPU_B7
Text Label 4750 9050 0    60   ~ 0
DPU_B3
Text Label 4750 9150 0    60   ~ 0
DPU_B6
Text Label 4750 9250 0    60   ~ 0
DPU_B4
Text Label 4750 9350 0    60   ~ 0
DPU_B5
Wire Wire Line
	6850 3450 7000 3450
Wire Wire Line
	6850 3550 7000 3550
Wire Wire Line
	6850 3650 7000 3650
Wire Wire Line
	6850 3750 7000 3750
Wire Wire Line
	6850 3850 7000 3850
Wire Wire Line
	6850 3950 7000 3950
Wire Wire Line
	4650 6850 4750 6850
Wire Wire Line
	4650 6950 4750 6950
Text Label 7000 3450 0    60   ~ 0
DRIVE_C0
Text Label 7000 3550 0    60   ~ 0
DRIVE_C1
Text Label 7000 3650 0    60   ~ 0
SENSE_C7
Text Label 7000 3750 0    60   ~ 0
DRIVE_C2
Text Label 7000 3850 0    60   ~ 0
SENSE_C6
Text Label 7000 3950 0    60   ~ 0
DRIVE_C3
Text Label 4750 6850 0    60   ~ 0
SENSE_C5
Text Label 4750 6950 0    60   ~ 0
DRIVE_C4
Wire Wire Line
	5050 4850 5250 4850
Wire Wire Line
	5050 4950 5250 4950
Text Label 5250 4850 0    60   ~ 0
DEBUG_TX
Text Label 5250 4950 0    60   ~ 0
DEBUG_RX
Wire Wire Line
	4650 7050 4750 7050
Wire Wire Line
	4650 7150 4750 7150
Wire Wire Line
	4650 7250 4750 7250
Wire Wire Line
	4650 7350 4750 7350
Wire Wire Line
	4650 7450 4750 7450
Wire Wire Line
	4650 7550 4750 7550
Wire Wire Line
	10400 5600 10650 5600
Wire Wire Line
	10400 5700 10650 5700
Text Label 4750 7050 0    60   ~ 0
SENSE_C4
Text Label 4750 7150 0    60   ~ 0
DRIVE_C5
Text Label 4750 7250 0    60   ~ 0
SENSE_C3
Text Label 4750 7350 0    60   ~ 0
DRIVE_C6
Text Label 4750 7450 0    60   ~ 0
SENSE_C2
Text Label 4750 7550 0    60   ~ 0
DRIVE_C7
Text Label 10650 5600 0    60   ~ 0
SENSE_C1
Text Label 10650 5700 0    60   ~ 0
DPU_C0
Wire Wire Line
	10400 5800 10650 5800
Wire Wire Line
	10400 5900 10650 5900
Wire Wire Line
	10400 6000 10650 6000
Wire Wire Line
	10400 6100 10650 6100
Wire Wire Line
	10400 6200 10650 6200
Wire Wire Line
	5050 5050 5250 5050
Wire Wire Line
	5050 5150 5250 5150
Wire Wire Line
	5250 1500 5450 1500
Text Label 10650 5800 0    60   ~ 0
SENSE_C0
Text Label 10650 5900 0    60   ~ 0
DPU_C1
Text Label 10650 6000 0    60   ~ 0
DPU_C7
Text Label 10650 6100 0    60   ~ 0
DPU_C2
Text Label 10650 6200 0    60   ~ 0
DPU_C6
Text Label 5250 5050 0    60   ~ 0
DPU_C3
Text Label 5250 5150 0    60   ~ 0
DPU_C5
Text Label 5450 1500 0    60   ~ 0
DPU_C4
Wire Wire Line
	5250 2200 5450 2200
Wire Wire Line
	5050 5250 5250 5250
Wire Wire Line
	5050 5350 5250 5350
Wire Wire Line
	5050 5450 5250 5450
Wire Wire Line
	4650 6050 4750 6050
Wire Wire Line
	4650 6150 4750 6150
Text Label 5450 2200 0    60   ~ 0
DPU_D5
Text Label 5250 5250 0    60   ~ 0
DPU_D4
Text Label 5250 5350 0    60   ~ 0
DPU_D6
Text Label 5250 5450 0    60   ~ 0
DPU_D3
Text Label 4750 6050 0    60   ~ 0
DPU_D7
Text Label 4750 6150 0    60   ~ 0
DPU_D2
Wire Wire Line
	4650 6250 4750 6250
Wire Wire Line
	4650 6350 4750 6350
Wire Wire Line
	4650 6450 4750 6450
Wire Wire Line
	4650 6550 4750 6550
Wire Wire Line
	4650 6650 4750 6650
Wire Wire Line
	4650 6750 4750 6750
Wire Wire Line
	10400 6300 10650 6300
Wire Wire Line
	10400 6400 10650 6400
Text Label 4750 6250 0    60   ~ 0
SENSE_D0
Text Label 4750 6350 0    60   ~ 0
DPU_D1
Text Label 4750 6450 0    60   ~ 0
SENSE_D1
Text Label 4750 6550 0    60   ~ 0
DPU_D0
Text Label 4750 6650 0    60   ~ 0
SENSE_D2
Text Label 4750 6750 0    60   ~ 0
DRIVE_D7
Text Label 10650 6300 0    60   ~ 0
SENSE_D3
Text Label 10650 6400 0    60   ~ 0
DRIVE_D6
Wire Wire Line
	10400 6500 10650 6500
Wire Wire Line
	10400 6600 10650 6600
Wire Wire Line
	10400 6700 10650 6700
Wire Wire Line
	10400 6800 10650 6800
Wire Wire Line
	10400 6900 10650 6900
Wire Wire Line
	6850 2750 7000 2750
Wire Wire Line
	6850 2850 7000 2850
Wire Wire Line
	6850 2950 7000 2950
Text Label 10650 6500 0    60   ~ 0
SENSE_D4
Text Label 10650 6600 0    60   ~ 0
DRIVE_D5
Text Label 10650 6700 0    60   ~ 0
SENSE_D5
Text Label 10650 6800 0    60   ~ 0
DRIVE_D4
Text Label 10650 6900 0    60   ~ 0
SENSE_D6
Text Label 7000 2750 0    60   ~ 0
DRIVE_D3
Text Label 7000 2850 0    60   ~ 0
SENSE_D7
Text Label 7000 2950 0    60   ~ 0
DRIVE_D2
Wire Wire Line
	6850 3250 7000 3250
Wire Wire Line
	6850 3350 7000 3350
Text Label 7000 3250 0    60   ~ 0
DRIVE_D1
Text Label 7000 3350 0    60   ~ 0
DRIVE_D0
$EndSCHEMATC
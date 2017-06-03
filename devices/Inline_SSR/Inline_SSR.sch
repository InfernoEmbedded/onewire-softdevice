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
LIBS:G3MB-SSR
LIBS:JACK_STEREO
EELAYER 25 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L JACK_STEREO J1
U 1 1 5932639C
P 3600 3250
F 0 "J1" H 3225 3250 50  0000 R CNN
F 1 "JACK_STEREO" H 3600 3500 50  0000 C CNN
F 2 "w_conn_av:jack_3.5_pj313d-smt" H 3600 3250 60  0001 C CNN
F 3 "" H 3600 3250 60  0001 C CNN
	1    3600 3250
	1    0    0    1   
$EndComp
$Comp
L G3MB_SSR U1
U 1 1 593263CF
P 5100 3200
F 0 "U1" H 5300 3500 60  0000 C CNN
F 1 "G3MB_SSR" H 5200 2900 60  0000 C CNN
F 2 "SSR-OmronG3MB:G3MB" H 5100 3200 60  0001 C CNN
F 3 "" H 5100 3200 60  0000 C CNN
	1    5100 3200
	1    0    0    -1  
$EndComp
Wire Wire Line
	3950 3400 4450 3400
Wire Wire Line
	3950 3200 4300 3200
Wire Wire Line
	4300 3200 4300 3000
Wire Wire Line
	4300 3000 4450 3000
$Comp
L FUSE F1
U 1 1 5932647D
P 6050 3000
F 0 "F1" H 6150 3050 50  0000 C CNN
F 1 "2A" H 5950 2950 50  0000 C CNN
F 2 "Fuse_Holders_and_Fuses:Fuse_0679H" H 6050 3000 50  0001 C CNN
F 3 "" H 6050 3000 50  0000 C CNN
	1    6050 3000
	1    0    0    -1  
$EndComp
Wire Wire Line
	5700 3000 5800 3000
$Comp
L CONN_01X02 P1
U 1 1 593264D9
P 6600 3050
F 0 "P1" H 6600 3200 50  0000 C CNN
F 1 "CONN_01X02" V 6700 3050 50  0000 C CNN
F 2 "2EDCK-Screw-Connectors:2EDCK-5.08-2PIN" H 6600 3050 50  0001 C CNN
F 3 "" H 6600 3050 50  0000 C CNN
	1    6600 3050
	1    0    0    1   
$EndComp
Wire Wire Line
	6300 3000 6400 3000
Wire Wire Line
	5700 3400 6400 3400
Wire Wire Line
	6400 3400 6400 3100
$EndSCHEMATC

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
EELAYER 25 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 2 2
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
L CONN_01X04 P1
U 1 1 5C86C296
P 6050 3500
F 0 "P1" H 6050 3750 50  0000 C CNN
F 1 "CONN_01X04" V 6150 3500 50  0000 C CNN
F 2 "" H 6050 3500 50  0000 C CNN
F 3 "" H 6050 3500 50  0000 C CNN
	1    6050 3500
	1    0    0    -1  
$EndComp
Wire Wire Line
	5000 3350 5850 3350
Wire Wire Line
	5850 3450 5300 3450
Wire Wire Line
	5300 3450 5300 3550
Wire Wire Line
	5300 3550 5000 3550
Wire Wire Line
	5850 3550 5400 3550
Wire Wire Line
	5400 3550 5400 3750
Wire Wire Line
	5850 3650 5500 3650
Wire Wire Line
	5500 3650 5500 3950
Wire Wire Line
	5500 3950 5000 3950
Wire Wire Line
	5400 3750 5000 3750
Text HLabel 5000 3350 0    60   Input ~ 0
step
Text HLabel 5000 3550 0    60   Input ~ 0
dir
Text HLabel 5000 3750 0    60   Input ~ 0
ena
Text HLabel 5000 3950 0    60   Input ~ 0
gnd
$EndSCHEMATC

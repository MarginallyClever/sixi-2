# Sixi 2 Robot Arm

Sixi 2 is an open source industrial robot arm.  It is designed with six degrees of freedom and can hold 2kg at 80cm.
Some examples of it in action:

![](https://i.imgur.com/wJwSlcT.jpg)

## Videos

* https://www.instagram.com/p/B56L99UnWkN/
* https://www.instagram.com/p/B6L7YMTnthS/
* https://www.instagram.com/p/B6jtXw5HbRo/

## Motivation

3D printers can print parts for themselves, but they cannot self-assemble.  The long goal of the Sixi is to build a machine that can assemble copies of itself.

When 3D printers were closed source, they started at $10k.  Makerbot and Prusa changed the game by bringing high quality open source 3D printers down to $2k.  Marginally Clever Robots, Ltd. aims to be the Prusa of robot arms.

## This repository 

This repository contains:

* The STL files from the stable version
* The bill of materials (BOM.csv)
* Issue tickets specifically related to the hardware.
* ROS package.

This repository does NOT contain:

* Assembly instructions + software guide: https://mcr.dozuki.com/c/Sixi_2_kit_Asssembly
* Robot Overlord app to simulate, drive, and test Sixi: https://github.com/MarginallyClever/Robot-Overlord-App
* Makelangelo Firmware in the Sixi's brain: https://github.com/MarginallyClever/Makelangelo-firmware

## Notes

The BOM.csv lists all the parts in the kit, most of which are off-the-shelf.  Some parts are manufactured.
	
	[LSR] laser cut
	[CNC] metal cut on a CNC mill
	[3D]  3D printed PLA plastic.

All the 3D printable parts were produced on a Prusa MK3S.  Parts are carefully designed to have a minimum of support material cleaning.
Please see STLs/STLPrintSettings.csv for recommended layer height, speed, color, etc.

The Sixi has no glue because we like operations that can be undone.

## Collaborate

We love collaborating!  Let's make great things happen together.

* Reach us online at http://marginallyclever.com/
* Discuss the project in our forum: https://www.marginallyclever.com/forums/forum/sixi-robot-arm/
* For a link to the Fusion files, become one of our Patreon supporters: https://www.patreon.com/imakerobots
* See also the ROS.org wiki page: https://wiki.ros.org/Robots/Sixi

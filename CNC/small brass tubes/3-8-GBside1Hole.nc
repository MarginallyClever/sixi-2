%
(3-8-GBside1Hole)
(180deg opposite from GB2holes)
(Machine)
(  vendor Tormach)
(  model 770M)
(  description Tormach 770M 3-axis)
(T6  D=0.1094 CR=0. TAPER=118deg - ZMIN=-0.124 - drill)
G90 G54 G64 G50 G17 G40 G80 G94 G91.1 G49
G20 (Inch)
G30

N10(GBside 1 hole)
T6 G43 H6 M6
S8731 M3 M8
G54
G0 X0.0984 Y0.
G0 Z0.6
G0 Z0.2
G98 G81 X0.0984 Y0. Z-0.124 R0.2 F17.5
G80
G0 Z0.6
M5 M9

G30
M30
%

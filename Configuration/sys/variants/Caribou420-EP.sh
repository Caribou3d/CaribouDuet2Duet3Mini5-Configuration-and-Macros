#!/bin/sh

# set output
#
fullfilename=$0
filename=$(basename "$fullfilename")

# create config.g
#
fname="config-${filename%.*}.g"
sed '
{s/#CARIBOU_VARIANT/Caribou420- E3d Thermistor - PINDA/};
{s/#CARIBOU_NAME/Caribou420-EP/};
{s/#CARIBOU_ZHEIGHT/Z416.50/};
{/#CARIBOU_HOTEND_THERMISTOR/ c\
; Hotend (Mosquito or Mosquito Magnum with E3d Thermistor)\
;\
M308 S1 P"e0temp" Y"thermistor" T100000 B4725 C7.060000e-8 R4700 A"Nozzle E1"  ; E3d configure sensor 0 as thermistor on pin e0temp\
;\
M950 H1 C"e0heat" T1                                        ; create nozzle heater output on e0heat and map it to sensor 2\
M307 H1 B0 S1.00                                            ; disable bang-bang mode for heater  and set PWM limit\
M143 H1 S280                                                ; set temperature limit for heater 1 to 280C
};
{/#CARIBOU_ZPROBE/ c\
; PINDA2 \
;\
M558 P5 C"zprobe.in" H1.5 F1000 T12000 A3                   ; set Z probe to PINDA2\
M308 S2 P"e1temp" A"Pinda V2" Y"thermistor" T100000 B3950   ; temperature of PINDA2\
M557 X23:235 Y5:186 S30.25:30                               ; define mesh grid
};
{/#CARIBOU_ZOFFSETS/ c\
G31 P1000 X23 Y5\
;G31 P1000 X23 Y5 Z0.985                        ; PEI Sheet (Prusa) Offset Spool3D Tungsten Carbide\
;G31 P1000 X23 Y5 Z0.440                        ; PEI Sheet (Prusa) Offset MICRO SWISS NOZZLE\
;G31 P1000 X23 Y5 Z1.285                        ; Textured Sheet (Prusa) Offset MICRO SWISS NOZZLE\
;G31 P1000 X23 Y5 Z0.64                         ; Textured Sheet (thekkiinngg) Offset MICRO SWISS NOZZLE\
;G31 P1000 X23 Y5 Z0.03                         ; Textured Sheet (thekkiinngg) Offset MICRO SWISS NOZZLE
}
' < ../config.g > ../$fname

# create 00_Level-X-Axis
#
fname="00_Level-X-Axis-${filename%.*}"
sed '
{s/#CARIBOU_VARIANT/Caribou420- E3d Thermistor - PINDA/};
{s/#CARIBOU_NAME/Caribou420-EP/};
{s/#CARIBOU_ZHEIGHTLEVELING/Z405/}
{s/#CARIBOU_ZHEIGHT/Z416.50/}
' < ../../macros/00_Level-X-Axis > ../../macros/$fname

# create homez and homeall
#
fname="homeall-${filename%.*}.g"
sed '
{s/#CARIBOU_VARIANT/Caribou420- E3d Thermistor - PINDA/}
' < ../homeall.g > ../$fname

fname="homez-${filename%.*}.g"
sed '
{s/#CARIBOU_VARIANT/Caribou420- E3d Thermistor - PINDA/}
' < ../homez.g > ../$fname
 
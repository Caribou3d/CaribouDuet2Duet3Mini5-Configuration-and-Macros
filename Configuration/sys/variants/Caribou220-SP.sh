#!/bin/sh

# set output
#
fullfilename=$0
filename=$(basename "$fullfilename")

# create config.g
#
fname="config-${filename%.*}.g"
sed '
{s/#CARIBOU_VARIANT/Caribou220- SE Thermistor - PINDA/};
{s/#CARIBOU_NAME/Caribou220-SP/};
{s/#CARIBOU_ZHEIGHT/Z216.50/};
{/#CARIBOU_HOTEND_THERMISTOR/ c\
; Hotend (Mosquito or Mosquito Magnum with SE Thermistor)\
;\
M308 S1 P"e0temp" Y"thermistor" T500000 B4723 C1.19622e-7 A"Nozzle"   ; SE configure sensor 0 as thermistor on pin e0temp\
;\
M950 H1 C"e0heat" T1                                        ; create nozzle heater output on e0heat and map it to sensor 1\
M307 H1 B0 S1.00                                            ; disable bang-bang mode for heater  and set PWM limit\
M143 H1 S365                                                ; set temperature limit for heater 1 to 365C
};
{/#CARIBOU_ZPROBE/ c\
; PINDA2 \
;\
M558 P5 C"zprobe.in" H1.5 F1000 T12000 A3                   ; set Z probe to PINDA2\
M308 S2 P"e1temp" A"Pinda V2" Y"thermistor" T100000 B3950   ; temperature of PINDA2\
M557 X23:235 Y5:186 S30.25:30                               ; define mesh grid
};
{/#CARIBOU_OFFSETS/ c\
G31 P1000 X23 Y5\
}
' < ../config.g > ../$fname

# create 00_Level-X-Axis
#
fname="00_Level-X-Axis-${filename%.*}"
sed '
{s/#CARIBOU_VARIANT/Caribou220- SE Thermistor - PINDA/};
{s/#CARIBOU_NAME/Caribou220-SP/};
{s/#CARIBOU_ZHEIGHTLEVELING/Z205/}
{s/#CARIBOU_ZHEIGHT/Z216.50/}
' < ../../macros/00_Level-X-Axis > ../../macros/$fname

# create homez and homeall
#
fname="homeall-${filename%.*}.g"
sed '
{s/#CARIBOU_VARIANT/Caribou220- SE Thermistor - PINDA/}
' < ../homeall.g > ../$fname

fname="homez-${filename%.*}.g"
sed '
{s/#CARIBOU_VARIANT/Caribou220- SE Thermistor - PINDA/}
' < ../homez.g > ../$fname
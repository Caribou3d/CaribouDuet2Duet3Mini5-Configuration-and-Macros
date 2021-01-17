#!/bin/sh

# set output
#
fullfilename=$0
filename=$(basename "$fullfilename")

# create config.g
#
fname="config-${filename%.*}.g"
sed '
{s/#CARIBOU_VARIANT/Caribou420- SE Thermistor - BL-Touch/};
{s/#CARIBOU_NAME/Caribou420-EBL/};
{s/#CARIBOU_ZHEIGHT/Z416.50/};
{/#CARIBOU_HOTEND_THERMISTOR/ c\
; Hotend (Mosquito or Mosquito Magnum with SE Thermistor) \
;\
M308 S1 P"e0temp" Y"thermistor" T500000 B4723 C1.19622e-7 A"Nozzle"   ; SE configure sensor 0 as thermistor on pin e0temp\
;\
M950 H1 C"e0heat" T1                                        ; create nozzle heater output on e0heat and map it to sensor 2\
M307 H1 B0 S1.00                                            ; disable bang-bang mode for heater  and set PWM limit\
M143 H1 S365                                                ; set temperature limit for heater 1 to 280C
};
{/#CARIBOU_ZPROBE/ c\
; BL-Touch \
;\
M950 S0 C"exp.heater3"                                  ; sensor for BL-Touch\
M558 P9 C"^zprobe.in" H2.5 F200 T10000                  ; for BL-Touch\
M557 X90:220 Y50:205 P3                                 ; define mesh grid
};
{/#CARIBOU_OFFSETS/ c\
G31 X-14.8 Y-42.7 Z0
}
' < ../config.g > ../$fname

# create 00-Level-X-Axis
#
fname="00-Level-X-Axis-${filename%.*}"
sed '
{s/#CARIBOU_VARIANT/Caribou420- SE Thermistor - PINDA/};
{s/#CARIBOU_NAME/Caribou420-EP/};
{s/#CARIBOU_ZHEIGHTLEVELING/Z405/}
{s/#CARIBOU_ZHEIGHT/Z416.50/}
' < ../../macros/00-Level-X-Axis > ../../macros/$fname

# create homez and homeall
#
fname="homeall-${filename%.*}.g"
sed '
{s/#CARIBOU_VARIANT/Caribou420- SE Thermistor - BL-Touch/};
{s/G1 X11.5 Y4.5 F6000/G1 X147 Y136 F6000 /};
' < ../homeall.g > ../$fname

fname="homez-${filename%.*}.g"
sed '
{s/#CARIBOU_VARIANT/Caribou420- SE Thermistor - BL-Touch/};
{s/G1 X11.5 Y4.5 F6000/G1 X147 Y136 F6000 /};
' < ../homez.g > ../$fname

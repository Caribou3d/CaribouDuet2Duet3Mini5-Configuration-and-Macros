#!/bin/sh

# set output 
#
fullfilename=$0
filename=$(basename "$fullfilename")
fcname="config-${filename%.*}.g"
flevelname="00_Level-X-Axis-${filename%.*}"

# create config.g
#
sed '
{s/#CARIBOU_VARIANT/Caribou320- E3d Thermistor - SuperPINDA/};
{s/#CARIBOU_NAME/Caribou320-ESP/};
{s/#CARIBOU_ZHEIGHT/Z316.50/};
{/#CARIBOU_HOTEND_THERMISTOR/ c\
; Hotend (Mosquito or Mosquito Magnum with E3d Thermistor) a\
;\
M308 S1 P"e0temp" Y"thermistor" T100000 B4725 C7.060000e-8 R4700 A"Nozzle E1"  ; E3d configure sensor 0 as thermistor on pin e0temp\
;\
M950 H1 C"e0heat" T1                                        ; create nozzle heater output on e0heat and map it to sensor 2\
M307 H1 B0 S1.00                                            ; disable bang-bang mode for heater  and set PWM limit\
M143 H1 S280                                                ; set temperature limit for heater 1 to 280C
};
{/#CARIBOU_ZPROBE/ c\
; SuperPINDA \
;\
M558 P5 C"zprobe.in" H1.5 F1000 T12000 A3                   ; set Z probe to PINDA\
M557 X23:235 Y5:186 S30.25:30                               ; define mesh grid
};
' < ../config.g > ../$fcname

# create 00_Level-X-Axis
#
sed '
{s/#CARIBOU_VARIANT/Caribou320- E3d Thermistor - SuperPINDA/};
{s/#CARIBOU_NAME/Caribou320-ESP/};
{s/#CARIBOU_ZHEIGHTLEVELING/Z305/}
{s/#CARIBOU_ZHEIGHT/Z316.50/}
' < ../../macros/00_Level-X-Axis > ../../macros/$flevelname



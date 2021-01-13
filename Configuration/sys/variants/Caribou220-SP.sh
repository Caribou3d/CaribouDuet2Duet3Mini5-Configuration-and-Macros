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
{s/#CARIBOU_VARIANT/Caribou220- SE Thermistor - PINDA/};
{s/#CARIBOU_NAME/Caribou220-SP/};
{s/#CARIBOU_ZHEIGHT/Z216.50/};
{/#CARIBOU_HOTEND_THERMISTOR/ c\
; Hotend (Mosquito or Mosquito Magnum with SE Thermistor a\
;\
M308 S1 P"e0temp" Y"thermistor" T500000 B4723 C1.19622e-7 A"Nozzle"   ; SE configure sensor 0 as thermistor on pin e0temp\
;\
M950 H1 C"e0heat" T1                                        ; create nozzle heater output on e0heat and map it to sensor 1\
M307 H1 B0 S1.00                                            ; disable bang-bang mode for heater  and set PWM limit\
M143 H1 S365                                                ; set temperature limit for heater 1 to 365C
};
{/#CARIBOU_ZPROBE/ c\
; PINDA \
;\
M558 P5 C"zprobe.in" H1.5 F1000 T12000 A3                   ; set Z probe to PINDA\
M308 S1 P"e0temp" A"Pinda V2" Y"thermistor" T100000 B3950   ; USE FOR PINDA\
M557 X23:235 Y5:186 S30.25:30                               ; define mesh grid
}
' < ../config.g > ../$fcname

# create 00_Level-X-Axis
#
sed '
{s/#CARIBOU_VARIANT/Caribou220- SE Thermistor - PINDA/};
{s/#CARIBOU_NAME/Caribou220-SP/};
{s/#CARIBOU_ZHEIGHTLEVELING/Z205/}
{s/#CARIBOU_ZHEIGHT/Z216.50/}
' < ../../macros/00_Level-X-Axis > ../../macros/$flevelname


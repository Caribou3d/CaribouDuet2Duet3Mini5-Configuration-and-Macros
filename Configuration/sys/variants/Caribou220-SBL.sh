#!/bin/sh

# =========================================================================================================
# definition for Caribou220- SE Thermistor - BL-Touch
# =========================================================================================================

# set output for sys and macros
#

SysOutputPath=../processed
# prepare output folder
if [ ! -d "$SysOutputPath" ]; then
	mkdir -p $SysOutputPath || exit 27
else
	rm -fr $SysOutputPath || exit 27
	mkdir -p $SysOutputPath || exit 27
fi

MacrosDir=../../macros
MacroOutputPath=$MacrosDir/processed
# prepare output folder
if [ ! -d "$MacroOutputPath" ]; then
	mkdir -p $MacroOutputPath || exit 27
else
	rm -fr $MacroOutputPath || exit 27
	mkdir -p $MacroOutputPath || exit 27
fi

# =========================================================================================================
# create sys files
# =========================================================================================================

# copy sys files to processed folder
find .. -maxdepth 1 -type f -exec cp -t $SysOutputPath {} +

# create config.g
#

sed '
{s/#CARIBOU_VARIANT/Caribou220- SE Thermistor - BL-Touch/};
{s/#CARIBOU_NAME/Caribou220-EBL/};
{s/#CARIBOU_ZHEIGHT/Z216.50/};
{/#CARIBOU_HOTEND_THERMISTOR/ c\
; Hotend (Mosquito or Mosquito Magnum with SE Thermistor) \
;\
M308 S1 P"e0temp" Y"thermistor" T500000 B4723 C1.19622e-7 A"Nozzle"   ; SE configure sensor 0 as thermistor on pin e0temp\
;\
M950 H1 C"e0heat" T1                                        ; create nozzle heater output on e0heat and map it to sensor 2\
M307 H1 B0 S1.00                                            ; disable bang-bang mode for heater  and set PWM limit\
M143 H1 S365                                                ; set temperature limit for heater 1 to 365C
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
' < ../config.g > $SysOutputPath/config.g

# create homez and homeall
#

sed '
{s/#CARIBOU_VARIANT/Caribou220- SE Thermistor - BL-Touch/};
{s/G1 X11.5 Y4.5 F6000/G1 X147 Y136 F6000 /};
' < ../homeall.g > $SysOutputPath/homeall.g

sed '
{s/#CARIBOU_VARIANT/Caribou220- SE Thermistor - BL-Touch/};
{s/G1 X11.5 Y4.5 F6000/G1 X147 Y136 F6000 /};
' < ../homez.g > $SysOutputPath/homez.g

sed '
{s/#CARIBOU_VARIANT/Caribou220- SE Thermistor - BL-Touch/};
{/#CARIBOU_ZPROBE/ c\
M280 P0 S160                           ; BLTouch, alarm release\
G4 P100                                ; BLTouch, delay for the release command
};
' < ../start.g > $SysOutputPath/start.g

# =========================================================================================================
# create macro files
# =========================================================================================================

# copy macros directory to processed folder (for BL-Touch except the Print-Surface Macros)
find $MacrosDir/* -maxdepth 0  ! \( -name "*First*" -o -name "*Preheat*" -o -name "*processed*" -o -name "*Print*" \) -exec cp -r -t  $MacroOutputPath {} \+
cp -r $MacrosDir/02-First_Layer_Calibration/processed $MacroOutputPath/02-First_Layer_Calibration
cp -r $MacrosDir/03-Preheat/processed $MacroOutputPath/03-Preheat

# create 00-Level-X-Axis
#
sed '
{s/#CARIBOU_VARIANT/Caribou220- SE Thermistor - BL-Touch/};
{s/#CARIBOU_NAME/Caribou220-EBL/};
{s/#CARIBOU_ZHEIGHTLEVELING/Z205/}
{s/#CARIBOU_ZHEIGHT/Z216.50/}
' < $MacrosDir/00-Level-X-Axis > $MacroOutputPath/00-Level-X-Axis

# =========================================================================================================


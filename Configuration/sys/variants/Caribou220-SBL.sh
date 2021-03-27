#!/bin/sh

# =========================================================================================================
# definition for Caribou220- SE Thermistor - BL-Touch
# =========================================================================================================

CARIBOU_VARIANT="Caribou220- SE Thermistor - BL-Touch"
CARIBOU_NAME="Caribou220-SBL"
CARIBOU_ZHEIGHTLEVELING="Z205"
CARIBOU_ZHEIGHT="Z216.50"

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

#
# create bed.g
#

sed "
{s/#CARIBOU_VARIANT/$CARIBOU_VARIANT/};
{s/G30 P0 X25 Y105 Z-99999/G30 P0 X10 Y105 Z-99999/};
{s/G30 P1 X240 Y105 Z-99999 S2/G30 P1 X225 Y105 Z-99999 S2/};
" < ../bed.g > $SysOutputPath/bed.g

#
# create config.g
#

# general replacements
sed "
{s/#CARIBOU_VARIANT/$CARIBOU_VARIANT/};
{s/#CARIBOU_NAME/$CARIBOU_NAME/};
{s/#CARIBOU_ZHEIGHT/$CARIBOU_ZHEIGHT/};
" < ../config.g > $SysOutputPath/config.g

# replacemente SE thermistor
sed -i "
{/#CARIBOU_HOTEND_THERMISTOR/ c\
; Hotend (Mosquito or Mosquito Magnum with SE Thermistor) \\
;\\
M308 S1 P\"e0temp\" Y\"thermistor\" T500000 B4723 C1.19622e-7 A\"Nozzle\"   ; SE configure sensor 0 as thermistor on pin e0temp\\
;\\
M950 H1 C\"e0heat\" T1                                        ; create nozzle heater output on e0heat and map it to sensor 2\\
M307 H1 B0 S1.00                                            ; disable bang-bang mode for heater  and set PWM limit\\
M143 H1 S365                                                ; set temperature limit for heater 1 to 365°C
};
" $SysOutputPath/config.g

# replacements for BL-Touch
sed -i "
{/#CARIBOU_ZPROBE/ c\
; BL-Touch \\
;\\
M950 S0 C\"exp.heater3\"                                 ; sensor for BL-Touch\\
M558 P9 C\"^zprobe.in\" H2.5 F200 T8000                  ; for BL-Touch\\
M557 X90:220 Y50:205 P3                                ; define mesh grid
};
{/#CARIBOU_OFFSETS/ c\
G31 X-24.3 Y-34.1
}
" $SysOutputPath/config.g

#
# create homez and homeall
#

sed "
{s/#CARIBOU_VARIANT/$CARIBOU_VARIANT/};
{s/#CARIBOU_MEASUREPOINT/G1 X148.5 Y142.5 F3600            ; go to center of the bed/};
{/#CARIBOU_ZPROBE/ c\
M280 P0 S160                      ; BLTouch, alarm release\\
G4 P100                           ; BLTouch, delay for the release command
};
" < ../homez.g > $SysOutputPath/homez.g

sed "
{s/#CARIBOU_VARIANT/$CARIBOU_VARIANT/};
{/#CARIBOU_ZPROBE/ c\
M280 P0 S160                           ; BLTouch, alarm release\\
G4 P100                                ; BLTouch, delay for the release command
};
" < ../start.g > $SysOutputPath/start.g

# =========================================================================================================
# create macro files
# =========================================================================================================

# copy macros directory to processed folder (for BL-Touch except the Print-Surface Macros)
find $MacrosDir/* -maxdepth 0  ! \( -name "*First*" -o -name "*Preheat*" -o -name "*processed*" -o -name "*Print*" \) -exec cp -r -t  $MacroOutputPath {} \+
cp -r $MacrosDir/01-First_Layer_Calibration/processed $MacroOutputPath/01-First_Layer_Calibration
cp -r $MacrosDir/02-Preheat/processed $MacroOutputPath/02-Preheat

# create 00-Level-X-Axis
#
sed "
{s/#CARIBOU_VARIANT/$CARIBOU_VARIANT/};
{s/#CARIBOU_NAME/$CARIBOU_NAME/};
{s/#CARIBOU_ZHEIGHTLEVELING/$CARIBOU_ZHEIGHTLEVELING/}
{s/#CARIBOU_ZHEIGHT/$CARIBOU_ZHEIGHT/}
" < $MacrosDir/00-Level-X-Axis > $MacroOutputPath/00-Level-X-Axis

# =========================================================================================================


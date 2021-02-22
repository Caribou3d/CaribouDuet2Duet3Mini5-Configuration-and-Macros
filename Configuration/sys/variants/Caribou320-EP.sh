#!/bin/sh

# =========================================================================================================
# definition for Caribou320- E3d Thermistor - PINDA2
# =========================================================================================================

CARIBOU_VARIANT="Caribou320- E3d Thermistor - PINDA2"
CARIBOU_NAME="Caribou320-EP"
CARIBOU_ZHEIGHTLEVELING="Z305"
CARIBOU_ZHEIGHT="Z316.50"

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

# copy sys files to processed folder (for PINDA except deployprobe and retractprobe)
find ../* -maxdepth 0  ! \( -name "*deploy*" -o -name "*retract*" -o -name "*processed*" -o -name "*variants*" \) -exec cp  -t $SysOutputPath {} +

# create bed.g
#
sed "
{s/#CARIBOU_VARIANT/$CARIBOU_VARIANT/};
" < ../bed.g > $SysOutputPath/bed.g

# create config.g
#

sed "
{s/#CARIBOU_VARIANT/$CARIBOU_VARIANT/};
{s/#CARIBOU_NAME/$CARIBOU_NAME/};
{s/#CARIBOU_ZHEIGHT/$CARIBOU_ZHEIGHT/};
{/#CARIBOU_HOTEND_THERMISTOR/ c\
; Hotend (Mosquito or Mosquito Magnum with E3d Thermistor) \\
;\\
M308 S1 P\"e0temp\" Y\"thermistor\" T100000 B4725 C7.060000e-8 R4700 A\"Nozzle E1\"  ; E3d configure sensor 0 as thermistor on pin e0temp\\
;\\
M950 H1 C\"e0heat\" T1                                   ; create nozzle heater output on e0heat and map it to sensor 2\\
M307 H1 B0 S1.00                                       ; disable bang-bang mode for heater  and set PWM limit\\
M143 H1 S280                                           ; set temperature limit for heater 1 to 280°C
};
{/#CARIBOU_ZPROBE/ c\
; PINDA2 \\
;\\
M558 P5 C\"zprobe.in\" H1.5 F1000 T12000 A3                   ; set Z probe to PINDA2\\
M308 S2 P\"e1temp\" A\"Pinda V2\" Y\"thermistor\" T100000 B3950   ; temperature of PINDA2\\
M557 X23:235 Y5:186 S30.25:30                               ; define mesh grid
};
{/#CARIBOU_OFFSETS/ c\
G31 P1000 X23 Y5
}
" < ../config.g > $SysOutputPath/config.g

# create homez and homeall
#

sed "
{s/#CARIBOU_VARIANT/$CARIBOU_VARIANT/}
{/#CARIBOU_ZPROBE/ c\
;
};" < ../homez.g > $SysOutputPath/homez.g

sed "
{s/#CARIBOU_VARIANT/$CARIBOU_VARIANT/};
{/#CARIBOU_ZPROBE/ c\
;
};
" < ../start.g > $SysOutputPath/start.g

# =========================================================================================================
# create macro files
# =========================================================================================================

# copy macros directory to processed folder (for BL-Touch except the Print-Surface Macros)
find $MacrosDir/* -maxdepth 0  ! \( -name "*First*" -o -name "*Preheat*" -o -name "*processed*" -o -name "*Nozzle*" \) -exec cp -r -t  $MacroOutputPath {} \+
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


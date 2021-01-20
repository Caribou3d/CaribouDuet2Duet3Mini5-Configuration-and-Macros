#!/bin/sh

# =========================================================================================================
# definition for Caribou420- E3d Thermistor - SuperPINDA
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

# copy sys files to processed folder (for SuperPINDA except deployprobe and retractprobe)
find ../* -maxdepth 0  ! \( -name "*deploy*" -o -name "*retract*" -o -name "*processed*" -o -name "*variants*" \) -exec cp  -t $SysOutputPath {} +

# create config.g
#

sed '
{s/#CARIBOU_VARIANT/Caribou420- E3d Thermistor - SuperPINDA/};
{s/#CARIBOU_NAME/Caribou420-ESP/};
{s/#CARIBOU_ZHEIGHT/Z416.50/};
{/#CARIBOU_HOTEND_THERMISTOR/ c\
; Hotend (Mosquito or Mosquito Magnum with E3d Thermistor) \
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
M558 P5 C"zprobe.in" H1.5 F1000 T12000 A3                   ; set Z probe to SuperPINDA\
M557 X23:235 Y5:186 S30.25:30                               ; define mesh grid
};
{/#CARIBOU_OFFSETS/ c\
G31 P1000 X23 Y5
}
' < ../config.g > $SysOutputPath/config.g

# create homez and homeall
#

sed '
{s/#CARIBOU_VARIANT/Caribou420- E3d Thermistor - SuperPINDA/}
' < ../homeall.g > $SysOutputPath/homeall.g

sed '
{s/#CARIBOU_VARIANT/Caribou420- E3d Thermistor - SuperPINDA/}
' < ../homez.g > $SysOutputPath/homez.g

# =========================================================================================================
# create macro files
# =========================================================================================================

# copy macros directory to processed folder
find $MacrosDir/* -maxdepth 0  ! \( -name "*Preheat*" -o -name "*processed*" -o -name "04-Nozzle*"  \) -exec cp -r -t  $MacroOutputPath {} \+
cp -r $MacrosDir/02-Preheat/processed $MacroOutputPath/02-Preheat

# create 00-Level-X-Axis
#
sed '
{s/#CARIBOU_VARIANT/Caribou420- E3d Thermistor - SuperPINDA/};
{s/#CARIBOU_NAME/Caribou420-ESP/};
{s/#CARIBOU_ZHEIGHTLEVELING/Z405/}
{s/#CARIBOU_ZHEIGHT/Z416.50/}
' < $MacrosDir/00-Level-X-Axis > $MacroOutputPath/00-Level-X-Axis

# =========================================================================================================


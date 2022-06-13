#!/bin/sh

# =========================================================================================================
# definition for Caribou220 Duet2-WiFi-Ethernet LGX Mosquito - E3d or SE Thermistor - PINDA2
# =========================================================================================================

CARIBOU_VARIANT="Caribou220 Duet2-WiFi-Ethernet LGX Mosquito - E3d or SE Thermistor - PINDA2"
CARIBOU_NAME="Caribou220-LGXM09-NP"
CARIBOU_ZHEIGHTLEVELING="Z205"
CARIBOU_ZHEIGHT="Z216.50"
CARIBOU_EESTEPS=800.00
CARIBOU_INITIALLOAD=90
CARIBOU_FINALUNLOAD=95
CARIBOU_MINEXTRUDETEMP=180
CARIBOU_MINRETRACTTEMP=180

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
find ../* -maxdepth 0  ! \( -name "*deploy*" -o -name "*retract*" -o -name "*processed*" -o -name "*variants*" \) -exec cp  -rt $SysOutputPath {} +
cp -r ../00-Functions $SysOutputPath

#
# create bed.g
#

sed "
{s/#CARIBOU_VARIANT/$CARIBOU_VARIANT/};
{/#CARIBOU_ZPROBERESET/ c\
M558 F600 T8000 A3 S0.03                               ; for PINDA2
};
" < ../bed.g > $SysOutputPath/bed.g

#
# create config.g
#

# general replacements
sed "
{s/#CARIBOU_VARIANT/$CARIBOU_VARIANT/};
{s/#CARIBOU_NAME/$CARIBOU_NAME/};
{s/#CARIBOU_ZHEIGHT/$CARIBOU_ZHEIGHT/};
{s/#CARIBOU_EESTEPS/$CARIBOU_EESTEPS/};
{s/#CARIBOU_MINEXTRUDETEMP/$CARIBOU_MINEXTRUDETEMP/};
{s/#CARIBOU_MINRETRACTTEMP/$CARIBOU_MINRETRACTTEMP/};
" < ../config.g > $SysOutputPath/config.g

# replacements for motor currents
sed -i "
{/#CARIBOU_MOTOR_CURRENTS/ c\
M906 X1250 Y1250 Z650 E650 I40                         ; set motor currents (mA) and motor idle factor in percent
};
" $SysOutputPath/config.g

# replacements for E3d thermistor
sed -i "
{/#CARIBOU_HOTEND_THERMISTOR/ c\
; Hotend (Mosquito or Mosquito Magnum with E3d Thermistor) \\
;\\
M308 S1 P\"e0temp\" Y\"thermistor\" T100000 B4725 C7.060000e-8 A\"Nozzle E1\"  ; E3d configure sensor 0 as thermistor on pin e0temp\\
;\\
M950 H1 C\"e0heat\" T1                                   ; create nozzle heater output on e0heat and map it to sensor 1\\
M307 H1 B0 S1.00                                       ; disable bang-bang mode for heater 1 and set PWM limit\\
M143 H1 S280                                           ; set temperature limit for heater 1 to 280°C
};
" $SysOutputPath/config.g

# replacements for PINDA2
sed -i "
{/#CARIBOU_ZPROBE/ c\
; PINDA2 \\
;\\
M558 P5 C\"^zprobe.in\" H1.5 F600 T8000 A3 S0.03              ; set z probe to PINDA2\\
M308 S2 P\"e1temp\" A\"Pinda V2\" Y\"thermistor\" T100000 B3950   ; temperature of PINDA2\\
M557 X23:235 Y5:186 S30.25:30                               ; define mesh grid
};
{/#CARIBOU_OFFSETS/ c\
G31 P1000 X23 Y5
}
" $SysOutputPath/config.g

#
# create homez and homeall
#

sed "
{s/#CARIBOU_VARIANT/$CARIBOU_VARIANT/}
{s/#CARIBOU_MEASUREPOINT/G1 X11.5 Y4.5 F6000                                    ; go to first probe point/};
{/#CARIBOU_ZPROBE/ c\
;
};" < ../homez.g > $SysOutputPath/homez.g

sed "
{s/#CARIBOU_VARIANT/$CARIBOU_VARIANT/};
{/#CARIBOU_ZPROBE/ c\
;
};
" < ../start.g > $SysOutputPath/start.g

#
# create trigger2.g
#

sed "
{s/#CARIBOU_MINEXTRUDETEMP/$CARIBOU_MINEXTRUDETEMP/};
{s/#CARIBOU_MINRETRACTTEMP/$CARIBOU_MINRETRACTTEMP/};
{s/#CARIBOU_INITIALLOAD/$CARIBOU_INITIALLOAD/g}
" < ../trigger2.g > $SysOutputPath/trigger2.g

# =========================================================================================================
# create macro files
# =========================================================================================================

# copy macros directory to processed folder
find $MacrosDir/* -maxdepth 0  ! \( -name "*Main*" -o -name "05-BL-Touch" -o -name "*Preheat*" -o -name "*processed*"  \) -exec cp -r -t  $MacroOutputPath {} \+

mkdir $MacroOutputPath/04-Maintenance
find $MacrosDir/04-Maintenance/* -maxdepth 0  ! \( -name "*First*" \) -exec cp -r -t  $MacroOutputPath/04-Maintenance {} \+
cp -r $MacrosDir/04-Maintenance/01-First_Layer_Calibration/processed $MacroOutputPath/04-Maintenance/01-First_Layer_Calibration
cp -r $MacrosDir/00-Preheat_Extruder/processed $MacroOutputPath/00-Preheat_Extruder

# create 00-Test_Homing
#
sed "
{s/#CARIBOU_VARIANT/$CARIBOU_VARIANT/};
{s/#CARIBOU_MEASUREPOINT/G1 X11.5 Y4.5 F6000               ; go to first probe point/};
{/#CARIBOU_ZPROBE/ c\
;
};
" < $MacrosDir/04-Maintenance/00-Self_Tests/00-Test_Homing > $MacroOutputPath/04-Maintenance/00-Self_Tests/00-Test_Homing

# create 01-Level-X-Axis
#
sed "
{s/#CARIBOU_VARIANT/$CARIBOU_VARIANT/};
{s/#CARIBOU_NAME/$CARIBOU_NAME/};
{s/#CARIBOU_ZHEIGHTLEVELING/$CARIBOU_ZHEIGHTLEVELING/}
{s/#CARIBOU_ZHEIGHT/$CARIBOU_ZHEIGHT/}
" < $MacrosDir/04-Maintenance/00-Self_Tests/01-Level_X-Axis > $MacroOutputPath/04-Maintenance/00-Self_Tests/01-Level_X-Axis

# create Load_Filament
#
sed "
{s/#CARIBOU_VARIANT/$CARIBOU_VARIANT/};
{s/#CARIBOU_MINEXTRUDETEMP/$CARIBOU_MINEXTRUDETEMP/};
{s/#CARIBOU_MINRETRACTTEMP/$CARIBOU_MINRETRACTTEMP/};
{s/#CARIBOU_INITIALLOAD/$CARIBOU_INITIALLOAD/g}
" < $MacrosDir/01-Filament_Handling/00-Load_Filament > $MacroOutputPath/01-Filament_Handling/00-Load_Filament

# create Unload_Filament
#
sed "
{s/#CARIBOU_VARIANT/$CARIBOU_VARIANT/};
{s/#CARIBOU_MINEXTRUDETEMP/$CARIBOU_MINEXTRUDETEMP/};
{s/#CARIBOU_MINRETRACTTEMP/$CARIBOU_MINRETRACTTEMP/};
{s/#CARIBOU_FINALUNLOAD/$CARIBOU_FINALUNLOAD/g}
" < $MacrosDir/01-Filament_Handling/01-Unload_Filament > $MacroOutputPath/01-Filament_Handling/01-Unload_Filament

# create Change_Filament
#
sed "
{s/#CARIBOU_VARIANT/$CARIBOU_VARIANT/};
{s/#CARIBOU_MINEXTRUDETEMP/$CARIBOU_MINEXTRUDETEMP/};
{s/#CARIBOU_MINRETRACTTEMP/$CARIBOU_MINRETRACTTEMP/};
{s/#CARIBOU_INITIALLOAD/$CARIBOU_INITIALLOAD/g}
{s/#CARIBOU_FINALUNLOAD/$CARIBOU_FINALUNLOAD/g}
" < $MacrosDir/01-Filament_Handling/03-Change_Filament > $MacroOutputPath/01-Filament_Handling/03-Change_Filament

# =========================================================================================================

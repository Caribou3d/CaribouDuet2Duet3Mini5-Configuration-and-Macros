#!/bin/sh

# =========================================================================================================
# definition for Caribou420 Duet2-WiFi-Ethernet LGX Mosquito - E3d or SE Thermistor - SuperPINDA
# =========================================================================================================
#
DUETBOARD=$1
#
if [ "$DUETBOARD" = "DUET2" ]; then
    CARIBOU_VARIANT="Caribou420 Duet2 WiFi\/Ethernet LGX Mosquito - E3d or SE Thermistor - SuperPINDA"
    DUETBOARDNAME="Duet2"
else
    CARIBOU_VARIANT="Caribou420 Duet3Mini5+ WiFi\/Ethernet LGX Mosquito - E3d or SE Thermistor - SuperPINDA"
    DUETBOARDNAME="Duet3Mini5+ "
fi
#
CARIBOU_NAME="Caribou420-LGXM18-NSP"
CARIBOU_ZHEIGHTLEVELING="Z405"
CARIBOU_ZHEIGHT="Z416.50"
CARIBOU_EESTEPS=400.00
CARIBOU_INITIALLOAD=85
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

# copy sys files to processed folder (for SuperPINDA except deployprobe and retractprobe)
find ../* -maxdepth 0  ! \( -name "*deploy*" -o -name "*retract*" -o -name "*processed*" -o -name "*variants*" \) -exec cp  -rt $SysOutputPath {} +
cp -r ../00-Functions $SysOutputPath
#
# replacements in functions
#
if [ "$DUETBOARD" = "DUET2" ]; then
# Duet 2
sed -i "
{/#CARIBOU_ENABLE_FILAMENT_SENSOR/ c\
M591 D0 P2 C\"e0stop\" S1                                                ; filament runout sensor
};
" $SysOutputPath/00-Functions/RunOutOn
else
sed -i "
{/#CARIBOU_ENABLE_FILAMENT_SENSOR/ c\
M591 D0 P2 C\"io2.in\" S1                                                ; filament runout sensor
};
" $SysOutputPath/00-Functions/RunOutOn
fi

if [ "$DUETBOARD" = "DUET2" ]; then
# Duet 2
sed -i "
{/#CARIBOU_DISABLE_FILAMENT_SENSOR/ c\
\        M591 D0 P0 C\"e0stop\" S1                                        ; disable filament runout sensor
};
" $SysOutputPath/00-Functions/RunOutOff
else
sed -i "
{/#CARIBOU_DISABLE_FILAMENT_SENSOR/ c\
\        M591 D0 P0 C\"io2.in\" S0                                        ; disable filament runout sensor
};
" $SysOutputPath/00-Functions/RunOutOff
fi

if [ "$DUETBOARD" = "DUET2" ]; then
# Duet 2
sed -i "
{/#CARIBOU_TRIGGER/ c\
M950 J1 C\"e0stop\"                                                      ; input 1 e0 filament sensor
};
" $SysOutputPath/00-Functions/TriggerOn
else
sed -i "
{/#CARIBOU_TRIGGER/ c\
M950 J1 C\"io2.in\"                                                      ; input 1 e0 filament sensor
};
" $SysOutputPath/00-Functions/TriggerOn
fi
#
# create current-sense-homing.g
#
if [ "$DUETBOARD" = "DUET2" ]; then
# Duet 2
sed "
{/#CARIBOU_SENSE_HOMING/ c\
M915 X S2 F0 H400 R0                                                   ; set the x axis sensitivity\\
M915 Y S2 F0 H400 R0                                                   ; set the y axis sensitivity\\
M913 X40 Y40 Z60                                                       ; set the x, y, and z drivers current percentage for non-print moves, per config.g
};
" < ../current-sense-homing.g > $SysOutputPath/current-sense-homing.g
else
sed "
{/#CARIBOU_SENSE_HOMING/ c\
M569 P0.1 V10                                                          ; reduce V to ensure stealthChop is enabled for x\\
M569 P0.2 V10                                                          ; reduce V to ensure stealthChop is enabled for y\\
M913 X30 Y30                                                           ; drop motor current to 30%\\
G4 P100                                                                ; wait 100ms\\
;\\
; tune drivers\\
;\\
G91                                                                    ; relative positioning\\
G1 H2 X0.2 Y0.2 F3000                                                  ; power up motors to ensure they are not stalled\\
G4 P100                                                                ; wait 100ms\\
M400                                                                   ; wait for current moves to finish\\
G1 H2 X-0.2 Y-0.2 F3000                                                ; go back to the original position
};
" < ../current-sense-homing.g > $SysOutputPath/current-sense-homing.g
fi
#
# create bed.g
#
sed "
{s/#CARIBOU_VARIANT/$CARIBOU_VARIANT/};
{/#CARIBOU_ZPROBERESET/ c\
M558 F600 T8000 A3 S0.03                                               ; for SuperPINDA
};
" < ../bed.g > $SysOutputPath/bed.g
#
# create config.g
#
# determine PRINTERNAME string
#
PRINTERNAME=$(printf "%s%*s%s" "M550 P\"$CARIBOU_NAME\"" $((63-${#CARIBOU_NAME})) '' "; set printer name")
#
# general replacements
#
sed "
{s/#DUETBOARDNAME/$DUETBOARDNAME/};
{s/#CARIBOU_VARIANT/$CARIBOU_VARIANT/};
{s/#CARIBOU_NAME/$PRINTERNAME/};
{s/#CARIBOU_ZHEIGHT/$CARIBOU_ZHEIGHT/};
{s/#CARIBOU_EESTEPS/$CARIBOU_EESTEPS/};
{s/#CARIBOU_MINEXTRUDETEMP/$CARIBOU_MINEXTRUDETEMP/};
{s/#CARIBOU_MINRETRACTTEMP/$CARIBOU_MINRETRACTTEMP/};
" < ../config.g > $SysOutputPath/config.g

# replacements for drives
if [ "$DUETBOARD" = "DUET2" ]; then
# Duet 2
sed -i "
{/#CARIBOU_DRIVES/ c\
M569 P0 S0 F11                                                         ; physical drive 0 goes backwards - x axis\\
M569 P1 S0 F8 Y3:2                                                     ; physical drive 1 goes backwards - y axis\\
M569 P2 S0 F10                                                         ; physical drive 2 goes backwards - z axis left\\
M569 P3 S1 F14                                                         ; physical drive 3 goes forwards  - extruder\\
M569 P4 S0 F10                                                         ; physical drive 4 goes backwards - z axis right\\
;\\
; motor configuration\\
;\\
M584 X0 Y1 Z2:4 E3                                                     ; set drive mapping\\
M671 X-36.5:293.5 Y0:0 S1.00                                           ; leadscrews at left (connected to Z/drive 2) and right (connected to E1/drive 4) of x axis
};
" $SysOutputPath/config.g
else
sed -i "
{/#CARIBOU_DRIVES/ c\
M569 P0.0 S0 D3 V1000                                                  ; physical drive 0.0 goes backwards - z axis left\\
M569 P0.1 S0 D3 V2000                                                  ; physical drive 0.1 goes backwards - x axis\\
M569 P0.2 S0 D3 V2000                                                  ; physical drive 0.2 goes backwards - y axis\\
M569 P0.3 S0 D3 V1000                                                  ; physical drive 0.3 goes backwards - z axis right\\
M569 P0.4 D3 V1000                                                     ; physical drive 0.4 goes forwards  - extruder\\
;\\
; motor configuration\\
;\\
M584 X0.1 Y0.2 Z0.0:0.3 E0.4                                           ; set drive mapping\\
M671 X-36.5:293.5 Y0:0 S1.00                                           ; leadscrews at left (connected to drive 0) and right (connected to drive 3) of x axis
};
" $SysOutputPath/config.g
fi

# replacements for motor currents
sed -i "
{/#CARIBOU_MOTOR_CURRENTS/ c\
M906 X1250 Y1250 Z650 E650 I40                                         ; set motor currents (mA) and motor idle factor in percent
};
" $SysOutputPath/config.g

# replacements for stallguard sensitivy
if [ "$DUETBOARD" = "DUET2" ]; then
# Duet 2
sed -i "
{/#CARIBOU_STALLGUARD/ c\
M915 X S2 F0 H400 R0                                                   ; set x axis sensitivity\\
M915 Y S1 F0 H400 R0                                                   ; set y axis sensitivity\\
M915 Z S0 F0 H200 R0                                                   ; set z axis sensitivity
};
" $SysOutputPath/config.g
else
sed -i "
{/#CARIBOU_STALLGUARD/ c\
M915 X S1 F0 H200 R0                                                   ; set x axis sensitivity\\
M915 Y S1 F0 H200 R0                                                   ; set y axis sensitivity\\
M915 Z S1 F0 H200 R0                                                   ; set z axis sensitivity
};
" $SysOutputPath/config.g
fi
# replacements for E3d thermistor
if [ "$DUETBOARD" = "DUET2" ]; then
# Duet 2
sed -i "
{/#CARIBOU_HOTEND_THERMISTOR/ c\
; hotend (Mosquito or Mosquito Magnum with E3d Thermistor)\\
;\\
M308 S1 P\"e0temp\" Y\"thermistor\" T100000 B4725 C7.060000e-8 A\"Nozzle E1\"; E3d configure sensor 0 as thermistor on pin e0temp\\
;\\
M950 H1 C\"e0heat\" T1                                                   ; create nozzle heater output on e0heat and map it to sensor 1\\
M307 H1 B0 S1.00                                                       ; disable bang-bang mode for heater 1 and set PWM limit\\
M143 H1 S280                                                           ; set temperature limit for heater 1 to 280°C
};
" $SysOutputPath/config.g
else
sed -i "
{/#CARIBOU_HOTEND_THERMISTOR/ c\
; hotend (Mosquito or Mosquito Magnum with E3d Thermistor)\\
;\\
M308 S1 P\"temp1\" Y\"thermistor\" T100000 B4725 C7.060000e-8 A\"Nozzle E1\" ; E3d configure sensor 0 as thermistor on pin e0temp\\
;\\
M950 H1 C\"out1\" T1                                                     ; create nozzle heater output on e0heat and map it to sensor 1\\
M307 H1 B0 S1.00                                                       ; disable bang-bang mode for heater 1 and set PWM limit\\
M143 H1 S280                                                           ; set temperature limit for heater 1 to 280°C
};
" $SysOutputPath/config.g
fi

# replacements for SuperPINDA
if [ "$DUETBOARD" = "DUET2" ]; then
# Duet 2
sed -i "
{/#CARIBOU_ZPROBE/ c\
; SuperPINDA\\
;\\
M558 P5 C\"^zprobe.in\" H1.5 F600 T8000 A3 S0.03                         ; set z probe to SuperPINDA\\
M557 X23:235 Y5:186 S30.25:30                                          ; define mesh grid
};
{/#CARIBOU_OFFSETS/ c\
G31 P1000 X23 Y5
}
" $SysOutputPath/config.g
else
sed -i "
{/#CARIBOU_ZPROBE/ c\
; SuperPINDA\\
;\\
M558 P5 C\"^io1.in\" H1.5 F600 T8000 A3 S0.03                            ; set z probe to SuperPINDA\\
M557 X23:235 Y5:186 S30.25:30                                          ; define mesh grid
};
{/#CARIBOU_OFFSETS/ c\
G31 P1000 X23 Y5
}
" $SysOutputPath/config.g
fi

# replacements for the heat bed
if [ "$DUETBOARD" = "DUET2" ]; then
# Duet 2
sed -i "
{/#CARIBOU_HEATBED/ c\
M308 S0 P\"bedtemp\" Y\"thermistor\" T100000 B4138 R4700 A\"Bed\"            ; configure sensor 0 as thermistor on pin bedtemp\\
M950 H0 C\"bedheat\" Q50 T0                                              ; create bed heater output on bedheat and map it to sensor 0\\
M143 H0 S110                                                           ; set temperature limit for heater 0 to 110°C\\
M307 H0 B0 S1.00                                                       ; disable bang-bang mode for the bed heater and set PWM limit\\
M140 H0                                                                ; map heated bed to heater 0
};
" $SysOutputPath/config.g
else
# Duet 3Mini5+
sed -i "
{/#CARIBOU_HEATBED/ c\
M308 S0 P\"temp0\" Y\"thermistor\" T100000 B4138 A\"Bed\"                    ; configure sensor 0 as thermistor on pin bedtemp\\
M950 H0 C\"out0\" Q50 T0                                                 ; create bed heater output on bedheat and map it to sensor 0\\
M143 H0 S110                                                           ; set temperature limit for heater 0 to 110°C\\
M307 H0 B0 S1.00                                                       ; disable bang-bang mode for the bed heater and set PWM limit\\
M140 H0                                                                ; map heated bed to heater 0
};
" $SysOutputPath/config.g
fi

# replacements for fans
if [ "$DUETBOARD" = "DUET2" ]; then
# Duet 2
sed -i "
{/#CARIBOU_FANS/ c\
; radial fan\\
;\\
M950 F0 C\"fan0\" Q160                                                   ; create fan 0 on pin fan1 and set its frequency\\
M106 P0 S0 H-1                                                         ; set fan 0 value. Thermostatic control is turned off\\
;\\
; extruder fan (temperature controlled)\\
;\\
M950 F1 C\"fan1\" Q500                                                   ; create fan 1 on pin fan0 and set its frequency\\
M106 P1 H1 T45                                                         ; fan turns on at 45°C
};
" $SysOutputPath/config.g
else
# Duet 3Mini5+
sed -i "
{/#CARIBOU_FANS/ c\
; extruder fan (temperature controlled)\\
;\\
M950 F1 C\"out5\" Q500                                                   ; create fan 1 on pin fan0 and set its frequency\\
M106 P1 H1 T45                                                         ; set fan 2 value. Thermostatic control is turned on\\
;\\
; radial fan\\
;\\
M950 F0 C\"out6\" Q25                                                    ; create fan 0 on pin fan1 and set its frequency\\
M106 P0 S0 H-1                                                         ; set fan 0 value. Thermostatic control is turned off
};
" $SysOutputPath/config.g
fi

#
# create homez and homeall
#

sed "
{s/#CARIBOU_VARIANT/$CARIBOU_VARIANT/}
{s/#CARIBOU_MEASUREPOINT/G1 X11.5 Y4.5 F6000                                                    ; go to first probe point/};
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
{s/#CARIBOU_MEASUREPOINT/G1 X11.5 Y4.5 F6000                                                    ; go to first probe point/};
{/#CARIBOU_ZPROBE/ c\
;
};
" < $MacrosDir/04-Maintenance/00-Self_Tests/00-Test_Homing > $MacroOutputPath/04-Maintenance/00-Self_Tests/00-Test_Homing

# create 01-Level-X-Axis
#
sed "
{s/#CARIBOU_VARIANT/$CARIBOU_VARIANT/};
{s/#CARIBOU_ZHEIGHTLEVELING/$CARIBOU_ZHEIGHTLEVELING/};
{s/#CARIBOU_ZHEIGHT/$CARIBOU_ZHEIGHT/}
" < $MacrosDir/04-Maintenance/00-Self_Tests/01-Level_X-Axis > $MacroOutputPath/04-Maintenance/00-Self_Tests/01-Level_X-Axis

# create 02-Measure_Axes-Length
#
sed "
{s/#CARIBOU_VARIANT/$CARIBOU_VARIANT/};
{s/#CARIBOU_ZHEIGHTLEVELING/$CARIBOU_ZHEIGHTLEVELING/};
{s/#CARIBOU_ZHEIGHT/$CARIBOU_ZHEIGHT/}
" < $MacrosDir/04-Maintenance/00-Self_Tests/02-Measure_Axes-Length > $MacroOutputPath/04-Maintenance/00-Self_Tests/02-Measure_Axes-Length

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
{s/#CARIBOU_INITIALLOAD/$CARIBOU_INITIALLOAD/g};
{s/#CARIBOU_FINALUNLOAD/$CARIBOU_FINALUNLOAD/g}
" < $MacrosDir/01-Filament_Handling/03-Change_Filament > $MacroOutputPath/01-Filament_Handling/03-Change_Filament

# =========================================================================================================

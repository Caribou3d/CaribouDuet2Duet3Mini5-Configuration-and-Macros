#!/bin/bash

# =========================================================================================================
#
# sort script to sort Configuration and macro files for CaribouDuet
#
# sort order: height -> thermistor -> z-Probe
#
# usage: ./sort startath targetpath
#
#
# Change log:
# 12 Jan 2021, wschadow, initial version
# 22 May 2021, wschadow, updated for new thermistor naming convention
#
# =========================================================================================================

# Set arrays for script

# Array of printers
Printer_Name="CaribouDuet"

# Array of Heights
declare -a HeightsArray=(220 320 420)
# Array of Thermistors
declare -a ThermistorsArray=(E3d-SE SE-HT)
# Array of Sensors
declare -a SensorArray=(PINDA2 SUPERPINDA BL_TOUCH_LEFT BL_TOUCH_RIGHT)
# Main script

if [ -z "$1" ] ; then
    Start_Path="."
else
    Start_Path=$1
fi

if [ -z "$2" ] ; then
    Destination_Path="."
else
    Destination_Path=$2
fi

Destination_Path_zip=$Destination_Path"zip/"
Destination_Path_orig=$Destination_Path"orig/"


echo "Start Path     : "$Start_Path
echo "Dest. Path-zip : "$Destination_Path_zip
echo "Dest. Path-orig: "$Destination_Path_orig

for HEIGHT in ${HeightsArray[@]}; do
    for THERMISTOR in ${ThermistorsArray[@]}; do
        case $THERMISTOR in
                E3d-SE)
                THERMISTOR_SHORT='N'
            ;;
                SE-HT)
                THERMISTOR_SHORT='H'
            ;;
        esac
        for SENSOR_TYPE in ${SensorArray[@]}; do
            case $SENSOR_TYPE in
                        PINDA2)
                        SENSOR_SHORT='P'
                    ;;
                        SUPERPINDA)
                        SENSOR_SHORT='SP'
                    ;;
                        BL_TOUCH_LEFT)
                        SENSOR_SHORT='BLL'
                    ;;
                        BL_TOUCH_RIGHT)
                        SENSOR_SHORT='BLR'
                    ;;
            esac
            mkdir -p $Destination_Path_zip/$Printer_Name$HEIGHT/$THERMISTOR/$SENSOR_TYPE
            find -L $Start_Path -name "*$HEIGHT-$THERMISTOR_SHORT$SENSOR_SHORT-Build*.zip" -type f -not -path "$Destination_Path_zip/$Printer_Name$HEIGHT/$THERMISTOR/$SENSOR_TYPE/*" -exec mv {} $Destination_Path_zip/$Printer_Name$HEIGHT/$THERMISTOR/$SENSOR_TYPE \;
            find -L $Start_Path -name "*$HEIGHT-LGXC-$THERMISTOR_SHORT$SENSOR_SHORT-Build*.zip" -type f -not -path "$Destination_Path_zip/$Printer_Name$HEIGHT/$THERMISTOR/$SENSOR_TYPE/*" -exec mv {} $Destination_Path_zip/$Printer_Name$HEIGHT/$THERMISTOR/$SENSOR_TYPE \;
            find -L $Start_Path -name "*$HEIGHT-LGXM-$THERMISTOR_SHORT$SENSOR_SHORT-Build*.zip" -type f -not -path "$Destination_Path_zip/$Printer_Name$HEIGHT/$THERMISTOR/$SENSOR_TYPE/*" -exec mv {} $Destination_Path_zip$Printer_Name$HEIGHT/$THERMISTOR/$SENSOR_TYPE \;
            mkdir -p $Destination_Path_orig/$Printer_Name$HEIGHT/$THERMISTOR/$SENSOR_TYPE
            find -L $Start_Path -name "*$HEIGHT-$THERMISTOR_SHORT$SENSOR_SHORT-Build*." -type f "$Destination_Path_orig/$Printer_Name$HEIGHT/$THERMISTOR/$SENSOR_TYPE/*" -exec mv {} $Destination_Path_orig/$Printer_Name$HEIGHT/$THERMISTOR/$SENSOR_TYPE \;
        done
    done
done

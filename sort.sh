#!/bin/bash

##################################################################


# Set arrays for script

# Array of printers
Printer_Name="CaribouDuet" 

# Array of Heights
declare -a HeightsArray=( 220 320 420)
# Array of Thermistors
declare -a ThermistorsArray=(E3d SE)
# Array of Sensors
declare -a SensorArray=(PINDA2 SUPERPINDA BL_TOUCH) 
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

echo "Start Path: "$Start_Path
echo "Dest. Path: "$Destination_Path

for HEIGHT in ${HeightsArray[@]}; do
	for THERMISTOR in ${ThermistorsArray[@]}; do
		case $THERMISTOR in 
				E3d)
				THERMISTOR_SHORT='E'
			;;
				SE)
				THERMISTOR_SHORT='S'
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
						BL_TOUCH)
						SENSOR_SHORT='BL'
					;;
			esac

			mkdir -p $Destination_Path/$Printer_Name$HEIGHT/$THERMISTOR/$SENSOR_TYPE
			find -L $Start_Path -name "*$HEIGHT-$THERMISTOR_SHORT$SENSOR_SHORT-Build*.zip" -type f -not -path "$Destination_Path/$Printer_Name$HEIGHT/$THERMISTOR/$SENSOR_TYPE/*" -exec cp {} $Destination_Path/$Printer_Name$HEIGHT/$THERMISTOR/$SENSOR_TYPE \;
		done
	done
done

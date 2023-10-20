#!/bin/bash
#
# =========================================================================================================
#
# This bash script is used to generate the CaribouDuet configuration and macro files
# for the Duet2WiFi and Duet3Mini5+ boards automatically
#
# Supported OS: Windows 10, Linux64 bit
#
# Change log:
# 12 Jan 2021, wschadow, initial version
# 14 Jan 2021, wschadow, added generation of filament files
# 17 Jan 2021, wschadow, simplified OUTPUT_PATHs
# 17 Jan 2021, wschadow, added generation of preheat macros
# 19 Jan 2021, wschadow, updated output information and version information
# 19 Jan 2021, wschadow, restructered the scripts, variant scripts now generate sys and macros, CC-build zips them
# 20 Jan 2021, wschadow, added Nozzle_handling macros for BL-Touch Versions
# 22 Jan 2021, wschadow, added macros for first layer calibration
# 24 Jan 2021, wschadow, added generation for filament dependant files for first layer calibration
# 30 Jan 2021, wschadow, added copying of sample gcodes
# 17 Feb 2021, wschadow, distinguish zip commands for different OS
# 22 Feb 2021, wschadow, added generation of .g file that display the version and build number
# 15 Mar 2021, wschadow, updated path of macros for displaying current version
# 22 May 2021, wschadow, updated path of macros
# 28 May 2021, wschadow, added generation of SlicerScripts.zip
# 01 Jun 2021, wschadow, included all subdirectories of SlicerScripts
# 02 Jun 2021, wschadow, corrected zip command for SlicerScripts to include Porfiles and exclude processed folder
# 13 Jun 2021, wschadow, changed output path to avoid collisions with Duet3Mini5+ version
# 31 Jul 2021, wschadow, added www, and driver, full content of SD-card is generated
# 31 Jul 2021, wschadow, when all configurations are build, the output will be sorted
# 11 Jun 2022, wschadow, added a counter, added generation of a zip for all configurations
# 20 Jun 2022, wschadow, added selection of the board
# 12 Jan 2023, wschadow, updated generation of temperature files, added info on build no
# 17 Jan 2023, wschadow, updated generation of temperature files
# 18 Jan 2023, wschadow, added generation of files for preheating bed
# 20 Jan 2023, wschadow, added option for cleaning up only (usage: ./CC-build.sh clean)
# 17 Oct 2023, wschadow, generation of preheat folder removed
#
# Copyright Caribou Research & Development 2021. Licensed under GPL3. Non-commercial use only.
# Source code and release notes are available on github: https://github.com/Caribou3d/CaribouDuet2-ConfigurationMacros
#
# =========================================================================================================
#
#### Start check if OSTYPE is supported
OS_FOUND=$( command -v uname)
case $( "${OS_FOUND}" | tr '[:upper:]' '[:lower:]') in
  linux*)
    TARGET_OS="linux"
   ;;
  msys*|cygwin*|mingw*)
    # or possible 'bash on windows'
    TARGET_OS='windows'
   ;;
  nt|win*)
    TARGET_OS='windows'
    ;;
  *)
    TARGET_OS='unknown'
    ;;
esac
# Windows
if [ $TARGET_OS == "windows" ]; then
    if [ $(uname -m) == "x86_64" ]; then
        echo "$(tput setaf 2)Windows 64-bit found$(tput sgr0)"
        Processor="64"
    elif [ $(uname -m) == "i386" ]; then
        echo "$(tput setaf 2)Windows 32-bit found$(tput sgr0)"
        Processor="32"
    fi
# Linux
elif [ $TARGET_OS == "linux" ]; then
    if [ $(uname -m) == "x86_64" ]; then
        echo "$(tput setaf 2)Linux 64-bit found$(tput sgr0)"
        Processor="64"
    elif [[ $(uname -m) == "i386" || $(uname -m) == "i686" ]]; then
        echo "$(tput setaf 2)Linux 32-bit found$(tput sgr0)"
        Processor="32"
    elif [ $(uname -m) == "aarch64" ]; then
        echo "$(tput setaf 2)Linux aarch64 bit found$(tput sgr0)"
        Processor="aarch64"
    fi
else
    echo "$(tput setaf 1)This script doesn't support your Operating system!"
    echo "Please use Linux 64-bit or Windows 10 64-bit with Linux subsystem / git-bash"
    echo "Read the notes of build.sh$(tput sgr0)"
    exit 1
fi
#sleep 2
#### End check if OSTYPE is supported
# Check for zip
if ! type zip > /dev/null; then
    if [ $TARGET_OS == "windows" ]; then
        echo "$(tput setaf 1)Missing 'zip' which is important to run this script"
        echo "Download and install 7z-zip from its official website https://www.7-zip.org/"
        echo "By default, it is installed under the directory /c/Program Files/7-Zip in Windows 10 as my case."
        echo "Run git Bash under Administrator privilege and"
        echo "navigate to the directory /c/Program Files/Git/mingw64/bin,"
        echo "you can run the command $(tput setaf 2)ln -s /c/Program Files/7-Zip/7z.exe zip.exe$(tput sgr0)"
        exit 3
    elif [ $TARGET_OS == "linux" ]; then
        echo "$(tput setaf 1)Missing 'zip' which is important to run this script"
        echo "install it with the command $(tput setaf 2)'sudo apt-get install zip'$(tput sgr0)"
        exit 3
    fi
fi
#### Set build environment
BUILD_ENV="0.1"
SCRIPT_PATH="$( cd "$(dirname "$0")" ; pwd -P )"
# List few useful data
echo
echo "Script path :" $SCRIPT_PATH
echo "OS          :" $OS
echo ""

#
# =========================================================================================================

# set output paths
#
FILAMENTPATH=$SCRIPT_PATH/Configuration/filaments
FILAMENTOUTPUT=$FILAMENTPATH/processed
#
# =========================================================================================================

# clean-up working directory

echo ' cleaning working directory ... '
rm -fr $FILAMENTOUTPUT
echo ' ... done'
echo

# clean-up working directory only

if [ -z "$2" ] ; then
    if [ "$1" == "clean" ] ; then
        exit
    fi
fi

#
# =========================================================================================================
#

# Get Commit_Number
GIT_COMMIT_NUMBER=$(git rev-list HEAD --count)
# Find firmware version in config.g file and use it to generate the output folder
CCDOT=$(grep --max-count=1 "\bRelease\b" $SCRIPT_PATH/Configuration/sys/config.g | sed -e's/  */ /g'|cut -d '"' -f2)
CC=$(echo $CCDOT | sed 's/\.//g' )
# Find build version in config.g file and use it to generate the output folder
BUILD=$(grep --max-count=1 "\bBuild\b" $SCRIPT_PATH/Configuration/sys/config.g | sed -e's/  */ /g'|cut -d ' ' -f4)
if [ "$BUILD" == "$GIT_COMMIT_NUMBER" ] ; then
    echo "CC_COMMIT in config.g is identical to current git commit number: $BUILD"
else
    echo "$(tput setaf 5)CC_COMMIT $BUILD in config.g is DIFFERENT to current git commit number $GIT_COMMIT_NUMBER. To cancel this process press CRTL+C and update the CC_COMMIT value.$(tput sgr0)"
    if [ -z "$ALL_VARIANTS" ]; then
        echo
        read -t 5 -p "Press Enter to continue..."
    fi
fi
echo
# First argument defines which variant of the CaribouDuet configuration will be build
if [ -z "$1" ] ; then
    # Select which variant of the CaribouDuet configuration will be build, like
    PS3="Select a variant: "
    while IFS= read -r -d $'\0' f; do
        options[i++]="$f"
    done < <(find Configuration/sys/variants/ -maxdepth 1 -type f -name "*" -print0 )
    select opt in "${options[@]}" "All" "Quit"; do
        case $opt in
            *.sh)
                VARIANT=$(basename "$opt" ".sh")
                VARIANTS[i++]="$opt"
                break
                ;;
            "All")
                VARIANT="All"
                ALL_VARIANTS="All"
                VARIANTS=${options[*]}
                break
                ;;
            "Quit")
                echo "You chose to stop"
                    exit
                    ;;
            *)
                echo "$(tput setaf 1)This is not a valid variant$(tput sgr0)"
                ;;
        esac
    done
else
    if [ -f "$SCRIPT_PATH/Configuration/sys/variants/$1" ] ; then
        VARIANTS=$1
    else
        echo "$(tput setaf 1)$1 could not be found in Firmware/variants please choose a valid one$(tput setaf 2)"
        ls -1 $SCRIPT_PATH/Configuration/sys/variants/*.sh | xargs -n1 basename
        echo "$(tput sgr0)"
        exit 21
    fi
fi
#
# select a board
#
if [ -z "$2" ] ; then
    PS3="Select a board: "
    echo
    echo "Which board-build do you want?"
    select yn in "Duet2" "Duet3Mini5+" "Quit"; do
        case $yn in
            "Duet2")
                DUETBOARD=DUET2
                break
                ;;
            "Duet3Mini5+")
                DUETBOARD=DUET3
                break
                ;;
            "Quit")
                echo "You chose to stop"
                    exit
                    ;;
            *)
                echo "$(tput setaf 1)This is not a valid board.$(tput sgr0)"
                ;;
        esac
    done
else
    if [[ "$2" == "DUET2" || "$2" == "DUET3" ]] ; then
        DUETBOARD=$2
    else
        echo "$(tput setaf 1)Board argument is wrong!$(tput sgr0)"
        echo "Only $(tput setaf 2)'DUET2'$(tput sgr0) or $(tput setaf 2)'DUET3'$(tput sgr0) are allowed as board argument!"
        exit
    fi
fi
#
# =========================================================================================================

# generate files for filaments folder
#
#
echo
echo 'creating filament macros ...'
echo
# read existing variants
while IFS= read -r -d $'\0' f; do
    filamentoptions[i++]="$f"
done < <(find Configuration/filaments/*.h -maxdepth 1 -type f -name "*" -print0 )
FILAMENTVARIANTS=${filamentoptions[*]}
for v in ${FILAMENTVARIANTS[*]}
do
    VARIANT=$(basename "$v" ".h")
    # =========================================================================================================
    # read filament definition
    source $FILAMENTPATH/$VARIANT.h
    echo 'generating files for:' $FILAMENTNAME
    # prepare output folder
    if [ ! -d "$SCRIPT_PATH/filaments/$FILAMENTNAME" ]; then
        mkdir -p $FILAMENTOUTPUT/$FILAMENTNAME || exit 27
    else
        rm -fr $FILAMENTOUTPUT/$FILAMENTNAME || exit 27
        mkdir -p $FILAMENTOUTPUT/$FILAMENTNAME || exit 27
    fi
    # create Load_Filament
    sed "
    {s/#FILAMENT_NAME/${FILAMENTNAME}/};
    {s/#FILAMENT_TEMPERATURE_ACTIVE/${FILAMENT_TEMPERATURE_ACTIVE}/g}
    {s/#FILAMENT_TEMPERATURE_STANDBY/${FILAMENT_TEMPERATURE_STANDBY}/g}
    " < $FILAMENTPATH/load.g > $FILAMENTOUTPUT/$FILAMENTNAME/load.g
    # create Load_Filament
    sed "
    {s/#FILAMENT_NAME/${FILAMENTNAME}/};
    {s/#FILAMENT_TEMPERATURE_ACTIVE/${FILAMENT_TEMPERATURE_ACTIVE}/g}
    {s/#FILAMENT_TEMPERATURE_STANDBY/${FILAMENT_TEMPERATURE_STANDBY}/g}
    " < $FILAMENTPATH/unload.g > $FILAMENTOUTPUT/$FILAMENTNAME/unload.g
    # create config.g
    cp $FILAMENTPATH/config.g $FILAMENTOUTPUT/$FILAMENTNAME/
done
echo
echo '... done'
# =========================================================================================================
echo
echo 'generating configurations and macros ....'
echo
#
VariantCount=1
TotalCount=($(wc -w <<< $VARIANTS))
if [ $TotalCount == 0 ]; then
    TotalCount=1
fi
#
if [ "$DUETBOARD" = "DUET2" ]; then
    BUILDPATH=$SCRIPT_PATH/../CC-build/CC-Duet2-$CC-Build$BUILD
else
    BUILDPATH=$SCRIPT_PATH/../CC-build/CC-Duet3Mini5-$CC-Build$BUILD
fi
#
# Prepare config files folders
if [ ! -d "$BUILDPATH" ]; then
    mkdir -p $BUILDPATH || exit 27
fi
for v in ${VARIANTS[*]}
do
    echo
    echo "Variant count: " $VariantCount " / " $TotalCount
    ((VariantCount=VariantCount+1))
    #
    VARIANT=$(basename "$v" ".sh")
    #List some useful data
    echo "$(tput setaf 2)$(tput setab 7)"
    echo "Variant       :" $VARIANT
    echo "Configuration :" $CC
    echo "Build #       :" $BUILD
    if [ "$DUETBOARD" = "DUET2" ]; then
        echo "Config Folder :" "CC-build/CC-Duet2-$CC-Build$BUILD" "$(tput sgr0)"
        echo
        VARIANTOUTPUT=$BUILDPATH/Duet2-$VARIANT
    else
        echo "Config Folder :" "CC-build/CC-Duet3Mini5-$CC-Build$BUILD" "$(tput sgr0)"
        echo
        VARIANTOUTPUT=$BUILDPATH/Duet3Mini5-$VARIANT
    fi
    # prepare output folder
    if [ ! -d "$VARIANTOUTPUT" ]; then
        mkdir -p $VARIANTOUTPUT || exit 27
    else
        rm -fr $VARIANTOUTPUT || exit 27
        mkdir -p $VARIANTOUTPUT || exit 27
    fi
    # =========================================================================================================
    #
    # run script to generate config.g and change macros
    echo
    echo '   creating file for sys ....'
    cd $SCRIPT_PATH/Configuration/sys/variants/
    $SCRIPT_PATH/Configuration/sys/variants/$VARIANT.sh $DUETBOARD
    echo '   ... done'
    # =========================================================================================================
    # copy files for sys and remove processed files
    SysOutputPath=$SCRIPT_PATH/Configuration/sys/processed
    echo
    echo '   copying files for sys ....'
    # prepare output folder
    INPUT=$SysOutputPath
    OUTPUT=$VARIANTOUTPUT/sys
    if [ ! -d "$OUTPUT" ]; then
        mkdir -p $OUTPUT || exit 27
    else
        rm -fr $OUTPUT || exit 27
        mkdir -p $OUTPUT || exit 27
    fi
    cp -r $INPUT/* $OUTPUT
    echo '   ... done'
    #
    # delete processed files
    rm -fr $SysOutputPath
    # =========================================================================================================
    # create zip file for macros an remove processed files
    echo
    echo '   creating files for macros ....'
    MacrosDir=$SCRIPT_PATH/Configuration/macros
    MacroOutputPath=$MacrosDir/processed
    if [ "$DUETBOARD" = "DUET2" ]; then
       DUETBOARDNAME="Duet2"
    else
        DUETBOARDNAME="Duet3Mini5+ "
    fi
    sed "
    {s/#DUETBOARDNAME/$DUETBOARDNAME/};
    {s/#CARIBOUDUETVERSION/$CCDOT/};
    {s/#CARIBOUDUETBUILD/$BUILD/};
    " < $MacrosDir/04-Maintenance/00-CaribouDuetVersion > $MacroOutputPath/04-Maintenance/00-CaribouDuetVersion
    echo '   ... done'
    # copy files for sys and remove processed files
    echo
    echo '   copying files for macros ....'
    # prepare output folder
    INPUT=$MacroOutputPath
    OUTPUT=$VARIANTOUTPUT/macros
    if [ ! -d "$OUTPUT" ]; then
        mkdir -p $OUTPUT || exit 27
    else
        rm -fr $OUTPUT || exit 27
        mkdir -p $OUTPUT || exit 27
    fi
    cp -r $INPUT/* $OUTPUT
    echo '   ... done'
    #
    # delete processed files
    rm -fr $MacroOutputPath
    # =========================================================================================================
    # copy filament files to build directory
    echo
    echo '   copying filament files ....'
    INPUT=$FILAMENTOUTPUT
    OUTPUT=$VARIANTOUTPUT/filaments
    # prepare output folder
    if [ ! -d "$OUTPUT" ]; then
        mkdir -p $OUTPUT || exit 27
    else
        rm -fr $OUTPUT || exit 27
        mkdir -p $OUTPUT || exit 27
    fi
    cp -r $INPUT/* $OUTPUT
    echo '   ... done'
    # =========================================================================================================
    # copy status directory
    StatusOutputPath=$SCRIPT_PATH/Configuration/settings/processed
    echo
    echo '   copying status directory ....'
    # prepare output folder
    INPUT=$StatusOutputPath
    OUTPUT=$VARIANTOUTPUT/settings/
    if [ ! -d "$OUTPUT" ]; then
        mkdir -p $OUTPUT || exit 27
    else
        rm -fr $OUTPUT || exit 27
        mkdir -p $OUTPUT || exit 27
    fi
    cp -r $INPUT/* $OUTPUT
    echo '   ... done'
    #
    # delete processed files
    rm -fr $StatusOutputPath
    # =========================================================================================================
    # copy files for SlicerScripts
    echo
    echo '   copying files for SlicerScripts ....'
    # prepare output folder
    INPUT=$SCRIPT_PATH/Configuration/SlicerScripts
    OUTPUT=$VARIANTOUTPUT/SlicerScripts
    if [ ! -d "$OUTPUT" ]; then
        mkdir -p $OUTPUT || exit 27
    else
        rm -fr $OUTPUT || exit 27
        mkdir -p $OUTPUT || exit 27
    fi
    cp -r $INPUT/* $OUTPUT
    echo '   ... done'
    #
    # =========================================================================================================
    # copy gcode files (sample prints) to build directory
    echo
    echo '   copying gcodes (sample prints) ....'
    INPUT=$SCRIPT_PATH/Configuration/gcodes
    OUTPUT=$VARIANTOUTPUT/gcodes
    # prepare output folder
    if [ ! -d "$OUTPUT" ]; then
        mkdir -p $OUTPUT || exit 27
    else
        rm -fr $OUTPUT || exit 27
        mkdir -p $OUTPUT || exit 27
    fi
    cp -r $INPUT/* $OUTPUT
    echo '   ... done'
    #
    # =========================================================================================================
    # copy gcode files (sample prints) to build directory
    echo
    echo '   copying DWC files ....'
    INPUT=$SCRIPT_PATH/www
    OUTPUT=$VARIANTOUTPUT/www
    # prepare output folder
    if [ ! -d "$OUTPUT" ]; then
        mkdir -p $OUTPUT || exit 27
    else
        rm -fr $OUTPUT || exit 27
        mkdir -p $OUTPUT || exit 27
    fi
    cp -r $INPUT/* $OUTPUT
    echo '   ... done'
    #
    # =========================================================================================================
    # create directories for firmware and menu
    OUTPUT=$VARIANTOUTPUT/firmware
    # prepare output folder
    if [ ! -d "$OUTPUT" ]; then
        mkdir -p $OUTPUT || exit 27
    else
        rm -fr $OUTPUT || exit 27
        mkdir -p $OUTPUT || exit 27
    fi
    OUTPUT=$VARIANTOUTPUT/menu
    # prepare output folder
    if [ ! -d "$OUTPUT" ]; then
        mkdir -p $OUTPUT || exit 27
    else
        rm -fr $OUTPUT || exit 27
        mkdir -p $OUTPUT || exit 27
    fi
    # =========================================================================================================
    # copy drivers
    INPUT=$SCRIPT_PATH/DuetDriver
    OUTPUT=$VARIANTOUTPUT/
    cp -r $INPUT/* $OUTPUT
    #
    # =========================================================================================================
    # create zip-file for configuration
    echo
    echo '   creating zip file for configuration ....'
    # delete possibly existing output file
    if [ "$DUETBOARD" = "DUET2" ]; then
        OUTPUT=$BUILDPATH/CC$CC-Duet2-$VARIANT-Build$BUILD.zip
    else
        OUTPUT=$BUILDPATH/CC$CC-Duet3Mini5-$VARIANT-Build$BUILD.zip
    fi
    if [ -f "$OUTPUT" ]; then
        rm -f $OUTPUT || exit 27
    fi
    #
    if [ $TARGET_OS == "windows" ]; then
        zip a $OUTPUT  $VARIANTOUTPUT/* | tail -4
    else
        pushd $VARIANTOUTPUT
        zip -r $OUTPUT  * | tail -4
        popd
    fi
    echo
    echo '   ... done'
    echo
    echo '... done'
done
#
# Sort configuration only when build ALL is selected
#
if [ ! -z "$ALL_VARIANTS" ]; then
    if [ "$ALL_VARIANTS" == "All" ]; then
        echo
        echo '   sorting files ....'
        echo

        $SCRIPT_PATH/sort.sh $BUILDPATH $BUILDPATH-sorted/

        echo
        echo '   ... done'
        echo
        echo '   creating zip file for all configurations ....'
        echo
        #
        # delete possibly existing output file
        OUTPUTPATH=$BUILDPATH-sorted/zip
        cd $OUTPUTPATH
        if [ "$DUETBOARD" = "DUET2" ]; then
            ZIPNAME=CaribouDuet2-Configuration-and-Macros-$CC-Build$BUILD.zip
        else
            ZIPNAME=CaribouDuet3Mini5-Configuration-and-Macros-$CC-Build$BUILD.zip
        fi
        if [ -f "$ZIPNAME" ]; then
            rm -f $ZIPNAME || exit 27
        fi
        if [ $TARGET_OS == "windows" ]; then
            zip a $ZIPNAME * | tail -4
        else
            zip -r $ZIPNAME * | tail -4
        fi
        mv $ZIPNAME ..
        #
        echo
        echo '   ... done'
        echo
    else
        echo "$(tput setaf 1)ALL_VARIANTS argument is wrong!$(tput sgr0)"
        echo "Only $(tput setaf 2)'All'$(tput sgr0) is allowed as argument!$(tput sgr0)"
        exit 37
    fi
fi
#
# housekeeping: delete filament folders in source directory
rm -fr $FIRSTLAYEROUTPUT
rm -fr $PREHEATEXTRUDEROUTPUT
rm -fr $PREHEATBEDOUTPUT
rm -fr $PREHEATBOTHOUTPUT
rm -fr $FILAMENTOUTPUT

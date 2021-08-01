# CaribouDuet2WiFi-Ethernet-Configuration-and-Macros

This repository contains the source code and the development versions of the configuration and macros running on the Original CaribouDuet2WiFi-Ethernet line of printers.

# Naming convention

Sorting order is height / Thermistor / Sensor

### Thermistor

1. N = E3d thermistor and Slice Engineering thermistor (white cable) up to 300°C
2. H = Slice Engineering High Temperature Thermistor (black cable) up to 450°C

(old, before version 1.3.0)

1. E = E3d thermistor
2. S = Slice Engineering Thermistor (black cable)


### Sensor
1. P = PINDA2
2. SP = SuperPINDA
3. BLL = BL-Touch Left installation
4. BLR = BL-Touch Right installation


Example:

CaribouDuet220-NSP = 220 version with E3d  or SE thermistor and PINDA2

CaribouDuet320-HBLL = 320 version with SE HT thermistor and BL-Touch Left



# Build

In your preferred Unix environment follow these steps:

1. Clone this repository and checkout the correct branch for your desired release version.
2. change into the directory `CaribouDuet2-ConfigurationMacros`
3. execute `./CC-build.sh`
4. select the desired configuration or build all configurations
5. in case you only built one version you will find a zipped output file in `../CC-build`
6. in case you built all versions output files are automatically sorted into a "sorted" directory

# Set-up

## Linux

- make sure zip isinstalled

## Using Git-bash under Windows 10 64-bit

- Download and install the 64bit Git version https://git-scm.com/download/win
- Also follow these instructions https://gist.github.com/evanwill/0207876c3243bbb6863e65ec5dc3f058
- Download and install 7z-zip from its official website https://www.7-zip.org/
  By default, it is installed under the directory /c/Program\ Files/7-Zip in Windows 10
- Run `Git-Bash` under Administrator privilege
- navigate to the directory /c/Program\ Files/Git/mingw64/bin
- run `ln -s /c/Program\ Files/7-Zip/7z.exe zip.exe`
- If your Windows isn't in English the Paths may look different
  Example in other languages
  - English `/mnt/c/Users/<your-username>/Downloads/Prusa-Firmware-MK3` will be on a German Windows`/mnt/c/Anwender/<your-username>/Downloads/Prusa-Firmware-MK3`
  - English `ln -s /c/Program\ Files/7-Zip/7z.exe zip.exe` will be on a Spanish Windows `ln -s /c/Archivos\ de\ programa/7-Zip/7z.exe zip.exe`

# Acknowledgements

Thanks to Bernd Brinkert and Daniel Heimbeck for support and discussions on various items and issues!!

Support for BL-Touch for installation on the right side was initiated by Michael Müller.

We would like to thank 3d-gussner for his effort when we started this project. The CC-build and the sorting scripts have their roots in the PF-build and sorting scripts for building the Prusa firmware which were developed by 3d-gussner.

We're thankful to rkolbi for providing his scripts and documentation to us at an early stage. His repository can be found at https://github.com/rkolbi/RRF-machine-config-files/tree/master/Prusa%20MK3s

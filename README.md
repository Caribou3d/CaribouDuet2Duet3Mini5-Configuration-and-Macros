# CaribouDuet-Config-and-Macros

This repository contains the source code and the development versions of the configuration and macros running on the Original CaribouDuet line of printers.

# Build

In you preferred Unix environment follow these steps

1. Clone this repository and checkout the correct branch for your desired release version.
2. change into the directory `CaribouDuet-Configuration-and-Macros`
3. execute `./CC-build.sh`
4. select the desired configuration or build all configurations
5. in case you only built one version you will find a zipped output file in `../CC-build`
6. in case you built all versions copy `./sort.sh` to `../CC-build`
7. change to th edirectory `../CC-build`
8. execute `./sort.sh`. Options are the start and target directory for the sorted files example `./sort.sh CC110-Build26/ CC110-Build26-sorted
`
9. the script will create all required directories and sort the out that was generated buy `CC-build.sh`

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

; =========================================================================================================
;
; Configuration file for #DUETBOARDNAME-WiFi/Ethernet (firmware version 3.4 and higher)
;
; for 0.9° motors on xy, and 0.9° or 1.8° (only LGXM) motor e
;
; for #CARIBOU_VARIANT
;
; CariboDuetConfiguration Release : "2.1.2"
;                           Build :   516
;
; Copyright Caribou Research & Development 2023. Licensed under GPL3. No commercial use.
; Source code and release notes are available on github: https://github.com/Caribou3d/CaribouDuet2-ConfigurationMacros
;
; =========================================================================================================
;
; global variables
;
global IdleCounter = 0                                                 ; counts idle time
global ExtruderTempActive_Old = 0                                      ; stores extruder temperature for idle check
global BedTempActive_Old = 0                                           ; stores bed temperature for idle check
global OldStateStatus = 0                                              ; stores the status of the printer, processing = 1
global purge = 0                                                       ; stores status to purge when autoloading
global zLiftDistance = 0                                               ; stores distance for lifting z axis
global waitForExtruderTemperature = false                              ; beeps when pre-heat temperature is reached
global waitForBedTemperature = false                                   ; beeps when pre-heat temperature is reached
global AskToChange = 1                                                 ; ask if filament should be changed?
global x_accel = 0                                                     ; stores x accelerations (mm/s^2)
global x_jerk = 0                                                      ; stores x maximum instantaneous speed changes (mm/min)
global y_accel = 0                                                     ; stores y accelerations (mm/s^2)
global y_jerk = 0                                                      ; maximum y instantaneous speed changes (mm/min)
global filamentErrorIgnore = 0                                         ; enable / disable execution of filament-error.g
global filamentTriggerIgnore = 0                                       ; enable / disable execution of trigger2.g
;
; general settings
;
M111 S0                                                                ; debugging off
G21                                                                    ; work in millimetres
;
; =========================================================================================================
; network settings
; =========================================================================================================
;
#CARIBOU_NAME
;
M552 S1                                                                ; enable network
M586 P0 S1                                                             ; enable HTTP
M586 P1 S1                                                             ; enable FTP
M586 P2 S0                                                             ; disable Telnet
M575 P1 S1 B57600                                                      ; enable support for PanelDue
;
; =========================================================================================================
; drives
; =========================================================================================================
;
; #CARIBOU_DRIVES
;
; set microsteps and steps / mm
; =========================================================================================================
;
M350 X16 Y16 Z16 E16 I1                                                ; configure microstepping with interpolation
M92 X200.00 Y200.00 Z400.00 E#CARIBOU_EESTEPS                                    ; set steps per mm
;
; set motor currents
; =========================================================================================================
;
; #CARIBOU_MOTOR_CURRENTS
;
M84 S60                                                                ; set idle timeout
;
; set speeds
; =========================================================================================================
;
M201 X3000.00 Y3000.00 Z100.00 E500.00                                 ; set accelerations (mm/s^2)
M203 X18000.00 Y18000.00 Z1000.00 E3600.00                             ; set maximum speeds (mm/min)
M204 P500.0 T500.0                                                     ; set print and travel accelerations (mm/s^2)
M566 X480.00 Y480.00 Z48.00 E300.00                                    ; set maximum instantaneous speed changes (mm/min)
;
set global.x_accel = move.axes[0].acceleration                         ; save accelerations (mm/s^2)
set global.x_jerk = move.axes[0].jerk                                  ; save maximum instantaneous speed changes (mm/min)
;
set global.y_accel = move.axes[1].acceleration                         ; save accelerations (mm/s^2)
set global.y_jerk = move.axes[1].jerk                                  ; save maximum instantaneous speed changes (mm/min)
;
M564 H0                                                                ; allow unhomed movement
;
; =========================================================================================================
; axes limits
; =========================================================================================================
;
M208 X-2 Y-7.5 Z0 S1                                                   ; set axes minimum
M208 X253.5 Y215 #CARIBOU_ZHEIGHT S0                                            ; set axes maximum
;
; =========================================================================================================
; endstops
; =========================================================================================================
;
M574 X1 S3                                                             ; configure sensorless endstop for low end on x
M574 Y1 S3                                                             ; configure sensorless endstop for low end on y
M574 Z1 S2                                                             ; configure z-probe endstop for low end on z
;
; =========================================================================================================
;
; #CARIBOU_ZPROBE
;
; =========================================================================================================
;
M574 Z1 S2                                                             ; set endstops controlled by probe
;
; stallguard sensitivy
;
; #CARIBOU_STALLGUARD
;
; =========================================================================================================
; heaters, fans, thermistors
; =========================================================================================================
;
; heated bed
; =========================================================================================================
;
; #CARIBOU_HEATBED
;
; extruder
; =========================================================================================================
;
; #CARIBOU_HOTEND_THERMISTOR
;
; display MCU and drivers temperature
; =========================================================================================================
;
M308 S4 P"mcu-temp" Y"mcu-temp" A"MCU"                                 ; set virtual heater for MCU
M308 S5 P"drivers" Y"drivers" A"Driver"                                ; set virtual heater for stepper drivers
;
; fans
; =========================================================================================================
;
; #CARIBOU_FANS
;
; ========================================================================================================
; tools
; =========================================================================================================
;
M563 P0 D0 H1 F0                                                       ; define tool 0
G10 P0 X0 Y0 Z0                                                        ; set tool 0 axis offsets
M568 P0 S0 R0 A0                                                       ; turn off extruder
M302 S#CARIBOU_MINEXTRUDETEMP R#CARIBOU_MINRETRACTTEMP                                                         ; allow extrusion starting from 180°C and retractions already from 180°C
;
; =========================================================================================================
; other settings
; =========================================================================================================
;
M18 XY                                                                 ; release / unlock x, y
M501                                                                   ; use config-override (for Thermistor Parameters and other settings)
G90                                                                    ; send absolute coordinates...
M83                                                                    ; ... but relative extruder moves
;
; =========================================================================================================
; filament handling
; =========================================================================================================
;
; execute macros that determine the status of the filament sensor
;
M98 P"0:/sys/00-Functions/FilamentsensorStatus"
;
; =========================================================================================================
;
; offsets - place off-sets for x and y here. z-offsets are handled in the print sheet macros
;
; #CARIBOU_OFFSETS
;
; =========================================================================================================
;
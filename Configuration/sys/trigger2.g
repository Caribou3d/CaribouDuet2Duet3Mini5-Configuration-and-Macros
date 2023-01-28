; =========================================================================================================
;
; trigger2 script - triggered by filament sensor mapping - used for autoload
;
; =========================================================================================================
;
M581 P0 T2 S-1 R0                                                      ; filament sensor does not listen anymore (S-1). Autoload is disabled.
;
if (global.filamentTriggerIgnore == 1)
    M98 P"0:/sys/00-Functions/ActivateRunOutSensor"                    ; activate RunOut Sensor to check if filament is loaded
    M99
;
M300 S500 P600                                                         ; beep
G4 P2000                                                               ; wait two seconds
;
if heat.heaters[1].current < heat.coldExtrudeTemperature               ; check temperature
    M98 P"0:/sys/00-Functions/ActivateRunOutSensor"                    ; activate RunOut Sensor to check if filament is loaded
    set global.filamentErrorIgnore = 1
    M291 R"Hotend too cold. Preheat extruder first!" P"Please pull out filament!" S2 ; ask to preheat extruder
    set global.filamentErrorIgnore = 0
    M99
;
T0                                                                    ; activate hotend
;
M291 P"Feeding filament ..." S1 T15                                    ; display message
;
G91                                                                   ; set to Relative Positioning
G1 E#CARIBOU_INITIALLOAD F400                                                            ; feed #CARIBOU_INITIALLOADmm of filament at 400mm/min
G1 E15 F200                                                            ; feed 15mm of filament at 200mm/min
G4 P1000                                                               ; wait one second
;
if {move.axes[0].workplaceOffsets[8] == 1}                             ; if filament sensor is enabled
    M98 P"0:/sys/00-Functions/ActivateRunOutSensor"
;
if {global.purge != -1}                                                ; only purge when filament was autoloaded
    M98 P"0:/macros/02-Filament_Handling/02-Purge_Filament"            ; need to purge?
;
; =========================================================================================================
;
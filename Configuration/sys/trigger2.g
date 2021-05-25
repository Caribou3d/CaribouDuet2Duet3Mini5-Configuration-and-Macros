; =========================================================================================================
;
; trigger2 script - triggered by filament sensor mapping - used for autoload
;
; =========================================================================================================
;
M300 S500 P600                                                   ; beep
G4 P2000	                                                     ; wait two seconds
;
M581 P1 T2 S-1 R0                                                ; filament sensor does not listen anymore (S-1). Autoload is disabled. 
;
T0                                                               ; activate hotend
;
if heat.heaters[1].current < 400                                 ; check temperature
    M291 R"Hotend too cold. Preheat extruder first!" P"Please pull out filament to activate sensor again!" S2 ;Ask to preheat extruder    M98 P"0:/macros/10_Functions/FilamentSensorStatus"           ; GCODE Script to activtate RunOut Sensor when filament has been loaded successfully 
    M98 P"0:/macros/10-Functions/FilamentSensorStatus"               ; GCODE Script to activtate RunOut Sensor when filament has been loaded successfully 
    abort
;
M291 P"Feeding filament.... " S1 T25
;
G91                    ; set to Relative Positioning
G1 E#CARIBOU_INITIALLOAD F400            ; feed #CARIBOU_INITIALLOADmm of filament at 400mm/min
G1 E15 F200            ; feed 15mm of filament at 200mm/min
G4 P1000               ; wait one second
;
M98 P"0:/macros/01-Filament_Handling/purge.g"
;
G1 E-0.5 F200	       ; retract 0.5mm of filament at 400mm/min
M291 P"..... done" T30
M400                   ; wait for the moves to finish
;
M98 P"0:/macros/10-Functions/FilamentSensorStatus"               ; GCODE Script to activtate RunOut Sensor when filament has been loaded successfully 
M291 P"Filament loaded" R"Finished" T2                          ; display message
;
; =========================================================================================================

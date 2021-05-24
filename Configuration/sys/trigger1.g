; =========================================================================================================
;
; trigger1 script - triggered by filament sensor mapping - used for autoload
;
; =========================================================================================================
;
M300 S1500 P2000                                                 ; play beep sound
G4 P2000	                                                     ; wait two seconds
;
M581 P1 T2 S-1 R0                                                ; filament sensor does not listen anymore (S-1). Autoload is disabled. 
;
T0                                                               ; activate hotend
;
if heat.heaters[1].current < 180                                    
    M291 P"Hotend too cold for loading filament. Preheat extruder first to 215°C?" R"Autoload" S3 ;Ask to preheat extruder
    M291 P"Heating, please wait" T2                             ; message to wait
    M109 S215                                                   ; set extruder temp to 215°C and wait    
;
M291 P"Feeding filament" R"Trigger 1 autoload" T2               ; display new message
M98 P"0:/macros/01-Filament_Handling/load.g"                    ; GCODE Script to load filament
M98 P"0:/macros/10_Functions/FilamentSensorCheck"               ; GCODE Script to activtate RunOut Sensor when filament has been loaded successfully 
M291 P"Filament loaded" R"Finished" T2                          ; display message
;
; =========================================================================================================

; =========================================================================================================
;
; called before a print from SD card is resumed
;
; =========================================================================================================
;
;
if heat.heaters[1].current < heat.coldExtrudeTemperature               ; check temperature
    M98 P"0:/sys/00-Functions/ActivateRunOutSensor"                    ; activate RunOut Sensor to check if filament is loaded
    M291 R"Hotend too cold. Preheat extruder first!" P"Please pull out filament!" S2 ; ask to preheat extruder
    M99
;
M98 P"current-sense-normal.g"                                          ; ensure the drivers current and sensitivity is set for normal routines
G1 R1 X0 Y0 Z5 F2000                                                   ; go to 5mm above position of the last print move
G1 R1 X0 Y0                                                            ; go back to the last print move
M83                                                                    ; relative extruder moves
G1 E1 F3600                                                            ; extrude 1mm of filament
M121                                                                   ; recover the last state pushed onto the stack
;
; =========================================================================================================
;
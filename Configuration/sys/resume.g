; =========================================================================================================
;
; called before a print from SD card is resumed
;
; =========================================================================================================
;
M98 P"00-Functions/CurrentSenseNormal"                                 ; ensure the drivers current and sensitivity is set for normal routines
;
if heat.heaters[1].current > heat.coldExtrudeTemperature               ; check extrude temperature
    M83                                                                ; relative extruder moves
    G1 E8 F600                                                         ; extrude 8mm of filament (now being able to pull that away)
;
G1 R1 X0 Y0 Z5 F2000                                                   ; go to 5mm above position of the last print move
G1 R1 X0 Y0                                                            ; go back to the last print move
;
M83                                                                    ; relative extruder moves
if heat.heaters[1].current > heat.coldExtrudeTemperature               ; check extrude temperature
    M83                                                                ; relative extruder moves
    G1 E0.6 F300                                                       ; extrude 0.6mm of filament
;
M121                                                                   ; recover the last state pushed onto the stack
;
; =========================================================================================================
;
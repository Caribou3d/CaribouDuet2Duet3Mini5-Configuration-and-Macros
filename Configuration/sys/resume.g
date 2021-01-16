; =========================================================================================================
;
; called before a print from SD card is resumed
;
; =========================================================================================================
;
M98 P"current-sense-normal.g"        ; Ensure the drivers current and sensitivity is set for normal routines
G1 R1 X0 Y0 Z5 F6000                 ; go to 5mm above position of the last print move
G1 R1 X0 Y0                          ; go back to the last print move
M83                                  ; relative extruder moves
M121                                 ; Recover the last state pushed onto the stack.
;
; =========================================================================================================

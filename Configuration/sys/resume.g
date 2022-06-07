; =========================================================================================================
;
; called before a print from SD card is resumed
;
; =========================================================================================================
;
M98 P"current-sense-normal.g"                                    ; ensure the drivers current and sensitivity is set for normal routines
G1 R1 X0 Y0 Z5 F2000                                             ; go to 5mm above position of the last print move
G1 R1 X0 Y0                                                      ; go back to the last print move
M83                                                              ; relative extruder moves
G1 E2 F3600                                                      ; extrude 2mm of filament
M121                                                             ; recover the last state pushed onto the stack
;
; =========================================================================================================
;

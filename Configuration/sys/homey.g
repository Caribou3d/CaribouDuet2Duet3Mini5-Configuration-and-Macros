; =========================================================================================================
;
; Home y Axis
;
; =========================================================================================================
;
G91                                                                    ; relative positioning
M98 P"current-sense-homing.g"                                          ; ensure the current and sensitivity is set for homing routines.
;
G1 H2 Y0.5 F10000                                                      ; energise motor to ensure it's not stalled
M400                                                                   ; wait for current moves to finish
G4 P200                                                                ; wait 200ms
;
G1 H2 Z5 F6000                                                         ; lift z relative to current position
M400                                                                   ; wait for current moves to finish
;
G1 H1 Y5 F1000                                                         ; move slowly away
G1 H1 Y-225 F3000                                                      ; move quickly to y axis endstop and stop there (first pass)
G1 H2 Y5 F1000                                                         ; go back a few mm
G1 H1 Y-10 F3000                                                       ; move slowly to y axis endstop once more (second pass)
G1 H2 Z-5 F6000                                                        ; lower z again
;
M400                                                                   ; wait for current moves to finish
G4 P200                                                                ; wait 200ms
;
G90                                                                    ; absolute positioning
;
M98 P"current-sense-normal.g"                                          ; ensure the current and sensitivity is set for normal routines.
;
; =========================================================================================================
;
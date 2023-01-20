; =========================================================================================================
;
; home x Axis
;
; =========================================================================================================
;
G91                                                                    ; relative positioning
M98 P"0:/sys/00-Functions/current-sense-homing"                        ; ensure the current and sensitivity is set for homing routines.
;
G1 H2 X0.5 F10000                                                      ; energise motor to ensure it's not stalled
M400                                                                   ; wait for current moves to finish
G4 P200                                                                ; wait 200ms
;
set global.zLiftDistance = 5                                           ; set distance to lift
M98 P"0:/sys/00-Functions/zLift"                                       ; call macro to lift z
;
G1 H1 X5 F1000                                                         ; move slowly away
G1 H1 X-260 F3000                                                      ; move quickly to x axis endstop and stop there (first pass)
G1 H2 X5 F1000                                                         ; go back a few mm
G1 H1 X-10 F3000                                                       ; move slowly to x axis endstop once more (second pass)
G1 H2 Z-5 F6000                                                        ; lower z again
;
M400                                                                   ; wait for current moves to finish
G4 P200                                                                ; wait 200ms
;
G90                                                                    ; absolute positioning
;
M98 P"0:/sys/00-Functions/current-sense-normal"                        ; ensure the current and sensitivity is set for normal routines.
;
; =========================================================================================================
;
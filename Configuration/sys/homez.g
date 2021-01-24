; =========================================================================================================
;
; Home XYZ Axis
;
; for #CARIBOU_VARIANT
;
; =========================================================================================================
;
G91                               ; relative positioning
M98 P"current-sense-homing.g"     ; Ensure the current and sensitivity is set for homing routines.
;
G1 H2 X0.5 Y-0.5 F10000	          ; energise motors to ensure they are not stalled
M400                              ; wait for current moves to finish
M913 X40 Y40                      ; drop motor current to 40%/40%
G4 P200                           ; wait 200ms
;
G1 H2 Z5 F6000                    ; lift Z relative to current position
M400                              ; wait for current moves to finish
;
; =========================================================================================================
; Home X Axis
; =========================================================================================================
;
G1 H1 X5 F1000                    ; move slowly away
G1 H1 X-260 F3000                 ; move quickly to X axis endstop and stop there (first pass)
G1 H2 X5 F1000                    ; go back a few mm
G1 H1 X-10 F3000                  ; move slowly to X axis endstop once more (second pass)
;
; =========================================================================================================
; Home Y Axis
; =========================================================================================================
;
M400                              ; wait for current moves to finish
G1 H1 Y5 F1000                    ; move slowly away
G1 H1 Y-260 F3000                 ; move quickly to X axis endstop and stop there (first pass)
G1 H2 Y5 F1000                    ; go back a few mm
G1 H1 Y-10 F3000                  ; move slowly to X axis endstop once more (second pass)
;
M400                              ; wait for current moves to finish
M913 X100 Y100                    ; return X & Y motor
G4 P200                           ; wait 200ms
;
G90                               ; absolute positioning
;
; =========================================================================================================
; Home Z Axis
; =========================================================================================================
;
G90                               ; absolute positioning
G1 X11.5 Y4.5 F6000               ; go to first probe point
G30                               ; home Z by probing the bed
G1 Z0.15 F100                     ; move Z to origin
G91                               ; relative positioning
G1 Z1 F100                        ; lift Z relative to current position
G90                               ; absolute positioning
M400	     	                  ; Wait for current moves to finish
;
; =========================================================================================================
;
G90                               ; absolute positioning
;
M98 P"current-sense-normal.g"     ; Ensure the current and sensitivity is set for homing routines.
;
; =========================================================================================================

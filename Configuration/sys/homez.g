; =========================================================================================================
;
; home xyz axes
;
; for Caribou220 Duet2 WiFi/Ethernet Bondtech - E3d or SE Thermistor - SuperPINDA
;
; =========================================================================================================
;
G91                                           ; relative positioning
M98 P"0:/sys/00-Functions/CurrentSenseHoming" ; ensure the current and sensitivity is set for homing routines.
;
set global.zLiftDistance = 5                  ; set distance to lift
M98 P"0:/sys/00-Functions/zLift"              ; call macro to lift z
;
; =========================================================================================================
; home x Axis
; =========================================================================================================
;
M17 X                                         ; energise motors to ensure they are not stalled
G4 P100                                       ; wait 100ms
;
if !move.axes[0].homed
    G1 H1 X5 F3000                            ; move slowly away
    G1 H1 X-260 F4000                         ; move quickly to x axis endstop and stop there (first pass)
    G1 H2 X5 F3000                            ; go back a few mm
    G1 H1 X-10 F4000                          ; move slowly to x axis endstop once more (second pass)
    G1 H2 Z-5 F6000                           ; wait for current moves to finish
    M400                                      ; wait for current moves to finish
;
; =========================================================================================================
; home y Axis
; =========================================================================================================
;
M17 Y                                         ; energise motors to ensure they are not stalled
G4 P100                                       ; wait 100ms
;
if !move.axes[1].homed
    G1 H1 Y5 F4000                            ; move slowly away
    G1 H1 Y-225 F3000                         ; move quickly to y axis endstop and stop there (first pass)
    G1 H2 Y5 F4000                            ; go back a few mm
    G1 H1 Y-10 F3000                          ; move slowly to y axis endstop once more (second pass)
    G1 H2 Z-5 F4000                           ; lower z again
    M400                                      ; wait for current moves to finish
;
; =========================================================================================================
;
M913 X100 Y100                                ; return x & y motor
G4 P200                                       ; wait 200ms
;
G90                                           ; absolute positioning
;
; =========================================================================================================
; home z axis
; =========================================================================================================
;
G90                                                                    ; absolute positioning
; #CARIBOU_ZPROBE
#CARIBOU_MEASUREPOINT
G30                                                                    ; home z by probing the bed
G1 Z1.15 F100                                                          ; move z to origin and 1.15mm above bed
G90                                                                    ; absolute positioning
M400                                                                   ; wait for current moves to finish
;
; =========================================================================================================
;
G90                                                                    ; absolute positioning
;
M98 P"0:/sys/00-Functions/CurrentSenseNormal"                          ; ensure the current and sensitivity is set for normal routines.
;
; =========================================================================================================
;
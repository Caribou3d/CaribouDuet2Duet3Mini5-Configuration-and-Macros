; =========================================================================================================
;
; bed.g
; called to perform automatic bed compensation via G32
;
; for #CARIBOU_VARIANT
;
; =========================================================================================================
;
M561                                                   ; clear any existing bed transform
G28                                                    ; home all axis
;
M558 F50 A5 S0.003                                     ; slow z-probe, up to 5 probes until disparity is 0.003 or less - else yield average
while iterations <=2                                   ; perform 3 passes
   G30 P0 X25 Y105 Z-99999                             ; probe near a leadscrew, half way along Y axis
   G30 P1 X240 Y105 Z-99999 S2                         ; probe near a leadscrew and calibrate 2 motors
   G1 X125 F10000                                      ; move to the center of the bed
   G30                                                 ; probe the bed at the current xy position
   M400                                                ; finish all moves, clear the buffer
;
M558 F50 A5 S-1                                        ; slow the z-probe, perform 5 probes and yield the average
while move.calibration.initial.deviation >= 0.003      ; perform additional leveling if previous deviation was over 0.003mm
   if iterations = 5                                   ; perform 5 addition checks, if needed
      M300 S3000 P500                                  ; sound alert, the required deviation could not be achieved
      M558 F200 A1                                     ; set normal z-probe speed
      abort "!!! ABORTED !!! Failed to achieve < 0.003 deviation. Current deviation is " ^ move.calibration.initial.deviation ^ "mm."
      G30 P0 X25 Y105 Z-99999                          ; probe near a leadscrew, half way along Y axis
      G30 P1 X240 Y105 Z-99999 S2                      ; probe near a leadscrew and calibrate 2 motors
   G1 X125 F10000                                      ; move the nozzle to the center of the bed
   G30                                                 ; probe the bed at the current XY position
   M400                                                ; finish all moves, clear the buffer
;
#CARIBOU_ZPROBERESET
;
echo "Gantry deviation of " ^ move.calibration.initial.deviation ^ "mm obtained."
;
G1 Z8                                                  ; raise nozzle 8mm to ensure it is above the z probe trigger height
;
; =========================================================================================================

; =========================================================================================================
;
; called when M0 (Stop) is run (e.g. when a print is cancelled)
;
; =========================================================================================================
;
M568 P0 S0 R0 A0                                                       ; turn off extruder 0
;
M140 S0 R0                                                             ; set bed temperature to 0C
M140 S-274                                                             ; set bed temperature to 0K to turn it off
;
M106 P0 S0                                                             ; turn off fan 0
;
G91                                                                    ; relative positioning
if {move.axes[2].machinePosition < (move.axes[2].max -20)}             ; if the z position is below 20mm below max z
    G1 Z15                                                             ; lift z axis by 15mm
G90                                                                    ; absolute positioning
G1 X{move.axes[0].min} Y{move.axes[1].min} } F7200                     ; park xy axes
M84 XY                                                                 ; disable motors
;
; =========================================================================================================
;
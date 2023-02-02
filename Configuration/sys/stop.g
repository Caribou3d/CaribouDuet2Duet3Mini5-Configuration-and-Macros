; =========================================================================================================
;
; called when M0 (Stop) is run (e.g. when a print is cancelled)
;
; =========================================================================================================
;
T-1                                                                    ; deselect tool
;
M568 P0 S0 R0 A0                                                       ; turn off extruder 0
;
M140 S0 R0                                                             ; set bed temperature to 0C
M140 S-274                                                             ; set bed temperature to 0K to turn it off
;
M106 P0 S0                                                             ; turn off fan 0
;
M98 P"0:/sys/00-Functions/Endscript"                                   ; execute end script
;
; =========================================================================================================
;
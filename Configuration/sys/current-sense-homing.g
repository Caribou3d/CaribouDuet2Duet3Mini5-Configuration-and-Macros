; =========================================================================================================
;
; Set the current and sensitivity for homing, non-printing, routines
;
; =========================================================================================================
;
M915 X S2 F0 H400 R0                                                   ; set the x axis sensitivity.
M915 Y S2 F0 H400 R0                                                   ; set the y axis sensitivity.
M913 X40 Y40 Z60                                                       ; set the x, y, and z drivers current percentage for non-print moves, per config.g.
;
; =========================================================================================================
;
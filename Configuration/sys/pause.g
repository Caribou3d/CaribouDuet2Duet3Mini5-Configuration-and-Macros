; =========================================================================================================
;
; called when a print is paused
;
; =========================================================================================================
;
M83               ; relative extruder moves
G1 E-2 F3600      ; retract 2mm of filament
G91               ; relative positioning
G1 Z5 F360        ; lift Z by 5mm
G90               ; absolute positioning
G1 X2 Y220 F6000  ; go to X=0 Y=220


; =========================================================================================================
;
; for #CARIBOU_VARIANT
;
; Executed before each print - BEFORE ANY SLICER CODE IS RAN
; This also loads the heightmap
;
; =========================================================================================================
;
M122                                   ; Clear diagnostic data to cleanly capture print evolution statistics.
T0                                     ; Ensure the tool is selected
; #CARIBOU_ZPROBE
M572 D0 S0.0                           ; Clear pressure advance.
M220 S100                              ; Set speed factor back to 100% in case it was changed
M221 S100                              ; Set extrusion factor back to 100% in case it was changed
M290 R0 S0                             ; Clear any baby-stepping
M106 S0                                ; Turn part cooling blower off if it is on
M703                                   ; Execute loaded filament's config.g
G32                                    ; execute bed.g (level gantry)
G29 S1                                 ; Load bed mesh for the system's set filament type
M400                                   ; Finish all moves, clear the buffer
G90                                    ; Absolute Positioning
M83                                    ; Extruder relative mode
M98 P"0:/sys/current-sense-normal.g"   ; Ensure that motor currents and sense are set for printing
;
; Slicer generated gcode takes it away from here ....
;
; =========================================================================================================

; =========================================================================================================
;
;  called when M0 (Stop) is run (e.g. when a print is cancelled)
;
; =========================================================================================================
;
M104 S0             ; turn off temperature
M140 S0             ; turn off heatbed
M107                ; turn off fan
G91                 ; set relaitive postitioning
G1 H2 Z10           ; lift z axis 10mm
G90                 ; set absolute postitioning
G1 H2 X0 Y210 F4000 ; move bed to front


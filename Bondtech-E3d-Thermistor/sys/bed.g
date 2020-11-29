; =========================================================================================================
;
; bed.g
; called to perform automatic bed compensation via G32
;
; =========================================================================================================
;
G28                                     ; Home-all
M561 									; clear any bed transform
G29 S2 									; Clear height map
G29  									; probe the bed and enable compensation
G1 X0 Y0 F6000							; Go to X0 Y0
;



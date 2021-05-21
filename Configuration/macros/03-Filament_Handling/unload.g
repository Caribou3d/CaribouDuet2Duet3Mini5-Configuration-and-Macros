; =========================================================================================================
;
; filament unload macro
;
; for #CARIBOU_VARIANT
;
; =========================================================================================================
;
T0                     ; select tool
G91                    ; set to Relative Positioning
M913 E100              ; set motor current to 100% of set current;
G1 E10 F200            ; feed 10mm of filament at 200mm/min
;
M291 P"Now retracting filament..." R"Unloading Filament" T5 ; Display message
;
G1 E-8 F2000           ; retract 8mm of filament at 2000mm/min
G1 E-#CARIBOU_FINALUNLOAD F2500          ; retract #CARIBOU_FINALUNLOADmm of filament at 2500mm/min
M291 P"..... done" T30
M292
;
; =========================================================================================================
;


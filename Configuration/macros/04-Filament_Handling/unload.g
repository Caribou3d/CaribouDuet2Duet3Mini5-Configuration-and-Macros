; =========================================================================================================
;
T0		               ; Select tool
G91                    ; Set to Relative Positioning
M913 E100              ; Set motor current to 100% of set current;
G1 E10 F200            ; Feed 10mm of filament at 200mm/min
;
M291 P"Now retracting filament..." R"Unloading Filament" T5 ; Display message
G1 E-8 F2000           ; Retract 8mm of filament at 2000mm/min
G1 E-95 F2500          ; Retract 95mm of filament at 2500mm/min
M291 P"..... done" T30
M292
;
; =========================================================================================================
;


; =========================================================================================================
;
G91               ; Set to Relative Positioning
M913 E100         ; Set motor current to 100% of set current;
G1 E5 F200        ; Feed 50mm of filament at 300mm/min
;
M291 P"Now retracting filament..." R"Unloading Filament" T5 ; Display another message
G1 E-8 F2000      ; Retract 3mm of filament at 1400mm/min
G1 E-95 F2500     ; Retract 120mm of filament at 2000mm/min
M291 P"..... done" T30
M292
;
; =========================================================================================================
;


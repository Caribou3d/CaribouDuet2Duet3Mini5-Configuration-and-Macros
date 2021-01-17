; =========================================================================================================
;
M300 S500 P600         ; beep
T0		               ; Select tool
M291 P"Insert filament. Press ok to start feeding filament..." S2       ; Display new message
M291 P"Feeding filament.... " S1 T25
;
G91                    ; Set to Relative Positioning
G1 E90 F400	           ; Feed 10mm of filament at 300mm/min
G1 E15 F200	           ; Feed 90mm of filament at 1000mm/min
G4 P1000	           ; Wait one second
;
M98 P"0:/macros/09 Filament Handling/purge.g"
;
G1 E-0.5 F200	       ; Retract 2mm of filament at 400mm/min
M291 P"..... done" T30
M400                   ; Wait for the moves to finish
;
M104 S0   		       ; turn off temperature
M140 S0                ; turn off heatbed
M107    	           ; turn off fan
;
; =========================================================================================================

;SEQUENCE PURGE FILAMENT
T0		; Select tool
;
while true
	M291 P"Press OK to purge..."  S3
	G1 E20 F100                	; extrude 20mm
	M300 S500 P200				; play beep sound
	G4 P200						; pause for 200ms
	M300 S600 P300				; play beep sound
	G4 P1000					; pause for 1000ms
;


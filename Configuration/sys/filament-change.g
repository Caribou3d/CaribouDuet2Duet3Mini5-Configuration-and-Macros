; =========================================================================================================
;
; 0:/sys/filament-change.g
; Called when a print from SD card runs out of filament
;
; =========================================================================================================
;
M25                                                    ; pause printing
;
G91                                                    ; set relative positioning
G1 Z5 F360                                             ; lift z by 5mm
G90                                                    ; set absolute positioning
echo move.axes[2].machinePosition
if  {move.axes[2].machinePosition < 80}                ; if z position is below 80mm
    G1 X200 Y0 Z80 F6000                               ; go to the parking position
else
    G1 X200 Y0 F6000                                   ; go to the parking position
;
M300 S500 P600                                         ; beep
;
M291 R"Unloading Filament..." P"Press OK to start." S2            ; display message
;
G91                    ; set to Relative Positioning
M913 E100              ; set motor current to 100% of set current;
;
G1 E4 F300             ; extrude 4mm of filament at 300mm/min
G1 E-8 F3000           ; retract 8mm of filament at 3000mm/min
G1 E-#CARIBOU_FINALUNLOAD F2500          ; retract #CARIBOU_FINALUNLOADmm of filament at 2500mm/min
;
M400
M292
;
if {move.axes[1].workplaceOffsets[1] == 1}                             ; if autoload is enabled
    M581 P1 T2 S-1 R0                                                  ; filament sensor P1 triggers Trigger2.g always (R0)  TRIGGER OFF
    M950 J1 C"nil"                                                     ; free input 1 e0 filament sensor 
    M591 D0 P2 C"e0stop" S1                                            ; filament runout sensor;
    while {sensors.filamentMonitors[0].status != "noFilament"}         ; check filament status
        M291 P"Please pull out filament!" S2                           ; ask pull out filament
;
M400                                                                   ; finish all moves, clear the buffer.
M300 S500 P600                                                         ; beep
M291 R"Insert filament." P"Press OK to start feeding filament..." S2   ; display new message
M291 P"Feeding filament.... " S1
;
G91                                                                    ; set to Relative Positioning
G1 E#CARIBOU_INITIALLOAD F400                                                            ; feed #CARIBOU_INITIALLOADmm of filament at 400mm/min
G1 E15 F200                                                            ; feed 15mm of filament at 200mm/min
M400                                                                   ; finish all moves, clear the buffer.
;
while true
	M291 R"Purging needed?" P"Press OK to purge, press Cancel if color is correct."  S3
	G1 E20 F100                     ; extrude 20mm
	M300 S500 P200                  ; play beep sound
	G4 P200                         ; pause for 200ms
	M300 S600 P300                  ; play beep sound
	G4 P1000                        ; pause for 1000ms
;
M400                                                                   ; finish all moves, clear the buffer.
;
M291 P"Press OK to resume print." S2                                   ; display message
M24                                                                    ; recover the last state pushed onto the stack.
;
; =========================================================================================================

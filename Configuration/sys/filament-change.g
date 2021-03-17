; =========================================================================================================
;
; 0:/sys/filament-change.g
; Called when a print from SD card runs out of filament
;
; =========================================================================================================
;
M25
G91                                                    ; set relative positioning.
G1 Z20 F360                                            ; raise the Z axis 20mm.
G90                                                    ; set absolute positioning.
G1 X200 Y0 F6000                                       ; go to the parking position.
M300 S800 P8000                                        ; play a beep sound.
;
M98 P"0:/macros/Filament Handling"                     ; unload and load filament using the macro.
M400                                                   ; finish all moves, clear the buffer.
;
M291 P"Press OK to recommence print." R"Filament Handling" S2
;
M98 P"0:/macros/Heat Nozzle"                           ; get nozzle hot to continue the print.
M116                                                   ; wait for all temperatures, shouldn't need this but just incase.
M121                                                   ; recover the last state pushed onto the stack.
;
; =========================================================================================================

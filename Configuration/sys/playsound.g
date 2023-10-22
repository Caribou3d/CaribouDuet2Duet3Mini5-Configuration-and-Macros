; =========================================================================================================
;
; play little start tune
;
; =========================================================================================================
;
; start tune
;
M400                                                                   ; finish all moves, clear the buffer
G4 S1                                                                  ; wait 1 second
M300 P200 S523.25                                                      ; play sound
G4 P250                                                                ; wait 250 milliseconds
M300 P200 S659.25                                                      ; play sound
G4 P250                                                                ; wait 250 milliseconds
M300 P200 S739.99                                                      ; play sound
G4 P300                                                                ; wait 300 milliseconds
M300 P285 S880.00                                                      ; play sound
G4 P500                                                                ; wait 500 milliseconds
M300 P285 S880.00                                                      ; play sound
G4 P335                                                                ; wait 335 milliseconds
M300 P625 S739.99                                                      ; play sound
G4 S1                                                                  ; wait 1 second
M400                                                                   ; finish all moves, clear the buffer
;
; =========================================================================================================
;
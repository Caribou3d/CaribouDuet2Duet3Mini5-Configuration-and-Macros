; =========================================================================================================
;
; called when a filament error occurs
;
; =========================================================================================================
;
; printer not printing, so we change mode to autoload, if activated
;
if state.status != "processing"                                        ; printer is not currently printing!
    if (global.filamentErrorIgnore != 1)                               ; leave when deactivated
        M292 P1                                                        ; cancel previous operation
        M300 S500 P600                                                 ; beep
        G4 P2000                                                       ; wait two seconds
        M291 P"Filament removed ..." S1 T15                            ; display message
    if {move.axes[0].workplaceOffsets[8] == 1}                         ; if filament sensor is active
        if {move.axes[1].workplaceOffsets[8] == 1}                     ; if autoload is active
            M98 P"0:/sys/00-Functions/ActivateAutoload"                ; activate autoload
    M99
;
; printer ran out of filament during print and filament change is initiated
;
M25                                                                    ; pause printing
M400                                                                   ; finish all moves, clear the buffer.
;
; =========================================================================================================
set global.AskToChange = 0                                             ; don't ask if filament should be changed
M98 P"0:/sys/00-Functions/ChangeFilament"                              ; call load filament macro
set global.AskToChange = 1                                             ; ask if filament should be changed
; =========================================================================================================
;
M291 P"Press OK to resume print." S2                                   ; display message
M24                                                                    ; resume printing
;
; =========================================================================================================
;
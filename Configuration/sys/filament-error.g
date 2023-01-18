; =========================================================================================================
;
; called when a filament error occurs
;
; =========================================================================================================
;
; printer not printing, so we change mode to autoload, if activated
;
if state.status != "processing"                                        ; printer is not currently printing!
    M300 S500 P600                                                     ; beep
    G4 P2000                                                           ; wait two seconds
    M291 P"Filament removed ..." S1 T15                                ; display message
    if {move.axes[0].workplaceOffsets[8] == 1}                         ; if filament sensor is active
        if {move.axes[1].workplaceOffsets[8] == 1}                     ; if autoload is active
            M98 P"0:/sys/00-Functions/ActivateAutoload"                ; activate autoload
    M99
;
; printer ran out of filament during print and filament change is initiated
;
M83                                                                    ; relative extruder moves
G1 E-1 F3600                                                           ; retract 1mm of filament
M83                                                                    ; relative extruder moves
G1 E-1 F3600                                                           ; retract 2mm of filament
;
set global.zLiftDistance = 5                                           ; set distance to lift
M98 P"0:/sys/00-Functions/zLift"                                       ; call macro to lift z
;
; =========================================================================================================
;
M98 P"0:/macros/02-Filament_Handling/03-Change_Filament"               ; call macro to unload filament
;
; =========================================================================================================
;
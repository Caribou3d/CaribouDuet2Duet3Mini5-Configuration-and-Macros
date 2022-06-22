; =========================================================================================================
;
; called when a filament error occurs
;
; =========================================================================================================
;
; printer not printing, so we change mode to autoload, if activated
;
if state.status != "processing"                                        ; printer is not currently printing!
    if {move.axes[0].workplaceOffsets[8] == 1}                         ; if filament sensor is active
        if {move.axes[1].workplaceOffsets[8] == 1}                     ; if autoload is active
            M98 P"0:/sys/00-Functions/ActivateAutoload"                ; activate autoload
    M99
;
; printer ran out of filament during print and filament change is initiated
;
M83                                                                    ; relative extruder moves
G1 E-2 F3600                                                           ; retract 2mm of filament
G91                                                                    ; relative positioning
G1 Z5 F360                                                             ; lift z by 5mm
G90                                                                    ; set absolute positioning
if  {move.axes[2].machinePosition < 80}                                ; if z position is below 80mm
    G1 X200 Y0 Z80 F6000                                               ; go to the parking position
else
    G1 X200 Y0 F6000                                                   ; go to the parking position
;
; =========================================================================================================
;
M98 P"0:/macros/01-Filament_Handling/03-Change_Filament"               ; call macro to unload filament
;
; =========================================================================================================
;
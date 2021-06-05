; =========================================================================================================
;
; 0:/sys/filament-change.g
;
;
; =========================================================================================================
;
M98 P"0:macros/01-Filament_Handling/Change_Filament"
;
M98 P"0:/sys/00-Functions/FilamentsensorStatus"                           ; update sensor status
;
M291 P"Press OK to resume print." S2                                   ; display message
M24                                                                    ; recover the last state pushed onto the stack.
;
; =========================================================================================================

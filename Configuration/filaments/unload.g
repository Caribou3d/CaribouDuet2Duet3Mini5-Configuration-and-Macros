; =========================================================================================================
;
;  Prepare to un-load #FILAMENT_NAME at #FILAMENT_TEMPERATURE°C
;
; =========================================================================================================
;
M291 P"Prepare for filament un-loading. Please wait while the nozzle is being heated up. Press OK to continue or CANCEL to abort." R"Unloading #FILAMENT_NAME at #FILAMENT_TEMPERATURE°C" S3;
;
M291 P"Please wait while the nozzle is being heated up" R"Heating: #FILAMENT_TEMPERATURE°C" T30 ; Display message
;
G91                                             ; relative positioning
G1 Z20 F6000 H2                                 ; lift Z relative to current position
M104 S#FILAMENT_TEMPERATURE	                                    ; Set current tool temperature to filament #FILAMENT_TEMPERATURE°C
M116        	                                ; Wait for the temperatures to be reached
;
M98 P"0:/macros/04-Filament_Handling/unload.g"  ; execute macro to load and purge filament
;
; =========================================================================================================

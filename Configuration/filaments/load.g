; =========================================================================================================
;
;  Prepare to load #FILAMENT_NAME at #FILAMENT_TEMPERATURE°C
;
; =========================================================================================================
;
M291 P"Prepare for filament loading. Please wait while the nozzle is being heated up. Press OK to continue or CANCEL to abort." R"Loading #FILAMENT_NAME at #FILAMENT_TEMPERATURE°C" S3;
;
M291 P"Please wait while the nozzle is being heated up" R"Heating: #FILAMENT_TEMPERATURE°C" S1 ; Display message
;
G91                                                    ; relative positioning
G1 Z20 F6000 H2                                        ; lift Z relative to current position
M104 S#FILAMENT_TEMPERATURE	                                           ; set current tool temperature to filament #FILAMENT_TEMPERATURE°C
M116        	                                       ; wait for the temperatures to be reached
;
M292                                                   ; close message
;
M98 P"0:/macros/01-Filament_Handling/00-Load_Filament"    ; execute macro to load and purge filament
;
; =========================================================================================================

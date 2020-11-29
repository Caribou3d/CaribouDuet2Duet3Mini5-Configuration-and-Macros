M291 P"Prepare for filament un-loading. Please wait while the nozzle is being heated up. Press OK to continue or CANCEL to abort." R"Unloading HIPS at 240°C" S3;
;
M291 P"Please wait while the nozzle is being heated up" R"Heating: 240°C" T30 ; Display message
G91                ; relative positioning
;G1 Z20 F6000 H2   ; lift Z relative to current position
M104 S240          ; Set current tool temperature to 240C
M116               ; Wait for the temperatures to be reached
;
M98 P"0:/macros/09 Filament Handling/unload.g"
;

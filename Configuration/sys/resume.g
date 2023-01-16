; =========================================================================================================
;
; called before a print from SD card is resumed
;
; =========================================================================================================
;
M98 P"0:/sys/00-Functions/FindToolSelected"                            ; find selected tool
;
if {global.ToolSelected = -1}
    M291 R"No tool selected!" P"Please activate one tool first." S2    ; display new message
    M99
;
if {global.ToolSelected < 2}
    if heat.heaters[global.ToolSelected+1].current < heat.coldExtrudeTemperature          ; check extrude temperature
        if heat.heaters[global.ToolSelected+1].current < heat.coldRetractTemperature      ; check retract temperature
            M291 R{"Hotend " ^ global.ToolSelected ^ " too cold!"} P{"Preheat first!"} S2 ; ask to preheat extruder
            M99
else
    if heat.heaters[1].current < heat.coldExtrudeTemperature           ; check extrude temperature
        if heat.heaters[1].current < heat.coldRetractTemperature       ; check retract temperature
           M291 R{"Hotend 0 too cold!"} P{"Preheat first!"} S2         ; ask to preheat extruder
           M99
    if heat.heaters[2].current < heat.coldExtrudeTemperature           ; check extrude temperature
        if heat.heaters[2].current < heat.coldRetractTemperature       ; check retract temperature
           M291 R{"Hotend 1 too cold!"} P{"Preheat first!"} S2         ; ask to preheat extruder
           M99
;
M98 P"current-sense-normal.g"                                          ; ensure the drivers current and sensitivity is set for normal routines
G1 R1 X0 Y0 Z5 F2000                                                   ; go to 5mm above position of the last print move
G1 R1 X0 Y0                                                            ; go back to the last print move
M83                                                                    ; relative extruder moves
G1 E2 F3600                                                            ; extrude 2mm of filament
M121                                                                   ; recover the last state pushed onto the stack
;
; =========================================================================================================
;
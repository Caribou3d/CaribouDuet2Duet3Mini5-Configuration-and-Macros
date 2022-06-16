; =========================================================================================================
;
; turn heating of when printer is idle for a period of time
;
; =========================================================================================================
;
if (state.status == "processing")
    set global.IdleCounter = 0                                         ; set counter to 0 when printing
if ((heat.heaters[0].state = "off") && (heat.heaters[1].state = "off"))
   set global.IdleCounter = 0                                          ; set counter to 0 when bed is off and heater  is not active
;
if (global.BedTempActive_Old != heat.heaters[0].active)
    set global.BedTempActive_Old = heat.heaters[0].active
    set global.IdleCounter = 0                                         ; set counter to 0 when bed active has been changed
;
if (global.ExtruderTempActive_Old != heat.heaters[1].active)
    set global.ExtruderTempActive_Old = heat.heaters[1].active
    set global.IdleCounter = 0                                         ; set counter to 0 when extruder active has been changed
;
if !(state.status == "processing")
    if (!(heat.heaters[0].state = "off") || !(heat.heaters[1].state = "off"))
        set global.IdleCounter = global.IdleCounter +1                 ; when idle increase counter
;
if (global.IdleCounter >= 90)                                          ; turn heating off after 15min
    M291 P{"Idle time: " ^ global.IdleCounter / 6 ^ " min."} S1 T5     ; display approx. idle time
    G4 S5                                                              ; wait 5 seconds
    M98 P"0:/macros/00-Turn_Heating_Off"                               ; call macro to turn heating off
;
; =========================================================================================================
;
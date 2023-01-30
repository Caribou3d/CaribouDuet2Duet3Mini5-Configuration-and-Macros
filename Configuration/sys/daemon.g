; =========================================================================================================
;
; turn heating of when printer is idle for a period of time
;
; =========================================================================================================
;
var idle_time = 90                                                     ; unit of 10 seconds, 1min -> idle_time = 6
;
if (state.status == "processing")
    set global.IdleCounter = 0                                         ; set counter to 0 when printing
;
if ((heat.heaters[0].state = "off") && (heat.heaters[1].state = "off"))
   set global.IdleCounter = 0                                          ; set counter to 0 when bed is off and heater is not active
;
if ((heat.heaters[0].state = "tuning") || (heat.heaters[1].state = "tuning"))
   set global.IdleCounter = 0                                          ; set counter to 0 when bed or heater  are running a PID tuning is not active
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
if (global.IdleCounter >= var.idle_time)                               ; turn heating off after 15min
    M300 S500 P2000                                                    ; beep
    echo {"Idle time: " ^ global.IdleCounter / 6 ^ " min."}
    echo "Turning heaters off ..."
    M98 P"0:/macros/00-Turn_Heating_Off"                               ; call macro to turn heating off
;
; =========================================================================================================
;
;  take care of babysteps
;
if state.status = "processing"                                         ; printer is currently printing!
    set global.OldStateStatus = 1
;
; save babysteps after print
;
if (!(state.status == "processing"))
    if (!(state.status == "pausing") && !(state.status == "paused"))
        if (!(state.status == "resuming") && global.OldStateStatus = 1) ; print just finished
            if move.axes[2].babystep !=0                               ; if no babysteps are currently adjusted - exit routine
                G31 Z{sensors.probes[0].triggerHeight - move.axes[2].babystep}
                M500 P10:31                                            ; save settings to config-overide.g
                M290 R0 S0                                             ; set babystep to 0mm absolute
                set global.OldStateStatus = 0
                echo "babysteps saved"
;
; =========================================================================================================
;
if (global.waitForExtruderTemperature == true)                         ; if pre-heating
    if (heat.heaters[1].current >= heat.heaters[1].active)
        echo "Extruder temperature reached."                           ; display new message
        M300 S500 P1000                                                ; beep when temperature is reached
        set global.waitForExtruderTemperature = false
;
; =========================================================================================================
;
if (global.waitForBedTemperature == true)                              ; if pre-heating
    if (heat.heaters[0].current >= heat.heaters[0].active)
        echo "Bed temperature reached."                                ; display new message
        M300 S500 P1000                                                ; beep when temperature is reached
        set global.waitForBedTemperature = false
;
; =========================================================================================================
;

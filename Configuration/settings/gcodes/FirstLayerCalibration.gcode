; =========================================================================================================
;
; First layer calibration gcode
; temperatures are set via global variables
;
; ====== start preheat start script =======================================================================
;
G90                                                                    ; use absolute coordinates
M83                                                                    ; extruder relative mode
;
if !move.axes[0].homed || !move.axes[1].homed || !move.axes[2].homed
    G28                                                                ; home all axis without mesh bed level
G0 X125 Y-7 Z80                                                        ; move extruder above bed keep extruder in front for cleaning and checking
;
M568 P0 S{global.calibration_nozzle_temperature} R{global.calibration_nozzle_temperature-50} A1 ; set current tool temperatures
;
M140 S{global.calibration_bed_temperature}                             ; set temperature for bed
M190 S{global.calibration_bed_temperature}                             ; wait for bed temp
;
G29                                                                    ; mesh bed leveling
G0 X0 Y-3 Z0 F3000                                                     ; move to home position
;
M568 P0 A2                                                             ; wait for extruder temperature
M116 P0                                                                ; wait for heater temperature
;;
M572 D0 S0.00                                                          ; set pressure advance
;
; play start tune
M98 P"0:/sys/playsound.g"
;
; ===== end preheat start script ==========================================================================
;
; =========================================================================================================
; start introLine
;
G1 Y-3.0 F1000.0                                                       ; go outside print area
G92 E0.0
G1 X60.0 E5.0 F1000.0                                                  ; intro line
G1 X100.0 E7.0 F1000.0                                                 ; intro line
;
; done introline
; =========================================================================================================
; start meander
G1 Z0.50 F7200.000
G1 X50 Y155 F6000
G1 Z0.150 F7200.000
G1 F1080
G1 X75 Y155 E2.5
G1 X100 Y155 E2
G1 X200 Y155 E2.62773
G1 X200 Y135 E0.66174
G1 X50 Y135 E3.62773
G1 X50 Y115 E0.49386
G1 X200 Y115 E3.62773
G1 X200 Y95 E0.49386
G1 X50 Y95 E3.62773
G1 X50 Y75 E0.49386
G1 X200 Y75 E3.62773
G1 X200 Y55 E0.49386
G1 X50 Y55 E3.62773
; done meander
; =========================================================================================================
; start Rectangle
G1 X50 Y35 E0.738
G1 X80 Y35.00 E0.738
G1 Y34.60 E0.010
G1 X50 Y34.60 E0.738
G1 Y34.20 E0.010
G1 X80 Y34.20 E0.738
G1 Y33.80 E0.010
G1 X50 Y33.80 E0.738
G1 Y33.40 E0.010
G1 X80 Y33.40 E0.738
G1 Y33.00 E0.010
G1 X50 Y33.00 E0.738
G1 Y32.60 E0.010
G1 X80 Y32.60 E0.738
G1 Y32.20 E0.010
G1 X50 Y32.20 E0.738
G1 Y31.80 E0.010
G1 X80 Y31.80 E0.738
G1 Y31.40 E0.010
G1 X50 Y31.40 E0.738
G1 Y31.00 E0.010
G1 X80 Y31.00 E0.738
G1 Y30.60 E0.010
G1 X50 Y30.60 E0.738
G1 Y30.20 E0.010
G1 X80 Y30.20 E0.738
G1 Y29.80 E0.010
G1 X50 Y29.80 E0.738
G1 Y29.40 E0.010
G1 X80 Y29.40 E0.738
G1 Y29.00 E0.010
G1 X50 Y29.00 E0.738
G1 Y28.60 E0.010
G1 X80 Y28.60 E0.738
G1 Y28.20 E0.010
G1 X50 Y28.20 E0.738
G1 Y27.80 E0.010
G1 X80 Y27.80 E0.738
G1 Y27.40 E0.010
G1 X50 Y27.40 E0.738
G1 Y27.00 E0.010
G1 X80 Y27.00 E0.738
G1 Y26.60 E0.010
G1 X50 Y26.60 E0.738
G1 Y26.20 E0.010
G1 X80 Y26.20 E0.738
G1 Y25.80 E0.010
G1 X50 Y25.80 E0.738
G1 Y25.40 E0.010
G1 X80 Y25.40 E0.738
G1 Y25.00 E0.010
G1 X50 Y25.00 E0.738
G1 Y24.60 E0.010
G1 X80 Y24.60 E0.738
G1 Y24.20 E0.010
G1 X50 Y24.20 E0.738
G1 Y23.80 E0.010
G1 X80 Y23.80 E0.738
G1 Y23.40 E0.010
G1 X50 Y23.40 E0.738
G1 Y23.00 E0.010
G1 X80 Y23.00 E0.738
G1 Y22.60 E0.010
G1 X50 Y22.60 E0.738
G1 Y22.20 E0.010
;
; done rectangle
;
; =========================================================================================================
; start end script
;
G1 F1000.0                                                             ; set feed rate
G1 E-2                                                                 ; retract 2mm
G10 P0 S-274 R-274                                                     ; turn off extruder
M140 S0 R0                                                             ; set bed temperature to 0C
M140 S-274                                                             ; set bed temperature to 0K to turn it off
M106 T0 S0                                                             ; turn off cooling fan
G1 X0 Y200 F7200                                                       ; home XY axis
M84 XY                                                                 ; disable motors
;
; done end script
; =========================================================================================================
;
; print results
;
if (move.axes[2].babystep !=0)                                        ; if no babysteps are currently adjusted - exit routine
   var newoffset = sensors.probes[0].triggerHeight - move.axes[2].babystep
   M290 R0 S0                                                         ; set babystep to 0mm absolute
   M291 R{"z-Offset"} P{"Current: " ^ sensors.probes[0].triggerHeight ^ ", Babysteps:" ^ move.axes[2].babystep ^ ", New: " ^ var.newoffset} S2
   M291 P{"Press OK to save or CANCEL to abort."} R{"Setting z-Offset to " ^ var.newoffset ^ "?"}  S3
   M400                                                               ; finish all current moves / clear the buffer
   G31 Z{var.newoffset}                                               ; set G31 z offset to corrected
   echo >"0:/settings/Set-Probe-Z-Offset.g" "G31 Z"^{var.newoffset}^"  ; set z-offset"
   G28                                                                ; home all axes without mesh bed level
   G90
else
   M291 P"Babysteps are 0.00. z-offset will not be changed." S1
;
; =========================================================================================================
;
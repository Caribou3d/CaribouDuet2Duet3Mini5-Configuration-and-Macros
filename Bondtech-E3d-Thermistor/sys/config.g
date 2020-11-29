; =========================================================================================================
;
; Configuration file for Duet WiFi (firmware version 3)           Version 20201129
; for 0.9° motors on xyz
; extruder heater connected on E1
; PINDA
;
; for CaribouDuet320
;
; =========================================================================================================
; Network settings
; =========================================================================================================
;
M550 P"CaribouDuet320"                                 ; set printer name
;
M552 S1                                                ; enable network
M586 P0 S1                                             ; enable HTTP
M586 P1 S1                                             ; enable FTP
M586 P2 S0                                             ; disable Telnet
M575 P1 S1 B57600                                      ; Enable support for PanelDue
;
; =========================================================================================================
; Drives
; =========================================================================================================
;
M569 P0 S0                                      	    ; physical drive 0 goes backwards - x-axis
M569 P1 S0                                       	    ; physical drive 1 goes backwards - y-axis
M569 P2 S0                                       	    ; physical drive 2 goes backwards - z - left
M569 P3 S1                                       	    ; physical drive 3 goes forwards  - Extruder
M569 P4 S0						                        ; physical drive 4 goes backwards - z right
;
; Motor Configuration
;
M584 X0 Y1 Z2:4 E3                                 	    ; set drive mapping
M671 X-36.5:293.5 Y0:0 S0.35 		   	            ; leadscrews at left (connected to Z) and right (connected to E1) of X axis
;
; set Microsteps and steps / mm
;
M350 X16 Y16 Z16 E16 I1                                 ; configure microstepping with interpolation
M92 X200.00 Y200.00 Z400.00 E830.00                     ; set steps per mm
;
; set motor currents
;
M906 X800 Y850 Z450 E550 I40                            ; set motor currents (mA) and motor idle factor in per cent
;
M84 S60                                                 ; Set idle timeout
;
; set speeds
;
M201 X500.00 Y500.00 Z100.00 E500.00                    ; set accelerations (mm/s^2)
M203 X9000.00 Y9000.00 Z1000.00 E3600.00                ; set maximum speeds (mm/min)
M204 P500.0 T500.0                                      ; set print and travel accelerations (mm(s^2)
M566 X480.00 Y480.00 Z48.00 E300.00                     ; set maximum instantaneous speed changes (mm/min)
;
M564 H0                                                 ; Allow unhomed movement
;
; =========================================================================================================
; Axis Limits
; =========================================================================================================
;
M208 X-2 Y-7.5 Z0 S1                                    ; set axis minima
M208 X256.9 Y214 Z316.50 S0                             ; set axis maxima
;
; =========================================================================================================
; Endstops
; =========================================================================================================
;
M574 X1 S3                                              ; configure sensorless endstop for low end on X
M574 Y1 S3                                              ; configure sensorless endstop for low end on Y
M574 Z1 S2                                              ; configure Z-probe endstop for low end on Z
M574 Z2 S3                                              ; configure sensorless endstop for high end on Z
M591 D0 P2 C"e0_stop" S1				                ; configure extruder endtstop (filament sensor)
;
M950 S3 C"exp.heater3"                                  ; create servo pin 0 for BLTouch
M558 P5 C"zprobe.in" H1.5 F1000 T12000 A3               ; set Z probe to PINDA
M557 X23:235 Y5:186 S30.25:30                           ; define mesh grid
;
M574 Z1 S2                                                ; Set endstops controlled by probe
M308 S1 P"e0temp" A"Pinda V2" Y"thermistor" T100000 B3950 ; USE FOR PINDA!
;
;
; Stallguard Sensitivy
;
M915 X S2 F0 H400 R0		        	 				; Set X axis Sensitivity
M915 Y S1 F0 H400 R0		          	 				; Set Y axis Sensitivity
M915 Z S0 F0 H200 R0		          	 				; Set Z axis Sensitivity
;
;
; =========================================================================================================
; Heater & Fans
; =========================================================================================================
;
; heated bed
; =========================================================================================================
;
M308 S0 P"bedtemp" Y"thermistor" T100000 B4138 R4700 A"Bed"  ; configure sensor 0 as thermistor on pin bedtemp
M950 H0 C"bedheat" T0                                        ; create bed heater output on bedheat and map it to sensor 0
M143 H0 S110                                                 ; set temperature limit for heater 0 to 110C
M307 H0 B0 S1.00                                             ; disable bang-bang mode for the bed heater and set PWM limit
M140 H0                                                      ; map heated bed to heater 0
;
; =========================================================================================================
;
; extruder
; =========================================================================================================
;
; Hotend (E3d / Mosquito / Mosquito Magnum w/ E3d Thermistor)
;
M308 S1 P"e0temp" Y"thermistor" T100000 B4725 C7.060000e-8 R4700 A"Nozzle E1"  ;  E3d   configure sensor 0 as thermistor on pin e0temp
;
M950 H1 C"e0heat" T1                                        ; create nozzle heater output on e0heat and map it to sensor 2
M307 H1 B0 S1.00                                            ; disable bang-bang mode for heater  and set PWM limit
M143 H1 S280                                                ; set temperature limit for heater 1 to 280C
;
; =========================================================================================================
;
M308 S4 P"mcu-temp" Y"mcu-temp" A"MCU"			            ; set virtual heater for MCU
M308 S5 P"drivers" Y"drivers" A"Driver"			            ; set virtual heater for stepper drivers
;
; =========================================================================================================
; Fans
; =========================================================================================================
;
; extruder fan (temerature controlled)
;
M950 F1 C"fan1" Q500                                     ; create fan 1 on pin fan0 and set its frequency
M106 P1 H1 T45
;
; radial fan
;
M950 F0 C"fan0" Q500                                     ; create fan 0 on pin fan1 and set its frequency
M106 P0 S0 H-1                                           ; set fan 0 value. Thermostatic control is turned off
;
; ========================================================================================================
; Tools
; =========================================================================================================
;
M563 P0 D0 H1 F0                                         ; define tool 0
G10 P0 X0 Y0 Z0                                          ; set tool 0 axis offsets
G10 P0 R0 S0                                             ; set initial tool 0 active and standby temperatures to 0C
M302 S190 R190                                           ; allow extrusion starting from 190°C and retractions already from 190°C
;
; =========================================================================================================
; other settings
; =========================================================================================================
;
M18 XYE                                                  ; release / unlock X, Y, and E axis
M501 													 ; use config-override (for Thermistor Parameters)
G90                                                      ; send absolute coordinates...
M83                                                      ; ... but relative extruder moves
;
; =========================================================================================================
;
; Z-Offsets - Once done with babystepping place your final here for ease of use, then uncomment the one your currently using
;
;G31 P1000 X23 Y5 Z0.985                        ; PEI Sheet (Prusa) Offset Spool3D Tungsten Carbide
;G31 P1000 X23 Y5 Z0.440                        ; PEI Sheet (Prusa) Offset MICRO SWISS NOZZLE	
;G31 P1000 X23 Y5 Z1.285                        ; Textured Sheet (Prusa) Offset MICRO SWISS NOZZLE
;G31 P1000 X23 Y5 Z0.64                         ; Textured Sheet (thekkiinngg) Offset MICRO SWISS NOZZLE
;G31 P1000 X23 Y5 Z0.03                         ; Textured Sheet (thekkiinngg) Offset MICRO SWISS NOZZLE
;
; =========================================================================================================
;

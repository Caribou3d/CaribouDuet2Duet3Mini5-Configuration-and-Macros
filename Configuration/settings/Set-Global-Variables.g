; =========================================================================================================
;
; global variables
;
global IdleCounter = 0                                                 ; counts idle time
global ExtruderTempActive_Old = 0                                      ; stores extruder temperature for idle check
global BedTempActive_Old = 0                                           ; stores bed temperature for idle check
global OldStateStatus = 0                                              ; stores the status of the printer, processing = 1
global purge = 0                                                       ; stores status to purge when autoloading
global zLiftDistance = 0                                               ; stores distance for lifting z axis
global waitForNozzleTemperature = false                                ; beeps when pre-heat temperature is reached
global waitForBedTemperature = false                                   ; beeps when pre-heat temperature is reached
global AskToChange = 1                                                 ; ask if filament should be changed?
global x_accel = 0                                                     ; stores x accelerations (mm/s^2)
global x_jerk = 0                                                      ; stores x maximum instantaneous speed changes (mm/min)
global y_accel = 0                                                     ; stores y accelerations (mm/s^2)
global y_jerk = 0                                                      ; maximum y instantaneous speed changes (mm/min)
global filamentErrorIgnore = 0                                         ; enable / disable execution of filament-error.g
global filamentTriggerIgnore = 0                                       ; enable / disable execution of trigger2.g
global calibration_bed_temperature = 60                                ; set default bed_temperature
global calibration_nozzle_temperature = 215                            ; set default nozzle_temperature
;
; =========================================================================================================
;
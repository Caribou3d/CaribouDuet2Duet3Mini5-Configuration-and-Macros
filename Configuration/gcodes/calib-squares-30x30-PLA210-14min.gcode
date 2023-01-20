; G-Code generated by Simplify3D(R) Version 4.1.2
; Jul 26, 2021 at 3:38:04 PM
; Settings Summary
;   processName,Process2
;   applyToModels,calib-squares-30x30-2
;   profileName,CaribouDuet PLA (modified)
;   profileVersion,2021-06-05 11:43:31
;   baseProfile,Default
;   printMaterial,fillamentum PLA
;   printQuality,Normal 0.2
;   printExtruders,
;   extruderName,Primary Extruder
;   extruderToolheadNumber,0
;   extruderDiameter,0.4
;   extruderAutoWidth,0
;   extruderWidth,0.4
;   extrusionMultiplier,0.95
;   extruderUseRetract,1
;   extruderRetractionDistance,0.6
;   extruderExtraRestartDistance,0
;   extruderRetractionZLift,0.6
;   extruderRetractionSpeed,1500
;   extruderUseCoasting,0
;   extruderCoastingDistance,0.5
;   extruderUseWipe,0
;   extruderWipeDistance,2
;   primaryExtruder,0
;   layerHeight,0.2
;   topSolidLayers,3
;   bottomSolidLayers,4
;   perimeterOutlines,1
;   printPerimetersInsideOut,1
;   startPointOption,3
;   startPointOriginX,0
;   startPointOriginY,210
;   sequentialIslands,1
;   spiralVaseMode,0
;   firstLayerHeightPercentage,100
;   firstLayerWidthPercentage,105
;   firstLayerUnderspeed,0.15
;   useRaft,0
;   raftExtruder,0
;   raftTopLayers,3
;   raftBaseLayers,2
;   raftOffset,3
;   raftSeparationDistance,0.12
;   raftTopInfill,100
;   aboveRaftSpeedMultiplier,0.3
;   useSkirt,0
;   skirtExtruder,0
;   skirtLayers,1
;   skirtOutlines,2
;   skirtOffset,2
;   usePrimePillar,0
;   primePillarExtruder,999
;   primePillarWidth,12
;   primePillarLocation,7
;   primePillarSpeedMultiplier,1
;   useOozeShield,0
;   oozeShieldExtruder,999
;   oozeShieldOffset,2
;   oozeShieldOutlines,1
;   oozeShieldSidewallShape,1
;   oozeShieldSidewallAngle,30
;   oozeShieldSpeedMultiplier,1
;   infillExtruder,0
;   internalInfillPattern,Rectilinear
;   externalInfillPattern,Rectilinear
;   infillPercentage,15
;   outlineOverlapPercentage,20
;   infillExtrusionWidthPercentage,105
;   minInfillLength,2
;   infillLayerInterval,1
;   internalInfillAngles,45,-45
;   overlapInternalInfillAngles,0
;   externalInfillAngles,45,-45
;   generateSupport,0
;   supportExtruder,0
;   supportInfillPercentage,15
;   supportExtraInflation,0.3
;   supportBaseLayers,1
;   denseSupportExtruder,0
;   denseSupportLayers,1
;   denseSupportInfillPercentage,75
;   supportLayerInterval,1
;   supportHorizontalPartOffset,0.15
;   supportUpperSeparationLayers,1
;   supportLowerSeparationLayers,1
;   supportType,0
;   supportGridSpacing,2
;   maxOverhangAngle,10
;   supportAngles,0,90
;   temperatureName,Primary Extruder,Heated Bed
;   temperatureNumber,0,0
;   temperatureSetpointCount,2,2
;   temperatureSetpointLayers,1,2,1,8
;   temperatureSetpointTemperatures,210,210,55,60
;   temperatureStabilizeAtStartup,1,1
;   temperatureHeatedBed,0,1
;   fanLayers,1,3
;   fanSpeeds,0,60
;   blipFanToFullPower,0
;   adjustSpeedForCooling,1
;   minSpeedLayerTime,18
;   minCoolingSpeedSlowdown,20
;   increaseFanForCooling,0
;   minFanLayerTime,45
;   maxCoolingFanSpeed,100
;   increaseFanForBridging,1
;   bridgingFanSpeed,100
;   use5D,1
;   relativeEdistances,1
;   allowEaxisZeroing,1
;   independentExtruderAxes,0
;   includeM10123,0
;   stickySupport,1
;   applyToolheadOffsets,0
;   gcodeXoffset,0
;   gcodeYoffset,0
;   gcodeZoffset,0
;   overrideMachineDefinition,1
;   machineTypeOverride,0
;   strokeXoverride,250
;   strokeYoverride,210
;   strokeZoverride,320
;   originOffsetXoverride,0
;   originOffsetYoverride,0
;   originOffsetZoverride,0
;   homeXdirOverride,-1
;   homeYdirOverride,-1
;   homeZdirOverride,-1
;   flipXoverride,1
;   flipYoverride,-1
;   flipZoverride,1
;   toolheadOffsets,0,0|0,0|0,0|0,0|0,0|0,0
;   overrideFirmwareConfiguration,0
;   firmwareTypeOverride,RepRap (Marlin/Repetier/Sprinter)
;   GPXconfigOverride,r2
;   baudRateOverride,115200
;   overridePrinterModels,0
;   printerModelsOverride
;   startingGcode,; =========================================================================================================,;,; start script for S3d for CaribouDuet,;,; =========================================================================================================,;, if !move.axes[0].homed || !move.axes[1].homed || !move.axes[2].homed,        G28                                                               ; home all axis without mesh bed level,G0 X60 Y-3 Z80                ; move extruder above bed,;  keep extruder in front for cleaning and checking,;,M104 S160 T0                  ; pre-heat extruder to 160C,M140 S[bed0_temperature]      ; this will take the layer 1 temperature for bed 0,M190 S[bed0_temperature]      ; wait for bed temp,;,G29                           ; mesh bed leveling using defined mesh grid,G0 X0 Y-3 Z0.6                ; go outside print area,;,M104 S[extruder0_temperature] ; set extruder temperature,M109 S[extruder0_temperature] ; wait for extruder temp,;,; =========================================================================================================,;,;,M98 P"0:/sys/primeLine.g"     ; execute primeline macro,;,G92 E0.0                      ; set extruder position,;,M572 D0 S0.07                 ; set pressure advance,;,; =========================================================================================================,
;   layerChangeGcode,G1 [current_Z_position] F10000;
;   retractionGcode,
;   toolChangeGcode,
;   endingGcode,M106 S0 ; turn off cooling fan,M104 S0 ; turn off extruder,M140 S0 ; turn off bed,G1 F1000.0 ; set feed rate,G1 E-3 ; retract,G1 X0 Y200 F7200 ; home XY axis,M84 ; disable motors,
;   exportFileFormat,gcode
;   celebration,0
;   celebrationSong,Funky Town
;   postProcessing,{REPLACE "; outer perimeter\n" "; outer perimeter\nM204 S600\n"},{REPLACE "; inner perimeter\n" "; inner perimeter\nM204 S1000\n"},{REPLACE "; solid layer\n" "; solid layer\nM204 S1000\n"},{REPLACE "; infill\n" "; infill\nM204 S1000\n"}
;   defaultSpeed,4800
;   outlineUnderspeed,0.5
;   solidInfillUnderspeed,0.8
;   supportUnderspeed,0.7
;   rapidXYspeed,7200
;   rapidZspeed,1200
;   minBridgingArea,50
;   bridgingExtraInflation,0.5
;   bridgingExtrusionMultiplier,0.95
;   bridgingSpeedMultiplier,0.4
;   useFixedBridgingAngle,1
;   fixedBridgingAngle,0
;   applyBridgingToPerimeters,0
;   filamentDiameters,1.75|1.75|1.75|1.75|1.75|1.75
;   filamentPricesPerKg,24|46|46|46|46|46
;   filamentDensities,1.25|1.25|1.25|1.25|1.25|1.25
;   useMinPrintHeight,0
;   minPrintHeight,0
;   useMaxPrintHeight,0
;   maxPrintHeight,3.97
;   useDiaphragm,0
;   diaphragmLayerInterval,20
;   robustSlicing,1
;   mergeAllIntoSolid,0
;   onlyRetractWhenCrossingOutline,0
;   retractBetweenLayers,1
;   useRetractionMinTravel,0
;   retractionMinTravel,1
;   retractWhileWiping,1
;   onlyWipeOutlines,1
;   avoidCrossingOutline,0
;   maxMovementDetourFactor,3
;   toolChangeRetractionDistance,12
;   toolChangeExtraRestartDistance,-0.5
;   toolChangeRetractionSpeed,600
;   externalThinWallType,1
;   internalThinWallType,1
;   thinWallAllowedOverlapPercentage,20
;   singleExtrusionMinLength,0
;   singleExtrusionMinPrintingWidthPercentage,50
;   singleExtrusionMaxPrintingWidthPercentage,200
;   singleExtrusionEndpointExtension,0.2
;   horizontalSizeCompensation,0
G90
M83
M106 S0
; =========================================================================================================
;
; start script for S3d for CaribouDuet
;
; =========================================================================================================
;
 if !move.axes[0].homed || !move.axes[1].homed || !move.axes[2].homed
    G28                       ; home all axis without mesh bed level
G0 X125 Y-3 Z80               ; move extruder above bed,
;                               keep extruder in front for cleaning and checking
M568 P0 S210 R160 A1          ; set extruder temperatures
M140 S55                      ; this will take the layer 1 temperature for bed 0
M190 S55                      ; wait for bed temp
;
G29                           ; mesh bed leveling using defined mesh grid
G0 X0 Y-3 Z0.6                ; go outside print area
;
M568 P0 A2                    ; set extruder heater active
M116 P0                       ; wait for extruder temperature
;
; =========================================================================================================
;
M98 P"0:/sys/primeLine.g"     ; execute primeline macro
;
G92 E0.0                      ; set extruder position
;
M572 D0 S0.07                 ; set pressure advance
;
; =========================================================================================================
; process Process2
; layer 1, Z = 0.200
T0
G1 E-0.6000 F1500
G1 0.200 F10000;
; feature outer perimeter
; tool H0.200 W0.420
G1 Z0.600 F1200
G1 X10.210 Y119.790 F7200
G1 Z0.200 F1200
G1 E0.6000 F1500
G1 X10.210 Y90.210 E0.9814 F360
G1 X39.790 Y90.210 E0.9814
G1 X39.790 Y104.810 E0.4844
G1 X110.210 Y104.810 E2.3363
G1 X110.210 Y90.210 E0.4844
G1 X124.810 Y90.210 E0.4844
G1 X124.810 Y39.790 E1.6728
G1 X110.210 Y39.790 E0.4844
G1 X110.210 Y10.210 E0.9814
G1 X139.790 Y10.210 E0.9814
G1 X139.790 Y39.790 E0.9814
G1 X125.190 Y39.790 E0.4844
G1 X125.190 Y90.210 E1.6728
G1 X139.790 Y90.210 E0.4844
G1 X139.790 Y104.810 E0.4844
G1 X210.210 Y104.810 E2.3363
G1 X210.210 Y90.210 E0.4844
G1 X239.790 Y90.210 E0.9814
G1 X239.790 Y119.790 E0.9814
G1 X210.210 Y119.790 E0.9814
G1 X210.210 Y105.190 E0.4844
G1 X139.790 Y105.190 E2.3363
G1 X139.790 Y119.790 E0.4844
G1 X125.190 Y119.790 E0.4844
G1 X125.190 Y170.210 E1.6728
G1 X139.790 Y170.210 E0.4844
G1 X139.790 Y199.790 E0.9814
G1 X110.210 Y199.790 E0.9814
G1 X110.210 Y170.210 E0.9814
G1 X124.810 Y170.210 E0.4844
G1 X124.810 Y119.790 E1.6728
G1 X110.210 Y119.790 E0.4844
G1 X110.210 Y105.190 E0.4844
G1 X47.931 Y105.190 E2.0662
G1 X47.931 Y105.391 E0.0067
G1 X45.220 Y105.391 E0.0899
G1 X45.220 Y105.190 E0.0067
G1 X39.790 Y105.190 E0.1802
G1 X39.790 Y119.790 E0.4844
G1 X10.210 Y119.790 E0.9814
G1 E-0.6000 F1500
; feature external single extrusion
; tool H0.200 W0.663
G1 Z0.800 F1200
G1 X45.342 Y109.827 F7200
G1 Z0.200 F1200
G1 E0.6000 F1500
G1 X45.342 Y106.000 E0.2004 F360
G1 X45.342 Y105.800 E0.0105
G1 E-0.6000 F1500
; feature solid layer
; tool H0.200 W0.420
G1 Z0.800 F1200
G1 X39.270 Y90.546 F7200
G1 Z0.200 F1200
G1 E0.6000 F1500
G1 X39.454 Y90.730 E0.0086 F576
G1 X39.454 Y91.324 E0.0197
G1 X38.676 Y90.546 E0.0365
G1 X38.082 Y90.546 E0.0197
G1 X39.454 Y91.918 E0.0644
G1 X39.454 Y92.512 E0.0197
G1 X37.488 Y90.546 E0.0923
G1 X36.894 Y90.546 E0.0197
G1 X39.454 Y93.106 E0.1201
G1 X39.454 Y93.700 E0.0197
G1 X36.300 Y90.546 E0.1480
G1 X35.706 Y90.546 E0.0197
G1 X39.454 Y94.294 E0.1759
G1 X39.454 Y94.888 E0.0197
G1 X35.112 Y90.546 E0.2037
G1 X34.518 Y90.546 E0.0197
G1 X39.454 Y95.482 E0.2316
G1 X39.454 Y96.076 E0.0197
G1 X33.924 Y90.546 E0.2595
G1 X33.330 Y90.546 E0.0197
G1 X39.454 Y96.670 E0.2873
G1 X39.454 Y97.264 E0.0197
G1 X32.736 Y90.546 E0.3152
G1 X32.142 Y90.546 E0.0197
G1 X39.454 Y97.858 E0.3431
G1 X39.454 Y98.452 E0.0197
G1 X31.548 Y90.546 E0.3709
G1 X30.954 Y90.546 E0.0197
G1 X39.454 Y99.046 E0.3988
G1 X39.454 Y99.640 E0.0197
G1 X30.360 Y90.546 E0.4267
G1 X29.766 Y90.546 E0.0197
G1 X39.454 Y100.234 E0.4545
G1 X39.454 Y100.828 E0.0197
G1 X29.172 Y90.546 E0.4824
G1 X28.578 Y90.546 E0.0197
G1 X39.454 Y101.422 E0.5103
G1 X39.454 Y102.016 E0.0197
G1 X27.984 Y90.546 E0.5382
G1 X27.390 Y90.546 E0.0197
G1 X39.454 Y102.610 E0.5660
G1 X39.454 Y103.204 E0.0197
G1 X26.796 Y90.546 E0.5939
G1 X26.202 Y90.546 E0.0197
G1 X39.454 Y103.798 E0.6218
G1 X39.454 Y104.392 E0.0197
G1 X25.608 Y90.546 E0.6496
G1 X25.014 Y90.546 E0.0197
G1 X39.454 Y104.986 E0.6775
G1 X39.454 Y105.580 E0.0197
G1 X24.420 Y90.546 E0.7054
G1 X23.826 Y90.546 E0.0197
G1 X39.454 Y106.174 E0.7332
G1 X39.454 Y106.768 E0.0197
G1 X23.232 Y90.546 E0.7611
G1 X22.638 Y90.546 E0.0197
G1 X39.454 Y107.362 E0.7890
G1 X39.454 Y107.955 E0.0197
G1 X22.045 Y90.546 E0.8168
G1 X21.451 Y90.546 E0.0197
G1 X39.454 Y108.549 E0.8447
G1 X39.454 Y109.143 E0.0197
G1 X20.857 Y90.546 E0.8726
G1 X20.263 Y90.546 E0.0197
G1 X39.454 Y109.737 E0.9004
G1 X39.454 Y110.331 E0.0197
G1 X19.669 Y90.546 E0.9283
G1 X19.075 Y90.546 E0.0197
G1 X39.454 Y110.925 E0.9562
G1 X39.454 Y111.519 E0.0197
G1 X18.481 Y90.546 E0.9841
G1 X17.887 Y90.546 E0.0197
G1 X39.454 Y112.113 E1.0119
G1 X39.454 Y112.707 E0.0197
G1 X17.293 Y90.546 E1.0398
G1 X16.699 Y90.546 E0.0197
G1 X39.454 Y113.301 E1.0677
G1 X39.454 Y113.895 E0.0197
G1 X16.105 Y90.546 E1.0955
G1 X15.511 Y90.546 E0.0197
G1 X39.454 Y114.489 E1.1234
G1 X39.454 Y115.083 E0.0197
G1 X14.917 Y90.546 E1.1513
G1 X14.323 Y90.546 E0.0197
G1 X39.454 Y115.677 E1.1791
G1 X39.454 Y116.271 E0.0197
G1 X13.729 Y90.546 E1.2070
G1 X13.135 Y90.546 E0.0197
G1 X39.454 Y116.865 E1.2349
G1 X39.454 Y117.459 E0.0197
G1 X12.541 Y90.546 E1.2627
G1 X11.947 Y90.546 E0.0197
G1 X39.454 Y118.053 E1.2906
G1 X39.454 Y118.647 E0.0197
G1 X11.353 Y90.546 E1.3185
G1 X10.759 Y90.546 E0.0197
G1 X39.454 Y119.241 E1.3463
G1 X39.454 Y119.454 E0.0071
G1 X39.073 Y119.454 E0.0126
G1 X10.546 Y90.927 E1.3385
G1 X10.546 Y91.521 E0.0197
G1 X38.479 Y119.454 E1.3106
G1 X37.885 Y119.454 E0.0197
G1 X10.546 Y92.115 E1.2827
G1 X10.546 Y92.709 E0.0197
G1 X37.291 Y119.454 E1.2549
G1 X36.697 Y119.454 E0.0197
G1 X10.546 Y93.303 E1.2270
G1 X10.546 Y93.897 E0.0197
G1 X36.103 Y119.454 E1.1991
G1 X35.509 Y119.454 E0.0197
G1 X10.546 Y94.491 E1.1713
G1 X10.546 Y95.085 E0.0197
G1 X34.915 Y119.454 E1.1434
G1 X34.321 Y119.454 E0.0197
G1 X10.546 Y95.679 E1.1155
G1 X10.546 Y96.273 E0.0197
G1 X33.727 Y119.454 E1.0877
G1 X33.133 Y119.454 E0.0197
G1 X10.546 Y96.867 E1.0598
G1 X10.546 Y97.461 E0.0197
G1 X32.539 Y119.454 E1.0319
G1 X31.945 Y119.454 E0.0197
G1 X10.546 Y98.055 E1.0041
G1 X10.546 Y98.648 E0.0197
G1 X31.352 Y119.454 E0.9762
G1 X30.758 Y119.454 E0.0197
G1 X10.546 Y99.242 E0.9483
G1 X10.546 Y99.836 E0.0197
G1 X30.164 Y119.454 E0.9204
G1 X29.570 Y119.454 E0.0197
G1 X10.546 Y100.430 E0.8926
G1 X10.546 Y101.024 E0.0197
G1 X28.976 Y119.454 E0.8647
G1 X28.382 Y119.454 E0.0197
G1 X10.546 Y101.618 E0.8368
G1 X10.546 Y102.212 E0.0197
G1 X27.788 Y119.454 E0.8090
G1 X27.194 Y119.454 E0.0197
G1 X10.546 Y102.806 E0.7811
G1 X10.546 Y103.400 E0.0197
G1 X26.600 Y119.454 E0.7532
G1 X26.006 Y119.454 E0.0197
G1 X10.546 Y103.994 E0.7254
G1 X10.546 Y104.588 E0.0197
G1 X25.412 Y119.454 E0.6975
G1 X24.818 Y119.454 E0.0197
G1 X10.546 Y105.182 E0.6696
G1 X10.546 Y105.776 E0.0197
G1 X24.224 Y119.454 E0.6418
G1 X23.630 Y119.454 E0.0197
G1 X10.546 Y106.370 E0.6139
G1 X10.546 Y106.964 E0.0197
G1 X23.036 Y119.454 E0.5860
G1 X22.442 Y119.454 E0.0197
G1 X10.546 Y107.558 E0.5582
G1 X10.546 Y108.152 E0.0197
G1 X21.848 Y119.454 E0.5303
G1 X21.254 Y119.454 E0.0197
G1 X10.546 Y108.746 E0.5024
G1 X10.546 Y109.340 E0.0197
G1 X20.660 Y119.454 E0.4745
G1 X20.066 Y119.454 E0.0197
G1 X10.546 Y109.934 E0.4467
G1 X10.546 Y110.528 E0.0197
G1 X19.472 Y119.454 E0.4188
G1 X18.878 Y119.454 E0.0197
G1 X10.546 Y111.122 E0.3909
G1 X10.546 Y111.716 E0.0197
G1 X18.284 Y119.454 E0.3631
G1 X17.690 Y119.454 E0.0197
G1 X10.546 Y112.310 E0.3352
G1 X10.546 Y112.904 E0.0197
G1 X17.096 Y119.454 E0.3073
G1 X16.502 Y119.454 E0.0197
G1 X10.546 Y113.498 E0.2795
G1 X10.546 Y114.092 E0.0197
G1 X15.908 Y119.454 E0.2516
G1 X15.314 Y119.454 E0.0197
G1 X10.546 Y114.686 E0.2237
G1 X10.546 Y115.280 E0.0197
G1 X14.720 Y119.454 E0.1959
G1 X14.126 Y119.454 E0.0197
G1 X10.546 Y115.874 E0.1680
G1 X10.546 Y116.468 E0.0197
G1 X13.532 Y119.454 E0.1401
G1 X12.938 Y119.454 E0.0197
G1 X10.546 Y117.062 E0.1123
G1 X10.546 Y117.656 E0.0197
G1 X12.344 Y119.454 E0.0844
G1 X11.751 Y119.454 E0.0197
G1 X10.546 Y118.249 E0.0565
G1 X10.546 Y118.843 E0.0197
G1 X11.157 Y119.454 E0.0286
G1 X10.563 Y119.454 E0.0197
G1 X10.546 Y119.437 E0.0008
G1 E-0.6000 F1500
G1 Z0.800 F1200
G1 X110.943 Y119.454 F7200
G1 Z0.200 F1200
G1 E0.6000 F1500
G1 X110.546 Y119.057 E0.0186 F576
G1 X110.546 Y118.463 E0.0197
G1 X111.537 Y119.454 E0.0465
G1 X112.131 Y119.454 E0.0197
G1 X110.546 Y117.869 E0.0744
G1 X110.546 Y117.275 E0.0197
G1 X112.725 Y119.454 E0.1023
G1 X113.319 Y119.454 E0.0197
G1 X110.546 Y116.681 E0.1301
G1 X110.546 Y116.087 E0.0197
G1 X113.913 Y119.454 E0.1580
G1 X114.507 Y119.454 E0.0197
G1 X110.546 Y115.493 E0.1859
G1 X110.546 Y114.899 E0.0197
G1 X115.101 Y119.454 E0.2137
G1 X115.695 Y119.454 E0.0197
G1 X110.546 Y114.305 E0.2416
G1 X110.546 Y113.711 E0.0197
G1 X116.289 Y119.454 E0.2695
G1 X116.883 Y119.454 E0.0197
G1 X110.546 Y113.117 E0.2973
G1 X110.546 Y112.523 E0.0197
G1 X117.477 Y119.454 E0.3252
G1 X118.071 Y119.454 E0.0197
G1 X110.546 Y111.929 E0.3531
G1 X110.546 Y111.335 E0.0197
G1 X118.665 Y119.454 E0.3809
G1 X119.259 Y119.454 E0.0197
G1 X110.546 Y110.741 E0.4088
G1 X110.546 Y110.147 E0.0197
G1 X119.853 Y119.454 E0.4367
G1 X120.447 Y119.454 E0.0197
G1 X110.546 Y109.553 E0.4645
G1 X110.546 Y108.959 E0.0197
G1 X121.041 Y119.454 E0.4924
G1 X121.635 Y119.454 E0.0197
G1 X110.546 Y108.365 E0.5203
G1 X110.546 Y107.771 E0.0197
G1 X122.229 Y119.454 E0.5482
G1 X122.823 Y119.454 E0.0197
G1 X110.546 Y107.177 E0.5760
G1 X110.546 Y106.583 E0.0197
G1 X123.417 Y119.454 E0.6039
G1 X124.011 Y119.454 E0.0197
G1 X110.546 Y105.989 E0.6318
G1 X110.546 Y105.395 E0.0197
G1 X124.605 Y119.454 E0.6596
G1 X125.199 Y119.454 E0.0197
G1 X110.546 Y104.801 E0.6875
G1 X110.546 Y104.207 E0.0197
G1 X125.793 Y119.454 E0.7154
G1 X126.387 Y119.454 E0.0197
G1 X110.546 Y103.613 E0.7432
G1 X110.546 Y103.019 E0.0197
G1 X126.981 Y119.454 E0.7711
G1 X127.575 Y119.454 E0.0197
G1 X110.546 Y102.425 E0.7990
G1 X110.546 Y101.831 E0.0197
G1 X128.169 Y119.454 E0.8268
G1 X128.763 Y119.454 E0.0197
G1 X110.546 Y101.237 E0.8547
G1 X110.546 Y100.643 E0.0197
G1 X129.357 Y119.454 E0.8826
G1 X129.950 Y119.454 E0.0197
G1 X110.546 Y100.050 E0.9104
G1 X110.546 Y99.456 E0.0197
G1 X130.544 Y119.454 E0.9383
G1 X131.138 Y119.454 E0.0197
G1 X110.546 Y98.862 E0.9662
G1 X110.546 Y98.268 E0.0197
G1 X131.732 Y119.454 E0.9941
G1 X132.326 Y119.454 E0.0197
G1 X110.546 Y97.674 E1.0219
G1 X110.546 Y97.080 E0.0197
G1 X132.920 Y119.454 E1.0498
G1 X133.514 Y119.454 E0.0197
G1 X110.546 Y96.486 E1.0777
G1 X110.546 Y95.892 E0.0197
G1 X134.108 Y119.454 E1.1055
G1 X134.702 Y119.454 E0.0197
G1 X110.546 Y95.298 E1.1334
G1 X110.546 Y94.704 E0.0197
G1 X135.296 Y119.454 E1.1613
G1 X135.890 Y119.454 E0.0197
G1 X110.546 Y94.110 E1.1891
G1 X110.546 Y93.516 E0.0197
G1 X136.484 Y119.454 E1.2170
G1 X137.078 Y119.454 E0.0197
G1 X110.546 Y92.922 E1.2449
G1 X110.546 Y92.328 E0.0197
G1 X137.672 Y119.454 E1.2727
G1 X138.266 Y119.454 E0.0197
G1 X110.546 Y91.734 E1.3006
G1 X110.546 Y91.140 E0.0197
G1 X138.860 Y119.454 E1.3285
G1 X139.454 Y119.454 E0.0197
G1 X110.546 Y90.546 E1.3563
G1 X111.140 Y90.546 E0.0197
G1 X139.454 Y118.860 E1.3285
G1 X139.454 Y118.266 E0.0197
G1 X111.734 Y90.546 E1.3006
G1 X112.328 Y90.546 E0.0197
G1 X139.454 Y117.672 E1.2727
G1 X139.454 Y117.078 E0.0197
G1 X112.922 Y90.546 E1.2449
G1 X113.516 Y90.546 E0.0197
G1 X139.454 Y116.484 E1.2170
G1 X139.454 Y115.890 E0.0197
G1 X114.110 Y90.546 E1.1891
G1 X114.704 Y90.546 E0.0197
G1 X139.454 Y115.296 E1.1613
G1 X139.454 Y114.702 E0.0197
G1 X115.298 Y90.546 E1.1334
G1 X115.892 Y90.546 E0.0197
G1 X139.454 Y114.108 E1.1055
G1 X139.454 Y113.514 E0.0197
G1 X116.486 Y90.546 E1.0777
G1 X117.080 Y90.546 E0.0197
G1 X139.454 Y112.920 E1.0498
G1 X139.454 Y112.326 E0.0197
G1 X117.674 Y90.546 E1.0219
G1 X118.268 Y90.546 E0.0197
G1 X139.454 Y111.732 E0.9941
G1 X139.454 Y111.138 E0.0197
G1 X118.862 Y90.546 E0.9662
G1 X119.456 Y90.546 E0.0197
G1 X139.454 Y110.544 E0.9383
G1 X139.454 Y109.950 E0.0197
G1 X120.050 Y90.546 E0.9104
G1 X120.643 Y90.546 E0.0197
G1 X139.454 Y109.357 E0.8826
G1 X139.454 Y108.763 E0.0197
G1 X121.237 Y90.546 E0.8547
G1 X121.831 Y90.546 E0.0197
G1 X139.454 Y108.169 E0.8268
G1 X139.454 Y107.575 E0.0197
G1 X122.425 Y90.546 E0.7990
G1 X123.019 Y90.546 E0.0197
G1 X139.454 Y106.981 E0.7711
G1 X139.454 Y106.387 E0.0197
G1 X123.613 Y90.546 E0.7432
G1 X124.207 Y90.546 E0.0197
G1 X139.454 Y105.793 E0.7154
G1 X139.454 Y105.199 E0.0197
G1 X124.801 Y90.546 E0.6875
G1 X125.395 Y90.546 E0.0197
G1 X139.454 Y104.605 E0.6596
G1 X139.454 Y104.011 E0.0197
G1 X125.989 Y90.546 E0.6318
G1 X126.583 Y90.546 E0.0197
G1 X139.454 Y103.417 E0.6039
G1 X139.454 Y102.823 E0.0197
G1 X127.177 Y90.546 E0.5760
G1 X127.771 Y90.546 E0.0197
G1 X139.454 Y102.229 E0.5482
G1 X139.454 Y101.635 E0.0197
G1 X128.365 Y90.546 E0.5203
G1 X128.959 Y90.546 E0.0197
G1 X139.454 Y101.041 E0.4924
G1 X139.454 Y100.447 E0.0197
G1 X129.553 Y90.546 E0.4645
G1 X130.147 Y90.546 E0.0197
G1 X139.454 Y99.853 E0.4367
G1 X139.454 Y99.259 E0.0197
G1 X130.741 Y90.546 E0.4088
G1 X131.335 Y90.546 E0.0197
G1 X139.454 Y98.665 E0.3809
G1 X139.454 Y98.071 E0.0197
G1 X131.929 Y90.546 E0.3531
G1 X132.523 Y90.546 E0.0197
G1 X139.454 Y97.477 E0.3252
G1 X139.454 Y96.883 E0.0197
G1 X133.117 Y90.546 E0.2973
G1 X133.711 Y90.546 E0.0197
G1 X139.454 Y96.289 E0.2695
G1 X139.454 Y95.695 E0.0197
G1 X134.305 Y90.546 E0.2416
G1 X134.899 Y90.546 E0.0197
G1 X139.454 Y95.101 E0.2137
G1 X139.454 Y94.507 E0.0197
G1 X135.493 Y90.546 E0.1859
G1 X136.087 Y90.546 E0.0197
G1 X139.454 Y93.913 E0.1580
G1 X139.454 Y93.319 E0.0197
G1 X136.681 Y90.546 E0.1301
G1 X137.275 Y90.546 E0.0197
G1 X139.454 Y92.725 E0.1023
G1 X139.454 Y92.131 E0.0197
G1 X137.869 Y90.546 E0.0744
G1 X138.463 Y90.546 E0.0197
G1 X139.454 Y91.537 E0.0465
G1 X139.454 Y90.943 E0.0197
G1 X139.057 Y90.546 E0.0186
G1 E-0.6000 F1500
G1 Z0.800 F1200
G1 X111.129 Y39.454 F7200
G1 Z0.200 F1200
G1 E0.6000 F1500
G1 X110.546 Y38.871 E0.0274 F576
G1 X110.546 Y38.277 E0.0197
G1 X111.723 Y39.454 E0.0552
G1 X112.317 Y39.454 E0.0197
G1 X110.546 Y37.683 E0.0831
G1 X110.546 Y37.089 E0.0197
G1 X112.911 Y39.454 E0.1110
G1 X113.505 Y39.454 E0.0197
G1 X110.546 Y36.495 E0.1388
G1 X110.546 Y35.901 E0.0197
G1 X114.099 Y39.454 E0.1667
G1 X114.693 Y39.454 E0.0197
G1 X110.546 Y35.307 E0.1946
G1 X110.546 Y34.713 E0.0197
G1 X115.287 Y39.454 E0.2225
G1 X115.881 Y39.454 E0.0197
G1 X110.546 Y34.119 E0.2503
G1 X110.546 Y33.525 E0.0197
G1 X116.475 Y39.454 E0.2782
G1 X117.069 Y39.454 E0.0197
G1 X110.546 Y32.931 E0.3061
G1 X110.546 Y32.337 E0.0197
G1 X117.663 Y39.454 E0.3339
G1 X118.257 Y39.454 E0.0197
G1 X110.546 Y31.743 E0.3618
G1 X110.546 Y31.149 E0.0197
G1 X118.851 Y39.454 E0.3897
G1 X119.445 Y39.454 E0.0197
G1 X110.546 Y30.555 E0.4175
G1 X110.546 Y29.961 E0.0197
G1 X120.039 Y39.454 E0.4454
G1 X120.633 Y39.454 E0.0197
G1 X110.546 Y29.367 E0.4733
G1 X110.546 Y28.773 E0.0197
G1 X121.227 Y39.454 E0.5011
G1 X121.821 Y39.454 E0.0197
G1 X110.546 Y28.179 E0.5290
G1 X110.546 Y27.585 E0.0197
G1 X122.415 Y39.454 E0.5569
G1 X123.009 Y39.454 E0.0197
G1 X110.546 Y26.991 E0.5847
G1 X110.546 Y26.397 E0.0197
G1 X123.603 Y39.454 E0.6126
G1 X124.197 Y39.454 E0.0197
G1 X110.546 Y25.803 E0.6405
G1 X110.546 Y25.209 E0.0197
G1 X124.791 Y39.454 E0.6684
G1 X125.385 Y39.454 E0.0197
G1 X110.546 Y24.615 E0.6962
G1 X110.546 Y24.021 E0.0197
G1 X125.979 Y39.454 E0.7241
G1 X126.573 Y39.454 E0.0197
G1 X110.546 Y23.427 E0.7520
G1 X110.546 Y22.833 E0.0197
G1 X127.167 Y39.454 E0.7798
G1 X127.761 Y39.454 E0.0197
G1 X110.546 Y22.239 E0.8077
G1 X110.546 Y21.646 E0.0197
G1 X128.354 Y39.454 E0.8356
G1 X128.948 Y39.454 E0.0197
G1 X110.546 Y21.052 E0.8634
G1 X110.546 Y20.458 E0.0197
G1 X129.542 Y39.454 E0.8913
G1 X130.136 Y39.454 E0.0197
G1 X110.546 Y19.864 E0.9192
G1 X110.546 Y19.270 E0.0197
G1 X130.730 Y39.454 E0.9470
G1 X131.324 Y39.454 E0.0197
G1 X110.546 Y18.676 E0.9749
G1 X110.546 Y18.082 E0.0197
G1 X131.918 Y39.454 E1.0028
G1 X132.512 Y39.454 E0.0197
G1 X110.546 Y17.488 E1.0306
G1 X110.546 Y16.894 E0.0197
G1 X133.106 Y39.454 E1.0585
G1 X133.700 Y39.454 E0.0197
G1 X110.546 Y16.300 E1.0864
G1 X110.546 Y15.706 E0.0197
G1 X134.294 Y39.454 E1.1142
G1 X134.888 Y39.454 E0.0197
G1 X110.546 Y15.112 E1.1421
G1 X110.546 Y14.518 E0.0197
G1 X135.482 Y39.454 E1.1700
G1 X136.076 Y39.454 E0.0197
G1 X110.546 Y13.924 E1.1979
G1 X110.546 Y13.330 E0.0197
G1 X136.670 Y39.454 E1.2257
G1 X137.264 Y39.454 E0.0197
G1 X110.546 Y12.736 E1.2536
G1 X110.546 Y12.142 E0.0197
G1 X137.858 Y39.454 E1.2815
G1 X138.452 Y39.454 E0.0197
G1 X110.546 Y11.548 E1.3093
G1 X110.546 Y10.954 E0.0197
G1 X139.046 Y39.454 E1.3372
G1 X139.454 Y39.454 E0.0135
G1 X139.454 Y39.268 E0.0062
G1 X110.732 Y10.546 E1.3476
G1 X111.326 Y10.546 E0.0197
G1 X139.454 Y38.674 E1.3198
G1 X139.454 Y38.080 E0.0197
G1 X111.920 Y10.546 E1.2919
G1 X112.514 Y10.546 E0.0197
G1 X139.454 Y37.486 E1.2640
G1 X139.454 Y36.892 E0.0197
G1 X113.108 Y10.546 E1.2361
G1 X113.702 Y10.546 E0.0197
G1 X139.454 Y36.298 E1.2083
G1 X139.454 Y35.704 E0.0197
G1 X114.296 Y10.546 E1.1804
G1 X114.890 Y10.546 E0.0197
G1 X139.454 Y35.110 E1.1525
G1 X139.454 Y34.516 E0.0197
G1 X115.484 Y10.546 E1.1247
G1 X116.078 Y10.546 E0.0197
G1 X139.454 Y33.922 E1.0968
G1 X139.454 Y33.328 E0.0197
G1 X116.672 Y10.546 E1.0689
G1 X117.266 Y10.546 E0.0197
G1 X139.454 Y32.734 E1.0411
G1 X139.454 Y32.140 E0.0197
G1 X117.860 Y10.546 E1.0132
G1 X118.454 Y10.546 E0.0197
G1 X139.454 Y31.546 E0.9853
G1 X139.454 Y30.953 E0.0197
G1 X119.047 Y10.546 E0.9575
G1 X119.641 Y10.546 E0.0197
G1 X139.454 Y30.359 E0.9296
G1 X139.454 Y29.765 E0.0197
G1 X120.235 Y10.546 E0.9017
G1 X120.829 Y10.546 E0.0197
G1 X139.454 Y29.171 E0.8739
G1 X139.454 Y28.577 E0.0197
G1 X121.423 Y10.546 E0.8460
G1 X122.017 Y10.546 E0.0197
G1 X139.454 Y27.983 E0.8181
G1 X139.454 Y27.389 E0.0197
G1 X122.611 Y10.546 E0.7902
G1 X123.205 Y10.546 E0.0197
G1 X139.454 Y26.795 E0.7624
G1 X139.454 Y26.201 E0.0197
G1 X123.799 Y10.546 E0.7345
G1 X124.393 Y10.546 E0.0197
G1 X139.454 Y25.607 E0.7066
G1 X139.454 Y25.013 E0.0197
G1 X124.987 Y10.546 E0.6788
G1 X125.581 Y10.546 E0.0197
G1 X139.454 Y24.419 E0.6509
G1 X139.454 Y23.825 E0.0197
G1 X126.175 Y10.546 E0.6230
G1 X126.769 Y10.546 E0.0197
G1 X139.454 Y23.231 E0.5952
G1 X139.454 Y22.637 E0.0197
G1 X127.363 Y10.546 E0.5673
G1 X127.957 Y10.546 E0.0197
G1 X139.454 Y22.043 E0.5394
G1 X139.454 Y21.449 E0.0197
G1 X128.551 Y10.546 E0.5116
G1 X129.145 Y10.546 E0.0197
G1 X139.454 Y20.855 E0.4837
G1 X139.454 Y20.261 E0.0197
G1 X129.739 Y10.546 E0.4558
G1 X130.333 Y10.546 E0.0197
G1 X139.454 Y19.667 E0.4280
G1 X139.454 Y19.073 E0.0197
G1 X130.927 Y10.546 E0.4001
G1 X131.521 Y10.546 E0.0197
G1 X139.454 Y18.479 E0.3722
G1 X139.454 Y17.885 E0.0197
G1 X132.115 Y10.546 E0.3443
G1 X132.709 Y10.546 E0.0197
G1 X139.454 Y17.291 E0.3165
G1 X139.454 Y16.697 E0.0197
G1 X133.303 Y10.546 E0.2886
G1 X133.897 Y10.546 E0.0197
G1 X139.454 Y16.103 E0.2607
G1 X139.454 Y15.509 E0.0197
G1 X134.491 Y10.546 E0.2329
G1 X135.085 Y10.546 E0.0197
G1 X139.454 Y14.915 E0.2050
G1 X139.454 Y14.321 E0.0197
G1 X135.679 Y10.546 E0.1771
G1 X136.273 Y10.546 E0.0197
G1 X139.454 Y13.727 E0.1493
G1 X139.454 Y13.133 E0.0197
G1 X136.867 Y10.546 E0.1214
G1 X137.461 Y10.546 E0.0197
G1 X139.454 Y12.539 E0.0935
G1 X139.454 Y11.945 E0.0197
G1 X138.055 Y10.546 E0.0657
G1 X138.648 Y10.546 E0.0197
G1 X139.454 Y11.352 E0.0378
G1 X139.454 Y10.758 E0.0197
G1 X139.242 Y10.546 E0.0099
G1 E-0.6000 F1500
G1 Z0.800 F1200
G1 X239.437 Y90.546 F7200
G1 Z0.200 F1200
G1 E0.6000 F1500
G1 X239.454 Y90.563 E0.0008 F576
G1 X239.454 Y91.157 E0.0197
G1 X238.843 Y90.546 E0.0286
G1 X238.249 Y90.546 E0.0197
G1 X239.454 Y91.751 E0.0565
G1 X239.454 Y92.344 E0.0197
G1 X237.656 Y90.546 E0.0844
G1 X237.062 Y90.546 E0.0197
G1 X239.454 Y92.938 E0.1123
G1 X239.454 Y93.532 E0.0197
G1 X236.468 Y90.546 E0.1401
G1 X235.874 Y90.546 E0.0197
G1 X239.454 Y94.126 E0.1680
G1 X239.454 Y94.720 E0.0197
G1 X235.280 Y90.546 E0.1959
G1 X234.686 Y90.546 E0.0197
G1 X239.454 Y95.314 E0.2237
G1 X239.454 Y95.908 E0.0197
G1 X234.092 Y90.546 E0.2516
G1 X233.498 Y90.546 E0.0197
G1 X239.454 Y96.502 E0.2795
G1 X239.454 Y97.096 E0.0197
G1 X232.904 Y90.546 E0.3073
G1 X232.310 Y90.546 E0.0197
G1 X239.454 Y97.690 E0.3352
G1 X239.454 Y98.284 E0.0197
G1 X231.716 Y90.546 E0.3631
G1 X231.122 Y90.546 E0.0197
G1 X239.454 Y98.878 E0.3909
G1 X239.454 Y99.472 E0.0197
G1 X230.528 Y90.546 E0.4188
G1 X229.934 Y90.546 E0.0197
G1 X239.454 Y100.066 E0.4467
G1 X239.454 Y100.660 E0.0197
G1 X229.340 Y90.546 E0.4745
G1 X228.746 Y90.546 E0.0197
G1 X239.454 Y101.254 E0.5024
G1 X239.454 Y101.848 E0.0197
G1 X228.152 Y90.546 E0.5303
G1 X227.558 Y90.546 E0.0197
G1 X239.454 Y102.442 E0.5582
G1 X239.454 Y103.036 E0.0197
G1 X226.964 Y90.546 E0.5860
G1 X226.370 Y90.546 E0.0197
G1 X239.454 Y103.630 E0.6139
G1 X239.454 Y104.224 E0.0197
G1 X225.776 Y90.546 E0.6418
G1 X225.182 Y90.546 E0.0197
G1 X239.454 Y104.818 E0.6696
G1 X239.454 Y105.412 E0.0197
G1 X224.588 Y90.546 E0.6975
G1 X223.994 Y90.546 E0.0197
G1 X239.454 Y106.006 E0.7254
G1 X239.454 Y106.600 E0.0197
G1 X223.400 Y90.546 E0.7532
G1 X222.806 Y90.546 E0.0197
G1 X239.454 Y107.194 E0.7811
G1 X239.454 Y107.788 E0.0197
G1 X222.212 Y90.546 E0.8090
G1 X221.618 Y90.546 E0.0197
G1 X239.454 Y108.382 E0.8368
G1 X239.454 Y108.976 E0.0197
G1 X221.024 Y90.546 E0.8647
G1 X220.430 Y90.546 E0.0197
G1 X239.454 Y109.570 E0.8926
G1 X239.454 Y110.164 E0.0197
G1 X219.836 Y90.546 E0.9204
G1 X219.242 Y90.546 E0.0197
G1 X239.454 Y110.758 E0.9483
G1 X239.454 Y111.352 E0.0197
G1 X218.648 Y90.546 E0.9762
G1 X218.055 Y90.546 E0.0197
G1 X239.454 Y111.945 E1.0040
G1 X239.454 Y112.539 E0.0197
G1 X217.461 Y90.546 E1.0319
G1 X216.867 Y90.546 E0.0197
G1 X239.454 Y113.133 E1.0598
G1 X239.454 Y113.727 E0.0197
G1 X216.273 Y90.546 E1.0877
G1 X215.679 Y90.546 E0.0197
G1 X239.454 Y114.321 E1.1155
G1 X239.454 Y114.915 E0.0197
G1 X215.085 Y90.546 E1.1434
G1 X214.491 Y90.546 E0.0197
G1 X239.454 Y115.509 E1.1713
G1 X239.454 Y116.103 E0.0197
G1 X213.897 Y90.546 E1.1991
G1 X213.303 Y90.546 E0.0197
G1 X239.454 Y116.697 E1.2270
G1 X239.454 Y117.291 E0.0197
G1 X212.709 Y90.546 E1.2549
G1 X212.115 Y90.546 E0.0197
G1 X239.454 Y117.885 E1.2827
G1 X239.454 Y118.479 E0.0197
G1 X211.521 Y90.546 E1.3106
G1 X210.927 Y90.546 E0.0197
G1 X239.454 Y119.073 E1.3385
G1 X239.454 Y119.454 E0.0126
G1 X239.241 Y119.454 E0.0071
G1 X210.546 Y90.759 E1.3463
G1 X210.546 Y91.353 E0.0197
G1 X238.647 Y119.454 E1.3185
G1 X238.053 Y119.454 E0.0197
G1 X210.546 Y91.947 E1.2906
G1 X210.546 Y92.541 E0.0197
G1 X237.459 Y119.454 E1.2627
G1 X236.865 Y119.454 E0.0197
G1 X210.546 Y93.135 E1.2349
G1 X210.546 Y93.729 E0.0197
G1 X236.271 Y119.454 E1.2070
G1 X235.677 Y119.454 E0.0197
G1 X210.546 Y94.323 E1.1791
G1 X210.546 Y94.917 E0.0197
G1 X235.083 Y119.454 E1.1513
G1 X234.489 Y119.454 E0.0197
G1 X210.546 Y95.511 E1.1234
G1 X210.546 Y96.105 E0.0197
G1 X233.895 Y119.454 E1.0955
G1 X233.301 Y119.454 E0.0197
G1 X210.546 Y96.699 E1.0677
G1 X210.546 Y97.293 E0.0197
G1 X232.707 Y119.454 E1.0398
G1 X232.113 Y119.454 E0.0197
G1 X210.546 Y97.887 E1.0119
G1 X210.546 Y98.481 E0.0197
G1 X231.519 Y119.454 E0.9841
G1 X230.925 Y119.454 E0.0197
G1 X210.546 Y99.075 E0.9562
G1 X210.546 Y99.669 E0.0197
G1 X230.331 Y119.454 E0.9283
G1 X229.737 Y119.454 E0.0197
G1 X210.546 Y100.263 E0.9004
G1 X210.546 Y100.857 E0.0197
G1 X229.143 Y119.454 E0.8726
G1 X228.549 Y119.454 E0.0197
G1 X210.546 Y101.451 E0.8447
G1 X210.546 Y102.045 E0.0197
G1 X227.955 Y119.454 E0.8168
G1 X227.362 Y119.454 E0.0197
G1 X210.546 Y102.638 E0.7890
G1 X210.546 Y103.232 E0.0197
G1 X226.768 Y119.454 E0.7611
G1 X226.174 Y119.454 E0.0197
G1 X210.546 Y103.826 E0.7332
G1 X210.546 Y104.420 E0.0197
G1 X225.580 Y119.454 E0.7054
G1 X224.986 Y119.454 E0.0197
G1 X210.546 Y105.014 E0.6775
G1 X210.546 Y105.608 E0.0197
G1 X224.392 Y119.454 E0.6496
G1 X223.798 Y119.454 E0.0197
G1 X210.546 Y106.202 E0.6218
G1 X210.546 Y106.796 E0.0197
G1 X223.204 Y119.454 E0.5939
G1 X222.610 Y119.454 E0.0197
G1 X210.546 Y107.390 E0.5660
G1 X210.546 Y107.984 E0.0197
G1 X222.016 Y119.454 E0.5382
G1 X221.422 Y119.454 E0.0197
G1 X210.546 Y108.578 E0.5103
G1 X210.546 Y109.172 E0.0197
G1 X220.828 Y119.454 E0.4824
G1 X220.234 Y119.454 E0.0197
G1 X210.546 Y109.766 E0.4545
G1 X210.546 Y110.360 E0.0197
G1 X219.640 Y119.454 E0.4267
G1 X219.046 Y119.454 E0.0197
G1 X210.546 Y110.954 E0.3988
G1 X210.546 Y111.548 E0.0197
G1 X218.452 Y119.454 E0.3709
G1 X217.858 Y119.454 E0.0197
G1 X210.546 Y112.142 E0.3431
G1 X210.546 Y112.736 E0.0197
G1 X217.264 Y119.454 E0.3152
G1 X216.670 Y119.454 E0.0197
G1 X210.546 Y113.330 E0.2873
G1 X210.546 Y113.924 E0.0197
G1 X216.076 Y119.454 E0.2595
G1 X215.482 Y119.454 E0.0197
G1 X210.546 Y114.518 E0.2316
G1 X210.546 Y115.112 E0.0197
G1 X214.888 Y119.454 E0.2037
G1 X214.294 Y119.454 E0.0197
G1 X210.546 Y115.706 E0.1759
G1 X210.546 Y116.300 E0.0197
G1 X213.700 Y119.454 E0.1480
G1 X213.106 Y119.454 E0.0197
G1 X210.546 Y116.894 E0.1201
G1 X210.546 Y117.488 E0.0197
G1 X212.512 Y119.454 E0.0923
G1 X211.918 Y119.454 E0.0197
G1 X210.546 Y118.082 E0.0644
G1 X210.546 Y118.676 E0.0197
G1 X211.324 Y119.454 E0.0365
G1 X210.730 Y119.454 E0.0197
G1 X210.546 Y119.270 E0.0087
G1 E-0.6000 F1500
G1 Z0.800 F1200
G1 X138.871 Y170.546 F7200
G1 Z0.200 F1200
G1 E0.6000 F1500
G1 X139.454 Y171.129 E0.0274 F576
G1 X139.454 Y171.723 E0.0197
G1 X138.277 Y170.546 E0.0552
G1 X137.683 Y170.546 E0.0197
G1 X139.454 Y172.317 E0.0831
G1 X139.454 Y172.911 E0.0197
G1 X137.089 Y170.546 E0.1110
G1 X136.495 Y170.546 E0.0197
G1 X139.454 Y173.505 E0.1388
G1 X139.454 Y174.099 E0.0197
G1 X135.901 Y170.546 E0.1667
G1 X135.307 Y170.546 E0.0197
G1 X139.454 Y174.693 E0.1946
G1 X139.454 Y175.287 E0.0197
G1 X134.713 Y170.546 E0.2225
G1 X134.119 Y170.546 E0.0197
G1 X139.454 Y175.881 E0.2503
G1 X139.454 Y176.475 E0.0197
G1 X133.525 Y170.546 E0.2782
G1 X132.931 Y170.546 E0.0197
G1 X139.454 Y177.069 E0.3061
G1 X139.454 Y177.663 E0.0197
G1 X132.337 Y170.546 E0.3339
G1 X131.743 Y170.546 E0.0197
G1 X139.454 Y178.257 E0.3618
G1 X139.454 Y178.851 E0.0197
G1 X131.149 Y170.546 E0.3897
G1 X130.555 Y170.546 E0.0197
G1 X139.454 Y179.445 E0.4175
G1 X139.454 Y180.039 E0.0197
G1 X129.961 Y170.546 E0.4454
G1 X129.367 Y170.546 E0.0197
G1 X139.454 Y180.633 E0.4733
G1 X139.454 Y181.227 E0.0197
G1 X128.773 Y170.546 E0.5011
G1 X128.179 Y170.546 E0.0197
G1 X139.454 Y181.821 E0.5290
G1 X139.454 Y182.415 E0.0197
G1 X127.585 Y170.546 E0.5569
G1 X126.991 Y170.546 E0.0197
G1 X139.454 Y183.009 E0.5847
G1 X139.454 Y183.603 E0.0197
G1 X126.397 Y170.546 E0.6126
G1 X125.803 Y170.546 E0.0197
G1 X139.454 Y184.197 E0.6405
G1 X139.454 Y184.791 E0.0197
G1 X125.209 Y170.546 E0.6683
G1 X124.615 Y170.546 E0.0197
G1 X139.454 Y185.385 E0.6962
G1 X139.454 Y185.979 E0.0197
G1 X124.021 Y170.546 E0.7241
G1 X123.427 Y170.546 E0.0197
G1 X139.454 Y186.573 E0.7520
G1 X139.454 Y187.167 E0.0197
G1 X122.833 Y170.546 E0.7798
G1 X122.239 Y170.546 E0.0197
G1 X139.454 Y187.761 E0.8077
G1 X139.454 Y188.354 E0.0197
G1 X121.646 Y170.546 E0.8356
G1 X121.052 Y170.546 E0.0197
G1 X139.454 Y188.948 E0.8634
G1 X139.454 Y189.542 E0.0197
G1 X120.458 Y170.546 E0.8913
G1 X119.864 Y170.546 E0.0197
G1 X139.454 Y190.136 E0.9192
G1 X139.454 Y190.730 E0.0197
G1 X119.270 Y170.546 E0.9470
G1 X118.676 Y170.546 E0.0197
G1 X139.454 Y191.324 E0.9749
G1 X139.454 Y191.918 E0.0197
G1 X118.082 Y170.546 E1.0028
G1 X117.488 Y170.546 E0.0197
G1 X139.454 Y192.512 E1.0306
G1 X139.454 Y193.106 E0.0197
G1 X116.894 Y170.546 E1.0585
G1 X116.300 Y170.546 E0.0197
G1 X139.454 Y193.700 E1.0864
G1 X139.454 Y194.294 E0.0197
G1 X115.706 Y170.546 E1.1142
G1 X115.112 Y170.546 E0.0197
G1 X139.454 Y194.888 E1.1421
G1 X139.454 Y195.482 E0.0197
G1 X114.518 Y170.546 E1.1700
G1 X113.924 Y170.546 E0.0197
G1 X139.454 Y196.076 E1.1979
G1 X139.454 Y196.670 E0.0197
G1 X113.330 Y170.546 E1.2257
G1 X112.736 Y170.546 E0.0197
G1 X139.454 Y197.264 E1.2536
G1 X139.454 Y197.858 E0.0197
G1 X112.142 Y170.546 E1.2815
G1 X111.548 Y170.546 E0.0197
G1 X139.454 Y198.452 E1.3093
G1 X139.454 Y199.046 E0.0197
G1 X110.954 Y170.546 E1.3372
G1 X110.546 Y170.546 E0.0135
G1 X110.546 Y170.732 E0.0062
G1 X139.268 Y199.454 E1.3476
G1 X138.674 Y199.454 E0.0197
G1 X110.546 Y171.326 E1.3198
G1 X110.546 Y171.920 E0.0197
G1 X138.080 Y199.454 E1.2919
G1 X137.486 Y199.454 E0.0197
G1 X110.546 Y172.514 E1.2640
G1 X110.546 Y173.108 E0.0197
G1 X136.892 Y199.454 E1.2361
G1 X136.298 Y199.454 E0.0197
G1 X110.546 Y173.702 E1.2083
G1 X110.546 Y174.296 E0.0197
G1 X135.704 Y199.454 E1.1804
G1 X135.110 Y199.454 E0.0197
G1 X110.546 Y174.890 E1.1525
G1 X110.546 Y175.484 E0.0197
G1 X134.516 Y199.454 E1.1247
G1 X133.922 Y199.454 E0.0197
G1 X110.546 Y176.078 E1.0968
G1 X110.546 Y176.672 E0.0197
G1 X133.328 Y199.454 E1.0689
G1 X132.734 Y199.454 E0.0197
G1 X110.546 Y177.266 E1.0411
G1 X110.546 Y177.860 E0.0197
G1 X132.140 Y199.454 E1.0132
G1 X131.546 Y199.454 E0.0197
G1 X110.546 Y178.454 E0.9853
G1 X110.546 Y179.047 E0.0197
G1 X130.953 Y199.454 E0.9575
G1 X130.359 Y199.454 E0.0197
G1 X110.546 Y179.641 E0.9296
G1 X110.546 Y180.235 E0.0197
G1 X129.765 Y199.454 E0.9017
G1 X129.171 Y199.454 E0.0197
G1 X110.546 Y180.829 E0.8739
G1 X110.546 Y181.423 E0.0197
G1 X128.577 Y199.454 E0.8460
G1 X127.983 Y199.454 E0.0197
G1 X110.546 Y182.017 E0.8181
G1 X110.546 Y182.611 E0.0197
G1 X127.389 Y199.454 E0.7902
G1 X126.795 Y199.454 E0.0197
G1 X110.546 Y183.205 E0.7624
G1 X110.546 Y183.799 E0.0197
G1 X126.201 Y199.454 E0.7345
G1 X125.607 Y199.454 E0.0197
G1 X110.546 Y184.393 E0.7066
G1 X110.546 Y184.987 E0.0197
G1 X125.013 Y199.454 E0.6788
G1 X124.419 Y199.454 E0.0197
G1 X110.546 Y185.581 E0.6509
G1 X110.546 Y186.175 E0.0197
G1 X123.825 Y199.454 E0.6230
G1 X123.231 Y199.454 E0.0197
G1 X110.546 Y186.769 E0.5952
G1 X110.546 Y187.363 E0.0197
G1 X122.637 Y199.454 E0.5673
G1 X122.043 Y199.454 E0.0197
G1 X110.546 Y187.957 E0.5394
G1 X110.546 Y188.551 E0.0197
G1 X121.449 Y199.454 E0.5116
G1 X120.855 Y199.454 E0.0197
G1 X110.546 Y189.145 E0.4837
G1 X110.546 Y189.739 E0.0197
G1 X120.261 Y199.454 E0.4558
G1 X119.667 Y199.454 E0.0197
G1 X110.546 Y190.333 E0.4280
G1 X110.546 Y190.927 E0.0197
G1 X119.073 Y199.454 E0.4001
G1 X118.479 Y199.454 E0.0197
G1 X110.546 Y191.521 E0.3722
G1 X110.546 Y192.115 E0.0197
G1 X117.885 Y199.454 E0.3444
G1 X117.291 Y199.454 E0.0197
G1 X110.546 Y192.709 E0.3165
G1 X110.546 Y193.303 E0.0197
G1 X116.697 Y199.454 E0.2886
G1 X116.103 Y199.454 E0.0197
G1 X110.546 Y193.897 E0.2607
G1 X110.546 Y194.491 E0.0197
G1 X115.509 Y199.454 E0.2329
G1 X114.915 Y199.454 E0.0197
G1 X110.546 Y195.085 E0.2050
G1 X110.546 Y195.679 E0.0197
G1 X114.321 Y199.454 E0.1771
G1 X113.727 Y199.454 E0.0197
G1 X110.546 Y196.273 E0.1493
G1 X110.546 Y196.867 E0.0197
G1 X113.133 Y199.454 E0.1214
G1 X112.539 Y199.454 E0.0197
G1 X110.546 Y197.461 E0.0935
G1 X110.546 Y198.055 E0.0197
G1 X111.945 Y199.454 E0.0657
G1 X111.352 Y199.454 E0.0197
G1 X110.546 Y198.648 E0.0378
G1 X110.546 Y199.242 E0.0197
G1 X110.758 Y199.454 E0.0099
G1 E-0.6000 F1500
; layer end
M106 S0 ; turn off cooling fan
M104 S0 ; turn off extruder
M140 S0 ; turn off bed
G1 F1000.0 ; set feed rate
G1 E-3 ; retract
G1 X0 Y200 F7200 ; home XY axis
M84 ; disable motors
; Build Summary
;   Build time: 0 hours 20 minutes
;   Filament length: 375.3 mm (0.38 m)
;   Plastic volume: 902.80 mm^3 (0.90 cc)
;   Plastic weight: 1.13 g (0.00 lb)
;   Material cost: 0.03

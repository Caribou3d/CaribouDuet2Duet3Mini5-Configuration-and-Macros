; =========================================================================================================
;
;  Test if connection to external network is possible, otherwise switch access point mode
;
; =========================================================================================================
;
while network.interfaces[0].actualIP = "0.0.0.0" && iterations < 30
  G4 S1                                                                ; wait 1 second
;
if network.interfaces[0].actualIP = "0.0.0.0"
  M552 S0                                                              ; enable WiFi module
  G4 S1                                                                ; wait 1 second
  M552 S-1                                                             ; disable WiFi module
  G4 S1                                                                ; wait 1 second
  M552 S0                                                              ; enable WiFi module
  G4 S1                                                                ; wait 1 second
  M589 S"CaribouDuet" P"CaribouDuet" I180.180.0.1                      ; set network parameters
  G4 S1                                                                ; wait 1 second
  M98 P"0:/settings/WiFi-Credentials.g"                                  ; set network credentials
  G4 S1                                                                ; wait 1 second
  M552 S2                                                              ; start access point mode
  M291 S2 R"Connection not established" P"WiFi module was switched to access point mode"
;
; =========================================================================================================
;
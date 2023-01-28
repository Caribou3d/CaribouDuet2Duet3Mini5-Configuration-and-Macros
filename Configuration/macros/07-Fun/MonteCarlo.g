; =========================================================================================================
;
; Monte-Carlo simulation for the estimation of pi = 3.1415926535
; The larger the number of darts, the better the estimate will be.
; You will need 1000 darts for 3     (takes 5sec)
;              20000 darts for 3.1   (takes 60 sec)
;             150000 darts for 3.14  (takes 420 sec)
; depending on the quality of the random numbers. A nice animation of the
; method can be found here https://academo.org/demos/estimating-pi-monte-carlo/
;
; =========================================================================================================
;
; variables
;
M291 R"Estimate Pi. That takes a moment ... " P"Press OK to start ..." S2 ; display new message
;
var maxdarts = 1000                                                    ; number of darts to be thrown. You
var radius   = 1000                                                    ; radius of the circle = half the length of the square
var darts    = 0                                                       ; loop counter
var countin  = 0                                                       ; number of darts inside the circle
var xpos     = 0                                                       ; x position of the dart
var ypos     = 0                                                       ; y position of the dart
var radiussquare = var.radius * var.radius                             ; square of the radius of the circle
;
; do the Monte-Carlo simulation
;
M291 P"Running ..." S1                                                 ; display message

while var.darts < var.maxdarts                                         ; throw maxdarts darts
    set var.darts = var.darts +1                                       ; count darts
    set var.xpos  = random(var.radius)                                 ; generate random x position
    set var.ypos  = random(var.radius)                                 ; generate random y position
    if var.xpos * var.xpos + var.ypos * var.ypos <= var.radiussquare   ; check if the dart is inside the circle
        set var.countin=var.countin+1                                  ; if yes then count it
;
var ratio = 4.0 * var.countin / var.maxdarts
;
M291 P{"Darts in circle ratio: " ^ var.countin ^ " / " ^ var.maxdarts ^ ". Error: " ^ pi - var.ratio } R{"Estimate for pi: " ^ var.ratio} S2                 ; display new message
;
; =========================================================================================================
;
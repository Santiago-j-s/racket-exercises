;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname car-example) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; #lang racket
(require 2htdp/universe)
(require 2htdp/image)

; Constants
(define WIDTH-OF-WORLD 200)
(define HEIGHT-OF-WORLD WIDTH-OF-WORLD)
(define WHEEL-RADIUS 5)
(define WHEEL-DISTANCE (* WHEEL-RADIUS 5))
(define CAR-LENGTH (* WHEEL-RADIUS 8))
(define Y-CAR (- HEIGHT-OF-WORLD (* 3 WHEEL-RADIUS)))

; Image constants
(define WHEEL (circle WHEEL-RADIUS "solid" "black"))
(define SPACE (rectangle WHEEL-RADIUS (/ WHEEL-RADIUS 2) "solid" "white"))
(define BOTH-WHEELS (beside WHEEL SPACE WHEEL))
(define BACKGROUND (rectangle HEIGHT-OF-WORLD WIDTH-OF-WORLD "solid" "white"))
(define UPCAR (rectangle (/ CAR-LENGTH 2) WHEEL-RADIUS 'solid "red"))
(define DOWNCAR (rectangle CAR-LENGTH (* 2 WHEEL-RADIUS) 'solid "red"))
(define CAR (underlay/offset (above UPCAR DOWNCAR) 0 (* 2 WHEEL-RADIUS) BOTH-WHEELS))
                    
; X Position -> Image
; places the car x pixels to the right of the left margin of the background
(define (render-world x) (place-image CAR x Y-CAR BACKGROUND))

; X Position -> X Position
; adds 3 to x to move the car to the right
(define (tock x)
  (modulo (+ x 3) WIDTH-OF-WORLD))

; X Position -> X Position
; places the car at the 'x-mouse' if 'button' is "button-down"
(define (click x-position x-mouse y-mouse button)
  (cond
    [(string=? "button-down" button) x-mouse]
    [else x-position]))

; World-State -> World-State
; launches the program from some initial state
(define (main ws)
  (big-bang ws
            [on-tick tock]
            [to-draw render-world]
            [on-mouse click]))

(main 0)
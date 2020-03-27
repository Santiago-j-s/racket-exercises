;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise45) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")))))
; Exercise 45
; AnimationState is a Number
; interpretation the number of clock ticks since the animation started

; Use the data definition to design a program that moves the car 
; to a sine wave. Don’t try to drive like that. 

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
(define CAR (underlay/offset 
             (above UPCAR DOWNCAR) 0 (* 2 WHEEL-RADIUS) BOTH-WHEELS))

; AnimationState -> Image
; interpretation the number of clock ticks since the animation started
(define (render-world as) (place-image 
                           CAR 
                           (modulo as WIDTH-OF-WORLD) 
                           (+ (* (sin as) 5) Y-CAR) 
                           BACKGROUND))

; AnimationState -> AnimationState
; adds 1 to as
(define (tock as) (+ as 1))

; AnimationState -> AnimationState
; launches the program from some initial state
(define (main ws)
  (big-bang ws
            [on-tick tock]
            [to-draw render-world]))

(main 0)
;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname exercise56) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))
(require 2htdp/universe)
(require 2htdp/image)

; Constants
(define HEIGHT 300)
(define WIDTH 100)
(define YDELTA 3)
(define FONT-SIZE 20)
(define WIDTH-ROCKET 5)
(define HEIGHT-ROCKET 30)
(define X-POS 10)
(define Y-TEXT (* 3/4 HEIGHT))
(define ROCKET-CENTER (/ HEIGHT-ROCKET 2))


; Graphical Constants
(define BACKGROUND (empty-scene WIDTH HEIGHT))
(define ROCKET (rectangle WIDTH-ROCKET HEIGHT-ROCKET "solid" "red"))

; A RocketState is one of:
; - "resting"
; - an number in [-3, -1]
; - a non-negative number
; interpretation a rocket resting on the ground, in count-down mode, 
; or the number of pixels from the top i.e. its height

; RocketState -> RocketState
(define (rocket-simulator rocket-state)
  (big-bang rocket-state
            [to-draw show]
            [on-key launch]
            [on-tick fly]
            [stop-when stop?]))

; RocketState -> Image
; Renders the state as a resting or flying rocket

(check-expect
 (show "resting")
 (place-image ROCKET
              X-POS (- HEIGHT ROCKET-CENTER)
              BACKGROUND))

(check-expect
 (show -2)
 (place-image (text "-2" FONT-SIZE "red")
              X-POS Y-TEXT
              (place-image ROCKET
                           X-POS (- HEIGHT ROCKET-CENTER)
                           BACKGROUND)))

(check-expect
 (show 53)
 (place-image ROCKET
              X-POS (- 53 ROCKET-CENTER)
              BACKGROUND))

(check-expect
 (show HEIGHT)
 (place-image ROCKET
              X-POS (- HEIGHT ROCKET-CENTER)
              BACKGROUND))

(check-expect
 (show 0)
 (place-image ROCKET
              X-POS (- 0 ROCKET-CENTER)
              BACKGROUND))
 
              
(define (show rocket-state)
  (cond
    [(resting? rocket-state) (place-rocket rocket-state)]
    [(<= -3 rocket-state -1) (show-countdown rocket-state)]
    [(>= rocket-state 0) (place-rocket rocket-state)]))

; RocketState KeyEvent -> RocketState
; Starts the count-down when the pressbar is pressed
; if the rocket is still resting

(check-expect (launch "resting" " ") -3)
(check-expect (launch "resting" "a") "resting")
(check-expect (launch -3 " ") -3)
(check-expect (launch -1 "a") -1)
(check-expect (launch 33 " ") 33)
(check-expect (launch 33 "a") 33)

(define (launch rocket-state key-event)
  (if (and (resting? rocket-state) (string=? " " key-event))
      -3
      rocket-state))

; RocketState -> RocketState
; Raises the rocket by YDELTA if the rocket is flying

(check-expect (fly "resting") "resting")
(check-expect (fly -3) -2)
(check-expect (fly -2) -1)
(check-expect (fly -1) HEIGHT)
(check-expect (fly 10) (- 10 YDELTA))
(check-expect (fly 22) (- 22 YDELTA))

(define (fly rocket-state)
  (cond
    [(resting? rocket-state) rocket-state]
    [(<= -3 rocket-state -1) (if (= rocket-state -1) HEIGHT (+ rocket-state 1))]
    [(>= rocket-state 0) (- rocket-state YDELTA)]))

; RocketState -> Image
; Places the rocket in the background
(define (place-rocket rocket-state)
  (cond [(or (resting? rocket-state) (<= -3 rocket-state -1))
         (place-image ROCKET X-POS (- HEIGHT ROCKET-CENTER) BACKGROUND)]
        [(>= rocket-state 0)
         (place-image ROCKET X-POS (- rocket-state ROCKET-CENTER) BACKGROUND)]))

; RocketSate -> Image
; Shows the countdown and the rocket in the ground
(define (show-countdown rocket-state)
  (place-image (text (number->string rocket-state) FONT-SIZE "red")
               X-POS Y-TEXT
               (place-rocket rocket-state)))

; RocketState -> Boolean
; Returns #true if the rocket is in the "resting" state
(define (resting? rocket-state)
  (if (and (string? rocket-state) (string=? "resting" rocket-state))
      #true
      #false))

; RocketState -> Boolean
; Returns #true when the rocket is out of sight
(define (stop? rocket-state)
  (if (and (number? rocket-state) (= rocket-state 0))
      #true
      #false))
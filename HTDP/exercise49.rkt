;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname exercise49) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ((lib "image.rkt" "teachpack" "2htdp")))))
;;; Exercise49
;;; Design a world program that maintains and displays a “happiness gauge.”
;;; Let’s call it gauge-prog, and let’s agree that the program consumes
;;; the maximum level of happiness.
;;; The gauge display starts with the maximum score, and with each clock tick,
;;; happiness decreases by -0.1; it never falls below 0,
;;; the minimum happiness score. Every time the down arrow key is pressed,
;;; happiness increases by 1/5;
;;; every time the up arrow is pressed, happiness jumps by 1/3

(require 2htdp/universe)
(require 2htdp/image)

; HappinessLevel is a Real Number in the closed interval [0, 1]
; HappinessGauge is a Scene with a gauge that represents the HappinessLevel

; Constants
(define MAX-HAPPINESS 1)
(define MIN-HAPPINESS 0)

; With each tick of the clock
; the HapppinessGauge is reduced by a value of MODIFIER-TIME
(define MODIFIER-TIME 0.1)
; Every time that the user press the down key the HappinessGauge
; is increased by a value of MODIFIER-DOWN
(define MODIFIER-DOWN 0.2)
; Every time that the user press the down key the HappinessGauge
; is increased by a value of MODIFIER-UP
(define MODIFIER-UP 1/3)

(define WIDTH-OF-WORLD 500)
(define HEIGHT-OF-WORLD (/ WIDTH-OF-WORLD 10))

; x position and y position of the HappinessGauge
(define X-POS (/ WIDTH-OF-WORLD 2))
(define Y-POS (/ HEIGHT-OF-WORLD 2))

; Image Constants
(define BACKGROUND (rectangle WIDTH-OF-WORLD HEIGHT-OF-WORLD "solid" "black"))
(define HAPPINESS-GAUGE (rectangle WIDTH-OF-WORLD 10 "outline" "red"))

; HappinessLevel -> HappinessGauge
; Draws the happiness gauge from a happiness level
(define (gauge-draw happiness-level)
  (place-image
   (overlay/align "left"
                  "bottom"
                  (rectangle (* happiness-level WIDTH-OF-WORLD) 
                             10
                             "solid"
                             "red")
                  HAPPINESS-GAUGE)
   X-POS
   Y-POS
   BACKGROUND))

; HappinessLevel -> Happiness-Level
; Reduces the hapinness level by a value of MODIFIER-TIME
; The happiness level must be greater than zero
(define (tock happiness-level)
  (let ([new-happiness-level (- happiness-level MODIFIER-TIME)])
    (if (> new-happiness-level MIN-HAPPINESS)
        new-happiness-level
        MIN-HAPPINESS)))

; HappinessLevel -> Happiness-Level
; Increments the happiness level by a value of increment
(define (increase-happiness happiness-level increment)
  (let ([new-happiness-level (+ happiness-level increment)])
    (if (> new-happiness-level MAX-HAPPINESS)
        MAX-HAPPINESS
        new-happiness-level)))

; HappinessLevel KeyEvent -> Happiness-Level
; Calculates a new happiness level when a key is pressed
; by a value of the key modifier (MODIFIER-UP, MODIFIER-DOWN)
(define (key-handler happiness-level key)
  (cond
    [(key=? key "down") (increase-happiness happiness-level MODIFIER-DOWN)]
    [(key=? key "up") (increase-happiness happiness-level MODIFIER-UP)]
    [else happiness-level]))

; HappinessGauge -> HappinessGauge
; launches the program from some initial HappinessLevel
(big-bang MAX-HAPPINESS
          [to-draw gauge-draw]
          [on-key key-handler]
          [on-tick tock 1])
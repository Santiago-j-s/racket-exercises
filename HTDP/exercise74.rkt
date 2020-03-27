;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname exercise74) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ((lib "image.rkt" "teachpack" "2htdp")))))
(require 2htdp/universe)

; Graphical Constants
(define BACKGROUND (empty-scene 100 100))
(define DOT (circle 3 "solid" "red"))

; The state of the world is represented by a Posn
(define (main p0)
  (big-bang p0
            [on-tick x+]
            [on-mouse reset-dot]
            [to-draw scene+dot]))

; Posn -> Image
; Adds a red dot to the background at p

(check-expect (scene+dot (make-posn 10 20))
              (place-image DOT 10 20 BACKGROUND))
(check-expect (scene+dot (make-posn 88 73))
              (place-image DOT 88 73 BACKGROUND))

(define (scene+dot p)
  (place-image DOT (posn-x p) (posn-y p) BACKGROUND))

; Posn -> Posn
; Increases the x coordinate of p by 3

(check-expect (x+ (make-posn 10 0)) (make-posn 13 0))

(define (x+ p)
  (posn-up-x p (+ 3 (posn-x p))))

; Posn Number Number MouseEvt -> Posn
; for mouse clicks, (make-posn x y); otherwise p

(check-expect (reset-dot (make-posn 10 20) 29 31 "button-down")
              (make-posn 29 31))
(check-expect (reset-dot (make-posn 10 20) 29 31 "button-up")
              (make-posn 10 20))

(define (reset-dot p x y me)
  (cond
    [(mouse=? "button-down" me) (make-posn x y)]
    [else p]))

; Posn -> Posn
; Changes the x coordinate of p for n

(check-expect (posn-up-x (make-posn 10 20) 4) (make-posn 4 20))

(define (posn-up-x p n)
  (make-posn n (posn-y p)))
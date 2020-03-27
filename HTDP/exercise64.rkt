;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname exercise64) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))
(require 2htdp/universe)

; A DoorState is one of:
; - "locked"
; - "closed"
; - "open"

; DoorState -> DoorState
(define (door-simulation initial-state)
  (big-bang initial-state
            [on-tick door-closer 3]
            [to-draw door-render]
            [on-key door-actions]))

; DoorState -> DoorState
; closes an open door

(check-expect (door-closer "closed") "closed")
(check-expect (door-closer "locked") "locked")
(check-expect (door-closer "open") "closed")

(define (door-closer door-state)
  (cond
    [(string=? "closed" door-state) "closed"]
    [(string=? "locked" door-state) "locked"]
    [(string=? "open" door-state) "closed"]))

; DoorState KeyEvent -> DoorState
; Simulates the actions on the door via three kinds of key events

(check-expect (door-actions "locked" "u") "closed")
(check-expect (door-actions "closed" "l") "locked")
(check-expect (door-actions "closed" " ") "open")
(check-expect (door-actions "open" "a") "open")
(check-expect (door-actions "closed" "a") "closed")

(define (door-actions door-state key-event)
  (cond
    [(and (string=? "locked" door-state) (string=? "u" key-event)) "closed"]
    [(and (string=? "closed" door-state) (string=? "l" key-event)) "locked"]
    [(and (string=? "closed" door-state) (string=? " " key-event)) "open"]
    [else door-state]))

; DoorState -> Image
; Translates the state of the door into a large text

(check-expect (door-render "closed") (text "closed" 60 "red"))

(define (door-render door-state) (text door-state 60 "red"))
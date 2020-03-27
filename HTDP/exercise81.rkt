;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise81) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")))))
; A Time is a structure (make-time Number Number Number)
; interpretation the hours, minutes and seconds that have passed since midnight
(define-struct time [hours minutes seconds])

(define t1 (make-time 1 0 0))
(define t2 (make-time 10 30 30))

; Time -> Number
; calculates the number of seconds that have passed since midnight

(check-expect (time->seconds t1) 3600)
(check-expect (time->seconds t2) 37830)

(define (time->seconds t)
  (+
   (* 3600 (time-hours t))
   (* 60 (time-minutes t))
   (time-seconds t)))

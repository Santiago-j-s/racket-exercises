;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise39) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")))))
;HTPD Exercise 39
;
; Design the function string-rest, which produces a string 
; like the given one with the first character removed.

(define (string-rest string)
  (substring string 1))

(check-expect (string-rest "hola") "ola")
(check-expect (string-rest "asdf") "sdf")
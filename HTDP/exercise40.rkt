;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise40) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")))))
;HTPD Exercise 40
;
; Design the function string-remove-last, which produces a string 
; like the given one with the last character removed.

(define (string-rest string)
  (substring string 0 (sub1 (string-length string))))

(check-expect (string-rest "hola") "hol")
(check-expect (string-rest "asdf") "asd")
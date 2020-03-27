;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise37) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")))))
; HTDP Exercise 37
;
; Design the function string-last,
; which extracts the last character from a non-empty string.


(define (string-last string)
  (substring string (sub1 (string-length string))))

(check-expect (string-last "hola") "a")
(check-expect (string-last "asdf") "f")
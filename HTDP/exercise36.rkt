;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise36) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")))))
; HTDP Exercise 36
; Design the function string-first, which extracts the first character from a non-empty string. Don’t worry about empty strings.

(define (string-first string)
  (substring string 0 1))

(check-expect (string-first "hola") "h")
(check-expect (string-first "asdf") "a")
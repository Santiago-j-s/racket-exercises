;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise82) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")))))
; A 1String is an one of
; - one letter string
; - #false
(define (1string? s)
  (if (or (= 1 (string-length s)) #false)
      #true
      #false))

; A Word is a structure: (make-word 1String 1String 1String)
; interpretation a word of three letters
(define-struct word [letter1 letter2 letter3])

(define word1 (make-word "a" "b" "c"))
(define word2 (make-word "a" "b" "d"))
(define word3 (make-word "b" "c" "a"))
(define word4 (make-word "a" "b" #false))

; Word Word -> Word
; produces a word that indicates when w1 and w2 agree or disagree
; retains the content of the structure fields if the two agree
; otherwise it places #false in the field of the resulting word

(check-expect (compare-word word1 (make-word "a" "b" "c")) word1)
(check-expect (compare-word word1 word2) word4)
(check-expect (compare-word word1 word3) (make-word #false #false #false))

(define (compare-word w1 w2)
  (make-word
   (compare-1string (word-letter1 w1) (word-letter1 w2))
   (compare-1string (word-letter2 w1) (word-letter2 w2))
   (compare-1string (word-letter3 w1) (word-letter3 w2))))
   
; 1String 1String -> 1String
; if s1 and s2 are equal returns s1, else #false

(check-expect (compare-1string "a" "a") "a")
(check-expect (compare-1string "a" "b") #false)

(define (compare-1string s1 s2)
  (if (string=? s1 s2)
      s1
      #false))
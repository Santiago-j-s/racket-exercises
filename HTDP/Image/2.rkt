;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |2|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")))))
(define (a-number digit)
  (overlay
   (text (number->string digit) 12 "white")
   (circle 10 "solid" "black")))

(define (place-and-turn digit dial)
  (rotate 30
          (overlay/align "center" 
                         "top"
                         (a-number digit)
                         dial)))

(place-and-turn
 3
 (place-and-turn
  8
  (place-and-turn
   5 
   (circle 60 "solid" "white"))))

(define (place-all-numbers dial)
  (foldl place-and-turn dial '(0 9 8 7 6 5 4 3 2 1)))

(place-all-numbers (circle 60 "solid" "white"))
;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |1|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")))))
(define victorian 
  (above (beside/align "bottom"
                       (triangle 40 "solid" "red")
                       (triangle 30 "solid" "red"))
         (rectangle 70 30 "solid" "white")))

(define door (rectangle 15 25 "solid" "brown"))

(define door-with-knob (overlay/align "right" 
                                      "center" 
                                      (circle 3 "solid" "yellow") 
                                      door))

(overlay/align "center" "bottom" door-with-knob victorian)

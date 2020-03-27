#lang racket
(define (sum n)
  (cond
    [(= n 0) 0]
    [(zero? (* (remainder n 5) (remainder n 3))) (+ (sum (- n 1)) n)]
    [else (sum (- n 1))]))
(sum 999)
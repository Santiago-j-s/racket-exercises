#lang racket
; fibsum : number number number number -> number
; to compute de sum of fibonacci numbers below 'max'
(define (fibsum n1 n2 sum max)
  (cond
    [(> n2 max) sum]
    [(odd? n2) (fibsum n2 (+ n1 n2) sum max)]
    [else (fibsum n2 (+ n1 n2) (+ sum n2) max)]))

(fibsum 0 1 0 4000000)

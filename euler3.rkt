#lang racket
(require math/number-theory)
(define number 600851475143)
(last (prime-divisors number))
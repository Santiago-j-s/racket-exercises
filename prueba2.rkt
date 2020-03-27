;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname prueba2) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")))))
#lang racket

(require net/url)
(require net/uri-codec)


(define (login nick password)
  (define login-url "http://wocial.com/in")
  (define args (string->bytes/utf-8
                (alist->form-urlencoded (list
                                        (cons 'wc__nick nick)
                                        (cons 'wc__pass password)))))
  
  (define in (post-impure-port 
                 (string->url login-url)
                 args
                 (list "Content-Type: application/x-www-form-urlencoded")))
  
  (port->string in))
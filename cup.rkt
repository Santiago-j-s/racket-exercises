#lang racket

(require net/url)
(require racket/port)

; Constants
(define BASE_URL "http://scup.unp.edu.ar/muestraweb")
(define LOGIN (string->url (string-append BASE_URL "/control_web.php")))
(define TDOC "D.N.I.")
(define NUMERO_DOCUMENTO "41.793.759")


(define contrasena "1111")

(define data (string->bytes/utf-8 
              (string-append "tdoc:" TDOC 
                             ";ndoc:" NUMERO_DOCUMENTO 
                             ";contrasena:" "1111" )))

(port->string (post-impure-port LOGIN data))
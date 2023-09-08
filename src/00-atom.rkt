#lang racket/base

(provide atom? nil)

(define atom?
 (lambda (x)
  (and (not (pair? x)) (not (null? x)))))

(define nil '())

; (atom? 1)
; (atom? '())
; (atom? '(1))

; (define add1
;  (lambda (n)
;   (+ n 1)))

; (println "hello Racket")

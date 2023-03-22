#lang racket
(provide atom?)

(define atom?
 (lambda (x)
  (and (not (pair? x)) (not (null? x)))))

; (atom? 1)
; (atom? '())
; (atom? '(1))

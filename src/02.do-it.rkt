#lang racket
(require "atom.rkt")

(define lat?
  (lambda (xs)
    (cond
      ((null? xs) #t)
      ((atom? (first xs)) (lat? (rest xs)))
      (else #f))))

; (lat? '(Jack Sprat cloud eat no chicken fat))
; (lat? '((Jack) Sprat cloud eat no chicken fat))
; (lat? '())
; (lat? '(bacon (and egg)))

(define member?
  )

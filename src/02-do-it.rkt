#lang racket
(require "00-atom.rkt")

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
  (lambda (a lat)
    (cond
      ((null? lat) #f)
      ((eq? a (first lat)) #t)
      (else (member? a (rest lat))))))

; (member? 'meat '(mashed potatos and meat gravy))
; (member 'liver '(bagles and lox))

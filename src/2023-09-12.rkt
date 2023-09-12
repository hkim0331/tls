#lang racket

(require "00-atom.rkt")

(define length2-aux
  (lambda (l n)
    (cond
      ((null? l) n)
      (else (length2-aux (rest l) (+ 1 n))))))

(define length2
  (lambda (l)
    (length2-aux l 0)))

; (length2 '(1 2 3 3 2))

(define rember-aux
  (lambda (a lst ret)
    (cond
      ((null? lst) ret)
      ((eq? (first lst) a) (append (reverse (rest lst)) ret))
      (else (rember-aux a (rest lst) (cons (first lst) ret))))))

(define rember
  (lambda (a lst)
    (reverse (rember-aux a lst '()))))

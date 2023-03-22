;;#lang racket

(define atom?
 (lambda (x)
  (and (not (pair? x)) (not (null? x)))))

; (atom? 1)
; (atom? '(1))
; (atom? '())


(first '(1 2 3))

(rest '(1 2 3))

;; define で名前をつける
(define a '(1 2 3))

(first a)

(rest a)

;; こんな例はよくない
(define apple 'orange)
(define orange 'apple)

apple

orange



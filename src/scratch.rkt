#lang racket

(require "00-atom.rkt")

; マクロはどう書く？
; time 関数書きたいぞ。
; already exists.
; (time body ...+)

(define-syntax-rule (swap x y)
  (let ((temp x))
    (set! x y)
    (set! y temp)))

; (define x 10)
; (define y 20)
; (swap x y)
; x
; y

; (current-inexact-milliseconds)

(define-syntax-rule (my-time expr)
  (let* ((now (current-inexact-milliseconds))
         (result expr))
    (println (format "elapsed time (millisecond) ~s"
                     (- (current-inexact-milliseconds) now)))
    result))

(define dec
  (lambda (n) (- n 1)))

(define tarai
  (lambda (x y z)
    (if (<= x y)
      y
      (tarai (tarai (dec x) y z)
             (tarai (dec y) z x)
             (tarai (dec z) x y)))))

;; (my-time (tarai 10 5 0))

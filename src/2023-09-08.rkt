#lang racket
(require "00-atom.rkt")

; # 2023-09-04

; 今日はコキマロ、シマジロー（仮称）、ChatPPP と hkimura の4人。
; 何章読んだってのじゃなく、ほんとに腹にストンと入ってるかの確認。

; ## 神様からもらった5つの関数は？

; - car (first)
; - cdr (rest)
; - cons
; - null?
; - eq?

; ## lat?

; 引数 xs が lat
; (アトムからなるリスト。リストを要素に持たないリスト)
; かどうかを判定する。

; ??? に入るのはなんでしょう？

; ```scheme
(define lat?
  (lambda (xs)
    (cond
      ((null? xs) #t)
      ((atom? (first xs)) (lat? (rest xs)))
      (else #f))))
; ```

(lat? '(1 2 3 4 5))
(lat? '((1) 2 3 4 5))
(lat? '(1 2 3 4 (5)))

; ; ## length

; ; リスト xs の長さを計算する。

; ; ??? に入るのはなんでしょう？

; ; ```scheme
(define length
  (lambda (xs)
    (cond
      ((null? xs) 0)
      (else (+ 1 (length (rest xs)))))))
; ; ```

(length '())
(length '(1 2 3 4))
(length '((1) (2)))

; ; ## member?

; ; a は lat のメンバーですか？

; ; ??? に入るのはなんでしょう？ member の第二引数は lat に限る。

; ; ```scheme
(define member?
  (lambda (a lat)
    (cond
      ((null? lat) #f)
      ((eq? (first lat) a) #t)
      (else (member? a (rest lat))))))
; ; ```

(member? 'a '(b c d a d))
(member? 'z '(a b c d))
(member? '(a) '((a) b c d))

; ; ## sum

; ; 整数のリストを総和する。

; ; ??? に入るのはなんでしょう？

; ; ```scheme
(define sum
  (lambda (xs)
    (cond
      ((null? xs) 0)
      (else (+ (first xs)
               (sum (rest xs)))))))
; ; ```

(sum (range 10))

; ; ## even?

; ; n は偶数ですか？

; ; ??? に入るのはなんでしょう？

; ; ```scheme
(define even?
  (lambda (n)
    (cond
    ((eq? n 0) #t)
    ((eq? n 1) #f)
    (else (even? (- n 2))))))
; ; ```

(even? 3)
(even? 4)

; ; ## 2 の冪乗

; ; ??? に入るのはなんですか？

; ; ```scheme
(define power-of-2
  (lambda (n)
    (cond
      ((eq? n 0) 1)
      (else (* 2 (power-of-2 (- n 1)))))))
; ; ```

(power-of-2 10)

; ; ## フィボナッチ数列

; ; ```
; fibo(0) = 0
; fibo(1) = 1
; fibo(n) = fibo(n-1) + fibo(f-2)をプログラムしてください。
; ; ```

; ; ```scheme
(define fibo
  (lambda (n)
    (cond
      ((eq? n 0) 0)
      ((eq? n 1) 1)
      (else (+ (fibo (- n 1))
               (fibo (- n 2)))))))
; ; ```

(fibo 10)
(fibo 20)
(fibo 30)

; ; ## リストは同じ長さか？

; ; ```scheme
(define same-len?
  (lambda (xs1 xs2)
    (cond
      ((null? xs1) (null? xs2))
      ((null? xs2) (null? xs1))
      (else (same-len? (rest xs1) (rest xs2))))))
; ; ```

(same-len? '() '())
(same-len? '(1) '(2))
(same-len? '(1 2 3) '(a b c))
(same-len? '(1 2 3 4) '(a b c))
(same-len? '(1 2 3) '(a b c d))

; ; ## あと何やったっけ？

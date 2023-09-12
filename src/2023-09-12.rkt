#lang racket

(require "00-atom.rkt")

;; ごく自然な再帰で。
(define length
  (lambda (lst)
    (cond
      ((null? lst) 0)
      (else (+ 1 (length (rest lst)))))))

;; 補助関数 length2-aux を導入、同時に補助変数 n も導入する。
;; 補助変数は戻り値予定のもの。
(define length2-aux
  (lambda (lst n)
    (cond
      ((null? lst) n)
      (else (length2-aux (rest lst) (+ 1 n))))))

(define length2
  (lambda (lst)
    (length2-aux lst 0)))

;; リスト lst から最初に見つかるアトム a を除いたリストを返す。
(define rember
  (lambda (a lst)
    (cond
      ((null? lst) '())
      ((eq? (first lst) a) (rest lst))
      (else (cons (first lst)
                  (rember a  (rest lst)))))))

; (rember '3 '(1 2 3 4 5))

;; 補助関数 rember2-aux の導入。補助変数 ret に戻りリストを作る。
;; 戻りリストの要素順がちょっと気になるが。。。
(define rember2-aux
  (lambda (a lst ret)
    (cond
      ((null? lst) ret)
      ((eq? (first lst) a) (append (rest lst) ret))
      (else (rember2-aux a (rest lst) (cons (first lst) ret))))))

(define rember2
  (lambda (a lst)
    (rember2-aux a lst '())))

; (rember2 1 '(1 2 3 4 5))
; (rember2 3 '(1 2 3 4 5))
; (rember2 5 '(1 2 3 4 5))

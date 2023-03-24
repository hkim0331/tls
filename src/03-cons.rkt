#lang racket
(require "atom.rkt")

;; cons の第一引数はアトムあるいはリストでよいが、
;; cons の第二引数はリストに限る。

; > (cons 'a '(1 2 3))
; '(a 1 2 3)
; > (cons '(a) '(1 2 3))
; '((a) 1 2 3)
; > (cons a '())
; '(a)

; lat からアトム a を抜いたリストを返す。
(define rember
  (lambda (a lat)
    (cond
      ((null? lat) '()) ; 抜くものがない。
      ((eq? a (first lat)) (rest lat)) ; 先頭に見つかった。
      (else (cons (first lat)
                  (rember a (rest lat))))))) ; 先頭を保存しておき、
                                             ; rember した結果にくっつける。

(rember 'mint '(lamb drops and mint jelly))
(rember 'and '(bacon lettuce and tomato))

;; firsts は引数リストの先頭要素だけからなるリストを返す。
;; 本は引数を l にしてるが、1と間違いやすいので lst あるいは coll で行こう。

; (define ffirst
;   (lambda (lst)
;     (first (first lst))))
(define ffirst caar)

(define firsts
  (lambda (lst)
    (cond
      ((null? lst) '())
      (else (cons (ffirst lst) (firsts (rest lst)))))))

(firsts '((apple pearch pumpkin)
          (plum pear cherry)
          (grape raisin pea)
          (bean carrot eggplant)))

;; insertR, insertL, subst
(define insertR
  (lambda (new old lat)
    (cond
      ((null? lat) '())
      ((eq? old (first lat)) (cons old (cons new lat)))
      (else (cons (first lat) (insertR new old (rest lat)))))))

(insertR 'topping 'fudge '(ice cream fudge for dessert))

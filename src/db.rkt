#lang racket

;; database システムを作ろう。
;; これと spin で、td-app を作る。
;; td-app は今日やったこと、今日やることをネットから
;; 入力、検索できるアプリとする。
;; ブラウザだけじゃなく、端末からも操作できるように。
;; td は todo とも、todays ともどっちでも。

; $ raco pkg install date
(require date)

; > (current-date-string-iso-8601 #t)
; "2023-03-24T07:08:48Z"
; > (current-date-string-iso-8601 #f)
; "2023-03-24T07:11:32Z"
;
; > (local-current-date)
; (date* 20 9 7 24 3 2023 5 82 #f 0 17000000 "")
;
; > (current-date-string-rfc-2822)
; "Fri, 24 Mar 2023 07:09:59 Z"
;
; > (current-time)
; (tm:time 'time-utc 737000000 1679641685)

(define nil '())
(define *db* nil)

(define init
  (lambda ()
    (set! *db* nil)))

(set! *db* "what happened?")
*db*
(init)
*db*

(define add-datetime
  (lambda (data)
    (append (list 'datetime (current-date-string-iso-8601 #f)) data)))

(add-datetime '(a 1 b 2))
    
(define insert
  (lambda (data)
    (set! *db* (cons (add-datetime data) *db*))))

(insert '(given-name "hiroshi" family-name "kimura"))
(first *db*)

(define next cddr)

(define debug
 (lambda (x . more)
  (println x)
  (map println more)))

(debug 1 2 3)

; FIXME: even length
(define has-key?
 (lambda (key row)
  ; (debug "has-key?" key row)
  (cond
   ((null? row) #f)
   ((eq? key (first row)) #t)
   (else (has-key? key (next row))))))

(has-key? 'a '(a b c d))
(has-key? 'z '(a 1 b 2 z 3))
(has-key? 'z '(a b d z))
(has-key? 'given-name '(given-name "a" family-name "b"))
(has-key? 'family-name '(given-name "a" family-name "b"))

(define find-value
 (lambda (key row)
  (cond
   ((null? row) #f)
   ((eq? key (first row)) (second row))
   (else (find-value key (next row))))))

(find-value 'a '())
(find-value 'a '(a 1 b 2))
(find-value 'z '(a 1 b 2 z 3))

; row が key を持つことは has-key? で保証されている。
(define satisfy?
 (lambda (f key value row)
  (f value (find-value key row))))

(satisfy? = 'a 1 '(a 1 b 2 c 3))
(satisfy? = 'b 2 '(a 1 b 2 c 3))
(satisfy? = 'c 4 '(a 1 b 2 c 3))

(define find-aux
  (lambda (db f key value)
    (cond
      ((null? db) nil)
      ((and (has-key? key (first db))
            (satisfy? f key value (first db)))
       (first db))
      (else (find-aux (rest db) f key value)))))

; (find string=? 'given-name "hiroshi") のように呼び出す。
(define find
 (lambda (f key value)
  (find-aux *db* f key value)))

(find string=? 'given-name "hiroshi")
(find string=? 'given-name "yasuko")

; (define find-all-aux)
; (define find-all)

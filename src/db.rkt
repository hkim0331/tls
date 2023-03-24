#lang racket
;; database システムを作ろう。これと spin で、td-app を作る。
;; td-app は今日やったこと、今日やることをネットから入力、検索できるアプリとする。
;; ブラウザだけじゃなく、端末からも操作できるように。
;; td は todo とも、todays ともどっちでも。
;;
;; * database  ::= document の集まり
;; * document  ::= key-value の集まり
;; * key-value ::= (key kv) でキー、(valye kv) でバリューが取り出せる kv の集まり
;;
;; require
;; $ raco pkg install date

(provide
  init
  insert
  find
  documents
  load
  save
  )

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
(init)
*db*

(define key (lambda (obj) (car obj)))
(define val (lambda (obj) (cdr obj)))

(define make-kv
  (lambda (key value)
    (cons key value)))

(define find-kv
  (lambda (k doc)
    (filter (lambda (kv) (eq? k (key kv))) doc)))

;; use list?
(define make-doc
  (lambda (key value . more)
    (if (null? more)
      (list (make-kv key value))
      (cons
        (make-kv key value)
        (apply make-doc more)))))

(make-doc 'a 1)
(make-doc 'a 1 'b 2)
(make-doc 'a 1 'b 2 'c '(x y z))
(find-kv 'b '((a . 1) (b . 2) (c x y z)))

(define make-datetime
 (lambda ()
  (make-kv  'datetime (current-date-string-iso-8601 #t))))

(make-datetime)

(define add-datetime
  (lambda (data)
    (cons (make-datetime) data)))

(add-datetime '((a . 1) (b . 2)))

(define insert
  (lambda (data)
    (set! *db* (cons (add-datetime data) *db*))))

(insert (make-doc 'given-name "akari" 'family-name "kimura"))
(insert (make-doc 'given-name "isana" 'family-name "kimura"))
(insert (make-doc 'given-name "aoi" 'family-name "kimura"))
(insert (make-doc 'given-name "hiroshi" 'family-name "kimura"))
(insert (make-doc 'given-name "miyuki" 'family-name "kimura"))

(define kv
  (lambda (k d)
    (first (filter (lambda (d) (eq? k (car d))) d))))

(kv 'given-name (first *db*))

(define find?
  (lambda (doc f key value)
    (let ((entry (kv key doc)))
      (and (not (empty? entry))
           (f value (val entry))))))

(find? (first *db*) string=? 'given-name "hiroshi")

(define find
  (lambda (f key value)
    (filter (lambda (doc) (find? doc f key value)) *db*)))

(find string=? 'given-name "hiroshi")
(first (find string=? 'family-name "kimura"))
(find string=? 'given-name "hiroshi")

(define documents (lambda () *db*))

(documents)

(define save-to
  (lambda (filename)
    (call-with-output-file
      filename
      (lambda (out) (write *db* out))
      #:exists 'replace)))

(define save
  (lambda () (save-to "scmdb.dat")))

(save)

(define load-from
  (lambda (filename)
    (call-with-input-file 
      filename
      (lambda (in) (set! *db* (read in))))))

(define load
  (lambda () (load-from "scmdb.dat")))
  
(init)
(load)
(documents)

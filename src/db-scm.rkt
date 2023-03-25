#lang racket
;; database システムを作ろう。これと spin で、td-app を作る。
;; td-app は今日やったこと、今日やることをネットから入力、検索できるアプリとする。
;; ブラウザだけじゃなく、端末からも操作できるように。
;; td は todo とも、todays ともどっちでも。
;;
;; * database ::= document の集まり
;; * document ::= entry の集まり
;; * entry    ::= (key entry) でキー、(valye entry) でバリューが取り出せるオブジェクト
;;
;; require
;; $ raco pkg install date

(provide
  init
  insert
  find
  documents
  load
  save)

(require date)

(define nil '())
(define *db* nil)

(define init
  (lambda ()
    (set! *db* nil)))

(init)

(define key (lambda (entry) (car entry)))
(define val (lambda (entry) (cdr entry)))

(define make-entry
  (lambda (key value) (cons key value)))

(define null-or-first
  (lambda (obj)
    (if (null? obj)
      '()
      (first obj))))

(define find-entry
  (lambda (k doc)
    (null-or-first (filter (lambda (entry) (eq? k (key entry))) doc))))

(define make-doc
  (lambda (key value . more)
    (if (null? more)
      (list (make-entry key value))
      (cons
        (make-entry key value)
        (apply make-doc more)))))

(make-doc 'a 1)
(make-doc 'a 1 'b 2)
(make-doc 'a 1 'b 2 'c '(x y z))

(find-entry 'b '((a . 1) (b . 2) (c x y z))) ;=> '(b . 2)
(find-entry 'z '((a . 1) (b . 2) (c x y z))) ;=> '()

(define make-datetime
 (lambda () (make-entry 'datetime (current-date-string-iso-8601 #t))))

; (make-datetime)

(define add-datetime
  (lambda (data) (cons (make-datetime) data)))

; (add-datetime '((a . 1) (b . 2)))

(define insert
  (lambda (data) (set! *db* (cons (add-datetime data) *db*))))

(insert (make-doc 'given-name "akari" 'family-name "kimura"))
(insert (make-doc 'given-name "isana" 'family-name "kimura"))
(insert (make-doc 'given-name "aoi" 'family-name "kimura"))
(insert (make-doc 'given-name "hiroshi" 'family-name "kimura"))
(insert (make-doc 'given-name "miyuki" 'family-name "kimura"))

(define entry
  (lambda (k d)
    (null-or-first (filter (lambda (d) (eq? k (car d))) d))))

(first *db*)
(entry 'given-name (first *db*))

(define find?
  (lambda (doc f key value)
    (let ((e (entry key doc)))
      (and (not (empty? e)) (f value (val e))))))

(find? (first *db*) string=? 'given-name "hiroshi")
(find? (first *db*) string=? 'given-name "miyuki")

(define find
  (lambda (f key value)
    (filter (lambda (doc) (find? doc f key value)) *db*)))

(define documents (lambda () *db*))

(define save-to
  (lambda (filename)
    (call-with-output-file
      filename
      (lambda (out) (write *db* out))
      #:exists 'replace)))

(define save
  (lambda () (save-to "scmdb.dat")))

(define load-from
  (lambda (filename)
    (call-with-input-file 
      filename
      (lambda (in) (set! *db* (read in))))))

(define load
  (lambda () (load-from "scmdb.dat")))

(save)
(init)
(load)
(length (documents))

(find string=? 'given-name "aoi")
(first (find string=? 'family-name "kimura"))
(find string=? 'given-name "hiroshi")
(find string<? 'datetime "2023")
(find string<? 'datetime "2024")
(insert (make-doc 'wbc "japan" 'result "gold"))
(find string=? 'wbc "japan")

(find (lambda (k v) #t) 'wbc "")

(define find-key
  (lambda (key)
    (find (lambda (k v) #t) key "")))

; もうちょっと
; (find-key 'wbc)

; (define key=? 
;   (lambda (k)
;     ()))
;; (filter (lambda (doc) (key=? 'key) (find-key 'family-name)))

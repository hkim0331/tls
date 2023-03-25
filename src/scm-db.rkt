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
  init       ; initialize database
  documents  ; return whole data
  insert     ; (insert 'key value 'key2 value2 ...)
  find       ; (find comp-function 'key value)
  has-key    ; (has-key 'key)
  load       ; load saved documents into memory
  save       ; save documents into file
  )

(require date)



;; FIXME: name?
(define null-or-first
  (lambda (obj)
    (if (null? obj)
      '()
      (first obj))))

(define nil '())
(define *db* nil)
(define documents (lambda () *db*))

(define id-closure
  (lambda ()
    (let ((n (length (documents))))
      (lambda ()
        (set! n (+ n 1))
        n))))

(define id (id-closure))

(define init
  (lambda ()
    (set! *db* nil)))

(define make-entry
  (lambda (key value) (cons key (cons value '()))))

(define key first)
(define val second)

; (define data (make-entry 'key 'value))
; (key data)
; (val data)

; (define get-value
;   (lambda (d k)
;     (null-or-first (filter (lambda (e) (eq? k (key e)) d)))))

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

; (make-doc 'a 1)
; (make-doc 'a 1 'b 2)
; (make-doc 'a 1 'b 2 'c '(x y z))

; (find-entry 'b '((a . 1) (b . 2) (c x y z))) ;=> '(b . 2)
; (find-entry 'z '((a . 1) (b . 2) (c x y z))) ;=> '()

(define make-datetime
 (lambda () (make-entry 'datetime (current-date-string-iso-8601 #t))))

; (make-datetime)

(define add-datetime
  (lambda (doc) (cons (make-datetime) doc)))

; (add-datetime '((a . 1) (b . 2)))

(define make-id
  (lambda () (make-entry 'id (id))))

; (make-id)

(define add-id
  (lambda (doc) (cons (make-id) doc)))

(define insert
  (lambda (a . b) 
    (let* ((data (cons a b))
           (doc (apply make-doc data)))
      (set! *db* (cons (add-id (add-datetime doc)) *db*)))))

(insert 'test "test")
*db*
(first *db*)
; (insert (make-doc 'given-name "isana" 'family-name "kimura"))
; (insert (make-doc 'given-name "aoi" 'family-name "kimura"))
; (insert (make-doc 'given-name "hiroshi" 'family-name "kimura"))
; (insert (make-doc 'given-name "miyuki" 'family-name "kimura"))

(define entry
  (lambda (k d)
    (null-or-first (filter (lambda (d) (eq? k (car d))) d))))

; (first *db*)
; (entry 'given-name (first *db*))

(define find
  (lambda (fn key value)
    (letrec
      ((find-aux (lambda (doc fn key value)
            (let ((e (entry key doc)))
              (and (not (empty? e)) (fn value (val e)))))))
        (filter (lambda (doc) (find-aux doc fn key value)) *db*))))

(define has-key
  (lambda (key)
    (find (lambda (k v) #t) key '())))

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

;; test 

(init)
(save)

(insert 'given-name "akari" 'family-name "kimura")
(insert 'given-name "isana" 'family-name "kimura")
(insert 'given-name "aoi" 'family-name "kimura")
(insert 'given-name "hiroshi" 'family-name "kimura")
(insert 'given-name "miyuki" 'family-name "kimura")
(insert 'wbc "japan" 'result "gold")
(insert 'wbc "usa" 'result "silver")
(insert 'computer 'mac 'os "macos")
(insert 'type "number" 'one 1)
(insert 'type "number" 'two 2)

(find string=? 'given-name "aoi")
(first (find string=? 'family-name "kimura"))
(find string=? 'given-name "hiroshi")

(find string<? 'datetime "2023")
(find string<? 'datetime "2024")

(find string=? 'wbc "japan")

(has-key 'wbc)
(first (find string=? 'result "gold"))

(find = 'id 8)

(save)
(init)
(load)
(has-key 'result)
; (documents)

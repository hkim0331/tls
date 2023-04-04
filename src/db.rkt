#lang racket
;; database システムを作ろう。これと spin で、todo アプリを作る。
;; todo アプリはやったこと、やることをネットから入力、検索できるアプリとする。
;;
;; * database ::= document の集まり
;; * document ::= entry の集まり
;; * entry    ::= (key entry) でキー、(valye entry) でバリューが取り出せるオブジェクト
;;

(provide
  init       ; initialize database
  documents  ; return whole data
  insert     ; (insert 'key value 'key2 value2 ...)
  find       ; (find comp-function 'key value)
  has-key    ; (has-key 'key)
  load       ; load saved documents into memory
  save       ; save documents into file
  now        ; returns iso-8601 timestamp
  today      ; returns todays date string yyyy-mm-dd
  )

(require racket/date)
(date-display-format 'iso-8601)

;; FIXME: function name?
(define null-or-first
  (lambda (obj)
    (if (null? obj)
      '()
      (first obj))))

(define now
  (lambda () (date->string (current-date) #t)))

(define today
  (lambda () (substring (now) 0 10)))

; (today)

(define *db* '())

(define documents (lambda () *db*))

(define id #f)

;; db はファイルに保存
(define db-dat (string-append (path->string (current-directory)) "/db.dat"))

(define init
  (lambda ()
    (set! *db* '())))

;; id の定義は最初の load のあとで
;; (define id (id-clojure)) のように。
;; load に組み込むのが自然か？
(define id-closure
  (lambda ()
    (let ((n (length (documents))))
      (lambda ()
        (set! n (+ n 1))
        n))))

(define save-to
  (lambda (filename)
    (call-with-output-file
      filename
      (lambda (out) (pretty-write *db* out))
      #:exists 'replace)))

(define save
  (lambda () (save-to db-dat)))

(define load-from
  (lambda (filename)
    (if (file-exists? filename)
      (call-with-input-file
        filename
        (lambda (in) (set! *db* (read in))))
      (set! *db* '()))))

(define load
  (lambda ()
   (load-from db-dat)
   (set! id (id-closure))))

;;
;; define database, documents, entries
;;

;; entries

(define key first)
(define val second)

(define make-entry
  (lambda (key value) (cons key (cons value '()))))

(define find-entry
  (lambda (k doc)
    (null-or-first (filter (lambda (entry) (eq? k (key entry))) doc))))


;; document には作成した日付 datetime と通し番号 id をつける。

(define make-doc
  (lambda (key value . more)
    (if (null? more)
      (list (make-entry key value))
      (cons
        (make-entry key value)
        (apply make-doc more)))))

(define make-datetime
  (lambda () (make-entry 'datetime (date->string (current-date) #t))))

(define add-datetime
  (lambda (doc) (cons (make-datetime) doc)))

(define make-id
  (lambda () (make-entry 'id (id))))

(define add-id
  (lambda (doc) (cons (make-id) doc)))

(define insert
  (lambda (a . b)
    (let* ((data (cons a b))
           (doc (apply make-doc data)))
      (set! *db* (cons (add-id (add-datetime doc)) *db*))
      (save))))

;; FIXME: funtion name?
(define entry
  (lambda (k d)
    (null-or-first (filter (lambda (d) (eq? k (car d))) d))))

(define find
  (lambda (fn key match)
    (letrec
      ((find-aux (lambda (doc fn key match)
            (let ((e (entry key doc)))
              (and (not (empty? e)) (fn (val e) match))))))
        (filter (lambda (doc) (find-aux doc fn key match)) *db*))))

(define has-key
  (lambda (key)
    (find (lambda (k v) #t) key '())))


(define db-test
  (lambda ()
    ;; あとで戻せるように back に退避
    (define back *db*)
    (init)
    ;;
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
    ;;
    (define out (open-output-string))
    (display (find string=? 'given-name "aoi") out)
    (display (first (find string=? 'family-name "kimura")) out)
    (display (find string=? 'given-name "hiroshi") out)
    (display (find string<? 'datetime "2023") out)
    (display (find string<? 'datetime "2024") out)
    (display (find string=? 'wbc "japan") out)
    (display (has-key 'wbc) out)
    (display (first (find string=? 'result "gold")) out)
    (display (find = 'id 8) out)
    ;;
    (display (get-output-string out))
    ;;
    ;; 退避したデータベースを戻す
    (define *db* back)
    ))

(db-test)

#lang racket
; get / ... display menu
; get /all ... display all todo
; get /date/yyyy-mm-dd ... display yyyy-mm-dd todo subjects only
; get /desc/n ... display todo id=n full
; get /create ... show input form
; post /create ... insert inputted todo

(require (planet dmac/spin)
         web-server/templates
         "db.rkt")

(define redirect
  (lambda (url)
    (define h (header #"Location" (string->bytes/utf-8 url)))
    `(302 (,h) "Look for the custom header!")))

; (get "/r"
;   (lambda ()
;     (redirect "/")))

(define getf
  (lambda (doc key)
    (let ((ret (filter (lambda (entry) (eq? key (first entry))) doc)))
      (if (null? ret)
        ""
        (second (first ret))))))

; (filter (lambda (e) (eq? 'id (first e))) '((id 3) (name 4)))
; (getf '((id 3) (name 4)) 'id)

(get "/"
  (lambda ()
    (include-template "todo-index.html")))

;; FIXME: select fields to be displayed
;;        id, datetime, subject
(define id-datetime-subject
  (lambda (doc)
    (let ((id       (getf doc 'id))
          (datetime (substring (getf doc 'datetime) 0 10))
          (subject  (getf doc 'subject)))
      (format "~a ~a ~a" id datetime subject))))

(define resp 
  (lambda (docs)
    (let ((out (open-output-string)))
      (map (lambda (doc) (display doc out) (display "<br>" out))
           docs)
      (display "<p><a href='/'>menu</a><p>" out)
      (get-output-string out))))

; (get "/all"
;   (lambda ()
;     (let ((out (open-output-string)))
;       (map (lambda (doc) (display (id-datetime-subject doc) out))
;            ; reverse?
;            (documents))
;       (get-output-string out))))

; (get "/all"
;   (lambda ()
;     (resp (map (lambda (doc) (id-datetime-subject doc))
;                (documents)))))

(get "/all"
  (lambda ()
    (resp (map id-datetime-subject (documents)))))

; date にマッチするものだけをリスト
(define date=?
  (lambda (date match)
    (string=? (substring date 0 (string-length match)) match)))

(get "/date/:date"
  (lambda (req)
    (let ((date (params req 'date)))
      (resp (map id-datetime-subject
                 (find date=? 'datetime date))))))

; id=n の :detail フィールドを表示
(get "/detail/:id"
  (lambda (req)
    (let ((id (params req 'id)))
      id)))

(get "/create"
  (lambda ()
    (include-template "todo-create.html")))

(post "/create"
  (lambda (req)
    (let ((subject (params req 'subject))
          (detail (params req 'detail)))
      ; (string-append "params" subject " " detail)
      (insert 'subject subject 'detail detail)
      (redirect "/all"))))

(load)
(run)

#lang racket
; get / ... display menu
; get /all ... display all todo
; get /date/pattern ... display subjects matched against `pattern` only
; get /today ... display today's todo
; get /detail?id=n ... display detail of topic `n`
; get /create ... show input form
; post /create ... insert inputted todo

(require (planet dmac/spin)
         web-server/templates
         "db.rkt")

(define redirect
  (lambda (url)
    (define h (header #"Location" (string->bytes/utf-8 url)))
    `(302 (,h) "redirect")))

(define getf
  (lambda (doc key)
    (let ((ret (filter (lambda (entry) (eq? key (first entry))) doc)))
      (if (null? ret)
        ""
        (second (first ret))))))

(get "/"
  (lambda ()
    (include-template "todo-index.html")))

(define id-datetime-subject
  (lambda (doc)
    (let ((id       (getf doc 'id))
          (datetime (substring (getf doc 'datetime) 0 10))
          (subject  (getf doc 'subject)))
      (format "<a href='/detail?id=~a'>~a</a> ~a ~a" id id datetime subject))))

(define resp
  (lambda (docs)
    (let ((out (open-output-string)))
      (map (lambda (doc) (display doc out) (display "<br>" out)) docs)
      (display "<p><a href='/'>menu</a><p>" out)
      (get-output-string out))))

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
      (resp (map id-datetime-subject (find date=? 'datetime date))))))

(get "/today"
  (lambda ()
    (redirect (format "/date/~a" (today)))))

; id=n の :detail フィールドを表示
(get "/detail"
  (lambda (req)
    (let* ((id (string->number (params req 'id)))
           (doc (first (find eq? 'id id)))
           (subject     (getf doc 'subject))
           (datetime    (getf doc 'datetime))
           (detail      (getf doc 'detail)))
      (include-template "todo-detail.html"))))

(get "/create"
  (lambda ()
    (include-template "todo-create.html")))

(post "/create"
  (lambda (req)
    (let ((subject (params req 'subject))
          (detail (params req 'detail)))
      (insert 'subject subject 'detail detail)
      (redirect "/all"))))

(define start
  (thunk ((load) (run)))

(start)

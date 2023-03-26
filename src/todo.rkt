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
      (format "<p>~a ~a ~a</p>" id datetime subject))))

(get "/all"
  (lambda ()
    (let ((out (open-output-string)))
      (map (lambda (doc) (display (id-datetime-subject doc) out))
           ; reverse?
           (documents))
      (get-output-string out))))

(get "/date/:date"
  (lambda (req)
    (let ((date (params req 'date)))
      date)))

(get "/desc/:id"
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

(run)

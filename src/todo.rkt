#lang racket
; get / ... display menu
; get /all ... display all todo
; get /date/yyyy-mm-dd ... display yyyy-mm-dd todo subjects only
; get /desc/n ... display todo id=n full
; get /create ... show input form
; post /create ... insert inputted todo

(require (planet dmac/spin)
         web-server/templates
         "scm-db.rkt")

(define redirect
  (lambda (url)
    (define h (header #"Location" (string->bytes/utf-8 url)))
    `(302 (,h) "Look for the custom header!")))

(get "/r"
  (lambda ()
    (redirect "/")))

(get "/"
  (lambda ()
    (include-template "todo-index.html")))
  
(get "/all"
  (lambda ()
    (let ((docs (documents)))
      )


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
    (print req)
    (redirect "/all")))

(run)

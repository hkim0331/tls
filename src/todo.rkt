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

(get "/"
  (lambda ()
    (include-template "todo-index.html")))
  
(get "/all")
(get "/date/:yyyy-mm-dd")
(get "/desc/:n")

(get "/create")
(post "/create")

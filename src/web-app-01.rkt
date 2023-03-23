#lang racket

(require (planet dmac/spin))
(require web-server/templates)

(get "/"
  (lambda () "Hello! next try /arg/:name"))

(get "/arg/:name"
  (lambda (req) (string-append "You are:" (params req 'name))))

(get "/plus/:x/:y"
  (lambda (req)
    (let ((x (string->number (params req 'x)))
          (y (string->number (params req 'y))))
      (string-append "ans:" (number->string (+ x y))))))

(get "/form"
  (lambda ()
     "<form method='post'>
      <input type='text' name='name'>
      <input type='submit'>"))

(post "/form"
  (lambda (req)
    (define name (params req 'name))
    (include-template "template.html")))

(run)

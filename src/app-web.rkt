#lang racket

(require (planet dmac/spin))
(require web-server/templates)

(get "/"
  (lambda () "Hello! next try /arg/:name"))

(get "/arg/:name"
  (lambda (req)
    (string-append
      "You are: " (params req 'name)
      "<p>Need meta charset header to display Japanese characters. But it simple.</p>"
      "<p>next, try /plus/n/m</p>")))

(get "/plus/:x/:y"
  (lambda (req)
    (let ((x (string->number (params req 'x)))
          (y (string->number (params req 'y))))
      (string-append
        "<p>ans:" (number->string (+ x y)) "</p>"
        "<p>follow this <a href='/form'>link</a>"))))

(get "/form"
  (lambda ()
    (string-append
       "<p>Input something</p>"
       "<form method='post'>
        <input type='text' name='name'>
        <input type='submit'>")))

(post "/form"
  (lambda (req)
    (define name (params req 'name))
    (include-template "template.html")))

(run)

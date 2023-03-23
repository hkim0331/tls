#lang racket

(require (planet dmac/spin))

(get "/"
  (lambda () "Hello!"))

(get "/hi"
  (lambda (req) (string-append "Helo, " (params req 'name))))

(get "/hi/:name"
  (lambda (req) (string-append "url args:" (params req 'name))))

;; 引数が渡っておらず、req をプリントできない。
;; ファイルに書けないのエラーのためか？
(post "/oui"
  (lambda (req) 
    (print req)
    (string-append "see you later " (params req 'bye))))

(run)

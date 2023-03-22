#lang racket
(require "atom.rkt")

(first '(1 2 3))

(rest '(1 2 3))

;; define で名前をつける
(define a '(1 2 3))

(first a)

(rest a)

;; こんな例はよくない
(define apple 'orange)
(define orange 'apple)

apple
orange

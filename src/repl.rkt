#lang racket

;; REPL は Read, Eval, Print, Loop の略とされる。

;; VScode/Magic Racket だったら、
;; 書いたプログラムを選んで、alt+enter で評価できる。

;; プログラムが1行だったら、) をタイプした直後に alt+enter で OK.
(+ 1 2 3)

;; 複数行になったらだめ。
;; readline-input:2:5: read-syntax: unexpected `)` [,bt for context]
;; のようなエラーになる。マウスでなぞって選んだ後に alt+enter は OK.
(+
1 2 3)

;; ひとまとまりのコードは画面右上の ▷ やその左の「四角の中に▷」ボタンのクリックで。

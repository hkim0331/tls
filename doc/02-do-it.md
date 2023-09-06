# 02. Do it, Do it Again, and Again, and Again...

## lat

list of atom の略。リストを要素に持たない、アトムだけを要素に持つリスト。

## (lat? x)

Scheme(LISP) なんで、関数名の後に ? が来てもなんの問題もない。
戻り値が true/false のどちらかになる関数を述語 predicates という。

## (member? a lat)

アトム a とアトムのリスト lat を引数に取り、a が lst 中に現れるかを返す述語。

```
(else (or (eq? (first lat) a)
          (member? a (rest lat))))
```

は上手な or の使い方。
or は左から評価し、最初に #t になったところで評価を打ち切り #t を返す。
リストの最後（最も右）まで評価して #t にならなかったら #f を返す。

## こんなの考えてみたいぞ

第二引数が lat 以外に一般のリストも取れる (member-list? a xs)

# Under Construction

# dmac/spin で　WEB アプリ

他にも WEB アプリのフレームワークはあるけれど、これがほんとに簡単と思う。
Nonoasan や Ttaro みたいな学生が作ったライブラリと思う。

<https://github.com/dmac/spin> 見ればやり方はわかる。

## インストール

    $ raco pkg install https://github.com/dmac/spin.git

あれ？ minimal-racket だと足りないものがたくさんか？
minila-racket のバージョンが 8.8 なのに、
落ちてくるライブラリのバージョンはそれより低い 8.6 が混ざっている。
なんかたくさんインストールされてるぞ。泥沼インストールになってないか？
大丈夫か？

こんなじゃダメよね。こういう時、すぐに壊して作り直せるコンテナが便利だ。
まだ終わらん。

やっと終わった。15分。かかりすぎだな。

```
raco setup: 0 rendering: <pkgs>/racket-index/scribblings/main/search.scrbl
raco setup: --- installing collections ---                         [13:46:25]
raco setup: installing: <collects>/racket
raco setup: installing: <pkgs>/gui-lib/mred
raco setup: installing: <pkgs>/gui-lib/racket/gui
raco setup: installing: <pkgs>/racket-doc/help
raco setup: --- post-installing collections ---                    [13:46:25]
m64~/racket/the-little-schemer(develop|✚1…)
```

Windows/WSL でやってみるか。

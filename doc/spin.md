# Under Construction

# dmac/spin で WEB アプリ

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

やっと終わった。時間、かかりすぎだな。

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

## その前に docker で入れた racket 8.6 でトライ

すんなりできた。数秒足らず。

```
$ raco pkg install https://github.com/dmac/spin.git
Querying Git references for spin at https://github.com/dmac/spin.git
Downloading repository https://github.com/dmac/spin.git commit f4dd095aecefbfbfbf12c9a542f9887ae252a28a
raco setup: version: 8.6
raco setup: platform: aarch64-linux [cs]
...
...
...
raco setup: 4 skipping: <pkgs>/racket-index/scribblings/main/local-redirect.scrbl
raco setup: 1 skipping: <pkgs>/racket-index/scribblings/main/search.scrbl
raco setup: --- installing collections ---                         [4:50:24]
raco setup: --- post-installing collections ---                    [4:50:24]
```

行末の [4:50:24] は経過時間じゃないようだ。

## それでもエラーが docker on mac

```
$ make-directory: cannot make directory
  path: /usr/share/racket/pkgs/scribble-lib/scribble/doc/lang/compiled
  system error: Permission denied; errno=13
  compilation context...:
   /usr/share/racket/pkgs/racket-index/scribblings/main/user/start.scrbl
  context...:
   /usr/share/racket/collects/compiler/private/cm-minima
...
...
```

## 構わず Web アプリ

Web アプリは関数呼び出しをネットワーク上でやるもの。

* 関数名は URL
* 引数は URL についたり、フォームから渡す
* 戻る HTML をブラウザが解釈してページにする、あるいは JSON だったら別のことをする。

基本は GET と POST とテンプレート。

<src/web-app-01.rkt>

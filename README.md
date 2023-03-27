# TLS

The Little Schemer（Scheme 手習い）を読もうかい。

2022 年後期工学部 2 年生対象の「情報応用」でプログラミングに興味を持った人が対象ですが、
そうじゃなくても OK.
授業とか単位とかに関係なく学んでみないか。

## なぜに？

大学やそれ以外で、プログラミングを学ぼうとする場合、
プログラミングはプログラム言語の文法を覚えることではない。
プログラミング的考え方を身につけるためのものだ
（そうじゃない授業は多い。下らない文法教えるだけみたいなのはその最先端だ。反吐が出そう）。

しかし、選んだ言語によっては、選んだ言語が学ぶ人の
「プログラミング的考え方」
に枠をはめてしまう。
C や Python などで大きいプログラム作ろうとしたら急激に難易度上がったりするだろ。
そうでなくても、出来合いのライブラリを組み合わせる以外、
まともなプログラムできなかったりするだろ。
それ、見逃しているもの、学び損ねたものがあるんだよ。

C や Python などとはちょっと違った Scheme で、
手続き型とは違った角度からプログラミングの世界をのぞいてみよう。

お手本にするのは世界的なベストセラー
"The Little Schemer"
だ。
オリジナルの英語版はネットに無料で見つかる。
日本語の訳本は 「Scheme 手習い」。図書館に数冊以上、あります。
「やさしい...」より数段イイ！
でも、日本での人気は日本のレベルを反映してか、クエスチョンマーク。
また、最初の方、著者たちの独特の書き方で面食らうだろうな。
なので、ちょっと手助けします。

## 準備

「Scheme手習い」は理想的な Scheme 言語を仮想して、
実装とは離れて、紙と鉛筆、頭の中で、計算の過程を考えるみたいなことをやる。

それ、できる人には相当なトレーニングになるんだろうが、
俺たち一般人には辛い。で、やっぱ、適当な処理系、
作成したコードを実行できるアプリがあったほうが楽だ。

### macos で minimal-racket は大変

普通は macos はいろいろ楽なんだけど、Scheme の処理系として minimal-racket を選ぶと苦労する。

```
% brew install minimal-racket
```

これでバージョン 8.8 の最新版がインストールできる。しかし、その後、外部ライブラリ、
VScode の Magic Racket がインストールしてくれっていう
racket-langserver をインストールすべく、

```
% raco pkg install racket-langserver
```

ってやると延々とダウンロードとコンパイルが始まって、終わらない。
ついには、投げやりなメッセージで終了する。

```
raco pkg install: packages installed, although setup reported errors
```

VScode 立ち上げると、

```
The Racket Language Client server crashed 5 times in the last 3m...
```

mac では Racket 以外の Scheme 処理系を選ぶか、次の VScode DevContaier がいいかも。


### VScode DevContainer

DockerDesktop が macos にインストールされているって前提で。

このリポジトリ 
https://github.com/hkim0331/tls.git
をダウンロードしたら、VScode で開く。

```
% code .
```

「DevContainer で開き直しますか」みたいに聞かれるので、そのまま YES.

Docker イメージのダウンロードに時間はかかるが、最初の一回だけ。あとは簡単。

### Windows だと？

Windows に直接 Racket 入れるよりも、WSL 使うのがいい。
WSL で ubuntu 入れておき、

```
$ sudo apt install racket
```

で racket 入るんで、そのあと、

```
$ code .
```

必要なライブラリ(例えば racket-langsever)は、

```
$ raco pkg install racket-langserver
```
で。

docker やってもよい。Windows じゃなく、WSL に docker 入れるのがおすすめ。

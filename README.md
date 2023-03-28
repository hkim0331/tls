# TLS

The Little Schemer（Scheme 手習い）を読もうかい。

2022 年後期工学部 2 年生対象の「情報応用」でプログラミングに興味を持った人が対象ですが、
そうじゃなくても OK.
授業とか単位とかに関係なく学んでみないか。

## なぜに？

大学やそれ以外でプログラミングを学ぼうとする場合、
プログラミングはプログラム言語の文法を覚えることではない。
プログラミング的考え方を身につけるためのものだ。
しかし、そうじゃない授業は多い。
単位はゲット、理解はノットな学生が増えるばかり。

初心者にプログラミングを教えるとして、
選んだ言語によっては、その言語が学ぶ人の
「プログラミング的考え方」
に枠をはめてしまうことがある。
C や Python などで大きいプログラム作ろうとしたら急激に難易度上がったりするだろ。
そうでなくても、出来合いのライブラリを組み合わせる以外、
まともなプログラムできなかったりするだろ。
それ、見逃しているもの、学び損ねたものがあるんだよ。
反対側から言えば教え損なったものがある。

C や Python などとは一味も二味も違う Scheme で、
手続き型とは違った角度からプログラミングの世界をのぞいてみよう。

お手本にするのは世界的なベストセラー
`The Little Schemer`.
英語版でよければネットに無料で見つかる。
日本語の訳本は 「Scheme 手習い」。図書館に数冊、入れてもらいました。
「やさしい...」より数段イイ！
でも、日本での人気は日本のレベルを反映してか、クエスチョンマーク。
著者たちの独特の書き方のために初見の人たちは面食らうんだろうな。
なのでちょっと手助けします。

## 準備

「Scheme手習い」は理想的な Scheme 言語を仮想し、
実装とは離れて、紙と鉛筆、頭の中で、計算の過程を考えるみたいなことをやる。

それ、できる人には相当なトレーニングなんだが、
俺たち一般人にはツラい。
で、やっぱ、適当な処理系、作成したコードを実行できるアプリがあったほうが楽。

### macos で minimal-racket は大変

普通、macos はいろいろ楽なんだが、2023 年 3 月現時点で
Scheme の処理系として minimal-racket を選ぶと苦労する。

```
% brew install minimal-racket
```

これでバージョン 8.8 の最新版がインストールできるが、
その後、外部ライブラリ、例えば date や、
VScode の Magic Racket が奨励する
racket-langserver ライブラリを追加すべく、

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
をクローンしたら、VScode で開く。

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

docker やってもよい。この場合も Windows に docker じゃなく、
Windows で入れた WSL に docker 入れるのがおすすめ。

### 準備が大変？

「Scheme アプリがあった方が楽」って言うのに、逆になっちゃうが、
なくてもいいじゃん。TLS は元々は具体的なコンピュータなし、
紙と鉛筆でプログラミングを考えようってノリ。行けるさ。

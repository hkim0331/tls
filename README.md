# TLS

The Little Schemer（Scheme 手習い）を読もうかい。

2022 年後期工学部 2 年生対象の「情報応用」でプログラミングに興味を持った人が対象ですが、
そうじゃなくても OK.
授業とか単位とかに関係なく学んでみないか。

## なぜに？

大学やそれ以外のプログラミング授業の目的はプログラム言語の文法を覚えることではない。
プログラミング的考え方を身につけることだ。
しかし、そうじゃない授業は多い。
単位はゲット、理解はノットな学生が増えるばかり。

初心者にプログラミングを教えるとして、
選んだ言語によっては、その言語が学ぶ人の考え方に枠をはめてしまうことがある。
学んだはずの C や Python などで大きいプログラム作ろうとしたら急激に難易度上がったりするだろ。
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
また、著者たちの独特の書き方のため、初見の人たちは面食らうだろう。
なのでちょっと手助けします。

## 準備

「Scheme手習い」は理想的な Scheme 言語を仮想し、
実装とは離れ、紙と鉛筆、頭の中で、計算の過程を考えるみたいなことをやる。

できる人には相当なトレーニングなんだが、俺たち一般人には、ま、ツライわな。
で、やっぱ、作成したコードを実行できるアプリがあったほうが楽。
Scheme のコードを入力したらそれを実行してくれるアプリを
`Scheme の処理系`
っていうとアタマ良さそうな雰囲気を出せる。

### macos で minimal-racket は大変

いろんなプログラミングを始める際、Mac はいろいろ楽なんだが、
2023 年 3 月現時点で Scheme を始めるとして minimal-racket を選ぶと苦労する。

```
% brew install minimal-racket
```

これでバージョン 8.8 の最新版がインストールできるが、
その後、外部ライブラリ、
例えば date や、
VScode の Magic Racket が奨励する racket-langserver ライブラリを追加すべく、

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

minimal-racket じゃなく、DrRacket っていろいろ詰め込んだアプリもあるんだが、
そっちなら楽なのかな？昔はオレも DrRacket 使ってた。
プログラム打ち込むエディタまで含めた IDE と思っていい。
でも、プログラム作成に VScode 使いたい。
そういう人には次の VScode DevContaier がいいかも。

### VScode DevContainer

DockerDesktop が Mac にインストールされているって前提で。

https://github.com/hkim0331/tls.git に racket のコンテナ作ったんで、
クローンし、VScode で開く。

```
% git clone https://github.com/hkim0331/tls.git
% cd tls
% code .
```

「DevContainer で開き直しますか」みたいに聞かれるので、そのまま YES.

Docker イメージのダウンロードに時間はかかるが、最初の一回だけ。あとは簡単。
こっちだと mac に racket 入れる必要ない。コンテナに入ってるから。

### Windows だと？

Windows に直接 Racket 入れるもできるが、WSL 使うのがいい。

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

もちろん、WSL で Docker やってもよい。
Windows に DockerDesktop って選択もあるけど、
WSL に Docker の方がおすすめ。
なぜかっつうと、Windows に DockerDesktop のインストールに何度か失敗、
あきらめたんで。


### 準備が大変？

「Scheme アプリがあった方が楽」って言うのに、逆になっちゃうが、
なくてもいいじゃん。TLS は元々は具体的なコンピュータなし、
紙と鉛筆でプログラミングをとことん考えようってのが基本だ。
行けるさ。

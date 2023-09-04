# The Little Schemer

## FORTRAN, LISP, C

1960 年ごろ、三つの言語が生まれた。
その後生まれて廃れた言語もたくさんあるが、
この3つは生き残り、今もあらゆる言語に影響を及ぼしている。

## CommonLisp

強力さのゆえに、姿、形を変えた LISP がたくさん登場し、ユーザが混乱した。
混乱を収集する規格として CommonLisp が制定された。1990年ごろ。

その規格に則った実装が複数ある。

* SBCL
* CCL
* ACL
* ...

```sh
ubuntu$ apt search lisp
```

CommonLisp を名乗るために守るべき部分が定めらたため、
あっちの LISP で書いたプログラムがこっちの LISP では動かない
ってことがなくなった。

CommonLisp は、その後流行する **オブジェクト指向** でも力を発揮した。
オブジェクト指向を名乗って登場した C++, Python, Ruby や SmallTalk よりも
もっとも成功したのは CommonLisp と言う人もある。
残念ながら hkimura 名前しか知らないが、
CLOS(CommonLispObjectSystem) と言う。

## Scheme

商用にも使えるのが CommonLisp の強みだが、プログラミングの学習用に
そのエッセンスを絞って考えられた言語が Scheme.

やはり Scheme にも複数の実装がある。

* Racket
* gauche
* guile
* mit-scheme
* ...


```sh
ubuntu$ apt search scheme
```

最初は学習用に考えられたもんだが、研究、開発、商売にも使えているらしい。


## Racket

## The Little Schemer(TLS)

今は、Scheme を実行できるアプリがすぐに手に入る時代だが、
この本は、仮想的言語を仮定し、現実的なコンパイラやインタプリタの実装から離れ、
ふざけてんのかと思うような軽い言い回しでプログラミングの理論にズブっと切り込む。
頭と紙と鉛筆でプログラミングを徹底的に考えるというのが
著者たちが最初に考えた読者のあるべき姿であると思われる。

なにしろ、first/rest/cons/null?/eq? の5つだけで
不完全性定理を理解しちゃおうとか、
プログラミング言語を作っちゃおうとか、
やることが「やさしい...」と段違い。

斜めに読んじゃダメなんです。
「前の章が理解できない時は次の章に進んじゃダメ」ってしっかり書いてある。
今の学生は本を読まないし、
読んだとしても理解できる部分だけをつまみ食いするだけだろ。
そう言うのがありの分野もあるだろう。でもこの本は違うんです。

### Windows で Racket

Windows に直接 Racket をインストールするよりは
WSL（Windows でLinux を走らせる仕組み、Virtualbox とは共存できない）
に入れるのが楽やろな。
Windows で VScode をスタートさせ、
その VScode から WSL 側の racket を利用するってのがおしゃれ。

```
> wsl -d Ubuntu
WSL$ sudo apt update
WSL$ sudo apt install racket
WSL$ raco pkg install racket-langserver
```

VScode には次の二つのエクステンションを入れる。

* WSL
* Magick Racket

Racket のフォルダで、`code .` で
Windows 側の VScode が起動して、WSL のフォルダが開く。

```
WSL$ code .
```

MagickRacket の Alt + Enter が S 式の評価じゃなく、1 行評価なんで、
REPL でいろいろ試したい時、いちいち評価する S 式を選択するのが面倒だ、hkimura は。

### DrRacket

他に、DrRacket っつう IDE をどさっと Windows に入れるって作戦もある。
DrRacket は racket 言語 + VScode みたいなエディタをひとまとまりにしたもの。

せっかく小さい Scheme なのに構えがデカすぎないかい、
なんてつまらないことで hkimura は敬遠気味。

### Mac で Racket

WSL に相当するものはすでに Mac が持っているので、

```
% brew install minimal-racket
```

Magic Racket 利用するには racket-langserver を入れろってあるんだが、
intel mac はエラーで終了、
m1 mac はいつまで経ってもインストールが終わらなんで、止めちゃった。

```
raco pkg install racket-langserver
```

なくてもプログラミング楽しめるが、
VScode がクラッシュってうるさいので
Settings の languageserver.enabled を false にする。

"magicRacket.languageServer.enabled": false

あるいは次の Sublime がいいかも。

### SublimeTextで Racket

Install Package で Racket を選ぶ。

S 式の評価は ^, b (コントロール押したままコンマ、離して b).
こっちの方が VScode + MagickRacket の Alt + Enter より楽だ。

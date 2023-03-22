# The Little Schemer

## C, FORTRAN, LISP


## CommonLisp

* SBCL
* CCL
* ACL
* ...

```sh
ubuntu$ apt search lisp
```

## Scheme

* Racket
* guile
* mit-scheme
* ...


```sh
ubuntu$ apt search scheme
```

## Racket

## The Little Schemer(TLS)

今は、Scheme を実行できるアプリがすぐに手に入る時代だが、
仮想的言語を仮定、実装から離れ、
頭と紙と鉛筆でプログラミングを考えるというのが最初の本来の姿か。

### Windows で Racket

Windows に直接 Racket をインストールするよりは
WSL（Windows でLinux を走らせる仕組み、Virtualbox とは共存できない）
に入れるのが楽やろな。
Windows で VScode をスタートさせ、
その VScode から WSL 側の racket を利用するってのがおしゃれ。

```
> wsl -d Ubuntu
$ sudo apt update
$ sudo apt install racket
$ raco pkg install racket-langserver
```

VScode には次の二つのエクステンションを入れる。

* WSL
* Magick Racket

他に、DrRacket っつう IDE をどさっと Windows に入れるって作戦もある。

### Mac で Racket

WSL に相当するものはすでに Mac が持っているので、

```
% brew install minimal-racket
```


SublimeText




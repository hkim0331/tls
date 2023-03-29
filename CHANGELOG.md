# CHANGELOG

## Unreleased
- raco pkg install racket-langserver できるようになったが、
  windows/wsl で体験するような関数のヘルプがポップアップしない。
  例えば、wsl vscode では null? にホバリングすると
  imported from "racket" - online docs 以下の小さいウィンドウが出る。
  でも multipass/docker では imported from racket のみ。
- multipass docker racket で Magic Racket language server enable すると
  空振りの XQuartz が起動する
- DockerDesktop では docker-compose に ports: [ "8000:8000" ] を入れると公開できない。
  docker-compose の設定じゃなく、DockerDesktop の隠れた力でポート公開している感じ。
- (備考, バインドマウントの仕方)
```
% docker run -it --rm -p 8000:8000 --mount type=bind,source="$(pwd)",target=/workspace hkim0331/racket bash
```
- セーブが 1 行長すぎ。

## 0.3.21 - 2023-03-29
- devcontainer の導入手順をやや細かく。

## 0.3.20 - 2023-03-28
- raco pkg install date をやめて racket/date を使う

## 0.3.19 - 2023-03-27
- update db.rkt
  db.dat がない時、*db* に () をセットしてスタート。
  insert/create 時に db.dat を作成する。

## 0.3.18 - 2023-03-27
- link from all to detail

  (format "&lt;a href='/detail/~a'>~a</a> ~a ~a" id id datetime subject)

- db.rkt: (today) returns "yyyy-mm-dd"
- defined (get "/today")

## 0.3.17 - 2023-03-26
- defined (get "/detail/:n")

## 0.3.16 - 2023-03-26
- FIXED BUG: id がセッションを超えてインクリメントする。

## 0.3.15 - 2023-03-26
- post も (params req 'name) で受け取れる。
- defined (post "/create")
- added bump-version.sh
- 絶対パス (string-append (path->string (current-directory)) "/db.dat")
- renamed scm-db.rkt as db.rkt
- defined (get "/all")

## 0.3.14 - 2023-03-26
- defineed scm-db.rkt:scm-db-test
- todo.rkt
- defined (rediret url)
- defined (get "/all")

## 0.2.13 - 2023-03-25
- (make-id) closure (define id (make-id))
- insert 時にエントリーに ('id (id)) を付与。
- provide/require

## 0.2.12 - 2023-03-25
- update README.md 
- make-doc を呼び出しに使わず、insert の内部で処理する
- find の補助関数を find 内部におさめる
- has-key
- raco pkg install

## 0.2.11 - 2023-03-24
### BREAKING entries, find を変更
- database  ::= document の集まり
- documents ::= entry の集まり
- entries   ::= (key entry) でキー、
                (val entry) でバリューが取り出せる entry の集まり
- find-all を基本形に。find-one は (first (find-one)) でよい
- module で。provide するのは init, insert, find, list,

## 0.2.10
- db.rkt find が動くようになった。次は find-all
- Magic Racket の選んで alt+enter はめんどくさい。
  それよりも、右上ボタンの Load file in REPL のほうかな。

## 0.1.9 - 2023-03-24
- <meta charset='UTF-8'> to template.html
- windows/wsl docker で動作チェック
  $ sudo dockerd
  $ code .
  <Reopen in Container>

## 0.1.9 - 2023-03-25
- renamed 
  app-web.rkt -> spin-web.rkt
  db-scm.rkt  -> scm-db.rkt
- dot-pair やめた


## 0.1.8 - 2023-03-24
- https://zenn.dev/yyu/articles/3f900eaa2aa860 を参考に、
  AMD/ARM の docker イメージを作る。
  2 台で別々に実行すれば2倍速でできるか。
  今回は m64 の buildx で amd/arm のイメージを作った。

## 0.1.7 - 2023-03-23
- added doc/spin.md and src/web-app-01.rkt

## 0.1.6 - 2023-03-23
- hkim0331/racket イメージ
  FROM ubuntu:22.10
  add git sqlite libedit2 racket
  raco pkg install --auto racket-langserver
- Docker Desktop の Recommend fixes は 22.10 を 23.04 にあげろがひとつ。
- pushed to DockerHUB as hkim0331/racket, 724MB

## 0.1.5 - 2023-03-22
- updated 00-intro.md 作文、もっと作文

## 0.1.3 - 2023-03-22
- src/03-cons.rkt
- VScode Dev Coontainer: raco pkg install racket-langserver に失敗するが...
  WindowsWSL だと raco できて、カーソルホバリングで関数の説明がポップアップしたりする。

## 0.1.2 - 2023-03-22
- macos では raco pkg install racket-langserver が延々と時間がかかって終了しない。
  intel mac でやったら途中で止まった。バージョンミスマッチ？
  windows wsl だとあっさり。windows vscode + magic racket を試してみよう。

## 0.1.1 - 2023-03-22
- FIXED: README をタイポした。恥ずかしい。

## 2023-03-10

- Teataro, Nanossa, aykz
  1,2,3章の途中まで
- Jagaimo

## 2023-03-

- Nanossan
  1,2,3章の途中まで

## 2023-02-24

- Teataro
  1,2,3 章の途中まで

/*
無理して is_member(char* s, char *ss[]) を書いてみる。
文字列 s は 文字列配列 ss　のメンバーか？
C ではとことんめんどくさい。
ss は決め打ちとする。ファイルから読ませてもいいか。でもめんどくさ。
書けるかな？
...敗北です。動くけどね。
ss が変わるたび、プログラムを編集し、コンパイルしないとダメ。
C の配列は Scheme のリストとは比べようもない硬直したデータ構造と思うべし。

2023-09-08 の Scheme 関数を C でエミュレートしようとしたけど、
この辺でいいでしょう。
たくさん書いても Scheme の関数の足元にも及ばない使い道のないプログラム。
*/

#include <stdio.h>
#include <stdlib.h>

char *ss[] = {"apple",
              "orange",
              "banana",
              "mango",
              "grape",
              "melon",
              "pear"};
// 敗北
int ss_max = 7;

int str_eql(char *s1, char *s2) {
  int i;

  for (i=0; s1[i]!='\0' || s2[i]!='\0'; i++) {
    if (s1[i]!=s2[i]) {
      return 0;
    }
  }
  return s1[i]==s2[i];
}

int is_member(char *s, char *ss[]) {
  int i;
  for (i=0; i<ss_max;i++) {
    if (str_eql(s, ss[i])) {
      return 1;
    }
  }
  return 0;
}

char * found(char *s, char *ss[]) {
  if (is_member(s, ss)) {
    return "found";
  } else {
    return "not found";
  }
}
int main(int argc, char *argv[]) {
  if (argc!=2) {
    printf("usage: ./a.out str\n");
    exit(1);
  }
  printf("%s\n", found(argv[1], ss));
  return 0;
}

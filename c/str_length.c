/*
文字列 s の長さを返す。そしてプリント。
*/

#include <stdio.h>
#include <stdlib.h>

int str_length(char *s) {
  if (*s == '\0') {
    return 0;
  } else {
    return 1 + str_length(s + 1);
  }
}

/* 再帰を使わないだったら、
int str_length(char *s) {
  int i;

  for (i = 0; s[i] != '\0'; i++) {
    ;
  }
  return i;
}

これはわかりやすいのか？

そして、知ったかぶりの学生はこうプログラムしてコンパイルエラー。
for の内側に変数 i を入れるの嬉しいか？
変数 i がない方が嬉しいだろ。

int str_length(char *s) {
  for (int i = 0; s[i] != '\0'; i++) {
    ;
  }
  return i;
}
*/

int main(int argc, char * argv[]) {
  if (argc!=2) {
    printf("usage: ./a.out string\n");
    exit(1);
  }
  printf("%i\n", str_length(argv[1]));
  return 0;
}

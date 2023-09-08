#include <stdio.h>
#include <stdlib.h>

int is_small(char c) {
  return 'a'<=c && c <= 'z';
}

int all_smalls(char *s) {
  int i;
  for (i=0; s[i]!='\0'; i++) {
    if (! is_small(s[i])) {
      return -1;
    }
  }
  return 1;
}

char* ans(int n) {
  if (n==1) {
    return "yes";
  } else {
    return "no";
  }
}

int main(int argc, char *argv[]) {
  if (argc!=2) {
    printf("error. usage: a.out string\n");
    exit(1);
  }
  printf("%s: %s\n", argv[1], ans(all_smalls(argv[1])));
  return 0;
}

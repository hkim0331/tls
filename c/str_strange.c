#include <stdio.h>

void strange(void) {
  char s1[] = "You can rewrite me.";
  char *s2  = "can you rewrite me?";


  printf("s1=%s, s2=%s\n", s1, s2);
  s1[0] = '!';
  s1[1] = '\0';
  printf("s1=%s, s2=%s\n", s1, s2);
  s2[0] = '?';  // error
  s1[1] = '\0'; // error
  printf("s1=%s, s2=%s\n", s1, s2);
}

int main(void) {
  strange();
  return 0;
}


#include <stdio.h>
#include <stdlib.h>

int main(int argc, char **argv) {
  int *a = (int *)malloc(10 * sizeof(int));
  a[5] = 0;
  if (a[argc])
    printf("xx\n");
  return 0;
}
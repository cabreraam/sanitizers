

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include <mpi.h>

int main(int argc, char *argv[]) {

  MPI_Init(&argc, &argv);

  char *s = malloc(100);
  strcpy(s, "Hello world!");
  printf("string is: %s\n", s);
  free(s); // nice!

  MPI_Finalize();
  return 0;
}
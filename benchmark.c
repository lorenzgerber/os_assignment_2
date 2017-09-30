#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <unistd.h>
#include "timer.h"
#define NUMBER_THREADS 20

/* Global variables */
int     thread_count = 1;
void *Pth_empty(void* rank);
int array_lengths[NUMBER_THREADS];
int *data_arrays[NUMBER_THREADS];


int int_pow(int base, int exp){
  int result = 1;
  while (exp)
    {
      if (exp & 1)
	result *= base;
      exp /= 2;
      base *= base;
    }
  return result;
}

int cmpfunc (const void * a, const void * b){
  return ( *(int*)a - *(int*)b );
}



int main(int argc, char* argv[]) {

  /* local variables */
  long       thread;
  pthread_t* thread_handles;
  time_t t;
  double start, finish;


  /* Intializes random number generator */
  srand((unsigned) time(&t));


  // Create data arrays
  int rank[NUMBER_THREADS];
  for(int i = 0; i < NUMBER_THREADS; i++){
    rank[i] = i;
  }

  for(int i = 0; i < NUMBER_THREADS; i++){
    array_lengths[i] = int_pow(2, i);
    data_arrays[i] = malloc(sizeof(int)*array_lengths[i]);
    for(int j = 0; j < array_lengths[i]; j++){
      data_arrays[i][j] = rand() % 255;
    }
  }


  thread_handles = malloc(NUMBER_THREADS*sizeof(pthread_t));
  

  GET_TIME(start);
  
  for(thread = 0; thread < NUMBER_THREADS; thread++){
    pthread_create(&thread_handles[thread], NULL, Pth_empty, &rank[thread]);
  }

  for(thread = 0; thread < NUMBER_THREADS; thread++){
    pthread_join(thread_handles[thread], NULL);
  }

  GET_TIME(finish);

  printf("total run time: %e\n", (finish - start)); 


  free(thread_handles);

  for(int i = 0; i < NUMBER_THREADS; i++){
    free(data_arrays[i]);
  }

  return 0;
}

/* dummy/ empty thread function */
void *Pth_empty(void* rank){
  int myrank = *((int*) rank);
  printf("Thread: %d starting\n", myrank);
  qsort(data_arrays[myrank], array_lengths[myrank], sizeof(int), cmpfunc);
  printf("Thread: %d finishing\n", myrank);
  return NULL;
}

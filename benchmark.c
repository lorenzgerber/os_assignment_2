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
double start_thread[NUMBER_THREADS];
double finish_thread[NUMBER_THREADS];

void bubble_sort(int a[], int n){

  int list_length, i, temp;

  for(list_length = n; list_length >= 2; list_length--){
    for(i = 0; i < list_length-1; i++){
      if(a[i] > a[i+1]){
	temp = a[i];
	a[i] = a[i+1];
	a[i+1] = temp;
      }
    }
  }
}
		 



int main(int argc, char* argv[]) {

  /* local variables */
  long       thread;
  pthread_t* thread_handles;
  pthread_attr_t attr;
  time_t t;
  double start, finish;
  int array_size = 60000;
  int step_size = -2000;

  pthread_attr_init(&attr);
  if(pthread_attr_setschedpolicy(&attr, SCHED_RR) != 0)
    fprintf(stderr, "Unable to set policy.\n");


  /* Intializes random number generator */
  srand((unsigned) time(&t));


  // Create data arrays
  int rank[NUMBER_THREADS];
  for(int i = 0; i < NUMBER_THREADS; i++){
    rank[i] = i;
  }

  for(int i = 0; i < NUMBER_THREADS; i++){
    array_lengths[i] = array_size;
    data_arrays[i] = malloc(sizeof(int)*array_lengths[i]);
    for(int j = 0; j < array_lengths[i]; j++){
      data_arrays[i][j] = rand() % 255;
    }
    array_size += step_size;
  }


  thread_handles = malloc(NUMBER_THREADS*sizeof(pthread_t));
  

  GET_TIME(start);
  
  for(thread = 0; thread < NUMBER_THREADS; thread++){
    pthread_create(&thread_handles[thread], &attr, Pth_empty, &rank[thread]);
  }

  for(thread = 0; thread < NUMBER_THREADS; thread++){
    pthread_join(thread_handles[thread], NULL);
  }

  GET_TIME(finish);

  printf("total run time: %e\n", (finish - start));
  for(int i = 0; i < NUMBER_THREADS; i++){
    printf("Thread: %d, start: %e, runtime: %e\n", i, start_thread[i], (finish_thread[i] - start_thread[i]));
  }


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
  GET_TIME(start_thread[myrank]);
  bubble_sort(data_arrays[myrank], array_lengths[myrank]);
  GET_TIME(finish_thread[myrank]);
  printf("Thread: %d finishing\n", myrank);
  return NULL;
}

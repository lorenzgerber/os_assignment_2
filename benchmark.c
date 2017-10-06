#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <unistd.h>
#include "timer.h"
#define NUMBER_THREADS 20

typedef struct thread_data {
  int rank;
  double runnable;
  double running;

} thread_data;

/* Global variables */
int     thread_count = 1;
void *Pth_empty(void* thread_data);
int array_lengths[NUMBER_THREADS];
int *data_arrays[NUMBER_THREADS];
double start_thread[NUMBER_THREADS];
double finish_thread[NUMBER_THREADS];

/*
 * bubble_sort
 */
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
  int array_size = 5000;
  int step_size = -200;



  pthread_attr_init(&attr);
  if(pthread_attr_setschedpolicy(&attr, SCHED_FIFO) != 0)
    fprintf(stderr, "Unable to set policy.\n");

  /* Intializes random number generator */
  srand((unsigned) time(&t));


  // Create data arrays
  int rank[NUMBER_THREADS];
  struct thread_data thread_data[NUMBER_THREADS];
  for(int i = 0; i < NUMBER_THREADS; i++){
    rank[i] = i;
    thread_data[i].rank = i;
  }


  for(int i = 0; i < NUMBER_THREADS; i++){
    array_lengths[i] = array_size;
    data_arrays[i] = malloc(sizeof(int)*array_lengths[i]);
    for(int j = 0; j < array_lengths[i]; j++){
      //data_arrays[i][j] = rand() % 255;
      data_arrays[i][j] = array_lengths[i] - j;
    }
    array_size += step_size;
  }






  thread_handles = malloc(NUMBER_THREADS*sizeof(pthread_t));


  GET_TIME(start);

  // Starting Threads
  for(thread = 0; thread < NUMBER_THREADS; thread++){
    GET_TIME(thread_data[thread].runnable);
    pthread_create(&thread_handles[thread], &attr, Pth_empty, &rank[thread]);
  }

  // Collecting Threads
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
void *Pth_empty(void* data){
  //int myrank = *((int*) rank);
  struct thread_data thread_data = *(struct thread_data*) data;
  GET_TIME(thread_data.running);
  printf("Thread %d starting, time waiting to run %e\n", thread_data.rank, thread_data.running - thread_data.runnable);
  GET_TIME(start_thread[thread_data.rank]);
  bubble_sort(data_arrays[thread_data.rank], array_lengths[thread_data.rank]);
  GET_TIME(finish_thread[thread_data.rank]);
  printf("Thread: %d finishing\n", thread_data.rank);
  printf("Thread %d, time waiting to run %e\n", thread_data.rank, thread_data.running - thread_data.runnable);
  return NULL;
}

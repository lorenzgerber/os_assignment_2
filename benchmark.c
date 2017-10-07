#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <unistd.h>
#include "timer.h"
#define NUMBER_THREADS 20

// per thread time keeping struct
typedef struct per_thread_time {
  double wall_t_create;
  double wall_t_run;
  double wall_t_finish;
  double cpu_t_start;
  double cpu_t_finish;
} per_thread_time;

/* Global variables */
void *Pth_empty(void* thread_data);
int array_lengths[NUMBER_THREADS];
int *data_arrays[NUMBER_THREADS];
struct per_thread_time thread_time [NUMBER_THREADS];

/*
 * generic bubble_sort
 * used as compute work task
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
  //time_t t;
  double start, finish;
  int array_size = 5000;
  int step_size = -200;



  pthread_attr_init(&attr);
  if(pthread_attr_setschedpolicy(&attr, SCHED_OTHER) != 0)
    fprintf(stderr, "Unable to set policy.\n");

  /* Intializes random number generator */
  //srand((unsigned) time(&t));


  // Create data arrays
  int rank[NUMBER_THREADS];
  for(int i = 0; i < NUMBER_THREADS; i++){
    rank[i] = i;
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

  // Time stamp for total runtime
  GET_WALL_TIME(start);

  // Starting Threads
  for(thread = 0; thread < NUMBER_THREADS; thread++){
    pthread_create(&thread_handles[thread], &attr, Pth_empty, &rank[thread]);
    GET_WALL_TIME(thread_time[thread].wall_t_create);
  }

  // Collecting Threads
  for(thread = 0; thread < NUMBER_THREADS; thread++){
    pthread_join(thread_handles[thread], NULL);
  }

  // Time stamp for total runtime
  GET_WALL_TIME(finish);

  // data output to stdout:
  // CPU time, Wall time, Wall time create until run, wall time run until finish
  for(int i = 0; i < NUMBER_THREADS; i++){
    printf("sched_other dec %d %e %e %e %e\n",
        i, thread_time[i].cpu_t_finish - thread_time[i].cpu_t_start,
        thread_time[i].wall_t_finish - thread_time[i].wall_t_create,
        thread_time[i].wall_t_run - thread_time[i].wall_t_create,
        thread_time[i].wall_t_finish - thread_time[i].wall_t_run);
  }

  free(thread_handles);

  for(int i = 0; i < NUMBER_THREADS; i++){
    free(data_arrays[i]);
  }

  return 0;
}

/**
 *
 * Thread function
 * Calling bubblesort and doing
 * Benchmarking
 */
void *Pth_empty(void* rank){
  int my_rank = *(int*) rank;

  GET_WALL_TIME(thread_time[my_rank].wall_t_run);
  GET_CPU_THREAD_TIME(thread_time[my_rank].cpu_t_start);

  bubble_sort(data_arrays[my_rank], array_lengths[my_rank]);

  GET_WALL_TIME(thread_time[my_rank].wall_t_finish);
  GET_CPU_THREAD_TIME(thread_time[my_rank].cpu_t_finish);

  return NULL;
}

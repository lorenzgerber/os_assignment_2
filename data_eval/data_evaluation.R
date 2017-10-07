# Data Eval for OS Assignment 2

library(dplyr)

# Load data
setwd("~/git/os_assignment_2/data_eval/")
benchmarking <- read.table('data.txt', sep=" ", stringsAsFactors = FALSE )
header<-c("scheduler", "load_type", "sort_size", "thread_rank", "cpu_time", "wall_time", "wall_create_to_run", "run_to_finish")
colnames(benchmarking)<-header
attach(benchmarking)


other_inc <- filter(benchmarking, scheduler == "sched_other", load_type == "inc")
by_rank<-group_by(other_inc, thread_rank)
summarize(by_rank, sd(cpu_time), sd(wall_time), sd(wall_create_to_run), sd(run_to_finish))
summarize(by_rank, mean(cpu_time), mean(wall_time), mean(wall_create_to_run), mean(run_to_finish))
summarize(by_rank, 'RSD cpu time' = 100/mean(cpu_time)*sd(cpu_time), 
          'RSD wall time' = 100/mean(wall_time)*sd(wall_time), 
          'RSD create to run' = 100/mean(wall_create_to_run)*sd(wall_create_to_run), 
          'RSD run to finish' = 100/mean(run_to_finish)*sd(run_to_finish))

rr_inc <- filter(benchmarking, scheduler == "sched_rr", load_type == "inc")
by_rank<-group_by(rr_inc, thread_rank)
summarize(by_rank, sd(cpu_time), sd(wall_time), sd(wall_create_to_run), sd(run_to_finish))
summarize(by_rank, mean(cpu_time), mean(wall_time), mean(wall_create_to_run), mean(run_to_finish))
summarize(by_rank, 'RSD cpu time' = 100/mean(cpu_time)*sd(cpu_time), 
          'RSD wall time' = 100/mean(wall_time)*sd(wall_time), 
          'RSD create to run' = 100/mean(wall_create_to_run)*sd(wall_create_to_run), 
          'RSD run to finish' = 100/mean(run_to_finish)*sd(run_to_finish))


other <- filter(benchmarking, scheduler == "sched_other")
by_load_type<-group_by(other, load_type)
summarize(by_load_type,mean(cpu_time), mean(wall_time), mean(wall_create_to_run), mean(run_to_finish))

rr <- filter(benchmarking, scheduler == "sched_rr")
by_load_type<-group_by(rr, load_type)
summarize(by_load_type,mean(cpu_time), mean(wall_time), mean(wall_create_to_run), mean(run_to_finish))

fifo <- filter(benchmarking, scheduler == "sched_fifo")
by_load_type<-group_by(fifo, load_type)
summarize(by_load_type,mean(cpu_time), mean(wall_time), mean(wall_create_to_run), mean(run_to_finish))

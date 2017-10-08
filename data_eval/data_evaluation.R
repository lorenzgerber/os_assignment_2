# Data Eval for OS Assignment 2

library(dplyr)

# Load per-thread data
setwd("~/git/os_assignment_2/data_eval/")
per_thread <- read.table('data.txt', sep=" ", stringsAsFactors = FALSE )
header<-c("scheduler", "load_type", "sort_size", "thread_rank", "cpu_time", "wall_time", "wall_create_to_run", "run_to_finish")
colnames(per_thread)<-header
attach(per_thread)


other_inc <- filter(per_thread, scheduler == "sched_other", load_type == "incr")
by_rank<-group_by(other_inc, thread_rank)
summarize(by_rank, sd(cpu_time), sd(wall_time), sd(wall_create_to_run), sd(run_to_finish))
summarize(by_rank, mean(cpu_time), mean(wall_time), mean(wall_create_to_run), mean(run_to_finish))
summarize(by_rank, 'RSD cpu time' = 100/mean(cpu_time)*sd(cpu_time), 
          'RSD wall time' = 100/mean(wall_time)*sd(wall_time), 
          'RSD create to run' = 100/mean(wall_create_to_run)*sd(wall_create_to_run), 
          'RSD run to finish' = 100/mean(run_to_finish)*sd(run_to_finish))

rr_inc <- filter(per_thread, scheduler == "sched_rr", load_type == "incr")
by_rank<-group_by(rr_inc, thread_rank)
summarize(by_rank, sd(cpu_time), sd(wall_time), sd(wall_create_to_run), sd(run_to_finish))
summarize(by_rank, mean(cpu_time), mean(wall_time), mean(wall_create_to_run), mean(run_to_finish))
summarize(by_rank, 'RSD cpu time' = 100/mean(cpu_time)*sd(cpu_time), 
          'RSD wall time' = 100/mean(wall_time)*sd(wall_time), 
          'RSD create to run' = 100/mean(wall_create_to_run)*sd(wall_create_to_run), 
          'RSD run to finish' = 100/mean(run_to_finish)*sd(run_to_finish))

fifo_inc <- filter(per_thread, scheduler == "sched_fifo", load_type == "incr")
by_rank<-group_by(rr_inc, thread_rank)
summarize(by_rank, sd(cpu_time), sd(wall_time), sd(wall_create_to_run), sd(run_to_finish))
summarize(by_rank, mean(cpu_time), mean(wall_time), mean(wall_create_to_run), mean(run_to_finish))
summarize(by_rank, 'RSD cpu time' = 100/mean(cpu_time)*sd(cpu_time), 
          'RSD wall time' = 100/mean(wall_time)*sd(wall_time), 
          'RSD create to run' = 100/mean(wall_create_to_run)*sd(wall_create_to_run), 
          'RSD run to finish' = 100/mean(run_to_finish)*sd(run_to_finish))



other <- filter(per_thread, scheduler == "sched_other")
by_load_type<-group_by(other, load_type)
summarize(by_load_type, "mean cpu time" = round(mean(cpu_time),2), "mean wall time" = round(mean(wall_time), 2), "mean create-to-run" = round(mean(wall_create_to_run),2), "mean run-to-finish" = round(mean(run_to_finish),2))

rr <- filter(per_thread, scheduler == "sched_rr")
by_load_type<-group_by(rr, load_type)
summarize(by_load_type, "mean cpu time" = round(mean(cpu_time),2), "mean wall time" = round(mean(wall_time), 2), "mean create-to-run" = round(mean(wall_create_to_run),2), "mean run-to-finish" = round(mean(run_to_finish),2))

fifo <- filter(per_thread, scheduler == "sched_fifo")
by_load_type<-group_by(fifo, load_type)
summarize(by_load_type, "mean cpu time" = round(mean(cpu_time),2), "mean wall time" = round(mean(wall_time), 2), "mean create-to-run" = round(mean(wall_create_to_run),2), "mean run-to-finish" = round(mean(run_to_finish),2))




other <- filter(per_thread, scheduler == "sched_other")
by_load_type<-group_by(other, load_type)
summarize(by_load_type, "range cpu-time (s)" = round(range(cpu_time)[2]-range(cpu_time)[1], 2), "range wall time (s)" = round(range(wall_time)[2] - range(wall_time)[1], 2), "range create-to-run (s)" = round(range(wall_create_to_run)[2] -  range(wall_create_to_run)[1], 2), "range run-to-finish" = round(range(run_to_finish)[2] - range(run_to_finish)[1], 2))

other <- filter(per_thread, scheduler == "sched_rr")
by_load_type<-group_by(other, load_type)
summarize(by_load_type, "range cpu-time (s)" = round(range(cpu_time)[2]-range(cpu_time)[1], 2), "range wall time (s)" = round(range(wall_time)[2] - range(wall_time)[1], 2), "range create-to-run (s)" = round(range(wall_create_to_run)[2] -  range(wall_create_to_run)[1], 2), "range run-to-finish" = round(range(run_to_finish)[2] - range(run_to_finish)[1], 2))

other <- filter(per_thread, scheduler == "sched_fifo")
by_load_type<-group_by(other, load_type)
summarize(by_load_type, "range cpu-time (s)" = round(range(cpu_time)[2]-range(cpu_time)[1], 2), "range wall time (s)" = round(range(wall_time)[2] - range(wall_time)[1], 2), "range create-to-run (s)" = round(range(wall_create_to_run)[2] -  range(wall_create_to_run)[1], 2), "range run-to-finish" = round(range(run_to_finish)[2] - range(run_to_finish)[1], 2))







# Load per run data
setwd("~/git/os_assignment_2/data_eval/")
per_run <- read.table('total_time.txt', sep=" ", stringsAsFactors = FALSE )
header<-c("scheduler", "load_type", "total_time")
colnames(per_run)<-header
attach(per_run)


other <- filter(per_run, scheduler == "sched_other")
by_load_type<-group_by(other, load_type)
summarize(by_load_type,"Per run" = round(mean(total_time),2))

rr <- filter(per_run, scheduler == "sched_rr")
by_load_type<-group_by(rr, load_type)
summarize(by_load_type,"Per run" = round(mean(total_time),2))

fifo <- filter(per_run, scheduler == "sched_fifo")
by_load_type<-group_by(fifo, load_type)
summarize(by_load_type,"Per run" = round(mean(total_time),2))


# RSD total time
other <- filter(per_run, scheduler == "sched_other")
by_load_type<-group_by(other, load_type)
summarize(by_load_type,"Per run" = round(100/mean(total_time)*sd(total_time),2))

rr <- filter(per_run, scheduler == "sched_rr")
by_load_type<-group_by(rr, load_type)
summarize(by_load_type,"Per run" = round(100/mean(total_time)*sd(total_time),2))

fifo <- filter(per_run, scheduler == "sched_fifo")
by_load_type<-group_by(fifo, load_type)
summarize(by_load_type,"Per run" = round(100/mean(total_time)*sd(total_time),2))

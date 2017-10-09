# Data Eval for OS Assignment 2

library(dplyr)

# Load per-thread data
setwd("~/git/os_assignment_2/data_eval/")
per_thread <- read.table('data.txt', sep=" ", stringsAsFactors = FALSE )
header<-c("scheduler", "load_type", "sort_size", "thread_rank", "cpu_time", "wall_time", "wall_create_to_run", "run_to_finish")
colnames(per_thread)<-header
attach(per_thread)

par(mfcol=c(4,3))

## Plotting
## Wall Time
other_inc <- filter(per_thread, scheduler == "sched_other", load_type == "incr")
rr_inc <- filter(per_thread, scheduler == "sched_rr", load_type == "incr")
fifo_inc <- filter(per_thread, scheduler == "sched_fifo", load_type == "incr")
plot(fifo_inc[,3], fifo_inc[,6], col="blue", main="Wall Time", sub="Increasing length of Task Size (n = 5)",xlab="task size", ylab="seconds", pch=2)
points(rr_inc[,3], rr_inc[,6], col="red", pch=1)
points(other_inc[,3], other_inc[,6], col="black", pch=0)
legend(1000,12,c("CFS", "RR", "FIFO"), col=c("black", "red", "blue"), pch=c(0,1,2))

other_inc <- filter(per_thread, scheduler == "sched_other", load_type == "decr")
rr_inc <- filter(per_thread, scheduler == "sched_rr", load_type == "decr")
fifo_inc <- filter(per_thread, scheduler == "sched_fifo", load_type == "decr")
plot(fifo_inc[,3], fifo_inc[,6], col="blue", main="Wall Time", sub="Decreasing length of Task Size (n = 5)",xlab="task size", ylab="seconds", pch=2)
points(rr_inc[,3], rr_inc[,6], col="red", pch=1)
points(other_inc[,3], other_inc[,6], col="black", pch=0)
legend(1200,12,c("CFS", "RR", "FIFO"), col=c("black", "red", "blue"), pch=c(0,1,2))

other_inc <- filter(per_thread, scheduler == "sched_other", load_type == "low")
rr_inc <- filter(per_thread, scheduler == "sched_rr", load_type == "low")
fifo_inc <- filter(per_thread, scheduler == "sched_fifo", load_type == "low")
plot(other_inc[,4], other_inc[,6], col="black", ylim = c(0,1.4), main="Wall Time", sub="Short length of Task Size (n = 5)",xlab="thread rank", ylab="seconds", pch=0)
points(rr_inc[,4], rr_inc[,6], col="red", pch=1)
points(fifo_inc[,4], fifo_inc[,6], col="blue", pch=2)
legend(0,1,c("CFS", "RR", "FIFO"), col=c("black", "red", "blue"), pch=c(0,1,2))

other_inc <- filter(per_thread, scheduler == "sched_other", load_type == "high")
rr_inc <- filter(per_thread, scheduler == "sched_rr", load_type == "high")
fifo_inc <- filter(per_thread, scheduler == "sched_fifo", load_type == "high")
plot(other_inc[,4], other_inc[,6], col="black", pch=0, ylim=c(0,34.60), main="Wall Time", sub="Long length of Task Size (n = 5)",xlab="thread rank", ylab="seconds")
points(rr_inc[,4], rr_inc[,6], col="red", pch=1)
points(fifo_inc[,4], fifo_inc[,6], col="blue", pch=2)
legend(0,30,c("CFS", "RR", "FIFO"), col=c("black", "red", "blue"), pch=c(0,1,2))




## Plotting
## wall create to run
other_inc <- filter(per_thread, scheduler == "sched_other", load_type == "incr")
rr_inc <- filter(per_thread, scheduler == "sched_rr", load_type == "incr")
fifo_inc <- filter(per_thread, scheduler == "sched_fifo", load_type == "incr")
plot(fifo_inc[,3], fifo_inc[,7], col="blue", pch=2, main="Create-until-run (wall time)", sub="Increasing length of Task Size (n = 5)",xlab="task size", ylab="seconds")
points(rr_inc[,3], rr_inc[,7], col="red", pch=1)
points(other_inc[,3], other_inc[,7], col="black", pch=0)
legend(1000,10,c("CFS", "RR", "FIFO"), col=c("black", "red", "blue"), pch=c(0,1,2))

other_inc <- filter(per_thread, scheduler == "sched_other", load_type == "decr")
rr_inc <- filter(per_thread, scheduler == "sched_rr", load_type == "decr")
fifo_inc <- filter(per_thread, scheduler == "sched_fifo", load_type == "decr")
plot(fifo_inc[,3], fifo_inc[,7], col="blue", pch=2, main="Create-until-run (wall time)", sub="Decreasing length of Task Size (n = 5)",xlab="task size", ylab="seconds")
points(rr_inc[,3], rr_inc[,7], col="red", pch=1)
points(other_inc[,3], other_inc[,7], col="black",pch=0)
legend(1200,12,c("CFS", "RR", "FIFO"), col=c("black", "red", "blue"), pch=c(0,1,2))

other_inc <- filter(per_thread, scheduler == "sched_other", load_type == "low")
rr_inc <- filter(per_thread, scheduler == "sched_rr", load_type == "low")
fifo_inc <- filter(per_thread, scheduler == "sched_fifo", load_type == "low")
plot(other_inc[,4], other_inc[,7], col="black", pch=0, ylim = c(0,1.4), main="Create-until-run (wall time)", sub="Short length of Task Size (n = 5)",xlab="thread rank", ylab="seconds")
points(rr_inc[,4], rr_inc[,7], col="red", pch=1)
points(fifo_inc[,4], fifo_inc[,7], col="blue", pch=2)
legend(0,1,c("CFS", "RR", "FIFO"), col=c("black", "red", "blue"), pch=c(0,1,2))

other_inc <- filter(per_thread, scheduler == "sched_other", load_type == "high")
rr_inc <- filter(per_thread, scheduler == "sched_rr", load_type == "high")
fifo_inc <- filter(per_thread, scheduler == "sched_fifo", load_type == "high")
plot(fifo_inc[,4], fifo_inc[,7], col="blue", pch=2, main="Create-until-run (wall time)", sub="Long length of Task Size (n = 5)",xlab="thread rank", ylab="seconds")
points(rr_inc[,4], rr_inc[,7], col="red", pch=1)
points(other_inc[,4], other_inc[,7], col="black", pch=0)
legend(0,25,c("CFS", "RR", "FIFO"), col=c("black", "red", "blue"), pch=c(0,1,2))





## Plotting
## wall run to finish
other_inc <- filter(per_thread, scheduler == "sched_other", load_type == "incr")
rr_inc <- filter(per_thread, scheduler == "sched_rr", load_type == "incr")
fifo_inc <- filter(per_thread, scheduler == "sched_fifo", load_type == "incr")
plot(other_inc[,3], other_inc[,8], col="black", pch=0, ylim=c(0,13),main="Run-until-finish (wall time)", sub="Increasing length of Task Size (n = 5)",xlab="task size", ylab="seconds")
points(fifo_inc[,3], fifo_inc[,8], col="blue", pch=2)
points(rr_inc[,3], rr_inc[,8], col="red", pch=1)
legend(1000,10,c("CFS", "RR", "FIFO"), col=c("black", "red", "blue"), pch=c(0,1,2))


other_inc <- filter(per_thread, scheduler == "sched_other", load_type == "decr")
rr_inc <- filter(per_thread, scheduler == "sched_rr", load_type == "decr")
fifo_inc <- filter(per_thread, scheduler == "sched_fifo", load_type == "decr")
plot(other_inc[,3], other_inc[,8], ylim=c(0,15), col="black", pch=0, main="Run-until-finish (wall time)", sub="Decreasing length of Task Size (n = 5)",xlab="task size", ylab="seconds")
points(fifo_inc[,3], fifo_inc[,8], col="blue", pch=2)
points(rr_inc[,3], rr_inc[,8], col="red", pch=1)
legend(1200,10,c("CFS", "RR", "FIFO"), col=c("black", "red", "blue"), pch=c(0,1,2))


other_inc <- filter(per_thread, scheduler == "sched_other", load_type == "low")
rr_inc <- filter(per_thread, scheduler == "sched_rr", load_type == "low")
fifo_inc <- filter(per_thread, scheduler == "sched_fifo", load_type == "low")
plot(other_inc[,4], other_inc[,8], col="black", pch=0, ylim = c(0,1.5), main="Run-until-finish (wall time)", sub="Short length of Task Size (n = 5)",xlab="thread rank", ylab="seconds")
points(rr_inc[,4], rr_inc[,8], col="red", pch=1)
points(fifo_inc[,4], fifo_inc[,8], col="blue", pch=2)
legend(0,1,c("CFS", "RR", "FIFO"), col=c("black", "red", "blue"), pch=c(0,1,2))

other_inc <- filter(per_thread, scheduler == "sched_other", load_type == "high")
rr_inc <- filter(per_thread, scheduler == "sched_rr", load_type == "high")
fifo_inc <- filter(per_thread, scheduler == "sched_fifo", load_type == "high")
plot(fifo_inc[,4], fifo_inc[,8], col="blue", pch=2, ylim=c(0,35), main="Run-until-finish (wall time)", sub="Long length of Task Size (n = 5)",xlab="thread rank", ylab="seconds")
points(rr_inc[,4], rr_inc[,8], col="red", pch=1)
points(other_inc[,4], other_inc[,8], col="black", pch=0)
legend(0,25,c("CFS", "RR", "FIFO"), col=c("black", "red", "blue"), pch=c(0,1,2))




#######

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

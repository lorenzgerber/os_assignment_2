#!/bin/bash

sudo gcc -o other_incr other_incr.c timer.h -pthread
sudo gcc -o other_decr other_decr.c timer.h -pthread
sudo gcc -o other_low other_low.c timer.h -pthread
sudo gcc -o other_high other_high.c timer.h -pthread

sudo gcc -o fifo_incr fifo_incr.c timer.h -pthread
sudo gcc -o fifo_decr fifo_decr.c timer.h -pthread
sudo gcc -o fifo_low fifo_low.c timer.h -pthread
sudo gcc -o fifo_high fifo_high.c timer.h -pthread

sudo gcc -o rr_incr rr_incr.c timer.h -pthread
sudo gcc -o rr_decr rr_decr.c timer.h -pthread
sudo gcc -o rr_low rr_low.c timer.h -pthread
sudo gcc -o rr_high rr_high.c timer.h -pthread




for i in `seq 1 5`
do
    sudo ./other_incr >> data.txt
    sudo ./other_decr >> data.txt
    sudo ./other_low >> data.txt
    sudo ./other_high >> data.txt
    sudo ./fifo_incr >> data.txt
    sudo ./fifo_decr >> data.txt
    sudo ./fifo_low >> data.txt
    sudo ./fifo_high >> data.txt
    sudo ./rr_incr >> data.txt
    sudo ./rr_decr >> data.txt
    sudo ./rr_low >> data.txt
    sudo ./rr_high >> data.txt
done

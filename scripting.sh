#!/bin/bash
for i in `seq 1 10`
do
    ./benchmark >> data.txt
done

#!/bin/bash

filelist="../benchmarklist.txt"

for bench in $(cat $filelist)
do
	file="logs/benchmarks/${bench}/mustarlog.log"
	total_time="$(sed -nE "s/.*Main: *(.*?) seconds total.*/\1/p" $file)"
	echo $bench, $total_time
done

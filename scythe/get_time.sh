#!/bin/bash

filelist="../benchmarklist.txt"

for bench in $(cat $filelist)
do
	file="logs/benchmarks/${bench}*/ScytheOP.out"
	t="$(sed -nE "s/.*Time]] (.*)s/\1/p" $file)"
	total_time="$(echo $t | sed "s/\s/+/g" | bc)"
	echo $bench, $total_time
done

#!/bin/bash

# filelist="../benchmarklist.txt"
# rulesize=$1

for bench in $(ls benchmarks/unrealizable)
do
	file="logs/benchmarks/unrealizable/$bench/time_taken.txt"
	time_min=$(sed -nE "s/real.*?([0-9].*?)m.*s/\1/p" $file)
	time_sec=$(sed -nE "s/real.*?m(.*)s/\1/p" $file)
	echo $bench, $( echo "$time_min * 60 + $time_sec" | bc)
done

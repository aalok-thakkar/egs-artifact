#!/bin/bash

filelist="../unrealizable.txt"
# rulesize=$1

for bench in $(cat $filelist)
do
	file="logs/benchmarks/unrealizable/${bench}/mustarlog.log"
	total_time=$(tail -1 $file | sed -nE "s/.*: (.*) seconds total.*/\1/p")
	echo $bench, $total_time
done

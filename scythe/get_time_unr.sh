#!/bin/bash

filelist="../unrealizable.txt"
# rulesize=$1

for bench in $(cat $filelist)
do
	file="logs/benchmarks/unrealizable/${bench}*/ScytheOP.out"
	t="$(sed -nE "s/.*Time]] (.*)s/\1/p" $file)"
	total_time="$(echo $t | sed "s/\s/+/g" | bc)"
	echo $bench, $total_time
done

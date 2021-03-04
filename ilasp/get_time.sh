#!/bin/bash

filelist="../benchmarklist.txt"
rulesize=$1

for bench in $(cat $filelist)
do
	file="logs/benchmarks/$rulesize/$bench/out.log"
	echo $bench, $(sed -nE "s/Solve time.*: *?(.*)s/\1/p" $file)
done

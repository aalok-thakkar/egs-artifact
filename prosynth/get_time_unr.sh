#!/bin/bash

# filelist="../benchmarklist.txt"
# rulesize=$1

for bench in $(ls benchmarks/unrealizable)
do
	file="logs/benchmarks/unrealizable/$bench/log.txt"
        grep -qs "model is not available" $file 2>&1 3>&1 > /dev/null
        n="$?"

        if (( $n == 0 )); then
                echo $bench, $(sed -nE "s/Total runtime: *?(.*)/\1/p" $file)
        else
                echo $bench, 
        fi

done

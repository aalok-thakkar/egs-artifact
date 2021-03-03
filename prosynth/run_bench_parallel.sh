#!/bin/bash
bench_dir="$1"
for i in $(find ${bench_dir}/* -type f -name "rules.small.dl")
do
	d=$(dirname $i)
	./run_single.sh $d > /dev/null &
done
wait

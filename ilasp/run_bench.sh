#!/bin/bash

bench_dir="$1"
for i in $(find ${bench_dir}/* -type f -name "ilasp_bench.las")
do
	d=$(dirname $i)
	echo $d
	./run_single.sh $d
done

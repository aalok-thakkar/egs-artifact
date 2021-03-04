#!/bin/bash
bench_dir="$1"
n=0
t=$(find ${bench_dir}/* -type f -name "rules.small.dl" | wc -l)
for i in $(find ${bench_dir}/* -type f -name "rules.small.dl")
do
        ./run_single.sh "$(dirname $i)" > /dev/null
	n=$((n+1))
	echo -ne "Run for $n / $t \r"
done

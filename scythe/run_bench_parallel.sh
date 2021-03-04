#!/bin/bash
bench_dir="$1"
for i in $(find ${bench_dir}/* -type f)
do
        ./run_single.sh "$i" 2>&1 > /dev/null &
done
wait

#!/bin/bash
bench_dir="$1"
for i in $(find ${bench_dir}/* -type f)
do
        ./run_single.sh "$i" > /dev/null
done

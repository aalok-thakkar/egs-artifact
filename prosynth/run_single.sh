#!/bin/bash

bench="$1"

mkdir -p logs/${bench}
rm -rf logs/${bench}/*
timeout 5m ./scripts/prepare $bench 2>&1 3>&1 > logs/${bench}/prepop.txt
n=$?
if (( $n == 0 )); then
	echo "PREPPED" > logs/${bench}/p.txt
	timeout 5m ./scripts/prosynth $bench 0 1 1 logs/$bench/pslog.txt 2>&1 > logs/${bench}/log.txt
else
	if (( $n == 124 )); then
		echo "PREP ERROR: TO" > logs/${bench}/p.txt
	else
		echo "PREP ERROR" > logs/${bench}/p.txt
	fi
fi

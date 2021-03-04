#!/bin/bash

bench=$1

mkdir -p logs/${bench}
rm -rf logs/${bench}/*

./run.sh ${bench} > logs/${bench}/out.log 2>logs/${bench}/err.log
mustarlog=$(sed -nE "s/.*log messages to (.*.log)/\1/p" logs/${bench}/out.log)
echo $mustarlog
mustarop=${mustarlog::-3}out
mv $mustarop logs/${bench}/mustarop.log
mv $mustarlog logs/${bench}/mustarlog.log

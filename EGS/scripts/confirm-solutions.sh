#!/usr/bin/env bash

set -e

export SOUFFLE_EXEC=$HOME/Synthesis-Datalog/souffle/src/souffle

(grep -v ':-' rules.small.dl | grep -v '\.decl Rule' | grep -v '\.input Rule'; cat solution.txt) > solution.dl
$SOUFFLE_EXEC solution.dl

for i in `ls *.expected`; do
    j=`echo $i | sed 's/\.expected$/\.csv/'`
    diff <(sort $i) <(sort $j)
done

rm *.csv

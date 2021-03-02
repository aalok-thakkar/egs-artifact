#!/usr/bin/env bash

set -e

export NUM_CORES=18
TSPWAIT_EXEC=$HOME/Synthesis-Datalog/popl2020-artifact/scripts/tsp-wait.sh

tsp -S $NUM_CORES

for i in `ls | grep -v 'scythe' | grep -v 'quickfoil' | grep -v 'scalebenchmarks'`; do
    cd $i
    tsp ../../make-rules.sh
    cd ..
done

$TSPWAIT_EXEC

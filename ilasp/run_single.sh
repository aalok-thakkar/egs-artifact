#!/bin/bash

bench="$1"

mkdir -p logs/${bench}
rm -rf logs/${bench}/*

{ time timeout 5m ./ILASP --version=3 -nc -na -ml=6 --max-rule-length=7 --clingo "./clingo"  ${bench}/ilasp_bench.las > logs/${bench}/out.log 2>logs/${bench}/err.log; } 2>logs/${bench}/time_taken.txt

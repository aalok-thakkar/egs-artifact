#!/bin/bash

bench="$1"
echo "Running Scythe on $bench"
mkdir -p logs/${bench}
rm -rf logs/${bench}/*
timeout 5m java -jar out/artifacts/Scythe_jar/Scythe.jar ${bench} StagedEnumerator > logs/${bench}/ScytheOP.out
echo "Scythe finished running on $bench"

#!/bin/bash

echo "Running the unrealizability experiments to reproduce table 2"
rm -rf egs/egs_unr_runtimes.csv scythe/scythe_unr_runtimes.csv ilasp/ilasp_unr_runtimes.csv prosynth/prosynth_unr_runtimes.csv unrealizability_runtimes.csv
echo "Running experiments for EGS"
cd egs/
./run_bench.sh benchmarks/unrealizable
echo "Storing runtimes"
./get_time_unr.sh | awk '{ print $2 }' > egs_unr_runtimes.csv
cd ..

echo "Running experiments for ProSynth"
cd prosynth
./run_bench.sh benchmarks/unrealizable
echo "Storing runtimes"
./get_time_unr.sh | awk '{ print $2 }' > prosynth_unr_runtimes.csv
cd ..

echo "Running experiments for ILASP"
cd ilasp
./run_bench.sh benchmarks/unrealizable
echo "Storing runtimes"
./get_time_unr.sh | awk '{ print $2 }' > ilasp_unr_runtimes.csv
cd ..

echo "Runnning experiments for Scythe"
cd scythe
./run_bench.sh benchmarks/unrealizable
echo "Storing runtimes"
./get_time_unr.sh | awk '{ print $2 }' > scythe_unr_runtimes.csv
cd ..

echo "Collecting all runtimes together..."
echo "Benchmarks, EGS, Scythe, ILASP, ProSynth" > unrealizability_runtimes.csv
pr -tm -s, unrealizable.txt egs/egs_unr_runtimes.csv scythe/scythe_unr_runtimes.csv ilasp/ilasp_unr_runtimes.csv prosynth/prosynth_unr_runtimes.csv >> unrealizability_runtimes.csv
echo "Done"

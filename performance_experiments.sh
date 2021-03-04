#!/bin/bash

echo "Running the performance experiments to reproduce fig. 4 and tables 3,4 and 5 (from appendix A)"
rm egs/egs_runtimes.csv scythe/scythe_runtimes.csv ilasp/ilasp_agnostic_runtimes.csv ilasp/ilasp_specific_runtimes.csv prosynth/prosynth_agnostic_runtimes.csv prosynth/prosynth_specific_runtimes.csv performance_runtimes.csv
echo "Running experiments for EGS"
cd egs/
echo "Running for Knowledge Discovery"
./run_bench.sh benchmarks/kd_bench
echo "Running for Program Analysis"
./run_bench.sh benchmarks/pa_bench
echo "Running for Relational Queries"
./run_bench.sh benchmarks/sql-queries
echo "Storing runtimes"
./get_time.sh | awk '{ print $2 }' > egs_runtimes.csv
cd ..

echo "Running experiments for ProSynth"
cd prosynth
echo "Running for Benchmarks with Task-Specific Candidate Rules"
./run_bench_parallel.sh benchmarks/specific
echo "Running for Benchmarks with Task-Agnostic Candidate Rules"
./run_bench_parallel.sh benchmarks/agnostic
echo "Storing runtimes"
./get_time.sh specific | awk '{ print $2 }' > prosynth_specific_runtimes.csv
./get_time.sh agnostic | awk '{ print $2 }' > prosynth_agnostic_runtimes.csv
cd ..

echo "Running experiments for ILASP"
cd ilasp
echo "Running for Benchmarks with Task-Specific Candidate Rules"
./run_bench_parallel.sh benchmarks/specific
echo "Running for Benchmarks with Task-Agnostic Candidate Rules"
./run_bench_parallel.sh benchmarks/agnostic
echo "Storing runtimes"
./get_time.sh specific | awk '{ print $2 }' > ilasp_specific_runtimes.csv
./get_time.sh agnostic | awk '{ print $2 }' > ilasp_agnostic_runtimes.csv
cd ..

echo "Runnning experiments for Scythe"
cd scythe
echo "Running for Knowledge Discovery"
./run_bench_parallel.sh benchmarks/kd_bench
echo "Running for Program Analysis"
./run_bench_parallel.sh benchmarks/pa_bench
echo "Running for Relational Queries"
./run_bench_parallel.sh benchmarks/sql-queries
echo "Storing runtimes"
./get_time.sh | awk '{ print $2 }' > scythe_runtimes.csv
cd ..

echo "Collecting all runtimes together..."
pr -tm -s, benchmarklist.txt egs/egs_runtimes.csv scythe/scythe_runtimes.csv ilasp/ilasp_agnostic_runtimes.csv ilasp/ilasp_specific_runtimes.csv prosynth/prosynth_agnostic_runtimes.csv prosynth/prosynth_specific_runtimes.csv > performance_runtimes.csv
echo "Done"

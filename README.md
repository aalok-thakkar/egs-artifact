Example-Guided Synthesis of Relational Queries
===============================================

Aalok Thakkar; Aaditya Naik; Nathaniel Sands; Mukund Raghothaman; Mayur Naik; Rajeev Alur

Introduction
------------

This is the artifact package accompanying our PLDI 2021 submission titled Example-Guided Synthesis of Relational Queries. In the paper, we present an algorithm to learn relational queries from input-output examples. We use a new technique called example guided synthesis, which exploits patterns in the examples to accelerate synthesis. We benchmark our algorithm, which we call EGS, against three existing solvers, ILASP, Prosynth, and Scythe.

This artifact contains all four tools (EGS, ILASP, ProSynth, and Scythe), benchmark files, and scripts to reproduce the
experiments described in the paper. In this document, we will describe the outline of these experiments, how to run
them, and also describe how one may use EGS to solve relational query synthesis problems of their own.

Installing the Artifact
-----------------------

The recommended way to install this artifact is by using Docker:
```
git clone https://github.com/aalok-thakkar/egs-artifact.git
cd egs-artifact/
docker build -t egs scripts/
docker run -it --name egs-artifact egs
```

Subsequently, to start and run the same docker container after exiting it:
```
docker start egs-artifact
docker attach egs-artifact
```

To uninstall the artifact, run the following commands to remove the container as well as the image:

```
docker container rm egs-artifact
docker rmi egs
```


__Hardware Requirements.__ We ran the experiments on a Xeon 6154 CPU running at 3 GHz with 18 cores and 36 threads. The
system was equipped with 394 GB of RAM, and was running the Ubuntu 18.04 LTS operating system over the Linux kernel
version 4.15. 

Structure of the Experiment
----------------------------

In our paper, we present a method of computing UCQs consistent with given input-output examples and compare it with three state-of-the-art tools on a suite of 86 benchmarks. The benchmarks are divided into the following four categories:

1. Knowledge Discovery: These comprise 20 tasks that involve synthesizing conjunctive queries and unions of conjunctive queries frequently used in the artificial intelli- gence and database literature.
2. Program Analysis: These comprise 18 tasks that involve synthesizing static analysis algorithms for im- perative and object-oriented programs.
3. Database Query. These comprise 41 tasks that involve synthesizing database queries. These tasks, orig- inally from StackOverflow posts and textbook examples, are obtained from Scythe’s benchmark suite.
4. Unrealizable: These comprise 7 tasks that do not admit a solution. 

We run the four tools on all of these 86 benchmarks and produce Table 2 and Figure 4 in the main paper. The exact runtimes for the knowledge discovery, program analysis, and database query benchmarks are presented in Tables 3, 4, and 5 in Appendix A (Runtime Comparisons). These experiments also produce the results discussed in Appendix B (Quality of Programs). 

### Running all the Experiments

To run the performance experiments, run `./performance_experiments_parallel.sh` to run all the performance experiments with some amounts of parallelism. This takes around 40 minutes
to run with the hardware specifications we have mentioned above. While the experiments can be run on less powerful machines, note that
this may use a lot of memory, in which case we provide `./performance_experiments.sh` as an alternative which runs the experiments sequentially, which will take
a lot more time (we approximate around 24 hours). Both these scripts will produce a CSV file `performance_runtimes.csv` in the root of the repository, which represents the tables 3,4 and 5 from Appendix A,
and a graph `graph.jpg` which represents Figure 4.

To run the unrealizability experiments, run `./unrealizability_experiments_parallel.sh` to run the unrealizability experiments with some amounts of parallelism. This takes
around 15 minutes to run with the hardware specifications we have mentioned above. Similarly to the performance experiments, we provide a sequential alternative
`./unrealizability_experiments.sh` which likewise takes more time (approximately 9 hours). Both these scripts will produce a CSV file `unrealizability_runtimes.csv` which represents table 2.

We recommend comparing the trends between different baselines in each experiment since the actual numbers will depend heavily on hardware configurations, compiler versions
and other numerous factors.


A Brief Tutorial to Using EGS
----------------------------------

### Running EGS on Individual Benchmark Problems

1. Pick a problem instance from the set of benchmark problems in the `/egs-artifact/benchmarks/` directory.
   Let the complete path of this directory be `PROBLEM_DIR`.
   We will explain the structure of this directory in the next subsection.
2. To perform the _synthesis_, from inside the main `/egs-artifact` directory, run the
   command `./run.sh $PROBLEM_DIR`. For the `benchmarks/knowledge-discovery/traffic` benchmark, the
   script should return in less than 2 seconds on a contemporary laptop.

### Setting up New Problem Instances

1. There are three ingredients in an EGS problem instance:
   1. Names and signatures of input and ouput relations,
   2. Set of tuples inhabiting the input relations, and
   3. Set of expected tuples inhabit the output relation.

2. Placing the training data:
   1. For each input relation `Rin`, place the set of input tuples as tab separated values in in a file named `Rin.facts`.
   2. For the output relation `Rout`, place the set of expected output tuples as tab separated values in a file named `Rout.expected`.

3. Create a file named `rules.small.dl` using any of the existing benchmarks as a template.

   1. We allow our Datalog rules to have a simple model of types: every relation is associated with a list of types
      called its _signature_, and the fields of every tuple inhabiting this relation match the corresponding type.
      Declare all relevant types at the beginning of the `rules.small.dl` file.

      For example, in the case of Traffic, we are modeling properties of road networks, which consist of streets. At the beginning
      of `rules.small.dl`, we therefore find a line saying `.type S`, indicating the type of streets.

   2. Declare all input and output relations in the problem instance. Each declaration consists of two lines,
      the first specifying the relation's signature, and the second identifying whether it is _consumed_ by the Datalog
      program (i.e., whether it is an input relation), or _produced_ by the Datalog program (i.e., whether it is an
      output relation).

      For Traffic, this looks as follows:
      ```
      .decl GreenSignal(s: S)
      .input GreenSignal
      .decl HasTraffic(s: S)
      .input HasTraffic
      .decl Intersect(s1: S, s2: S)
      .input Intersect
      .decl Crashes(s: S)
      .output Crashes
      ```
   3. Now you are ready to _synthesize_. Run `./run.sh $PROBLEM_DIR`. If synthesis is
   successful, the script will print the set of rules that form the target program.

Running ILASP
----------------------------------

### Running ILASP on Individual Benchmark Problems

1. Change into the ILASP directory
```
cd ilasp/
```

2. Pick a problem directory from the set of benchmark problems in the `benchmarks` directory.
   A problem directory is one containing a single file `ilasp_bench.las`.
   For example, the directory `benchmarks/specific/kd_bench/adjacent-to-red`.
   Note that the benchmarks under the `benchmarks/specific` directory are those whose bias modes have
   been crafted specifically for each benchmark, while those under the `benchmarks/agnostic` directory
   are those with task-agnostic mode biases. Unrealizable benchmarks will be under `benchmarks/unrealizable`.

3. To run the individual problem, run the following command:
```
./run_single.sh path/to/directory
```
   For example:
```
./run_single.sh benchmarks/specific/kd_bench/adjacent-to-red
```
   The results will be stored in the `logs/benchmarks/specific/kd_bench/adjacent-to-red` directory.

### Running ILASP on all Benchmarks

1. Change into the ILASP directory
```
cd ilasp/
```

2. Either run `./run_bench.sh benchmark/path` which will sequentially run each benchmark with a timeout of 5 minutes, or
   run `./run_bench_parallel.sh benchmark/path` which will run the benchmarks parallelly with a timeout of 5 minutes, and
   will terminate once all benchmarks are finished running or have timed out.
```
./run_bench.sh benchmarks # run all benchmarks sequentially
./run_bench_parallel.sh benchmarks/agnostic/pa_bench # run all program analysis benchmarks with task-agnostic candidate rules in parallel
```

3. Once all the benchmarks have run, run `./get_time.sh specific` to get the running
   times for the benchmarks under the `benchmarks/specific` directory,
   and `./get_time.sh agnostic`
   to get the running times for the benchmarks under the `benchmarks/agnostic` directory,
   and `./get_time_unr.sh` to get the running times for the unrealizable benchmarks.

Running ProSynth
----------------------------------

### Running ProSynth on Individual Benchmark Problems

1. Change into the ProSynth directory
```
cd prosynth/
```

2. Pick a problem directory from the set of benchmark problems in the `benchmarks` directory.
   A problem directory is one containing a set of input files `*.facts`, output files `*.expected`,
   and two other files `rules.small.dl` and `ruleNames.small.txt`.
   For example, the directory `benchmarks/specific/kd_bench/adjacent-to-red`.
   Note that the benchmarks under the `benchmarks/specific` directory are those whose candidate rules have
   been crafted specifically for each benchmark, while those under the `benchmarks/agnostic` directory
   are those with task-agnostic candidate rules. Unrealizable benchmarks will be under `benchmarks/unrealizable`.

3. To run the individual problem, run the following command:
```
./run_single.sh path/to/directory
```
   For example:
```
./run_single.sh benchmarks/specific/kd_bench/adjacent-to-red
```
   The results will be stored in the `logs/benchmarks/specific/kd_bench/adjacent-to-red` directory.

### Running ProSynth on all Benchmarks

1. Change into the ProSynth directory
```
cd prosynth/
```

2. Either run `./run_bench.sh benchmark/path` which will sequentially run each benchmark with a timeout of 5 minutes, or
   run `./run_bench_parallel.sh benchmark/path` which will run the benchmarks parallelly with a timeout of 5 minutes, and
   will terminate once all benchmarks are finished running or have timed out.
```
./run_bench.sh benchmarks # run all benchmarks sequentially
./run_bench_parallel.sh benchmarks/specific/kd_bench # run all knowledge discovery benchmarks with task-specific candidate rules in parallel
```
3. Once all the benchmarks have run, run `./get_time.sh specific` to get the running
   times for the benchmarks under the `benchmarks/specific` directory,
   and `./get_time.sh agnostic`
   to get the running times for the benchmarks under the `benchmarks/agnostic` directory,
   and `./get_time_unr.sh` to get the running times for the unrealizable benchmarks.

Running Scythe
----------------------------------

### Running Scythe on Individual Benchmark Problems

1. Change into the Scythe directory
```
cd scythe/
```

2. Pick a problem file from the set of benchmark problems in the `benchmarks` directory. Each filei `*_scythe`
   under the `benchmarks` directory constitutes a benchmark adapted to work with Scythe.
   For example, `benchmarks/kd_bench/adjacent-to-red_target_scythe`.
   Note that the benchmarks
   with multiple output relations have to be split up (eg. animals under `benchmarks/kd_bench` must be split up into
   animals_bird, animals_fish, animals_mammal and animals_reptile).

3. To run an individual problem, run the following command:
```
./run_single.sh path/to/benchmark
```
For example,
```
./run_single.sh benchmarks/kd_bench/adjacent-to-red_target_scythe
```
   The results wil be stored in `logs/benchmarks/kd_bench/adjacent-to-red_target_scythe`

### Running Scythe on all Benchmarks

1. Change into the Scythe directory
```
cd scythe/
```

2. Either run `./run_bench.sh benchmark/dir` which will sequentially run each benchmark with a timeout of 5 minutes, or
   run `./run_bench_parallel.sh benchmark/dir` which will run the benchmarks parallelly with a timeout of 5 minutes, and
   will terminate once all benchmarks are finished running or have timed out.
```
./run_bench.sh benchmarks # run all benchmarks sequentially
./run_bench_parallel.sh benchmarks/kd_bench # run all knowledge discovery benchmarks in parallel
```
3. Once all the benchmarks have run, run `./get_time.sh` to get the running
   times for the realizable benchmarks and `./get_time_unr.sh` to get the running times for the unrealizable benchmarks.


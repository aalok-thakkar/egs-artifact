Example-Guided Synthesis of Relational Queries
===============================================

Aalok Thakkar; Aaditya Naik; Nathaniel Sands; Mukund Raghothaman; Mayur Naik; Rajeev Alur

Introduction
------------

This is the artifact package accompanying our PLDI 2021 submission titled _Example-Guided Synthesis of Relational Queries_. The paper presents a new approach called example-guided synthesis, which exploits data patterns in the examples to construct relational queries from input-output examples. We have
implemented this approach as EGS algorithm and benchmarked it against the existing solvers, ILASP, ProSynth, and Scythe. 

This artifact contains all four tools (EGS, ILASP, ProSynth, and Scythe), benchmark files, and scripts to reproduce the
experiments described in the paper. In this document, we will describe the outline of these experiments, how to run
them, and also describe how one may use EGS to solve relational query synthesis problems of their own.

Installing the Artifact
-----------------------

The recommended way to install this artifact is by using Docker:

To uninstall the artifact, run the following commands:

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

A Brief Tutorial to Using ILASP
----------------------------------

A Brief Tutorial to Using ProSynth
----------------------------------

A Brief Tutorial to Using Scythe
----------------------------------

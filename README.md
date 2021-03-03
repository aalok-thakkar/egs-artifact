Example-Guided Synthesis of Relational Queries
===============================================

Aalok Thakkar; Aaditya Naik; Nathaniel Sands; Mukund Raghothaman; Mayur Naik; Rajeev Alur

Introduction
------------

This is the artifact package accompanying our PLDI 2021 submission titled _Example-Guided Synthesis of Relational Queries_. The paper presents a new approach called example-guided synthesis, which exploits data patterns in the examples to construct relational queries from input-output examples. We have
implemented this approach as EGS algorithm and benchmarked it against the existing solvers, ILASP 2, ProSynth, and Scythe. 

This artifact contains all four tools (EGS, ILASP 2, ProSynth, and Scythe), benchmark files, and scripts to reproduce the
experiments described in the paper. In this document, we will describe the outline of these experiments, how to run
them, and also describe how one may use EGS to solve relational query synthesis problems of their own.

Installing the Artifact
-----------------------

The recommended way to install this artifact is by using Docker:

To uninstall the artifact, run the following commands:

__Hardware Requirements.__ We ran the experiments on a Xeon 6154 CPU running at 3 GHz with 18 cores and 36 threads. The
system was equipped with 394 GB of RAM, and was running the Ubuntu 18.04 LTS operating system over the Linux kernel
version 4.15. 

Structure of the Experiments
----------------------------

A Brief Tutorial to Using EGS
----------------------------------

### Running EGS on Individual Benchmark Problems

### Setting up New Problem Instances

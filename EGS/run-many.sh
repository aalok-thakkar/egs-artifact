#!/usr/bin/env bash

set -e

time ls ./benchmarks/curated/ | grep -v 'scalebenchmarks' \
                              | sed 's/^/.\/benchmarks\/curated\//' | xargs ./run.sh

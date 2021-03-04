#!/usr/bin/env bash

pushd egs-artifact
  pushd prosynth/souffle
    ./bootstrap
    ./configure
    # make -j 8
    make
  popd
popd

#!/usr/bin/env bash

set -e

sbt assembly

export LOGNAME=`date +%s | sed 's/^/r/'`
echo "Echoing output in $LOGNAME.out and piping log messages to $LOGNAME.log"

# Change heap space limits with
# export JAVA_OPTS="-Xms16g -Xmx24g"

# Print GC statistics with
# export JAVA_OPTS="-XX:-PrintGC -XX:-PrintGCDetails"
# https://stackoverflow.com/a/466919

# Profile using VisualVM

scala ./target/scala-2.13/mustar-assembly-0.1.0-SNAPSHOT.jar "$@" 2> $LOGNAME.log | tee $LOGNAME.out
echo $?

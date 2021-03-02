#!/usr/bin/env bash

# set -e

sbt assembly
export JAR_NAME=./target/scala-2.13/egs-assembly-0.1.0-SNAPSHOT.jar

export LOG_DIR=`date +%s | sed 's/^/r/'`
echo "Placing output and log files in $LOG_DIR"
mkdir -p $LOG_DIR

for PROBLEM_DIR in "$@"; do
    echo `date` $PROBLEM_DIR
    export PROBLEM_NAME=`basename $PROBLEM_DIR`
    if [[ "$PROBLEM_NAME" != "scalebenchmarks" ]]; then
        timeout --foreground --kill-after=60 60 scala $JAR_NAME $PROBLEM_DIR \
                                                    > $LOG_DIR/$PROBLEM_NAME.out \
                                                   2> $LOG_DIR/$PROBLEM_NAME.log
        export RETURN_RESULT=$?
        if [[ $RETURN_RESULT != 0 ]]; then
            echo $RETURN_RESULT
        fi
    else
        echo "Skipping directory $PROBLEM_NAME"
    fi
done

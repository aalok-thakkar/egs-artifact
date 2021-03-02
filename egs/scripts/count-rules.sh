#!/usr/bin/env bash
for i in `find . -name 'rules.small.dl' | grep -v 'scalebenchmarks' | sort`; do
    j=`echo $i | sed 's/\/rules.small.dl//' | sed 's/^\.\///'`
    echo -e "$j\t`grep ':-' $i | wc -l`"
done

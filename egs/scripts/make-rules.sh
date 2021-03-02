#!/usr/bin/env bash

set -e

RULEGEN_EXEC=$HOME/Synthesis-Datalog/datalog-bench/rule-gen/generate-fast
SOUFFLE_EXEC=$HOME/Synthesis-Datalog/souffle/src/souffle

numDesired=100
chainLen=0

solnSize=`wc -l solution.txt | sed 's/ .*//'`
numRules=$solnSize
while [ $numRules -le $numDesired ]; do
    let chainLen=$chainLen+1
    echo $chainLen

    $RULEGEN_EXEC . $chainLen
    genRulesSize=`grep ':-' rules.dl | wc -l | sed 's/ .*//'`
    numRules=$(( $solnSize + $genRulesSize ))
done

(cat solution.txt; grep ':-' rules.dl | shuf) | head -n $numDesired | sed 's/, Rule(.*/\./' > tmp1.dl
shuf tmp1.dl | nl | sed 's/^ *//' | sed 's/  /\t/' > tmp2.dl
paste <(cut -f2 tmp2.dl) <(cut -f1 tmp2.dl) | sed 's/.\t/, Rule(/' | sed 's/$/)./' > tmp3.dl

grep -v ':-' rules.dl > rules.large.dl
cat tmp3.dl >> rules.large.dl
sed 's/.*, Rule(//' tmp3.dl | sed 's/)\.//' > ruleNames.large.txt

$SOUFFLE_EXEC rules.large.dl < /dev/null

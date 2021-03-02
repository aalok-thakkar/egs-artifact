#!/usr/bin/env bash

set -e
export RULES_T=$1

cat $RULES_T | sed 's/.*(//' | sed 's/)$//' | sed 's/,/\n/g' | sed 's/^ *//' | sort | uniq | sed 's/^/.type /'
echo

cat $RULES_T | sed 's/^*//' | sed 's/(/(_: /' | sed 's/, */, _: /g' | sed 's/^/.decl /'
echo

cat $RULES_T | grep '^\*' | sed 's/^*//' | sed 's/(.*)//' | sed 's/^/.input /'
echo

cat $RULES_T | grep -v '^\*' | sed 's/(.*)//' | sed 's/^/.output /'

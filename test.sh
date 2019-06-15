#!/bin/bash

for file in $1/*
do
F=`echo "$file" | sed 's/.*\///g'`
tr -d ".'-" < $file | tr -sc 'A-Za-z0-9' '\n' | tr A-Z a-z | sort | uniq -c | sort -n -r | head -n 100 > "./results/top100$F"
done

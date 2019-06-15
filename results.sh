#!/bin/bash

if [ -e "$1/other.txt" ] 
then
    mv "$1/other.txt" "$1/other.out"
fi
if [ -d "./sort" ]
then
    rm -rf "./sort"
fi
mkdir "./sort"

echo "creating freq.txt"

cat $1/*.txt > ./tokens.out
tr -cd 'A-Za-z0-9\n' < tokens.out | tr A-Z a-z | sort | uniq -c | sort -T="./sort" -n -r > frequency.txt

if [ -d "./results" ]
then
    rm -rf "./results"
fi
mkdir "./results"

echo "creating top and bottom lists"

cat frequency.txt | head -n 100 > ./results/top100.txt
cat frequency.txt | tail -n 100 > ./results/bottom100.txt
rm tokens.out
rm frequency.txt

echo "creating top lists for each file"

for file in $1/*
do
F=`echo "$file" | sed 's/.*\///g'`
tr -cd 'A-Za-z0-9\n' < $file | tr A-Z a-z | sort | uniq -c | sort -T="./sort" -n -r | head -n 100 > "./results/top100$F"
done

#rm -rf "./output"
#rm -rf "./sort"

#MISC
#tr -d ".'-" < tokens.out | tr -sc 'A-Za-z0-9' '\n' | tr A-Z a-z | sort -T=./sort | uniq -c | sort -n -r > frequency.txt
#tr -d ".'-" < $file | tr -sc 'A-Za-z0-9' '\n' | tr A-Z a-z | sort -T=./sort | uniq -c | sort -n -r | head -n 100 > "./results/top100$F"


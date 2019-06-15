#!/bin/bash

mv $1/other.txt $1/other.out

cat $1/*.txt > ./tokens.out

#tr -d ".'-" < tokens.out | tr -sc 'A-Za-z0-9' '\n' | tr A-Z a-z | sort | uniq -c | sort -n -r > frequency.txt
tr -cd 'A-Za-z0-9\n@' < tokens.out | tr -sc 'A-Za-z0-9' '\n' | tr A-Z a-z | sort | uniq -c | sort -n -r > frequency.txt

if [ -d "./results" ]
then
    rm -rf "./results"
fi
mkdir "./results"

cat frequency.txt | head -n 100 > ./results/top100.txt
cat frequency.txt | tail -n 100 > ./results/bottom100.txt

rm tokens.out
rm frequency.txt

for file in $1/*
do
F=`echo "$file" | sed 's/.*\///g'`
#tr -d ".'-" < $file | tr -sc 'A-Za-z0-9' '\n' | tr A-Z a-z | sort | uniq -c | sort -n -r | head -n 100 > "./results/top100$F"
tr -cd 'A-Za-z0-9\n@' < $file | tr -sc 'A-Za-z0-9' '\n' | tr A-Z a-z | sort | uniq -c | sort -n -r | head -n 100 > "./results/top100$F"
done

rm *.java
rm *.class
#rm -rf "./output"


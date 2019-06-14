#!/bin/bash 

set -e

javacc PS1Tokenizer.jj
javac ./*.java

if [ -d "./output" ]
then
    rm -rf "./output"
fi

# TEST ON RANDOM FILE #

if [ -d "./in" ]
then
    rm -rf "./in"
fi

mkdir "./in"

NAMES=$( ls /uafs/textmining/big | shuf -n 25 )

for n in $NAMES
do
    F=$( find /uafs/textmining/big -name $n)
    cp $F "./in"
done

time java UATokenizer "in" $2

#----------------------#

#time java UATokenizer $1 $2

cat $2/*.txt > ./tokens.out

tr -sc 'A-Za-z0-9' '\n' < tokens.out | tr A-Z a-z | sort | uniq -c | sort -n -r > frequency.txt

cat frequency.txt | head -n 100 > top100.txt
cat frequency.txt | tail -n 100 > bottom100.txt

for file in $2/*
do
F=`echo "$file" | sed 's/.*\///g'`
tr -sc 'A-Za-z0-9' '\n' < $file | tr A-Z a-z | sort | uniq -c | sort -n -r | head -n 100 > "top100$F"
done

rm *.java
rm *.class
rm -rf "./output"
rm tokens.out

#!/bin/bash 

set -e

javacc PS1Tokenizer.jj
javac ./*.java

if [ -d "./output" ]
then
    rm -rf "./output"
fi

# TEST ON RANDOM FILE #

if [ "${#@}" -gt "2" ]
then

    if [ -d "./in" ]
    then
        rm -rf "./in"
    fi

    mkdir "./in"

    NAMES=$( ls /uafs/textmining/big | shuf -n $3 )

    for n in $NAMES
    do
        F=$( find /uafs/textmining/big -name $n)
        cp $F "./in"
    done

    time java UATokenizer "in" $2

else
    time java UATokenizer $1 $2

fi

#----------------------#

cat $2/*.txt > ./tokens.out

tr -sc 'A-Za-z0-9' '\n' < tokens.out | tr A-Z a-z | sort | uniq -c | sort -n -r > frequency.txt

if [ -d "./results" ]
then
    rm -rf "./results"
fi

mkdir "./results"

cat frequency.txt | head -n 100 > ./results/top100.txt
cat frequency.txt | tail -n 100 > ./results/bottom100.txt

for file in $2/*
do
F=`echo "$file" | sed 's/.*\///g'`
tr -sc 'A-Za-z0-9' '\n' < $file | tr A-Z a-z | sort | uniq -c | sort -n -r | head -n 100 > "./results/top100$F"
done

rm *.java
rm *.class
rm -rf "./output"
rm tokens.out

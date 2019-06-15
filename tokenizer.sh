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

    #/uafs/textmining/big
    NAMES=$( ls $1 | shuf -n $3 )

    for n in $NAMES
    do
        F=$( find $1 -name $n)
        cp $F "./in"
    done

    time java UATokenizer "in" $2

else
    time java UATokenizer $1 $2

fi

#----------------------#

cat $2/*.txt > ./tokens.out

#tr -d ".'-" < tokens.out | tr -sc 'A-Za-z0-9' '\n' | tr A-Z a-z | sort | uniq -c | sort -n -r > frequency.txt
tr -cd 'A-Za-z0-9\n@' < tokens.out | tr -sc 'A-Za-z0-9' '\n' | tr A-Z a-z | sort | uniq -c | sort -n -r > frequency.txt

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
#tr -d ".'-" < $file | tr -sc 'A-Za-z0-9' '\n' | tr A-Z a-z | sort | uniq -c | sort -n -r | head -n 100 > "./results/top100$F"
tr -cd 'A-Za-z0-9\n@' < $file | tr -sc 'A-Za-z0-9' '\n' | tr A-Z a-z | sort | uniq -c | sort -n -r | head -n 100 > "./results/top100$F"
done

rm *.java
rm *.class
#rm -rf "./output"
#rm tokens.out

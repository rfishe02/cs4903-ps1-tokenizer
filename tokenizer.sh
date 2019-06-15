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


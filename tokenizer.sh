#!/bin/bash 

set -e

javacc PS1Tokenizer.jj
javac ./*.java

if [ -d "./output" ]
then
    rm -rf "./output"
fi

if [ -d "./in" ]
then
    rm -rf "./in"
fi
mkdir "./in"

# TEST ON RANDOM SUBSET, RANDOM FILES, OR WHOLE DIRECTORY #
# <INPUT DIR> <OUTPUT DIR> <NUM FILES> <REGEX>

if [ "${#@}" -gt "3" ] 
then 

    FILES=$( grep -lE $4 "$1/"* | shuf -n $3  )
        
    for f in $FILES
    do
        cp $f "./in"
    done
        
    time java UATokenizer "./in" $2

elif [ "${#@}" -gt "2" ]
then

    NAMES=$( ls $1 | shuf -n $3 )

    for n in $NAMES
    do
        F=$( find $1 -name $n)
        cp $F "./in"
    done

    time java UATokenizer "./in" $2

else
    time java UATokenizer $1 $2
fi

SIZE=$( ls $1 | wc -l )

#rm *.java
#rm *.class


#!/bin/bash

# input.sh <IN DIRECTORY> <NUM FILES> <OPTIONAL REGEX>

IN=$1
OUT="./input"
K=$2

SIZE=$( ls $IN | wc -l )

if [ $K -lt $SIZE ] 
then
    
    if [ -d $OUT ]
    then
        rm -rf "$OUT/"*
    else 
        mkdir $OUT
    fi
    
    echo "collecting random files from $IN"
    
    if [ "${#@}" -gt "2" ]
    then 
    
        REGEX=$3
    
        FILES=$( grep -lE $REGEX "$IN/"* | shuf -n $K )
        
        for f in $FILES
        do
            cp $f $OUT
        done

    else 
        NAMES=$( ls $IN | shuf -n $K )

        for n in $NAMES
        do
            F=$( find $IN -name $n)
            cp $F $OUT
        done
    fi
    
    echo "copied $K files to $OUT"

else
    echo "FEWER IN FILES IN DIRECTORY THAN EXPECTED"
fi

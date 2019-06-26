
#!/bin/bash 

# sample.sh <OUT FILES> <NUM SAMPLES>

IN=$1
OUT="./sample"
K=$2
EXT=".txt"

if [ "${#@}" -gt "1" ]
then

    if [ -d $OUT ]
    then
        rm -rf "$OUT/"*
    else 
        mkdir $OUT
    fi

    echo "sampling each $EXT file in $IN"

    for file in "$IN/"*"$EXT"
    do
        F=`echo "$file" | sed 's/.*\///g'`
        cat $file | shuf -n $K > "$OUT/$F"
    done
    
    echo "wrote $K samples to $OUT"
else 
    echo "NO DIRECTORY GIVEN AND QUANTITY GIVEN"
fi

#!/bin/bash

if [ "${#@}" -gt "0" ]
then

    # CREATE NECESSARY DIRECTORIES
    
    R="./results"
    S="./sort"
    
    if [ -d $R ]
    then
        rm -rf $R
    fi
    
    if [ -d $S ]
    then
        rm -rf $S
    fi
   
    mkdir $R
    mkdir $S

    # SORT & CREATE TOP & BOTTOM 100 LISTS
    
    echo "combining output files"

    cat $1/*.out > ./tokens.out
    tr -cd 'A-Za-z0-9\n' < tokens.out | tr -sc 'A-Za-z0-9' '\n' | tr A-Z a-z | sort -T $S | uniq -c | sort -T $S -n -r > frequency.txt

    echo "creating top and bottom lists for all"

    cat frequency.txt | head -n 150 > ./results/top.txt
    cat frequency.txt | tail -n 150 > ./results/bottom.txt
    
    rm tokens.out
    rm frequency.txt

    # SORT & CREATE TOP LISTS FOR EACH FILE

    echo "creating top lists for each file"

    for file in $1/*.txt
    do
        F=`echo "$file" | sed 's/.*\///g'`
        tr -cd 'A-Za-z0-9\n' < $file | tr -sc 'A-Za-z0-9' '\n' | tr A-Z a-z | sort -T $S | uniq -c | sort -T $S -n -r | head -n 150 > "$R/top$F"
    done

    rm -rf $S

    echo "done"
    
fi

#MISC
#tr -d ".'-" < tokens.out | tr -sc 'A-Za-z0-9' '\n' | tr A-Z a-z | sort -T "./sort" | uniq -c | sort -T "./sort" -n -r > frequency.txt
#tr -d ".'-" < $file | tr -sc 'A-Za-z0-9' '\n' | tr A-Z a-z | sort -T=./sort | uniq -c | sort -T "./sort" -n -r | head -n 100 > "./results/top100$F"



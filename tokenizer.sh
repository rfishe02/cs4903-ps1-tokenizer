#!/bin/bash 

set -e

javacc PS1Tokenizer.jj
javac ./*.java

time java UATokenizer $1 $2

cat $2/*.out > ./tokens.out

tr -sc 'A-Za-z0-9' '\n' < tokens.out | tr A-Z a-z | sort | uniq -c | sort -n -r > frequency.txt

rm -rf *.java
rm -rf *.class

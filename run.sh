#!/bin/bash 

set -e

javacc PS1Tokenizer.jj
javac ./*.java

time java UATokenizer $1 $2

cat $2/*.out > ./output.txt

tr -sc 'A-Za-z0-9' '\n' < output.txt | tr A-Z a-z | sort | uniq -c | sort -n -r > final.txt

rm -rf *.java
rm -rf *.class

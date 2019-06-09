#!/bin/bash 

set -e

javacc PS1Tokenizer.jj
javac ./*.java

time UATokenizer input output

cat $2/*.out > ./output

tr -sc 'A-Za-z0-9' '\n' < output.txt | tr A-Z a-z | sort | uniq -c | sort -n -r > final.txt

rm -rf *.java
rm -rf *.class

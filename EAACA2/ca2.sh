#!/bin/bash

echo -e "IDLE \t\t N \t\t CO" >> results.dat

for i in {1..40}
do
    ./loadtest $i &
    idle=$(mpstat 1 10 | awk 'END{print $NF}')
    pkill loadtest
    echo -e $idle "\t\t" $i "\t\t" $(wc -l synthetic.dat | awk '{print $1}') >> results.dat
done

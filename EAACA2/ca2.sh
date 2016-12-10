#!/bin/bash

echo -e "IDLE \t\t N \t\t CO" >> results.dat

for i in {1..50}
do
    ./loadtest $i &
    idle=$(mpstat 1 6 | awk 'NR==10{print $12}')
    pkill loadtest
    echo -e $idle "\t\t" $i "\t\t" $(wc -l synthetic.dat | awk '{print $1}') >> results.dat
done

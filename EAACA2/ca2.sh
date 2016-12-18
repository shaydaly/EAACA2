#!/bin/bash
#this is the header in the file, identifyin the collumns, -e is used to allow the user of the \t
echo -e "IDLE \t\t N \t\t CO" >> results.dat

#for iterate to iterate though simulating number of users, from 1 to 40
for i in {1..40}
do
	#run the load test, with the number of users passed in using i
    ./loadtest $i &
	#runs mpstat 8 times in 1 second intervals, then uses AWK to retrieve the final line which is the average.
    idle=$(mpstat 1 8 | awk 'END{print $NF}')
	#pkill is used to kill the load test
    pkill loadtest
	# this appends the idle variable, i which is the number of users, and the completed transactions from synthetic.dat file using awk into the file results.dat
    echo -e $idle "\t\t" $i "\t\t" $(wc -l synthetic.dat | awk '{print $1}') >> results.dat
done

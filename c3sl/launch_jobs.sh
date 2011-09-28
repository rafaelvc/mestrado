#!/bin/bash

DIR=$1
for i in $(echo "$DIR"{1..5})
do
	cd $i
	nohup ./experiments.sh </dev/null &
	cd - 
done

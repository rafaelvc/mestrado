#!/bin/bash

DIR=$1
for i in $(echo "$DIR"{1..8})
do
	cd $i
	nohup ./experiments.sh </dev/null &
	cd - 
done

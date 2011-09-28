#!/bin/bash

DIR=$1
EXP_GPPARAM=$2 
EXP_OUTDIR=$3

for i in $(echo "$PWD/e/$DIR"{1..4})
do
	cd $i
	nohup ./experiments.sh $EXP_GPPARAM $EXP_OUTDIR </dev/null &
	cd - 
done

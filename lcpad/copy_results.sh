#!/bin/bash 

ORIG=$1
DEST=$2
SUBDIR=$3 

run=1 
for r in $( ls -d "$ORIG"{1..15}/$SUBDIR/results.{1..2} 2> /dev/null )
do 
	echo cp -pr $r "$DEST"/results."$run"
	cp -pr $r "$DEST"/results."$run"
	run=$(( $run + 1 ))
done 


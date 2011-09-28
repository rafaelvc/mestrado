#!/bin/bash

for run in $(seq 1 2)
do	
	mkdir -p results.$run/
	#folds
	for i in 1
	do
		[ -s results.$run/result_fold_${i}.txt ] && continue;
		make clean
		rm -f beagle.obm.gz beagle.log result_fold.txt
		re=`echo "s/^\(.*f.open.*\)[0-9].*$/\1${i}\");/g"`
		sed -i $re SymbRegMain.cpp
		sed -i $re SymbRegEvalOp.cpp
		make
		./symbreg -OBec.conf.file=mymaxfct.conf
		mv -f beagle.obm.gz results.$run/beagle_${i}.obm.gz
		mv -f beagle.log results.$run/beagle_${i}.log
		mv -f result_fold.txt results.$run/result_fold_${i}.txt
	done
	if ! [ -e results.$run/beagle.log.tar.bz2 ]; then 
		tar -cjvf results.$run/beagle.log.tar.bz2 results.$run/beagle_*.log 
		rm -f results.$run/beagle_*.log 
	fi
done

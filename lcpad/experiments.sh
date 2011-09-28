#!/bin/bash

GP_PARAMS=$1
OUT_DIR=$2

eval `ssh-agent` > /dev/null
ssh-add ~/.ssh/id_rsa_lcpad_experiments 2>/dev/null
for run in $(seq 1 2)
do	
	mkdir -p results.$run/
	#folds
	for i in 1 2 3 4 5
	do
		[ -s results.$run/result_fold_${i}.txt ] && continue;
		rm -f beagle.obm.gz beagle.log result_fold.txt
		re=`echo "s/^\(.*f.open.*\)[0-9].*$/\1${i}\");/g"`
		sed -i $re SymbRegMain.cpp
		sed -i $re SymbRegEvalOp.cpp
		ssh lcpad -x `pwd`/rebuild.sh `pwd`
		nice -n 19 ./symbreg_bin -OBec.conf.file=mymaxfct.conf,"$GP_PARAMS" 
		mv -f beagle.obm.gz results.$run/beagle_${i}.obm.gz
		mv -f beagle.log results.$run/beagle_${i}.log
		mv -f result_fold.txt results.$run/result_fold_${i}.txt
	done
	tar -cjvf results.$run/beagle.log.tar.bz2 results.$run/beagle_*.log 
	rm -f results.$run/beagle_*.log 
done
mkdir $OUT_DIR 
mv results.* $OUT_DIR/
ssh-agent -k > /dev/null

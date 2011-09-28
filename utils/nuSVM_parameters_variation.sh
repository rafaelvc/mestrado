#!/bin/bash

BASE=$1
OUTLIERSF=$2
NRFEATURES=$3

for i in 0.001 0.01 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9
do
    evalstr="sed -i 's/-N 0.[0-9]\+/-N $i/g' process_weka_results.sh"
    eval $evalstr
    for j in 0.001 0.01 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9
    do
        rm -rf 10_bases_out/
        ./genBasesRNSFolds.sh $BASE $OUTLIERSF 
        evalstr="sed -i 's/-G 0.[0-9]\+/-G $j/g' process_weka_results.sh"
        eval $evalstr
        ./process_weka_results.sh 10_bases_out $BASE $NRFEATURES T,O 2/
        echo "-N $i -G $j"
        python process_out_weka.py 2/out_nuSVM.*-1
    done
done 

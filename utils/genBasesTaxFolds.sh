#!/bin/bash

BASE=$1
OUTLIERF=$2 

# for i in 1 2 3 4 5
for i in 1 
do 
./prepare_db_Andras_experiments2.sh Analise_TAX/${BASE}/ $OUTLIERF Analise_TAX/${BASE}/ targets_fold${i}.data Analise_TAX/${BASE}/ outliers_fold${i}_test.data Analise_TAX/${BASE}/ targets_fold${i}_test.data $i
done 


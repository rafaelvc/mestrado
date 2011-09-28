#!/bin/bash

BASE=$1
OUTLIERF=$2 

for i in 1 2 3 4 5
do 
./prepare_db_Andras_experiments2.sh Analise_Andras/${BASE}classes/ $OUTLIERF Analise_Andras/${BASE}classes/ targets_fold${i}.data Analise_Andras/${BASE}classes/ outliers_fold${i}_test.data Analise_Andras/${BASE}classes/ targets_fold${i}_test.data $i
done 


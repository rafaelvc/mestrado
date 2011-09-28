#!/bin/bash

BASE=$1
OUTLIERF=$2 

./prepare_db_AUC_experiments.sh Analise_AUC/$BASE/ $OUTLIERF Analise_AUC/$BASE/ targets_fold1.data Analise_AUC/$BASE/ outliers_fold1_test.data


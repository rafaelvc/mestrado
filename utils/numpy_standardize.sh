#!/bin/bash

cp $1 $1.bkp
python standardize_numpy.py $1
sed -i "s/^\(.\)/$2,\1/"  $1.std_np 
mv $1.std_np $1 

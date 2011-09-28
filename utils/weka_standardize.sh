#!/bin/sh

WEKA_HOME=/media/SAMSUNG/rafael_notebook/rafael/Desktop/Mestrado_stuff/weka-3-6-1
#weka format
./change_to_arff.py teste $2 $3 $1
#standardize in the weka format (arff)
java -Xmx1024m -cp .:$WEKA_HOME/weka.jar weka.filters.unsupervised.attribute.Standardize -i $1.arff -o $1_std.arff
#back to the original format
sed -i '/\@relation.*$/        d 
         /^$/                  d 
         /\@attribute.*$/      d 
         /^$/                  d 
         /\@data.*$/           d
	 s/^\(.*\),\(.\)$/\2,\1/ '  $1_std.arff
cp $1 $1.bkp_std
mv $1_std.arff $1

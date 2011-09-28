# junta_outliers_target outlier target_file 

UTILS_DIR=/home/rafael/Desktop/Mestrado/3/utils/

cp $1 $1".new"
cat $2 >> $1".new" 
python ${UTILS_DIR}embaralha.py $1".new" $1".new.fuzzy"
echo python ${UTILS_DIR}embaralha.py $1".new" $1".new.fuzzy"
mv  $1".new.fuzzy" $1".fuzzy"


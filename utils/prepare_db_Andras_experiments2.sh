
DIR_DB_OUTLIERS=$1
DB_OUTLIERS=$2
DIR_DB_TARGETS=$3
DB_TARGETS=$4
DIR_DB_CLASSB=$5
DB_CLASSB=$6
DIR_DB_TARGETS_TEST=$7
DB_TARGETS_TEST=$8
FOLD=$9


# 0 - Prepara diretorio de trabalho
mkdir -p 10_bases_out
cp $DIR_DB_OUTLIERS/$DB_OUTLIERS 10_bases_out/
cp $DIR_DB_TARGETS/$DB_TARGETS 10_bases_out/
cp $DIR_DB_TARGETS_TEST/$DB_TARGETS_TEST 10_bases_out/
cp $DIR_DB_CLASSB/$DB_CLASSB 10_bases_out/ 

# Fix TARGETS
./preprocess_matlab.sh 10_bases_out/$DB_TARGETS
python matlab_to_pginput.py 10_bases_out/$DB_TARGETS".new" 
sed 's/^\(.\)/T,\1/g' 10_bases_out/$DB_TARGETS".new.fixed" >  10_bases_out/$DB_TARGETS
rm -f 10_bases_out/$DB_TARGETS".new"  10_bases_out/$DB_TARGETS".new.fixed"

# Fix TARGETS_TEST
./preprocess_matlab.sh 10_bases_out/$DB_TARGETS_TEST
python matlab_to_pginput.py 10_bases_out/$DB_TARGETS_TEST".new" 
sed 's/^\(.\)/T,\1/g' 10_bases_out/$DB_TARGETS_TEST".new.fixed" >  10_bases_out/$DB_TARGETS_TEST
rm -f 10_bases_out/$DB_TARGETS_TEST".new"  10_bases_out/$DB_TARGETS_TEST".new.fixed"

# Fix TEST OUTLIERS 
./preprocess_matlab.sh 10_bases_out/$DB_CLASSB
python matlab_to_pginput.py 10_bases_out/$DB_CLASSB".new" 
sed 's/^\(.\)/O,\1/g' 10_bases_out/$DB_CLASSB".new.fixed" >  10_bases_out/$DB_CLASSB
rm -f 10_bases_out/$DB_CLASSB".new"  10_bases_out/$DB_CLASSB".new.fixed"

# Fix TRAIN OUTLIERS
./preprocess_matlab.sh 10_bases_out/$DB_OUTLIERS
python matlab_to_pginput.py 10_bases_out/$DB_OUTLIERS".new" 
sed 's/^\(.\)/O,\1/g' 10_bases_out/$DB_OUTLIERS".new.fixed" >  10_bases_out/$DB_OUTLIERS
rm -f 10_bases_out/$DB_OUTLIERS".new"  10_bases_out/$DB_OUTLIERS".new.fixed"

#  2 - Adiciona outliers gerados artificialmente na base dos 
# targets, embaralha e faz o split da base para cross-fold validation  
mv 10_bases_out/$DB_TARGETS 10_bases_out/data.treino$FOLD
cat 10_bases_out/$DB_OUTLIERS >> 10_bases_out/data.treino$FOLD
mv 10_bases_out/$DB_TARGETS_TEST 10_bases_out/data.teste$FOLD
cat 10_bases_out/$DB_CLASSB >> 10_bases_out/data.teste$FOLD 

rm -f 10_bases_out/$DB_OUTLIERS 10_bases_out/$DB_CLASSB 



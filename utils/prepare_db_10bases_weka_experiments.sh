
DIR_MATLAB=$1
DB_OUTLIERS=$2
DIR_DB_TARGETS=$3
DB_TARGETS=$4
DIR_DB_CLASSB=$5
DB_CLASSB=$6
TARGET=$7

# 0 - Prepara diretorio de trabalho

mkdir -p 10_bases_out
cp $DIR_MATLAB/$DB_OUTLIERS 10_bases_out/
cp $DIR_DB_TARGETS/$DB_TARGETS 10_bases_out/

# 1 - Pega saida do matlab e tranforma em entrada para 
# o script de preprocessamento (converte 1.0e+001 em 10.0)
# e adciona indicação de outlier (O).

./preprocess_matlab.sh 10_bases_out/$DB_OUTLIERS
python matlab_to_pginput.py 10_bases_out/$DB_OUTLIERS".new" 
./postprocess_matlab.sh 10_bases_out/$DB_OUTLIERS".new.fixed"
mv -f 10_bases_out/$DB_OUTLIERS".new.fixed.new" 10_bases_out/$DB_OUTLIERS
rm -f 10_bases_out/$DB_OUTLIERS".new" 
rm -f 10_bases_out/$DB_OUTLIERS".new.fixed" 

# 2 - Adiciona outliers gerados artificialmente na base dos 
# targets, embaralha e faz o split da base para cross-fold validation  

cp 10_bases_out/$DB_TARGETS 10_bases_out/$DB_TARGETS".teste" 
cat $DIR_DB_CLASSB/$DB_CLASSB >> 10_bases_out/$DB_TARGETS".teste" 
python embaralha.py 10_bases_out/$DB_TARGETS".teste" 10_bases_out/$DB_TARGETS".teste.fuzzy"

cat 10_bases_out/$DB_OUTLIERS >> 10_bases_out/$DB_TARGETS
python embaralha.py 10_bases_out/$DB_TARGETS 10_bases_out/$DB_TARGETS".fuzzy"

exit 1;


python split_db_to_cross_validation.py 10_bases_out/$DB_TARGETS".fuzzy" $TARGET

# 3 - Acrescenta classe B nas bases de teste e embaralha
for i in 1 2 3 4 5; do
	cat $DIR_DB_CLASSB/$DB_CLASSB >> 10_bases_out/$DB_TARGETS".fuzzy.teste$i"
	python embaralha.py 10_bases_out/$DB_TARGETS".fuzzy.teste$i" 10_bases_out/$DB_TARGETS".teste$i"
	rm -f 10_bases_out/$DB_TARGETS".fuzzy.teste$i" 
	# renomeia arquivos de treino
	mv -f 10_bases_out/$DB_TARGETS".fuzzy.treino$i" 10_bases_out/$DB_TARGETS".treino$i" 
done 


# ./prepare_db_10bases_experiments.sh /media/SAMSUNG/10Bases/Pima_Indians/pimas-indians-n-outliers/ pimas-indians-n_box_50.data /media/SAMSUNG/10Bases/Pima_Indians/ pima-indians-diabetes.n.data.picked  /media/SAMSUNG/10Bases/Pima_Indians/ pima-indians-diabetes.p.data





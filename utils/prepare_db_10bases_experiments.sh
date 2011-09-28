
DIR_ARTIFICIAL_OUTLIERS=$1
DB_OUTLIERS=$2
DIR_DB_TARGETS=$3
DB_TARGETS=$4
DIR_DB_CLASSB=$5
DB_CLASSB=$6
TARGET=$7

# 0 - Prepara diretorio de trabalho
mkdir -p 10_bases_out
cp $DIR_ARTIFICIAL_OUTLIERS/$DB_OUTLIERS 10_bases_out/
cp $DIR_DB_TARGETS/$DB_TARGETS 10_bases_out/
cp $DIR_DB_CLASSB/$DB_CLASSB 10_bases_out/ 

# 1 - Pega saida do matlab e tranforma em entrada para 
# o script de preprocessamento (converte 1.0e+001 em 10.0)
# e adciona indicação de outlier (O).
./preprocess_matlab.sh 10_bases_out/$DB_OUTLIERS
python matlab_to_pginput.py 10_bases_out/$DB_OUTLIERS".new" 
./postprocess_matlab.sh 10_bases_out/$DB_OUTLIERS".new.fixed"
mv -f 10_bases_out/$DB_OUTLIERS".new.fixed.new" 10_bases_out/$DB_OUTLIERS
rm -f 10_bases_out/$DB_OUTLIERS".new" 
rm -f 10_bases_out/$DB_OUTLIERS".new.fixed" 

#  2 - Adiciona outliers gerados artificialmente na base dos 
# targets, embaralha e faz o split da base para cross-fold validation  
cat 10_bases_out/$DB_OUTLIERS >> 10_bases_out/$DB_TARGETS
# python embaralha.py 10_bases_out/$DB_TARGETS 10_bases_out/$DB_TARGETS".fuzzy"
python split_db_to_cross_validation.py 10_bases_out/$DB_TARGETS $TARGET

exit 

# Calcula os 20% de exemplos B para cada teste fold
nr_samplesB=`cat 10_bases_out/$DB_CLASSB | wc -l`
nr_samples=`perl -e "printf int($nr_samplesB*0.2)"` 

sed -i 's/^./O/' 10_bases_out/$DB_CLASSB

# 3 - Acrescenta classe B nas bases de teste e embaralha
for i in 1 2 3 4 5; do
	
	end_point=`cat 10_bases_out/$DB_CLASSB | wc -l`
	python pick-up-samples.py $nr_samples $end_point 10_bases_out/$DB_CLASSB --with-split --file 
	cat 10_bases_out/$DB_CLASSB.picked >> 10_bases_out/$DB_TARGETS".fuzzy.teste$i"
	python embaralha.py 10_bases_out/$DB_TARGETS".fuzzy.teste$i" 10_bases_out/$DB_TARGETS".teste$i"
	rm -f 10_bases_out/$DB_TARGETS".fuzzy.teste$i" 
	rm -f 10_bases_out/$DB_CLASSB.picked
        mv 10_bases_out/$DB_CLASSB.without.picked 10_bases_out/$DB_CLASSB
	# renomeia arquivos de treino
	mv -f 10_bases_out/$DB_TARGETS".fuzzy.treino$i" 10_bases_out/$DB_TARGETS".treino$i"

done 

#clean up 
rm -f 10_bases_out/$DB_OUTLIERS 10_bases_out/$DB_TARGETS 10_bases_out/$DB_TARGETS".fuzzy" 10_bases_out/$DB_CLASSB

# pimas 
# mkdir -p experiment2/{breast,ionosphere,iris,letter-a,letter-vowell,pimas
# mkdir -p experiment2/pimas/{box-100,box-50,box-200,gauss-100,gauss-200,gauss-50,hyph-100,hyph-200,hyph-50}
# ./prepare_db_10bases_experiments.sh /media/SAMSUNG/10Bases/Pima_Indians/pimas-indians-n-outliers/ pimas-indians-n_box_50.data /media/SAMSUNG/10Bases/Pima_Indians/ pima-indians-diabetes.n.data /media/SAMSUNG/10Bases/Pima_Indians/ pima-indians-diabetes.p.data N

# breast 
# mkdir -p experiment2/breast/{box-100,box-50,box-200,gauss-100,gauss-200,gauss-50,hyph-100,hyph-200,hyph-50}
# ./prepare_db_10bases_experiments.sh /media/SAMSUNG/10Bases/Breast-cancer-wisconsin/breast-outliers-B/ breast-B_box_50.data /media/SAMSUNG/10Bases/Breast-cancer-wisconsin/ wdbc_B.data /media/SAMSUNG/10Bases/Breast-cancer-wisconsin/ wdbc_M.data B

# ionos
# mkdir -p experiment2/ionosphere/{box-100,box-50,box-200,gauss-100,gauss-200,gauss-50,hyph-100,hyph-200,hyph-50}
# ./prepare_db_10bases_experiments.sh /media/SAMSUNG/10Bases/Ionosphere/ionosphere-outliers-g/ ionosphere-g_box_50.data /media/SAMSUNG/10Bases/Ionosphere/ ionosphere.g.data /media/SAMSUNG/10Bases/Ionosphere/ ionosphere.b.data wdbc_M.data G

#letter A
# mkdir -p experiment2/letter-a/{box-100,box-50,box-200,gauss-100,gauss-200,gauss-50,hyph-100,hyph-200,hyph-50}
# ./prepare_db_10bases_experiments.sh /media/SAMSUNG/10Bases/Letter/letter-a-outliers/ letter-a_box_50.data /media/SAMSUNG/10Bases/Letter/ letter-a.data /media/SAMSUNG/10Bases/Letter/ letter-non-a.data.picked A

#iris 
# mkdir -p experiment2/iris/{box-100,box-50,box-200,gauss-100,gauss-200,gauss-50,hyph-100,hyph-200,hyph-50}
#./prepare_db_10bases_experiments.sh /media/SAMSUNG/10Bases/Iris/iris-outliers-versicolor iris-versicolor_gauss_200.data /media/SAMSUNG/10Bases/Iris iris.versicolor.dat /media/SAMSUNG/10Bases/Iris iris.B.data.fuzzy V


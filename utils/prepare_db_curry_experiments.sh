# Nos experimentos do Curry 2009 foi convencionado que 
# 75% dos individuos do target sao usados no treino e 
# 25% no teste. Esta separacao foi feita manualmente. 

# Exemplo de composicao de bases de treino e teste: 

# Classe Target 100 exemplos
# Classe Outliers artificiais 100 exemplos (andras)
# Classe B 300 exemplos (exemplos das demais classes do banco de dados)

# Base de Treino = (75 exemplos Target) + (100 exemplos outliers artificais)
# Base de Teste  = (25 exemplos Target) + (300 exemplos classe B) 

DIR_ARTIFICIAL_OUTLIERS=$1
DB_OUTLIERS=$2
DIR_DB_TARGETS=$3
DB_TARGETS=$4
DB_TARGETS_TEST=$5
DIR_DB_CLASSB=$6
DB_CLASSB=$7

# 0 - Prepara diretorio de trabalho
mkdir -p curry_out
cp $DIR_ARTIFICIAL_OUTLIERS/$DB_OUTLIERS curry_out/
cp $DIR_DB_TARGETS/$DB_TARGETS curry_out/
cp $DIR_DB_TARGETS/$DB_TARGETS_TEST curry_out/
cp $DIR_DB_CLASSB/$DB_CLASSB curry_out/ 

# 1 - Pega saida do matlab e tranforma em entrada para 
# o script de preprocessamento (converte 1.0e+001 em 10.0)
# e adciona indicação de outlier (O).
./preprocess_matlab.sh curry_out/$DB_OUTLIERS
python matlab_to_pginput.py curry_out/$DB_OUTLIERS".new" 
./postprocess_matlab.sh curry_out/$DB_OUTLIERS".new.fixed"
mv -f curry_out/$DB_OUTLIERS".new.fixed.new" curry_out/$DB_OUTLIERS
rm -f curry_out/$DB_OUTLIERS".new" 
rm -f curry_out/$DB_OUTLIERS".new.fixed" 

# 2 - Adiciona outliers gerados artificialmente na base dos targets e embaralha (base de treino) 
cat curry_out/$DB_OUTLIERS >> curry_out/$DB_TARGETS
python embaralha.py curry_out/$DB_TARGETS curry_out/$DB_TARGETS".treino"
# mv curry_out/$DB_TARGETS".fuzzy" curry_out/$DB_TARGETS".treino"

# 3 - Monta base de teste
sed -i 's/^./O/' curry_out/$DB_CLASSB
cat curry_out/$DB_CLASSB >> curry_out/$DB_TARGETS_TEST
python embaralha.py curry_out/$DB_TARGETS_TEST curry_out/$DB_TARGETS_TEST".teste"
# mv curry_out/$DB_TARGETS_TEST".fuzzy" curry_out/$DB_TARGETS".teste"

#clean up 
rm -f curry_out/$DB_OUTLIERS curry_out/$DB_TARGETS curry_out/$DB_TARGETS_TEST curry_out/$DB_CLASSB

# letter-a
# ./prepare_db_curry_experiments.sh /media/SAMSUNG/gecco2011/ outliers_lettera.data /home/rafael/note/Desktop/Mestrado/2/pg/uci_bases/letter/curry/letter-a/ letter-a.data.without.picked letter-a.data.picked /home/rafael/note/Desktop/Mestrado/2/pg/uci_bases/letter/curry/letter-a/ letter-non-a.data.picked 

# letter-e
#./prepare_db_curry_experiments.sh /media/SAMSUNG/gecco2011/ outliers_lettere.data /home/rafael/note/Desktop/Mestrado/2/pg/uci_bases/letter/curry/letter-e/ letter-e.data.without.picked letter-e.data.picked /home/rafael/note/Desktop/Mestrado/2/pg/uci_bases/letter/curry/letter-e/ letter-non-e.data.picked

# letter-vowell 
# ./prepare_db_curry_experiments.sh /media/SAMSUNG/gecco2011/ outliers_lettere.data /home/rafael/note/Desktop/Mestrado/2/pg/uci_bases/letter/curry/letter-e/ letter-e.data.without.picked letter-e.data.picked /home/rafael/note/Desktop/Mestrado/2/pg/uci_bases/letter/curry/letter-e/ letter-non-e.data.picked

#adult
# ./prepare_db_curry_experiments.sh /media/SAMSUNG/gecco2011/ outliers_adults.data /media/SAMSUNG/rafael_notebook/rafael/Desktop/Mestrado/2/pg/uci_bases/adult/ adultG50K.data.fixed.binary adultG50K.data.test.fixed.binary /media/SAMSUNG/rafael_notebook/rafael/Desktop/Mestrado/2/pg/uci_bases/adult/ adultL50K.data.test.fixed.binary

#census
# ./prepare_db_curry_experiments.sh /home/rafael/ outliers_census_k100.data /media/SAMSUNG/rafael_notebook/rafael/Desktop/Mestrado/2/pg/uci_bases/census_income_kdd/ census-income50Kplus.data.fixed.binary census-income50Kplus.data.test.fixed.binary /media/SAMSUNG/rafael_notebook/rafael/Desktop/Mestrado/2/pg/uci_bases/census_income_kdd/ census-income50K.data.test.fixed.binary

#mushroom
# ./prepare_db_curry_experiments.sh /home/rafael/ outliers_mushroom.data /media/SAMSUNG/rafael_notebook/rafael/Desktop/Mestrado/2/pg/uci_bases/mushroom/ agaricus-lepiotaP.data.binary.without.picked agaricus-lepiotaP.data.binary.picked /media/SAMSUNG/rafael_notebook/rafael/Desktop/Mestrado/2/pg/uci_bases/mushroom/ agaricus-lepiotaE.data.binary.picked


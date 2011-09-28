
DB_DIR=$1
DB_NAME=$2 
ATTRS=$3
CLASSES=$4
OUT_DIR=$5

WEKA_HOME=/media/SAMSUNG/rafael_notebook/rafael/Desktop/Mestrado_stuff/weka-3-6-1

# Change to arff format that is suitable for weka 
for f_treino in $DB_DIR/*treino*
do
./change_to_arff.py $DB_NAME $ATTRS $CLASSES $f_treino
f_treinos=( "${f_treinos[@]}" "${f_treino}.arff" )
done 

for f_teste in $DB_DIR/*teste*
do
./change_to_arff.py $DB_NAME $ATTRS $CLASSES $f_teste 
f_testes=( "${f_testes[@]}" "${f_teste}.arff" )
done 
echo Changing to arff phase completed.
mkdir -p $OUT_DIR
# Generate the weka ouput 
# -Xmx1024 makes more room for the heap usage 1GB
for run in $(seq 1) 
do
	i=0
	for f_treino in ${f_treinos[@]}
	do 
		 # nu-SVM com kernel RBF e parametros default libsvm
         # echo $f_treino ${f_testes[$i]}
         java -Xmx1024m -cp .:$WEKA_HOME/weka.jar:$WEKA_HOME/libsvm.jar weka.classifiers.functions.LibSVM -S 1 -K 2 -t $f_treino -T ${f_testes[$i]} -i -o -v > $OUT_DIR/out_nuSVM.$i-$run
#		 java -Xmx1024m -cp .:$WEKA_HOME/weka.jar weka.classifiers.trees.J48 -t $f_treino -T ${f_testes[$i]} -i -o -v > $OUT_DIR/out_j48.$i-$run
		 java -Xmx1024m -cp .:$WEKA_HOME/weka.jar weka.classifiers.functions.MultilayerPerceptron -t $f_treino -T ${f_testes[$i]} -i -o -v > $OUT_DIR/out_mlayer.$i-$run
#		 java -Xmx1024m -cp .:$WEKA_HOME/weka.jar weka.classifiers.functions.SMO -t $f_treino -T ${f_testes[$i]} -i -o -v > $OUT_DIR/out_smo.$i-$run
		i=`expr $i \+ 1`
	done
done 
echo Runing weka classifier phase completed.
exit 1

echo J48:
./process_out_weka.py $OUT_DIR/out_j48* 
echo SMO:
./process_out_weka.py $OUT_DIR/out_smo* 
echo MultilayerPerceptron:
./process_out_weka.py $OUT_DIR/out_mlayer* 

# java weka.classifiers.trees.J48 -t ~/Desktop/Mestrado/3/utils/10_bases_out/iris.versicolor.dat.fuzzy.arff -T ~/Desktop/Mestrado/3/utils/10_bases_out/iris.versicolor.dat.teste.fuzzy.arff -i -o -v | grep -e '[ab]' | tail -n 2
 
#./process_weka_results.sh experiment2/breast/box-50/ breast 30 B,O /tmp/weka2/

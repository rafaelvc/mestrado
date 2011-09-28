
## This script changes to the arff file format that
## is suitable for the weka command line 

DB_NAME=$1
NR_ATTRIBUTES=$2
CLASSES=$3
DB_FILE=$4

sed_command="'1i @relation $DB_NAME\n" 
for i in `seq $NR_ATTRIBUTES`
do
        sed_command=$sed_command"@attribute $i numeric\n" 
done
sed_command=$sed_command"@attribute label {$CLASSES}\n"
sed_command=$sed_command"@data'"
echo $sed_command" "$DB_FILE | xargs sed > xargs sed 's/^\(.\),\(.*\)$/\2,\1/g' 
$sed_command_cvs_style 

# sed $sed_command $DB_FILE
        

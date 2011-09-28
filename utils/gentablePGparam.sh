#!/bin/bash 

BASE=$1 
DIR=/media/SAMSUNG/Artigo_DS2011/results_PGparam/$BASE/
PARAM=(
#         pop1000tree12mutsd15cx85gen100
#         pop1000tree24mutsd15cx85gen100
#         pop1000tree12mutsd30cx70gen100
#         pop1000tree24mutsd30cx70gen100
#         pop2000tree12mutsd15cx85gen100
#         pop2000tree24mutsd15cx85gen100
#         pop2000tree12mutsd30cx70gen100
#         pop2000tree24mutsd30cx70gen100

        pop1000tree12mutsd15cx85gen200
        pop1000tree24mutsd15cx85gen200
        pop1000tree12mutsd30cx70gen200
        pop1000tree24mutsd30cx70gen200
        pop2000tree12mutsd15cx85gen200
        pop2000tree24mutsd15cx85gen200
        pop2000tree12mutsd30cx70gen200
        pop2000tree24mutsd30cx70gen200


)
CONF=( A B C D E F G H )

# CONF=( I J L M N O P Q )

# Table header
echo "\begin{table}[!t,h]"
echo "\begin{small}"
echo "\centerline{"
echo "\begin{tabular}{|l|l|l|l|l|}"
echo "\hline"
echo "        & \multicolumn{4}{c|}{$BASE}  \\\\ "
echo "\hline"
echo "Taxas    & \$Acc\$ & \$TPr\$ & \$TNr\$ & \$AUC\$  \\\\ "
echo "\hline"

# Table body 
i=0 
for p in ${PARAM[@]}
do
    python results2latex.py "$DIR/$p" ${CONF[i]}
    echo "\hline"
    i=$(( $i + 1 )) 
done 

# Table footer
echo "\end{tabular}}"
echo "\end{small}"
echo "\caption{}"
echo "\end{table}"


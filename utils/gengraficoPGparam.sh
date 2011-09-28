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

#        pop1000tree12mutsd15cx85gen200
        pop1000tree24mutsd15cx85gen200
        pop1000tree12mutsd30cx70gen200
        pop1000tree24mutsd30cx70gen200
        pop2000tree12mutsd15cx85gen200
        pop2000tree24mutsd15cx85gen200
        pop2000tree12mutsd30cx70gen200
        pop2000tree24mutsd30cx70gen200
)
# CONF=( A B C D E F G H )
CONF=( J L M N O P Q )

# Table body 
i=0 
for p in ${PARAM[@]}
do
    python getmaxfitgen.py "$DIR/$p/" ${CONF[i]}
    if [[ $? -eq 1  ]];then
        exit 
    fi
    i=$(( $i + 1 )) 
done 



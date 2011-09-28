#!/bin/bash 

ORIG=$1
BASE=$2

PARAM=(
# 	pop1000tree12mutsd15cx85gen100 
# 	pop1000tree24mutsd15cx85gen100
# 	pop1000tree12mutsd30cx70gen100
# 	pop1000tree24mutsd30cx70gen100
# 	pop2000tree12mutsd15cx85gen100
# 	pop2000tree24mutsd15cx85gen100
# 	pop2000tree12mutsd30cx70gen100
# 	pop2000tree24mutsd30cx70gen100
# 	pop1000tree12mutsd15cx85gen200
 	pop1000tree24mutsd15cx85gen200
 	pop1000tree12mutsd30cx70gen200
 	pop1000tree24mutsd30cx70gen200

#	pop2000tree12mutsd15cx85gen200
#	pop2000tree24mutsd15cx85gen200
#	pop2000tree12mutsd30cx70gen200
#	pop2000tree24mutsd30cx70gen200

) 


for param in ${PARAM[@]}
do
	
 	DEST="$HOME/results_PGparam/$BASE/$param"
	if [[ -d "${ORIG}1/$param/" && ! -d "$DEST" ]]
	then   
		mkdir -p $DEST
		run=1 
		for r in $( ls -d "$ORIG"{1..15}/$param/results.{1..2} 2> /dev/null )
		do 
			echo cp -pr $r "$DEST"/results."$run"
			cp -pr $r "$DEST"/results."$run"
			run=$(( $run + 1 ))
		done 
	else
		echo "There is no $param or it is already done." 
	fi 
done 


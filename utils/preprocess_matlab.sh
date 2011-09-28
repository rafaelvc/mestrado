#removes the first spaces
#removes the las spaces
#replaces the spaces by ,
#removes e+-000 

sed 's/^\s\+// 
     s/\s\+$// 
     s/\s\+/,/g
     s/e[+-]000//g' $1 > $1".new"


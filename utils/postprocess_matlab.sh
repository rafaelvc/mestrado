#adds O indicating that is an outlier sample

sed 's/^\(.\)/O,\1/g' $1 > $1".new"


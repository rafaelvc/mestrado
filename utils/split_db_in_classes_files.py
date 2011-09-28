# shell way
# grep class_a * > db_a.data 
# grep class_b * > db_b.data 
# ...
# cat db_a.dat | cut -dclass_a -f1 >> db_a.data 


class_f = 10 
db_file = "breas"
classes = ["a","b","c"]
class_db_file = {}

fp_db = open(db_file);
for c in clases:
	f = open("db_" + c ".data", "w")
	class_db_file [c] = f

while 1:
	l = fp_db.readline()
	if not l:
	 	break
	f = dict_db_file [ l.rstrip().split(",")[class_f] 
	new_l = l[:class_f] + l[class_f+1:]
	f.write(new_l)
	
for c in clases:
	dict_db_file [ c ] . close ()


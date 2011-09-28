#!/usr/bin/python 

"""./change_to_arff.py teste 5 V,O 10_bases_out/iris.versicolor.dat""" 

import sys
import re

def place_header(fp, db_name, attr, classes  ):
	fp.write("@relation " + db_name  + "\n\n" )
	for i in xrange( int(attr) ):
		fp.write("@attribute " + str(i) + " numeric\n" )
	fp.write("@attribute label {" + classes + "}\n\n" )
	fp.write("@data\n")

if __name__ == "__main__":

	db_name = sys.argv[1]
	nr_attributes = sys.argv[2]
	classes = sys.argv[3]
	db_file = sys.argv[4]
	fp = open(db_file)
	fp_out = open(db_file + ".arff","w")
	place_header( fp_out, db_name, nr_attributes, classes )

	while True: 
		l = fp.readline()
		if not l:
			break
		new_l = re.sub(r"^(.),(.*)$", r"\2,\1", l) #change O,1,2,4 to 1,2,4,O (csv style)
		fp_out.write( new_l )	
		l = None

	fp.close()
	fp_out.close()

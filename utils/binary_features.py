# Usage: ./binary_features.py category_file db_file 

# Category file in the format: 
# category1_value1,category1_value2,..,category1_valuen
# category2_value1,category2_value2,..,category1_valuem
# ...
# categoryx_value1,category2_value2,..,category1_valuey

# First step builds a dictorinay with corresponding binary values
# from category file :
# eg: value1 = 001, value2 = 010, value3 = 100

# Second step changes every single value with the dict value using 
# db_file value as dict key. 

import sys

fp_cat = open(sys.argv[1])
fp_base = open(sys.argv[2])

dict_cat = []
while 1:
	line = fp_cat.readline()
	if not line:	
		break
	values = (line.rstrip().split(","))
	#print values
	#sys.exit()
	cont = len(values)
	v = [ '0' for i in range(0,cont) ]
	#for i in range(0,len(values)):
		#v.append('0,')
	#v = v[:-1]
	dict = {}
	for c in values: 
		v[cont-1] = '1'
		dict[c] = ",".join(v)
		v[cont-1] = '0'
		cont -= 1
	dict_cat.append(dict)	
	
# print dict_cat	

while 1:
	line = fp_base.readline()
	if not line:	
		break
	values = line.rstrip().split(",") 
	cont = 0
	new_line = values[0] + ","
	# print values[1:]
	# sys.exit()
	for c in values[1:]:  
		if c.isdigit(): 
			new_line += (c + ",")
		else: 
			dict = dict_cat[cont]
			new_line += dict[c] + ","
			cont += 1
	print new_line[:-1] 
						
fp_cat.close()
fp_base.close()

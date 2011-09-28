# Usage: ./binary_features.py category_file db_file 

# Category file in the format: 
# category1_value1,category1_value2,..,category1_valuen
# category2_value1,category2_value2,..,category1_valuem
# ...
# categoryx_value1,category2_value2,..,category1_valuey

# First step builds a dictorinay with corresponding single values
# from category file :
# eg: value1 = 1, value2 = 2, value3 = 3

# Second step changes every single value with the dict value using 
# db_file value as dict key. 

import sys
import re

fp_cat = open(sys.argv[1])
fp_base = open(sys.argv[2])

dict_cat = []
while 1:
    line = fp_cat.readline()
    if not line:	
        break
    values = (line.rstrip().split(","))
    dict = {}
    cont = 1.0
    for c in values: 
        dict[c] = str(cont) 
        cont += 1.0
#    print dict
    dict_cat.append(dict)	
	
# print dict_cat	
# sys.exit()

float_re = re.compile('\d+\.\d+')
while 1:
    line = fp_base.readline()
    if not line:	
        break
    values = line.rstrip().split(",") 
    cont = 0
    new_line = "" 
    for c in values:  
        if c.isdigit() or float_re.search(c): 
            new_line += (c + ",")
        else: 
            dict = dict_cat[cont]
            new_line += dict[c] + ","
            cont += 1
    print new_line[:-1] 
						
fp_cat.close()
fp_base.close()

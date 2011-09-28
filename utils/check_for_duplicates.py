import sys
import re
# import pdb

duplicates_info = [] 
f = open( sys.argv[1] ) 
contline = 1
linenrs = []
for linef in f:
	if contline in linenrs:
		contline += 1
		continue 	
	l_splitted_f = re.split('\s+',linef)[1:-1]
	f1 = open( sys.argv[1] ) 
	linedup = 1
	linenr = []
#	pdb.set_trace()
	for linef1 in f1:
		if linedup == contline: 
			linedup += 1
			continue 
		l_splitted_f1 = re.split('\s+',linef1)[1:-1]
		if l_splitted_f == l_splitted_f1:
			if not linenr: 
				linenr = [contline] 
			linenr.append( linedup )  
		linedup += 1
	linenrs = linenrs + linenr 
	if linenr:
		duplicates_info.append( (linef,linenr,len(linenr)) )
	contline += 1
	f1.close()
f.close()
for d in duplicates_info:
	print d 

print linenrs 
print "Total, duplicatas: ", len(linenrs)



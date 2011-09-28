import sys
import re

fp = open(sys.argv[1])
gpout = fp.readline()
classes = fp.readline()
fp.close()

g_ = gpout.split(",")
# g_ = g_[:-1]
c_ = classes.split(",")
# c_ = c_[:-1]
out = [[]]
i = 0 
for g in g_: 
	out.append(  [[ float ( g.strip() ),float ( c_[i].strip() )]] )
	i += 1
out.sort()
#fp = open(sys.argv[1] + ".cvs", "w")

# reobj = re.compile(r'/[\[\]]/')
for o in out: 
	o = str ( o ).replace("[",'')
	o = str ( o ).replace("]",'')
	o = str ( o ).replace(",",'')
	print o 
#	fp.write()	

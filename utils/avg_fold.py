import sys 
from math import sqrt

# print sys.argv[0]
# print len(sys.argv)
# sys.exit(  ) 

if len(sys.argv) > 1:
	dir = sys.argv[1]

nr_folds = 5
total = 0.0

fold_ = [] 

for i in range(1,nr_folds + 1):
	fd = open(dir + "result_fold_" + str(i) + ".txt")
	line = fd.readline()
	x = float ( (line.split(" ")[3]).rstrip() )
	fold_.append(x)
	total += x
	fd.close()
media = total / (1.0 * nr_folds)

total = 0.0
for x in fold_: 
	x_ = media - x 
	x_ *= x_
	total += x_ 

desvio =  sqrt ( total / (1.0 * (nr_folds-1)) )

print media
print desvio 

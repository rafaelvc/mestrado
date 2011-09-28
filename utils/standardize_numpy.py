# http://www.scipy.org/NumPy_for_Matlab_Users
# Make all numpy available via shorter 'num' prefix
import numpy as num
# Make all matlib functions accessible at the top level via M.func()
import numpy.matlib as M
# Make some matlib functions accessible directly at the top level via, e.g. rand(3,3)
from numpy.matlib import rand,zeros,ones,empty,eye

import sys
import csv

fname = sys.argv[1]
minv = sys.argv[2]
maxv = sys.argv[3]

freader = csv.reader(open(fname), delimiter=',')
db=None
for line in freader: 
	new_row = num.array( [ line[1:] ], dtype='f'  )  
	if isinstance(db,num.ndarray): 
		db = num.append(db, new_row, axis=0)
	else:
		db = new_row

max_ = num.amax(db,axis=0)
min_ = num.amin(db,axis=0)

prop  = abs(max_ - min_)
propv = abs(maxv - minv)

# [-1,1]
# standardizedDB = (-1.0 + ((db - min_) * (2.0 / prop)))
standardizeDB = (minv + ((db-min_) * (propv/prop))

num.savetxt(fname + '.std_np', standardizedDB, fmt='%1.4f', delimiter=',') 


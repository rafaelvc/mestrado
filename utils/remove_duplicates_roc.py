import sys
import numpy
import csv

fname = sys.argv[1]
f = open(fname)
uniq_samples = []
while 1:
    line = f.readline()
    if not line:
        break
    line = line.split(";")
    x = float ( line[0].strip() ) 
    y = float ( line[1].strip() ) 
    if (x,y) not in uniq_samples: 
        uniq_samples.append( (x,y) ) 
f.close()

uniq=[ str(x) + ";" + str(y)  for x,y in uniq_samples ] 
if uniq: 
    print len(uniq)
    fnew = open(fname + '.uniq', 'w') 
    fnew.write( "\n".join( uniq ) )
    fnew.close()   

#  freader = csv.reader(open(fname), delimiter=';')
#  db=None
#  for line in freader:
#      new_row = num.array( [ line[1:] ], dtype='f'  )
#      if isinstance(db,num.ndarray):
#          db = num.append(db, new_row, axis=0)
#     else:

# fnew =  open(fname + '.uniq.csv', 'w') 
# print len(samples)
# uniq_samples = []
# for  s in samples: 
#     if s not in uniq_samples: 
#         uniq_samples.append( str(s[0]) + ";" + str(s[1]) ) 
# print len(uniq_samples) 
# fnew.write( "\n".join( uniq_samples ) )
# fnew.close() 

# uniq = set( samples ) 
# fnew =  open(fname + '.uniq.csv', 'w') 
# db=None
# for p in uniq:
#     print p
#     line = str( p[0] ) + ";" + str( p[1] ) + "\n"
#     fnew.write( line )
# fnew.close() 

# for p in uniq:
#      new_row = numpy.array( [ p ], dtype='f'  )
#      if isinstance(db,numpy.ndarray):
#         db = numpy.append(db, new_row, axis=0)
#      else:
#         db = new_row
# numpy.savetxt(fname + '.uniq.csv', db, fmt='%1.4f', delimiter=';')




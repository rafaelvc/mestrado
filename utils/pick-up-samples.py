import sys
import random 

if len ( sys.argv ) - 1 != 5:   
	print "Usage: <nr_picked_up> <end_point_picked_up> <db_samples_file> --(with|without)-split --(file|screen)"
	sys.exit()

nr_samples = int(sys.argv[2])
cont = int(sys.argv[1])

if sys.argv[5] == "--file": 
	fname = sys.argv[3] + ".picked"
	fp_picked = open(fname, "w") 
	# print "Generatig file with picked up samples..."
	# print fname

fname = sys.argv[3]
fp = open(fname)
picked = []
while cont > 0:
	r = random.randrange(0,nr_samples)
	if r not in picked: 
		picked.append(r)
		fp.seek(0)	
		while r >= 0:
			line = fp.readline()
			r -= 1
		if  sys.argv[5] == "--file": #ugly 
			fp_picked.write( line )
		else: 
			print line.replace('\n','')
		cont -= 1

fp.close()
if sys.argv[5] == "--file": #ugly 
	fp_picked.close()

if sys.argv[4] ==  "--with-split": 
	fname = sys.argv[3] + ".without.picked"
	fp_without = open( fname , "w")
	# print "Generatig file without picked up samples..."
	# print fname
	fname = sys.argv[3] 
	fp = open( fname )
	cont = 0 
	while 1: 
		line = fp.readline()
		if not line: 
			break
		if cont not in picked: 
			if  sys.argv[5] == "--file": #ugly 
				fp_without.write(line)
			else: 
				print line.replace('\n','')
		cont += 1
	fp.close()
	fp_without.close()



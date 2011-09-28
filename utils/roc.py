import sys

fp = open(sys.argv[1])
while 1:
	line = fp.readline()
	if not line:
		break
	if line[:5] == "GPOUT":
		gp_out = [ float(g) for g in line[7:].split(",") ]
		line = fp.readline()
		classes = [ int(c) for c in line[7:].split(",") ] 
		break
fp.close()

# print "leu"
#gp_out = [-5,-3,0,1,2,4,5,10] 
#classes = [0,1,0,1,1,1,0,1]

rates = [] 
for gpo in gp_out:
	tpr = fpr = 0.0
 	tp = tn = fn = fp = 0 	
	for i in range(0, len(gp_out)):
		if gp_out[i] < gpo and classes[i] == 1:
			tp += 1 
		elif gp_out[i] >= gpo and classes[i] == 0:
			tn += 1
		elif gp_out[i] < gpo and classes[i] == 0:
			fp += 1
		elif gp_out[i] >= gpo and classes[i] == 1:
			fn += 1
	# print str(tp  * 1.0 / (tp+fn)) + " " + str(fn)
	tpr = (tp * 1.0) / (tp + fn)  
	fpr = (fp * 1.0) / (tn + fp)  
	rates.append((tpr, fpr))	

for r in rates:
	print str(r).replace('(','').replace(')','').replace(' ','')


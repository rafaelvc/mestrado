
import sys

def auc(points): 
	A = 0.0
	for i in xrange(0,len(points)-1): 
		x1 = (points[i])[0]
		y1 = (points[i])[1]
		x2 = (points[i+1])[0]
		y2 = (points[i+1])[1]
		if y1 < y2: 
			A += ((x2-x1)*y1 + ((x2-x1)*(y2-y1))/2)
		else:
			A += ((x2-x1)*y2 + ((x2-x1)*(y1-y2))/2)
	return A 

acc_total = tpr_total = tnr_total = auc_total = 0.0 
for f in sys.argv[1:]:
	f_ = open(f)
	while True:
		line = f_.readline()
		if not line:
			break
		if line[:9] == "Accuracy:":
			acc_total += float(line.split(":")[1])
		elif line[:4] == "TP/P":
			tpr_total += float(line.split(":")[1])
		elif line[:4] == "TN/N":
			tnr_total += float(line.split(":")[1])
		elif line[:5] == "GPOUT":
			gp_out = [ float(g) for g in line[7:].split(",") ]
			line = f_.readline()
			classes = [ int(c) for c in line[7:].split(",") ] 
			rates = []
			for gpo in gp_out:
				tpr = fpr = 0.0
				tp = tn = fn = fp = 0.0 	
				for i in range(0, len(gp_out)):
					if gp_out[i] >= gpo and classes[i] == 1:
						tp += 1.0 
					elif gp_out[i] < gpo and classes[i] == 0:
						tn += 1.0
					elif gp_out[i] >= gpo and classes[i] == 0:
						fp += 1.0
					elif gp_out[i] < gpo and classes[i] == 1:
						fn += 1.0
				tpr=tp/(tp + fn)  
				fpr=fp/(tn + fp)  
				rates.append([fpr, tpr])	
			rates.sort()
			auc_total += auc(rates)

nrFiles = len(sys.argv[1:]) * 1.0
print "Accuracy:", acc_total / nrFiles
print "TP/P:", tpr_total / nrFiles
print "TN/N:", tnr_total / nrFiles
print "AUC:",  auc_total / nrFiles

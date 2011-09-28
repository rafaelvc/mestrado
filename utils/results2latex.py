import sys
from numpy import average,std 

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

rodadas = 30 
folds = 5
dir = sys.argv[1]
conf = sys.argv[2]
acc_,tpr_,tnr_,auc_ = [],[],[],[]

for i in range(1,rodadas+1):
    path = dir + "/results."  + str(i) + "/"
    for j in range(1,folds+1): 
        try:
            gp_out,classes = [],[]
            fold_file = path + "result_fold_" + str(j) + ".txt"
            fd = open(fold_file)
            for line in fd: 		        
                item = line.split(":")
                if len(item) == 1:
                    continue
                if item[0].strip() == "Accuracy":
                    x = float(item[1].strip())
                    acc_.append(x)
                elif item[0].strip() == "TP/P":
                    x = float(item[1].strip())
                    tpr_.append(x)
                elif item[0].strip() == "TN/N":
                    x = float(item[1].strip())
                    tnr_.append(x)
                elif item[0].strip() == "GPOUT":
                    gp_out = [ float(g) for g in item[1][1:].split(",") ]
                elif item[0].strip() == "CLASS":
                    classes = [ int(c) for c in item[1][1:].split(",") ] 
            if gp_out and classes:
                rates = [] 
                for gpo in gp_out:
                    tp = tn = fn = fp = 0.0 	
                    for l in range(0, len(gp_out)):
                        if gp_out[l] >= gpo and classes[l] == 1:
                            tp += 1.0 
                        elif gp_out[l] < gpo and classes[l] == 0:
                            tn += 1.0
                        elif gp_out[l] >= gpo and classes[l] == 0:
                            fp += 1.0
                        elif gp_out[l] < gpo and classes[l] == 1:
                            fn += 1.0
                    rates.append([fp/(tn + fp), tp/(tp + fn)])	
                rates.sort()
                x = auc(rates)
                auc_.append(x)
            fd.close()
            # print i,j
        except:
            # pass
            print "File not found? (%s)" % fold_file 
            sys.exit(2)	


print conf + (" & $%2.2f\\pm%2.2f$ & $%2.2f\\pm%2.2f$& $%2.2f\\pm%2.2f$& $%2.2f\\pm%2.2f$ \\\\" % (  
        average( acc_ ) * 100.0, std( acc_ ) * 100.0,
        average( tpr_ ) * 100.0, std( tpr_ ) * 100.0,  
        average( tnr_ ) * 100.0, std( tnr_ ) * 100.0,   
        average( auc_ ) * 100.0, std( auc_ ) * 100.0 ))


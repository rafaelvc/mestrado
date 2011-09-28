import sys
from numpy import average,std,array,savetxt,hstack
from scipy.stats import kruskal,wilcoxon 
 
class ParsingError(Exception): 
    def __init__(self, filepath): 
        self.p = filepath
    def __str__(self): 
	    return repr(self.p)

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
folds = int(sys.argv[1])
base = sys.argv[2]
dirs = sys.argv[3:]
# conf = sys.argv[2]
# acc_,tpr_,tnr_,auc_ = [],[],[],[]
accs,tprs,tnrs,aucs = [],[],[],[]

accs_ = array(None)
tprs_ = array(None)
tnrs_ = array(None)
aucs_ = array(None)

for dir in dirs: 
    acc_,tpr_,tnr_,auc_ = [],[],[],[]
    for i in range(1,rodadas+1):
        path = dir + "/results."  + str(i) + "/"
        for j in range(1,folds+1): 

            try:
                gp_out,classes = [],[]
                fold_file = path + "result_fold_" + str(j) + ".txt"
                print fold_file
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
                else:
                    raise ParsingError(fold_file)

                fd.close()

            except ParsingError as e: 
                print "Parsing error on: ", e.value 
                sys.exit(2)	
            except IOError as e:
                # pass
                print "File not found? (%s)" % fold_file 
                sys.exit(2)	

    if accs_.any(): 
        accs_ = hstack( (accs_, array( acc_ ).reshape(folds * rodadas,1)) ) 
        tprs_ = hstack( (tprs_, array( tpr_ ).reshape(folds * rodadas,1)) ) 
        tnrs_ = hstack( (tnrs_, array( tnr_ ).reshape(folds * rodadas,1)) ) 
        aucs_ = hstack( (aucs_, array( auc_ ).reshape(folds * rodadas,1)) ) 
    else: 
        accs_ = array( acc_ ).reshape(folds * rodadas,1)
        tprs_ = array( tpr_ ).reshape(folds * rodadas,1)
        tnrs_ = array( tnr_ ).reshape(folds * rodadas,1)
        aucs_ = array( auc_ ).reshape(folds * rodadas,1)

    accs.append( array( acc_ ) )
    tprs.append( array( tpr_ ) )
    tnrs.append( array( tnr_ ) )
    aucs.append( array( auc_ ) )

savetxt(base + '_acc.csv', accs_, fmt='%1.4f', delimiter=',')
savetxt(base + '_tpr.csv', tprs_, fmt='%1.4f', delimiter=',')
savetxt(base + '_tnr.csv', tnrs_, fmt='%1.4f', delimiter=',')
savetxt(base + '_auc.csv', aucs_, fmt='%1.4f', delimiter=',')

sys.exit(0)


### Uses Kruskal and Wilcoxon tests from scipy

# print conf + (" & $%2.2f\\pm%2.2f$ & $%2.2f\\pm%2.2f$& $%2.2f\\pm%2.2f$& $%2.2f\\pm%2.2f$ \\\\" % (  
#         average( acc_ ) * 100.0,std( acc_ )* 100.0,
#         average( tpr_ ) * 100.0,std( tpr_ )* 100.0,  
#         average( tnr_ )* 100.0,std( tnr_ )* 100.0,   
#         average( auc_ )* 100.0,std( auc_ )* 100.0 ))
# 

# # 2 configs 
# print "Acc:" 
# print "Kruskal H %s, p-value %s"        %  kruskal( accs[0], accs[1] )
# print "Wilcoxon 0,1 - T %s, p-value %s" % wilcoxon( accs[0], accs[1] )
# print "TPr:" 
# print "Kruskal H %s, p-value %s"        % kruskal( tprs[0], tprs[1] )
# print "Wilcoxon 0,1 - T %s, p-value %s" % wilcoxon( tprs[0], tprs[1] )
# print "TNr:" 
# print "Kruskal H %s, p-value %s"        % kruskal( tnrs[0], tnrs[1] )
# print "Wilcoxon 0,1 - T %s, p-value %s" % wilcoxon( tnrs[0], tnrs[1] )
# print "\n" 

# # 3 configs 
# print "Acc:" 
# print "Kruskal H %s, p-value %s"        %  kruskal( accs[0], accs[1], accs[2] )
# print "Wilcoxon 0,1 - T %s, p-value %s" % wilcoxon( accs[0], accs[1] )
# print "Wilcoxon 0,2 - T %s, p-value %s" % wilcoxon( accs[0], accs[2] )
# print "Wilcoxon 1,2 - T %s, p-value %s" % wilcoxon( accs[1], accs[2] )
# print "TPr:" 
# print "Kruskal H %s, p-value %s"        % kruskal( tprs[0], tprs[1], tprs[2] )
# print "Wilcoxon 0,1 - T %s, p-value %s" % wilcoxon( tprs[0], tprs[1] )
# print "Wilcoxon 0,2 - T %s, p-value %s" % wilcoxon( tprs[0], tprs[2] )
# print "Wilcoxon 1,2 - T %s, p-value %s" % wilcoxon( tprs[1], tprs[2] )
# print "TNr:" 
# print "Kruskal H %s, p-value %s"        % kruskal( tnrs[0], tnrs[1], tnrs[2] )
# print "Wilcoxon 0,1 - T %s, p-value %s" % wilcoxon( tnrs[0], tnrs[1] )
# print "Wilcoxon 0,2 - T %s, p-value %s" % wilcoxon( tnrs[0], tnrs[2] )
# print "Wilcoxon 1,2 - T %s, p-value %s" % wilcoxon( tnrs[1], tnrs[2] )
# print "\n" 

# # 4 configs 
print "Acc:" 
print "Kruskal H %s, p-value %s"        %  kruskal( accs[0], accs[1], accs[2] , accs[3]) 
print "Wilcoxon 0,1 - T %s, p-value %s" % wilcoxon( accs[0], accs[1] )
print "Wilcoxon 0,2 - T %s, p-value %s" % wilcoxon( accs[0], accs[2] )
print "Wilcoxon 0,3 - T %s, p-value %s" % wilcoxon( accs[0], accs[3] )
print "Wilcoxon 1,2 - T %s, p-value %s" % wilcoxon( accs[1], accs[2] )
print "Wilcoxon 1,3 - T %s, p-value %s" % wilcoxon( accs[1], accs[3] )
print "Wilcoxon 2,3 - T %s, p-value %s" % wilcoxon( accs[2], accs[3] )
print "TPr:" 
print "Kruskal H %s, p-value %s"        % kruskal( tprs[0], tprs[1], tprs[2] , tprs[3]) 
print "Wilcoxon 0,1 - T %s, p-value %s" % wilcoxon( tprs[0], tprs[1] )
print "Wilcoxon 0,2 - T %s, p-value %s" % wilcoxon( tprs[0], tprs[2] )
print "Wilcoxon 0,3 - T %s, p-value %s" % wilcoxon( tprs[0], tprs[3] )
print "Wilcoxon 1,2 - T %s, p-value %s" % wilcoxon( tprs[1], tprs[2] )
print "Wilcoxon 1,3 - T %s, p-value %s" % wilcoxon( tprs[1], tprs[3] )
print "Wilcoxon 2,3 - T %s, p-value %s" % wilcoxon( tprs[2], tprs[3] )
print "TNr:" 
print "Kruskal H %s, p-value %s"        % kruskal( tnrs[0], tnrs[1], tnrs[2] , tnrs[3]) 
print "Wilcoxon 0,1 - T %s, p-value %s" % wilcoxon( tnrs[0], tnrs[1] )
print "Wilcoxon 0,2 - T %s, p-value %s" % wilcoxon( tnrs[0], tnrs[2] )
print "Wilcoxon 0,3 - T %s, p-value %s" % wilcoxon( tnrs[0], tnrs[3] )
print "Wilcoxon 1,2 - T %s, p-value %s" % wilcoxon( tnrs[1], tnrs[2] )
print "Wilcoxon 1,3 - T %s, p-value %s" % wilcoxon( tnrs[1], tnrs[3] )
print "Wilcoxon 2,3 - T %s, p-value %s" % wilcoxon( tnrs[2], tnrs[3] )
print "\n" 
 
# 8 configs 
# print "Acc:" 
# print "Kruskal H %s, p-value %s"        %  kruskal( accs[0], accs[1], accs[2] , accs[3], accs[4], accs[5], accs[6] , accs[7])
# 
# print "Wilcoxon 0,1 - T %s, p-value %s" % wilcoxon( accs[0], accs[1] )
# print "Wilcoxon 0,2 - T %s, p-value %s" % wilcoxon( accs[0], accs[2] )
# print "Wilcoxon 0,3 - T %s, p-value %s" % wilcoxon( accs[0], accs[3] )
# print "Wilcoxon 0,4 - T %s, p-value %s" % wilcoxon( accs[0], accs[4] )
# print "Wilcoxon 0,5 - T %s, p-value %s" % wilcoxon( accs[0], accs[5] )
# print "Wilcoxon 0,6 - T %s, p-value %s" % wilcoxon( accs[0], accs[6] )
# print "Wilcoxon 0,7 - T %s, p-value %s" % wilcoxon( accs[0], accs[7] )
# 
# print "Wilcoxon 1,2 - T %s, p-value %s" % wilcoxon( accs[1], accs[2] )
# print "Wilcoxon 1,3 - T %s, p-value %s" % wilcoxon( accs[1], accs[3] )
# print "Wilcoxon 1,3 - T %s, p-value %s" % wilcoxon( accs[1], accs[3] )
# print "Wilcoxon 1,4 - T %s, p-value %s" % wilcoxon( accs[1], accs[4] )
# print "Wilcoxon 1,5 - T %s, p-value %s" % wilcoxon( accs[1], accs[5] )
# print "Wilcoxon 1,6 - T %s, p-value %s" % wilcoxon( accs[1], accs[6] )
# print "Wilcoxon 1,7 - T %s, p-value %s" % wilcoxon( accs[1], accs[7] )
# 
# print "Wilcoxon 2,3 - T %s, p-value %s" % wilcoxon( accs[2], accs[3] )
# print "Wilcoxon 2,4 - T %s, p-value %s" % wilcoxon( accs[2], accs[4] )
# print "Wilcoxon 2,5 - T %s, p-value %s" % wilcoxon( accs[2], accs[5] )
# print "Wilcoxon 2,6 - T %s, p-value %s" % wilcoxon( accs[2], accs[6] )
# print "Wilcoxon 2,7 - T %s, p-value %s" % wilcoxon( accs[2], accs[7] )
# 
# print "Wilcoxon 3,4 - T %s, p-value %s" % wilcoxon( accs[3], accs[4] )
# print "Wilcoxon 3,5 - T %s, p-value %s" % wilcoxon( accs[3], accs[5] )
# print "Wilcoxon 3,6 - T %s, p-value %s" % wilcoxon( accs[3], accs[6] )
# print "Wilcoxon 3,7 - T %s, p-value %s" % wilcoxon( accs[3], accs[7] )
# 
# print "Wilcoxon 4,5 - T %s, p-value %s" % wilcoxon( accs[4], accs[5] )
# print "Wilcoxon 4,6 - T %s, p-value %s" % wilcoxon( accs[4], accs[6] )
# print "Wilcoxon 4,7 - T %s, p-value %s" % wilcoxon( accs[4], accs[7] )
# 
# print "Wilcoxon 5,6 - T %s, p-value %s" % wilcoxon( accs[5], accs[6] )
# print "Wilcoxon 5,7 - T %s, p-value %s" % wilcoxon( accs[5], accs[7] )
# 
# print "Wilcoxon 6,7 - T %s, p-value %s" % wilcoxon( accs[6], accs[7] )
# 
# 
# print "TPr:" 
# print "Kruskal H %s, p-value %s"        %  kruskal( tprs[0], tprs[1], tprs[2] , tprs[3], tprs[4], tprs[5], tprs[6] , tprs[7])
# 
# print "Wilcoxon 0,1 - T %s, p-value %s" % wilcoxon( tprs[0], tprs[1] )
# print "Wilcoxon 0,2 - T %s, p-value %s" % wilcoxon( tprs[0], tprs[2] )
# print "Wilcoxon 0,3 - T %s, p-value %s" % wilcoxon( tprs[0], tprs[3] )
# print "Wilcoxon 0,4 - T %s, p-value %s" % wilcoxon( tprs[0], tprs[4] )
# print "Wilcoxon 0,5 - T %s, p-value %s" % wilcoxon( tprs[0], tprs[5] )
# print "Wilcoxon 0,6 - T %s, p-value %s" % wilcoxon( tprs[0], tprs[6] )
# print "Wilcoxon 0,7 - T %s, p-value %s" % wilcoxon( tprs[0], tprs[7] )
# 
# print "Wilcoxon 1,2 - T %s, p-value %s" % wilcoxon( tprs[1], tprs[2] )
# print "Wilcoxon 1,3 - T %s, p-value %s" % wilcoxon( tprs[1], tprs[3] )
# print "Wilcoxon 1,3 - T %s, p-value %s" % wilcoxon( tprs[1], tprs[3] )
# print "Wilcoxon 1,4 - T %s, p-value %s" % wilcoxon( tprs[1], tprs[4] )
# print "Wilcoxon 1,5 - T %s, p-value %s" % wilcoxon( tprs[1], tprs[5] )
# print "Wilcoxon 1,6 - T %s, p-value %s" % wilcoxon( tprs[1], tprs[6] )
# print "Wilcoxon 1,7 - T %s, p-value %s" % wilcoxon( tprs[1], tprs[7] )
# 
# print "Wilcoxon 2,3 - T %s, p-value %s" % wilcoxon( tprs[2], tprs[3] )
# print "Wilcoxon 2,4 - T %s, p-value %s" % wilcoxon( tprs[2], tprs[4] )
# print "Wilcoxon 2,5 - T %s, p-value %s" % wilcoxon( tprs[2], tprs[5] )
# print "Wilcoxon 2,6 - T %s, p-value %s" % wilcoxon( tprs[2], tprs[6] )
# print "Wilcoxon 2,7 - T %s, p-value %s" % wilcoxon( tprs[2], tprs[7] )
# 
# print "Wilcoxon 3,4 - T %s, p-value %s" % wilcoxon( tprs[3], tprs[4] )
# print "Wilcoxon 3,5 - T %s, p-value %s" % wilcoxon( tprs[3], tprs[5] )
# print "Wilcoxon 3,6 - T %s, p-value %s" % wilcoxon( tprs[3], tprs[6] )
# print "Wilcoxon 3,7 - T %s, p-value %s" % wilcoxon( tprs[3], tprs[7] )
# 
# print "Wilcoxon 4,5 - T %s, p-value %s" % wilcoxon( tprs[4], tprs[5] )
# print "Wilcoxon 4,6 - T %s, p-value %s" % wilcoxon( tprs[4], tprs[6] )
# print "Wilcoxon 4,7 - T %s, p-value %s" % wilcoxon( tprs[4], tprs[7] )
# 
# print "Wilcoxon 5,6 - T %s, p-value %s" % wilcoxon( tprs[5], tprs[6] )
# print "Wilcoxon 5,7 - T %s, p-value %s" % wilcoxon( tprs[5], tprs[7] )
# 
# print "Wilcoxon 6,7 - T %s, p-value %s" % wilcoxon( tprs[6], tprs[7] )
# 
# 
# 
# print "TNr:" 
# print "Kruskal H %s, p-value %s"        %  kruskal( tnrs[0], tnrs[1], tnrs[2] , tnrs[3], tnrs[4], tnrs[5], tnrs[6] , tnrs[7])
# 
# print "Wilcoxon 0,1 - T %s, p-value %s" % wilcoxon( tnrs[0], tnrs[1] )
# print "Wilcoxon 0,2 - T %s, p-value %s" % wilcoxon( tnrs[0], tnrs[2] )
# print "Wilcoxon 0,3 - T %s, p-value %s" % wilcoxon( tnrs[0], tnrs[3] )
# print "Wilcoxon 0,4 - T %s, p-value %s" % wilcoxon( tnrs[0], tnrs[4] )
# print "Wilcoxon 0,5 - T %s, p-value %s" % wilcoxon( tnrs[0], tnrs[5] )
# print "Wilcoxon 0,6 - T %s, p-value %s" % wilcoxon( tnrs[0], tnrs[6] )
# print "Wilcoxon 0,7 - T %s, p-value %s" % wilcoxon( tnrs[0], tnrs[7] )
# 
# print "Wilcoxon 1,2 - T %s, p-value %s" % wilcoxon( tnrs[1], tnrs[2] )
# print "Wilcoxon 1,3 - T %s, p-value %s" % wilcoxon( tnrs[1], tnrs[3] )
# print "Wilcoxon 1,3 - T %s, p-value %s" % wilcoxon( tnrs[1], tnrs[3] )
# print "Wilcoxon 1,4 - T %s, p-value %s" % wilcoxon( tnrs[1], tnrs[4] )
# print "Wilcoxon 1,5 - T %s, p-value %s" % wilcoxon( tnrs[1], tnrs[5] )
# print "Wilcoxon 1,6 - T %s, p-value %s" % wilcoxon( tnrs[1], tnrs[6] )
# print "Wilcoxon 1,7 - T %s, p-value %s" % wilcoxon( tnrs[1], tnrs[7] )
# 
# print "Wilcoxon 2,3 - T %s, p-value %s" % wilcoxon( tnrs[2], tnrs[3] )
# print "Wilcoxon 2,4 - T %s, p-value %s" % wilcoxon( tnrs[2], tnrs[4] )
# print "Wilcoxon 2,5 - T %s, p-value %s" % wilcoxon( tnrs[2], tnrs[5] )
# print "Wilcoxon 2,6 - T %s, p-value %s" % wilcoxon( tnrs[2], tnrs[6] )
# print "Wilcoxon 2,7 - T %s, p-value %s" % wilcoxon( tnrs[2], tnrs[7] )
# 
# print "Wilcoxon 3,4 - T %s, p-value %s" % wilcoxon( tnrs[3], tnrs[4] )
# print "Wilcoxon 3,5 - T %s, p-value %s" % wilcoxon( tnrs[3], tnrs[5] )
# print "Wilcoxon 3,6 - T %s, p-value %s" % wilcoxon( tnrs[3], tnrs[6] )
# print "Wilcoxon 3,7 - T %s, p-value %s" % wilcoxon( tnrs[3], tnrs[7] )
# 
# print "Wilcoxon 4,5 - T %s, p-value %s" % wilcoxon( tnrs[4], tnrs[5] )
# print "Wilcoxon 4,6 - T %s, p-value %s" % wilcoxon( tnrs[4], tnrs[6] )
# print "Wilcoxon 4,7 - T %s, p-value %s" % wilcoxon( tnrs[4], tnrs[7] )
# 
# print "Wilcoxon 5,6 - T %s, p-value %s" % wilcoxon( tnrs[5], tnrs[6] )
# print "Wilcoxon 5,7 - T %s, p-value %s" % wilcoxon( tnrs[5], tnrs[7] )
# 
# print "Wilcoxon 6,7 - T %s, p-value %s" % wilcoxon( tnrs[6], tnrs[7] )


#!/usr/bin/python 
import re
import sys 
from math import sqrt

def desvio(media, valores):

    total = 0.0
    nr_val = len(valores)
    for x in valores:
        x_ = media - x
        x_ *= x_
        total += x_
    return sqrt(total/(1.0*(nr_val-1)))

def fmtResult(vl):
    return "%2.1f" % (vl * 100.0)

files = sys.argv[1:]
expr_acc = re.compile(r"^Correctly.* (\d+\.?\d+)\s+%$")
expr_tpr = re.compile(r"^\s*(\d+)\s+(\d+)\s+\|\s+a")
expr_tnr = re.compile(r"^\s*(\d+)\s+(\d+)\s+\|\s+b")
expr_auc = re.compile(r"^Weighted Avg.(\s+\d+\.?\d*){5}\s+(\d+\.?\d*)")

total_acc = total_tpr = total_tnr = total_auc = 0.0 
accs = tprs = tnrs = aucs = []

for f in files: 
    fp = open(f)
    acc = tpr = tnr = auc = None 
    while True: 
        l = fp.readline()
        if not l:
            break
        if not auc:
            auc = expr_auc.search(l)
            # print auc
            if auc: 
                total_auc += float(auc.group(2))
                # print float(auc.group(2))
                aucs.append(float(auc.group(2)))
        if not acc:
            acc = expr_acc.search(l)
            if acc: 
                total_acc += float(acc.group(1))/100.0 
                print acc.group(1)
                # print "Accuracy: " , str ( float(acc.group(1))/100.0 )
                accs.append( float(acc.group(1))/100.0  ) 
        if not tpr:
            tpr = expr_tpr.search(l)
            if tpr: 
                right = float(tpr.group(1)) 
                wrong = float(tpr.group(2))
                total_tpr += right / (right+wrong)  
                # print "TP/P: " , str ( r )
                tprs.append( right / (right+wrong) )
        if not tnr:
            tnr = expr_tnr.search(l)
            if tnr: 
                right = float(tnr.group(2)) 
                wrong = float(tnr.group(1))
                total_tnr += right / (right+wrong)  
                # print "TN/N: " , str ( r )
                tnrs.append( right / (right+wrong) ) 
                break 

        l=None
    fp.close()

nr_f = len(files) * 1.0  

media_acc = total_acc / nr_f
media_tpr = total_tpr / nr_f 
media_tnr = total_tnr / nr_f
media_auc = total_auc / nr_f 

desvio_acc = desvio( media_acc, accs )
desvio_tpr = desvio( media_tpr, tprs )
desvio_tnr = desvio( media_tnr, tnrs )
desvio_auc = desvio( media_auc, aucs )

print "& $" +  fmtResult(media_acc) + "\pm" + fmtResult(desvio_acc) +  "$& $" + fmtResult(media_tpr) +"\pm" + fmtResult(desvio_tpr) + "$&  $" + fmtResult(media_tnr) + "\pm" + fmtResult(desvio_tnr) + "$  & $" + fmtResult(media_auc)+"\pm" + fmtResult(desvio_auc) +  "$  \\\\"

# print "Accuracy:" , str( media_acc  )  
# print "TP/P:" , str( media_tpr )
# print "TN/N:" , str( media_tnr )
# print "AUC:" , str( media_auc )
# 
# print "Accuracy:" , str ( total_acc / nr_f )  
# print "TP/P:" , str ( total_tpr / nr_f )
# print "TN/N:" , str ( total_tnr / nr_f )
# print "AUC:" , str ( total_auc / nr_f )


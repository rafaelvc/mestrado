import sys
from numpy import *
# If the package has been installed correctly, this should work:
import Gnuplot, Gnuplot.funcutils

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


def plot(points,title=""): 

    # startup, debug 1 output on stderr a
    # g = Gnuplot.Gnuplot(debug=1)
    points.sort()
    g = Gnuplot.Gnuplot()
    g.title(title) # (optional)
    # g('set data style linespoints') # give gnuplot an arbitrary command
    g('set xrange[0:1]')
    g('set yrange[0:1]')
    g('set xlabel "False Positive Rate"')
    g('set ylabel "True Positive Rate"')
    g('set label 1 "AUC: ' + str ( auc(points) ) + '" at 0.1,0.95 ' ) 
    g('set terminal png size 600 400')
    g('set output "' + title + '.png"')
    g.plot(Gnuplot.Data(points, with_="lines lt 1"))
    raw_input('gplot.ps generated. \nPlease press return to continue...\n')



if __name__ == '__main__':
    fp = open(sys.argv[1])
    while 1:
        line = fp.readline()
        if not line:
            break
        if line[:5] == "GPOUT":
            gp_out = [ float(g) for g in line[6:].split(",") ]
            line = fp.readline()
            classes = [ int(c) for c in line[7:].split(",") ] 
            break
    fp.close()
    print gp_out

	# The PG algorithm is working with a further test, so discarting the last one!
    # gp_out = gp_out[:-1]
    # classes = classes[:-1]
    rates = [] 
    for gpo in gp_out:
        tpr = fpr = 0.0
        tp = tn = fn = fp = 0.0 	
        for i in range(0, len(gp_out)):
            if gp_out[i] >= gpo and classes[i] == 1:
                tp += 1.0 
            elif gp_out[i] < gpo and classes[i] == 0:
                tn += 1.0
            elif gp_out[i] > gpo and classes[i] == 0:
                fp += 1.0
            elif gp_out[i] <= gpo and classes[i] == 1:
                fn += 1.0
        tpr = tp / (tp + fn)  
        fpr = fp / (tn + fp)  
        rates.append([fpr, tpr])	
    print rates

    if (len(sys.argv) > 2) and sys.argv[2] == "-plot": 
        plot(rates, sys.argv[3]) 
    if (len(sys.argv) > 2) and sys.argv[2] == "-auc": 
        rates.sort()
        print "Auc: " 	
    else:
        rates.sort()
        for r in rates:
            print str(r).replace('[','').replace(']','').replace(' ','')


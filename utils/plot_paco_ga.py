from numpy import *
# If the package has been installed correctly, this should work:
import Gnuplot, Gnuplot.funcutils


def plot(points=None,title=""):

        # startup, debug 1 output on stderr a
        # g = Gnuplot.Gnuplot(debug=1)
        # points.sort()
        g = Gnuplot.Gnuplot()
        g.title(title) # (optional)
        g('set data style linespoints') # give gnuplot an arbitrary command
        g('set xrange[0:1]')
        g('set yrange[0:1]')
        g('set xlabel "False Positive Rate"')
        g('set ylabel "True Positive Rate"')
        g('set label 1 "AUC: ' + str ( "" ) + '" at 0.1,0.95 ' )
        g('set terminal postscript')
        g('set output "gplot.ps"')
        g('plot [0,1], [1,2], [3,4]')
  	   # g('plot ' + str([22,11],[28,11],[19,11],[22,11],[19,11],[22,11],[28,11],[28,11],[19,11],[19,11],[19,11],[19,11],[19,11],[19,11],[19,11],[19,11],[19,11],[19,11],[19,11],[28,11],[28,11],[19,11],[19,11],[19,11],[19,11],[22,11],[28,11],[28,11],[22,11],[19,11],[19,11],[19,11],[19,11],[19,11],[19,11],[19,11],[19,11],[19,11],[19,11]])) 
        # + ',' + str([[19,11],[19,11],[19,11],[19,11],[19,11]]))
        # Plot a list of (x, y) pairs (tuples or a numpy array would
        # also be OK):
        # g.plot(points)
        raw_input('gplot.ps generated. \nPlease press return to continue...\n')



if __name__ == "__main__": 
	plot()

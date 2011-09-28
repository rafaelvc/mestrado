from numpy import *

# If the package has been installed correctly, this should work:
import Gnuplot, Gnuplot.funcutils
def demo(): 

# startup, debug 1 output on stderr a
# g = Gnuplot.Gnuplot(debug=1)
	g = Gnuplot.Gnuplot()
	g.title('A simple example') # (optional)
	g('set data style linespoints') # give gnuplot an arbitrary command
	g('set terminal postscript')
	g('set output "gplot.ps"')
# Plot a list of (x, y) pairs (tuples or a numpy array would
# also be OK):
	# g.plot([[0,1.1], [1,5.8], [2,3.3], [3,4.2]])
	g.plot([[1.0,0.66], [0.8,0.66], [0.8,0.33], [0.6,0.33], [0.4,0.33], [0.2,0.33], [0.2,0.0], [0.0,0.0]])

raw_input('Please press return to continue...\n')

# raw_input('Please press return to continue...\n')


# when executed, just run demo():
if __name__ == '__main__':
    demo()




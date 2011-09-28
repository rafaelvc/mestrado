# import xml.dom.minidom 
# from xml.dom.minidom  import Node
# import Gnuplot

# in_file = sys.argv[1]
# doc = xml.dom.minidom.parse(in_file)
# vivarium = doc.getElementsByTagName('Vivarium')
# if vivarium:    
#     hallOffame = vivarium.getElementsByTagName('HallOfFame') 
#     fitness = hallOffame.getElementsByTagName('Fitness') 
#     fit_value = float ( fitness.firstChild.data )
#     print fit_value 
#     print "ok"
# 


# grep -m1 -A3 HallOfFame $fobm | grep Fit | sed s/^.*\"\>//g | cut -d'<' -f1
import sys
from os import popen 
from glob import glob
from numpy import average,std 

indir=sys.argv[1]
files = glob(indir + 'results.*/*.obm')
fit = [] 
for fobm  in files: 
    getfitShCMD = "grep -m1 -A3 HallOfFame " + fobm +  ' | grep Fit | sed s/^.*\\"\\>//g | cut -d\'<\' -f1'
    cmd = popen( getfitShCMD ) 
    fitvalue = float( cmd.read()[:-1] ) 
    fit.append( fitvalue ) 

print "$%2.2f\\pm%2.2f$" % (average( fit ) , std( fit ))








 

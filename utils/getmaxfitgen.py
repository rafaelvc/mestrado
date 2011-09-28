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

import sys
from os import popen 
from glob import glob
from numpy import average,std 

def out_iter(out): 
    break_out = out.split('\n')
    for line in break_out: 
        yield line 

indir=sys.argv[1]
title=sys.argv[2]
files = glob(indir + 'results.*/results.*/*.log')
fit = [] 

maxfitgen = [] 
for flog in files: 
    getfitShCMD =  "grep -A3 fitness " + flog +  " | grep Max | sed 's/^.\\+>\\(.\\+\\)<.\\+$/\\1/g'"
    cmd = popen( getfitShCMD ) 
    fitgen = []
    cont = 0
    print flog
    for line in out_iter(cmd.read()): 
        if line and (cont % 2) == 0: # openbeagle logs twice  
            fitgen.append( float( line ) )
        cont += 1
    maxfitgen.append( (fitgen,flog) )
   

outf=open( title + '.csv', "w" ) 
gens=len(fitgen)

points = []
for g in xrange(0,gens): 
    f = []
    for fit,flog in maxfitgen: 
        try: 
            f.append( fit[g] ) 
        except: 
            print "Erro: ", flog
            sys.exit(1)
    outf.write( "%2.1f;%2.2f\n" % ( (g+1), average(f) ) )
sys.exit(0) #needed by the caller
 

# outf.write( "%2.1f;%2.2f\n" % ((g+1),average(f)) ) 
# outf.close()





 

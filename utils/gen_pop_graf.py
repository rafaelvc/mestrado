import xml.dom.minidom 
from xml.dom.minidom  import Node
import Gnuplot
import sys

class PGInfo: 
    def __init__(self,gen,fitAvg,fitMin,fitMax):
        self.generation = gen
        self.fitnessAvg = fitAvg
        self.fitnessMin = fitMin
        self.fitnessMax = fitMax

def plot(title, out_file, *groupPoints):

    # startup, debug 1 output on stderr a
    # g = Gnuplot.Gnuplot(debug=1)
    # points.sort()
    g = Gnuplot.Gnuplot()
    g.title(title) # (optional)
    # g('set style data linespoints') # give gnuplot an arbitrary command
#    g('set xrange[0:' + str( max( [ gen for gen,info in groupPoints[0] ] ) ) + ']')
#    print groupPoints[0]
    g.set_range("xrange",(0,max([ gen for gen,info in groupPoints[0] ])))
    g.set_range("yrange", (0,1))
    g.set_label("xlabel", "Generations")
#    g('set xlabel "Generations"')
    g.set_label("ylabel","Fitness")
#    g('set label 1 "AUC: ' + str ( auc(points) ) + '" at 0.1,0.95 ' )
#    g('set terminal postscript')
    g('set terminal png large transparent size 600 400')
    g('set output "' + out_file +  '.png"')
    # for points in groupPoints: 
    g.plot(Gnuplot.Data(groupPoints,with_='lines lt 2'))
   # g('plot ' + str(groupPoints))
    raw_input('\nPlease press return to continue...\n')

def getAttrValue(namedNodeMap, atrrName):
    for i in xrange(0,namedNodeMap.length):
        attr = namedNodeMap.item(i)   
        if attr.name == attrName:
            return attr.value 
    return None

title = sys.argv[1]
in_file = sys.argv[2]
out_file = sys.argv[3]

doc = xml.dom.minidom.parse(in_file)
pginfo_dict = {}
for log in doc.getElementsByTagName('Log'):
    stats = log.getElementsByTagName('Stats') 
    if stats: 
        for s in stats: 
            if s.getAttribute("id") == "vivarium":
                generation = int ( s.getAttribute("generation") )
                for m in s.getElementsByTagName("Measure"):
                    if m.getAttribute("id") == "fitness":
                        fitness_avg = float ( m.getElementsByTagName("Avg")[0].firstChild.data )
                        fitness_max = float ( m.getElementsByTagName("Max")[0].firstChild.data )
                        fitness_min = float ( m.getElementsByTagName("Min")[0].firstChild.data ) 
                pginfo_dict[generation] = PGInfo(gen=generation, fitAvg=fitness_avg, fitMax=fitness_max, fitMin=fitness_min)

points_genfitavg = []
points_genfitmax = []
points_genfitmin = []
for gen in pginfo_dict.keys():
    points_genfitavg.append( [ gen,pginfo_dict[gen].fitnessAvg ] )
    points_genfitmax.append( [ gen,pginfo_dict[gen].fitnessMax ] ) 
    points_genfitmin.append( [ gen,pginfo_dict[gen].fitnessMin ] )

points_genfitavg.sort()
points_genfitmax.sort()
points_genfitmin.sort()

plot(title, out_file, points_genfitavg, points_genfitmax, points_genfitmin)


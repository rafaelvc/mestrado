# import pprint
 
# import xml.dom.minidom
# from xml.dom.minidom import Node
 
# doc = xml.dom.minidom.parse("beagle.log")
# logger = doc.getElementsByTagName("Logger")
# print len( logger.childNodes )
## for log in logger.getElementsByTagName("Log")[0]:
#	if log.nodeType == Node.TEXT_NODE: 
#		print log.data 
#


# mapping = {}
# viv = doc.getElementsByTagName("Vivarium")
# deme = pop.getElementsByTagName("Deme")
# pop =  viv.getElementsByTagName("Population")
# for individual in pop: 
#	print individual 
      
# for node in doc.getElementsByTagName("Vivarium"):
#  print node 

#  isbn = node.getAttribute("isbn")
#  L = node.getElementsByTagName("title")
#  for node2 in L:
#    title = ""
#    for node3 in node2.childNodes:
#     if node3.nodeType == Node.TEXT_NODE:
#        title += node3.data
#    mapping[isbn] = title
 
# mapping now has the same value as in the SAX example:
# pprint.pprint(mapping)



import os, sys, glob, io
from lxml import etree 
from scipy import *


# f = os.popen('tgdata.dat', 'w') 
f = open('tgdata.dat', 'w') 
et = etree.parse("beagle.log")
root = et.getroot()
for log in root.iter("Log"):
	stats = log.find("Stats")
	if stats is not None and stats.get("id") == "vivarium": 
		gen = stats.get("generation")
		fit = stats.find("Measure").find("Max").text 
		f.write( gen + " " + fit + "\n" )
#		print >>f, gen + " " + fit 
# f.flush()
f.close()


# data=io.array_import.read_array('tgdata.dat')
# plotfile='tgdata.png'
# gplt.plot(data[:,0],data[:,1],'title "Generatio vs. Fitness" with points')
# gplt.xtitle('Generation')
# gplt.ytitle('Fitness [%]')
# gplt.grid("off")
# gplt.output(plotfile,'png medium transparent picsize 600 400')










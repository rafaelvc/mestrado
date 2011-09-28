import pprint
 
import xml.dom.minidom
from xml.dom.minidom import Node
 
doc = xml.dom.minidom.parse("beagle.obm")
 
# mapping = {}
 
pop = doc.getElementsByTagName("Vivarium")
deme = pop.getElementsByTagName("Deme")
pop =  deme.getElementsByTagName("Population")
for individual in pop: 
	print individual 
      
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


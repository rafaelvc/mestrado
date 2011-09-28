
import sys

from numpy import * 
from numpy.random import 
from scipy.linalg.basic import norm 

def 


def nearest():
	
	return 	

def generate_detector(data,n,maxd,mind):

	rows,coluns=data.shape
	if not n:
		n=rows	
	if not max:
		maxv = data.max(0)
		minv = data.min(0) 
	detectors = None
	for i in xrange(0,coluns)
		c = uniform( minv(i), maxv(i), size=(n,1) 
		if not detectors:
			detectors=c
		else:
			detectors=hstack((detectors,c))
	return detectors 


def rns(data,dr,dage,n,dknears,ndtectors,runs): 
	
	data = load_data(dt_file)

	drows,cols=data.shape
	
	detectors = generate_detectors(data)
	age_detectors = zeros(drows,1) 

	for r in xrange(0,runs): 
		
		i = 1
		
		for d in detectors:   

			nearestcells,dists,refs = nearest(data,d,dknears) 
			mean_nearest = nearestcells.mean(axis=0)
			mean_dist = dists.mean() 

			if mean_dist < dr: 

				if age_detectors(i) > dage:
					d = generate_detectors(data,1)
					age_detectors(i)  = 0 
				else:
					dir = (d - mean_nearest) / dknears
					d = d + (n * dir)	
					age_detectors(i) += 1 
			else:


				exp( -1.0 * ( pow( norm((d-x),2), 2 ) 
	
			i += 1


			

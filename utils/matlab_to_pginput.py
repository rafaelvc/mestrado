import sys
import re

def drop_exp(nr,exp,signal):

	nr_ = "" 
	sinal = False
	splitted = nr.split(".") 
	main = splitted[0]
	dec = splitted[1]
	if exp == 0:        #does not need any conversion
		return nr
	if main[0] == "-": #sinal 
		main = main[1:]
		sinal = True 
	if signal == "+": 
		size_dec = len(dec)
		if size_dec <= exp: 
			nr_ = main + dec
			for i in xrange(exp-size_dec): 
				nr_ = nr_ + '0'
			nr_ = nr_ + ".0" 
		else: 
			main = re.sub('^0+','',main) #0.123.. case
			nr_ = main + dec[:exp] + "."
			nr_ = nr_ + dec[(-1 * (size_dec-exp)):]
	else:
		size_main = len(main)
		if size_main <= exp: 
			nr_ = "0." 
			for i in xrange(exp-size_main): 
				nr_ = nr_ + '0'
			nr_ = nr_ +  main + dec
		else: 
			nr_ = main[:(-1 * exp)] + "."
			nr_ = nr_ + main[(size_main-exp):] + dec 
	if sinal: 
		nr_ = "-" + nr_
	return  nr_


fp = open(sys.argv[1])
fp_ = open(sys.argv[1] + ".fixed", "w")
exp_r = re.compile('^(.*)e(\+|\-)0*([0-9]+)$')
while True:
	l = fp.readline()
	if not l:
		break
	new_l = []
	for i in l.split(","):
		dec = exp_r.search(i)
		if dec: 
			nr_main = dec.group(1)
			sinal_exp = dec.group(2) 
			nr_exp = dec.group(3)
			nr = drop_exp( nr_main, int(nr_exp), sinal_exp ) 
		else:
			nr = i.rstrip()
		new_l.append(nr)
	new_l = str(new_l)[1:-1] # change to str and removes [,]
	new_l = new_l.replace(' ','') # replace "1", "2", "3" by "1","2","3" 
	new_l = new_l.replace('\'','') # replace "1","2","3" by 1,2,3 
	fp_.write( new_l )
	fp_.write( "\n" )
fp.close()
fp_.close()


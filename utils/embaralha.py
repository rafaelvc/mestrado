import random 
import sys

fp = open(sys.argv[1])
fp_ = open(sys.argv[2],"w")

lines = 0
lines_ = []
while 1: 
	l = fp.readline()
	if not l: 
		break
	lines_.append(l)
	lines += 1

r = lines
while r > 0: 
        l = []
	rd = random.randrange(0,r)
	fp_.write(lines_[rd])	
	if rd == r-1:
		lines_.pop()
	elif rd == 0:
		for i in range(1,r):
			l.append(lines_[i])
		lines_ = l
	else:
		# print str(r) + " - " + str(rd) + " - " + str(len(lines_))
		for i in range(0,rd):
			l.append(lines_[i])
		for i in range(rd+1,r):
			l.append(lines_[i])
		lines_ = l
	r -= 1

fp.close()
fp_.close()
	

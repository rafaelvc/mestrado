

def indv(f1,f2,f3,f4):
	return (f2+(f1+f4)) - (f1*f4)

def indv_(dict) 
    return ((dtf2*f6) + f5/f6)/ (f2*f5)/(f4*f3)


fd = open("valida")
cont = 0
while True and fd:
	ln = fd.readline()
	if ln == "***\n":
		break
	if (cont % 2) == 0: 
		ln = ln.rstrip() # removes \n
		fs = ln.split(", ")	
		f1 = float (fs[0])
		f2 = float (fs[1])
		f3 = float (fs[2])
		f4 = float (fs[3])
		print indv(f1,f2,f3,f4)
	cont += 1

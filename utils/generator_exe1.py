

def generator1(a):
     pop = True
     for z in a[:]: 
        if pop: 
            pop = False
            r = a.pop()
        else:
            pop = True
            r = a.pop(0)
        yield r, a

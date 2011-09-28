import sys

# This is what openbeagle does whenever there is a zero div
def check_forzero_div(a,b):
    if b < 0.001 and b > -0.001:
        return 1.0
    return a / b 

def indv_(sample):
    try:
        arg1 = check_forzero_div(sample['f5'], sample['f6'])
        arg2 = check_forzero_div((sample['f2'] * sample['f5']), (sample['f4'] * sample['f3']))
        return check_forzero_div(((sample['f2'] * sample['f6'])+arg1), arg2)
    except ZeroDivisionError: 
        print "A zero division in the sample: "
        print sample

fp = open(sys.argv[1]) 
samples = []
while 1: 
    line = fp.readline()
    if not line: 
        break
    line = line.rstrip().split(",")
    features_value = [ float (f) for f in line[1:] ] 
    sample = {}
    for f in xrange(1,len(features_value)+1):
        sample[ 'f' + str(f) ] = features_value[f-1]
    # print sample
    samples.append( sample ) 

gpout = []
for sample in samples:
    gpout.append( indv_(sample) ) 
#    print gpout
print '\n'.join( [str (x) for x in gpout] )
fp.close()

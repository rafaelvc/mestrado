import sys

folds = 5
fname = sys.argv[1]

fp = open(fname)
samples = []
total_samples = 0
while 1: 
    line = fp.readline()
    if not line: 
        break
    total_samples += 1
    samples.append(line)
fp.close()

nrtest = (total_samples / folds)
rest   = (total_samples % folds)

for i in xrange(0,folds):

    fname = sys.argv[1] + ".teste" + str(i + 1)
    fp_fold = open(fname, "w") 
    test_ini = nrtest * i
    test_end =  test_ini + nrtest 
    for j in xrange(test_ini,test_end): 
        line = str( samples[j] ) 
        fp_fold.write( line )
    fp_fold.close()

    fname = sys.argv[1] + ".treino" + str(i + 1)
    fp_fold = open(fname, "w") 
    for j in xrange(0,total_samples-rest): 
        if j < test_ini or j >= test_end: 
            line = str( samples[j] ) 
            fp_fold.write( line )

    #place rest in the train 
    if rest > 0:
        for j in xrange(0,rest):
            line = samples[(nrtest*folds)+j]  
            fp_fold.write( line )

    fp_fold.close()




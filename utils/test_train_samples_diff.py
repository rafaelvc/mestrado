import sys
import pdb 

ftrain = open(sys.argv[1])
ftest = open(sys.argv[2])
ftest_fixed = None

if len(sys.argv) == 4: 
    ftest_fixed = open(sys.argv[3], 'w')

trainSamples = []
while True:  
    line = ftrain.readline()
    if not line:
            break
    # trainSamples.append(line.split(','))
    trainSamples.append(line)
    line = ''

ftrain.close()

testSamples = []
while True:  
    line = ftest.readline()
    if not line:
            break
    # testSamples.append(line.split(','))
    testSamples.append(line)
    line = ''
ftest.close()

trainCount = 1
equalSamples = []
for strain in trainSamples:
    testCount = 1 
    for stest in testSamples:
        if strain == stest:
        #    equalSamples.append( (trainCount,testCount) ) 
            equalSamples.append( testCount ) 
        testCount = testCount + 1
    trainCount = trainCount + 1
# print equalSamples.join('\n')
uniq = set( equalSamples )
uniq_sorted = sorted( uniq )
print '\n'.join( [ str(x) for x in uniq_sorted ] ) 
# print len(equalSamples)

if ftest_fixed: 
    testCount = 1
    for stest in testSamples:
        if testCount not in uniq_sorted: 
            ftest_fixed.write(stest)
        testCount += 1
    ftest_fixed.close()

            

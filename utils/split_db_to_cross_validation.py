# run python split_db_to_cross_validation.py M/box/wdbc_one_classM_box.data.fuzzy <target> 

import sys

target = sys.argv[2]
nr_cross_validade = 5 
fp = open(sys.argv[1])
lines = 0
nr_targets = 0
nr_outliers = 0
while 1:
	l = fp.readline()
	if not l: 
		break 
	if l.split(",")[0] == target:  #considerando label na primeira coluna
		nr_targets += 1
	else:
		nr_outliers += 1
	lines += 1	

for i in range(0,nr_cross_validade):

	fp.seek(0)
	fp_tre = open(sys.argv[1] + ".treino" + str(i+1), "w")		
	fp_tes = open(sys.argv[1] + ".teste" + str(i+1), "w")		
	tar_ini = i * (nr_targets / nr_cross_validade) 
	tar_fim = tar_ini + (nr_targets / nr_cross_validade) 
	t_ = 0
	while 1: 
		l = fp.readline()
		if not l: 
			break 
		if l.split(",")[0] == target:
			if t_ >= tar_ini and t_ < tar_fim: 
				fp_tes.write(l)
			else: 
				fp_tre.write(l)
			t_ += 1 
		else:
			# fp_tes.write(l) usa outliers no treino e no teste
			fp_tre.write(l)
	fp_tes.close()
	fp_tre.close()

fp.close()

print "Lines: " + str(lines)
print "Targets: " + str(nr_targets)
print "Outliers: " + str(nr_outliers)




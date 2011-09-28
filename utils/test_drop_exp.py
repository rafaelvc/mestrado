from matlab_to_pginput import drop_exp

print "Expoentes negativos:"
print "Teste case1:"
esperado = "0.010"
resultado = drop_exp("1.0",2,"-")
if resultado == esperado:
	print "T1: OK"
else:
	print "T1: FAILED!"
print "Result: " + resultado 
print "Teste case2:"
esperado = "0.120"
resultado = drop_exp("12.0",2,"-")
if resultado == esperado:
	print "T2: OK"
else:
	print "T2: FAILED!"
print "Result: " + resultado 
print "Teste case3:"
esperado = "1.2389"
resultado = drop_exp("123.89",2,"-")
if resultado == esperado:
	print "T3: OK"
else:
	print "T3: FAILED!"
print "Result: " + resultado 
print "Teste case4:"
esperado = "-1.2389"
resultado = drop_exp("-123.89",2,"-")
if resultado == esperado:
	print "T4: OK"
else:
	print "T4: FAILED!"
print "Result: " + resultado 
print "Teste case5:"
esperado = "111111111111.1112389"
resultado = drop_exp("111111111111111.2389",3,"-")
if resultado == esperado:
	print "T5: OK"
else:
	print "T5: FAILED!"
print "Result: " + resultado 

print "Expoentes positivos:"
print "Teste case6:"
esperado = "111111111111111238.9"
resultado = drop_exp("111111111111111.2389",3,"+")
if resultado == esperado:
	print "T6: OK"
else:
	print "T6: FAILED!"
print "Result: " + resultado 
print "Teste case7:"
esperado = "12389.0"
resultado = drop_exp("1238.9",1,"+")
if resultado == esperado:
	print "T7: OK"
else:
	print "T7: FAILED!"
print "Result: " + resultado 
print "Teste case8:"
esperado = "123899000.0"
resultado = drop_exp("1238.99",5,"+")
if resultado == esperado:
	print "T8: OK"
else:
	print "T8: FAILED!"
print "Result: " + resultado 
print "Teste case9:"
esperado = "19987.654321"
resultado = drop_exp("1.9987654321",4,"+")
if resultado == esperado:
	print "T9: OK"
else:
	print "T9: FAILED!"
print "Result: " + resultado 
print "Teste case10:"
esperado = "8765.4321"
resultado = drop_exp("0.87654321",4,"+")
if resultado == esperado:
	print "T10: OK"
else:
	print "T10: FAILED!"
print "Result: " + resultado 





# <MUL><SUB><MUL><X/><W/></MUL><DIV><Y/><W/></DIV></SUB><ADD><MUL><X/><Z/></MUL><ADD><W/><Y/></ADD></ADD></MUL>

a = "<MUL><SUB><MUL><X/><W/></MUL><DIV><Y/><W/></DIV></SUB><ADD><MUL><X/><Z/></MUL><ADD><W/><Y/></ADD></ADD></MUL>"

for crt in a:


if str = "MUL": 
	indiv += "( * "
elif str = "SUB": 
	indiv += "( - "
elif str = "ADD": 
	indiv += "( + "
elif str = "DIV": 
	indiv += "( / "
elif str = "X" or str = "Y" or str = "Z" or str = "W"
	indiv += " " + str 

def get_value(var): 
	if var = "x":
	  return 1
	else
	  return 2

def isOperator(x):
	return (x == '*' or x == '+' or x == '/' or x == '-')

def isOperand(x)
	return (x == 'X' or x == 'Y' or  x == 'Z' or  x == 'W')

def make_stack(indv): 
	for x in indiv: 
		if isOperador 


def process_stack():
	while len(stack) > 1:
		if isOperator(stack[0]):
			stack.insert(0,x)
		if isOperand(x):
			if isOperand(stack[0]):
				x1 = get_value(x)
				x2 = get_value(stack.pop())
				op = stack.pop())
				result = apply_op(op, x1, x2)
				stack.insert(0,result)
			else
				stack.insert(0,x)

	

a = "((x y *) y)+)"
for x in a: 

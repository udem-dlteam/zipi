import ast as AST

def parse(source):
    return AST.parse(source)

def dump(ast):
    return eval(AST.dump(ast,True,False))

def lstr(l):
    return " ".join(l)

def Module(*,body):
    return("(Module " + lstr(body) + ")")

def FunctionDef(*, name, args, body, decorator_list, returns):
    return("(FunctionDef \""+ name + "\" " + lstr(body) + ")")

def arguments(*, args, vararg, kwonlyargs, kw_defaults, kwarg, defaults):
    return("(arguments)")

def Return(*, value):
    return("(Return "+ value + ")")

def BinOp(*, left, op, right):
    return("(BinOp " + op + " "+ left + " " + right + ")")

def Add():
    return("(Add)")

def Call(*, func, args, keywords):
    return("(Call " + str(func) + " (" + lstr(args) + ")" + " (" + lstr(keywords) + "))")

def arg(*, arg, annotation):
    return("(arg " + arg + " " + str(annotation) + ")")

def Name(*, id, ctx):
    return("(Name \"" + id + "\" " + ctx + ")")

def Load():
    return("(Load)")

def Store():
    return("(Store)")

def Expr(*,value):
    return("(Expr " + value + ")")

def Num(*,n):
    return("(Num " + str(n) + ")")

def main():
    print(dump(parse("""
def f(x):
    return x+x
print(f(10))
""")))

main()

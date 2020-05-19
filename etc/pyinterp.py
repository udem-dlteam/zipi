import argparse
import ast as AST

debug = False


def interp_file(path):
    source = read_file(path)
    interp(parse(source))

def read_file(path):
    with open(path, 'rb') as f:
        content = f.read()
    return content

def parse(source):
    return AST.parse(source)

def interp(ast):
    code = comp(ast)
    run(code)



def comp(ast):

    cte = dict()  # unused for now

    (cte1, code) = comp_mod(cte, ast)

    return code

def run(code):

    rte = dict()  # unused for now

    def cont(rte):
        print('done!')

    code(rte, cont)




# Compilation of a module.

def comp_mod(cte, ast):

    if isinstance(ast, AST.Module):
        # Module(stmt* body, type_ignore *type_ignores)
        if debug: print('AST.Module')
        return comp_stmt_seq(cte, ast, ast.body)

    else:
        assert False, 'comp_mod expected a module AST'

def comp_stmt_seq(cte, ast, stmt_seq):
    if debug: print('comp_stmt_seq')
    if len(stmt_seq) == 0:
        return gen_stmt_empty(cte, ast)
    else:
        (cte1, code1) = comp_stmt(cte, stmt_seq[0])
        if len(stmt_seq) == 1:
            return (cte1, code1)
        else:
            (cte2, code2) = comp_stmt_seq(cte1, ast, stmt_seq[1:])
            return gen_stmt_seq(cte2, ast, code1, code2)



# Compilation of a statement.

def comp_stmt(cte, ast):

    if isinstance(ast, AST.Expr):
        # Expr(expr value)
        if debug: print('AST.Expr')
        (cte1, code1) = comp_expr(cte, ast.value)
        return gen_Expr(cte1, ast, code1)

    elif isinstance(ast, AST.Pass):
        # Pass
        if debug: print('AST.Pass')
        return gen_Pass(cte, ast)

    else:
        assert False, 'comp_stmt expected a statement AST'



# Compilation of an expression.

def comp_expr(cte, ast):

    if isinstance(ast, AST.BinOp):
        # BinOp(expr left, operator op, expr right)
        if debug: print('AST.BinOp')
        (cte1, code1) = comp_expr(cte, ast.left)
        (cte2, code2) = comp_expr(cte, ast.right)
        return gen_BinOp(cte2, ast, ast.op, code1, code2)

    elif isinstance(ast, AST.UnaryOp):
        # UnaryOp(unaryop op, expr operand)
        if debug: print('AST.UnaryOp')
        (cte1, code1) = comp_expr(cte, ast.operand)
        return gen_UnaryOp(cte2, ast, ast.op, code1, code2)

    elif isinstance(ast, AST.Num):
        if debug: print('AST.Num')
        return gen_constant(cte, ast, ast.n)

    elif isinstance(ast, AST.Str):
        if debug: print('AST.Str')
        return gen_constant(cte, ast, ast.s)

    elif isinstance(ast, AST.Bytes):
        if debug: print('AST.Bytes')
        return gen_constant(cte, ast, ast.s)

    elif isinstance(ast, AST.Ellipsis):
        if debug: print('AST.Ellipsis')
        return gen_constant(cte, ast, Ellipsis)

    elif isinstance(ast, AST.NameConstant):
        if debug: print('AST.NameConstant')
        return gen_constant(cte, ast, ast.value)

    else:
        print(ast)
        print(dir(ast))
        assert False, 'comp_expr expected an expression AST'



# Code generation functions.

# Note that 'code' is represented as a function closure and 'running'
# code consists of calling the function with the runtime environment (rte)
# and continuation (cont) that continues the execution.  The continuation
# receives the new rte and, if the code is for an expression, the result
# of the expression evaluation.


def gen_stmt_seq(cte, ast, code1, code2):

    def code(rte, cont):
        code1(rte, lambda rte1: code2(rte1, cont))

    return (cte, code)

def gen_stmt_empty(cte, ast):

    def code(rte, cont):
        cont(rte)

    return (cte, code)



def gen_Pass(cte, ast):

    def code(rte, cont):
        stmt_end(rte, cont, ast)

    return (cte, code)



def gen_Expr(cte, ast, code_expr):

    def code(rte, cont):
        code_expr(rte, lambda rte1, val1: cont(rte1))

    return (cte, code)



def gen_BinOp(cte, ast, op, code1, code2):

    if debug: print(op)

    if isinstance(op, AST.Add):
        sem_op = sem_Add
    elif isinstance(op, AST.Sub):
        sem_op = sem_Sub
    elif isinstance(op, AST.Mult):
        sem_op = sem_Mult
    elif isinstance(op, AST.Div):
        sem_op = sem_Div
    elif isinstance(op, AST.Mod):
        sem_op = sem_Mod
    elif isinstance(op, AST.FloorDiv):
        sem_op = sem_FloorDiv
    else:
        assert False, 'gen_BinOp unimplemented operator'

    def code(rte, cont):
        code1(rte,
              lambda rte1, val1:
                code2(rte1,
                      lambda rte2, val2:
                        sem_op(rte2, cont, val1, val2, ast)))

    return (cte, code)

def sem_Add(rte, cont, val1, val2, ast):
    result = val1 + val2
    expr_end(rte, cont, result, ast)

def sem_Sub(rte, cont, val1, val2, ast):
    result = val1 - val2
    expr_end(rte, cont, result, ast)

def sem_Mult(rte, cont, val1, val2, ast):
    result = val1 * val2
    expr_end(rte, cont, result, ast)

def sem_Div(rte, cont, val1, val2, ast):
    result = val1 / val2
    expr_end(rte, cont, result, ast)

def sem_Mod(rte, cont, val1, val2, ast):
    result = val1 % val2
    expr_end(rte, cont, result, ast)

def sem_FloorDiv(rte, cont, val1, val2, ast):
    result = val1 // val2
    expr_end(rte, cont, result, ast)



def gen_constant(cte, ast, val):

    def code(rte, cont):
        return sem_constant(rte, cont, val, ast)

    return (cte, code)

def sem_constant(rte, cont, val, ast):
    result = val
    expr_end(rte, cont, result, ast)



def expr_end(rte, cont, val, ast):

    # Simulate codeBoot GUI that shows the value of the expression
    # and waits for the user to click "next step" to continue execution.
    # Note that codeBoot will also use rte to show the value of variables.

    print('expression at '+str(ast.lineno)+'.'+str(ast.col_offset+1)+': value = '+repr(val))

    gui_wait_for_click(lambda: cont(rte, val))


def stmt_end(rte, cont, ast):

    # Simulate codeBoot GUI that shows the execution of a statement
    # and waits for the user to click "next step" to continue execution.
    # Note that codeBoot will also use rte to show the value of variables.

    print('statement at '+str(ast.lineno)+'.'+str(ast.col_offset+1))

    gui_wait_for_click(lambda: cont(rte))


def gui_wait_for_click(continue_execution):
    if debug:
        continue_execution()
    else:
        from threading import Timer
        Timer(1.0, continue_execution).start()
    


def main():
    parse = argparse.ArgumentParser(description='interp_file')
    parse.add_argument('file', help='source file')
    args = parse.parse_args()
    interp_file(args.file)

main()


# % cat test.py
# 1+2*3
# pass
# (2*21)%5
# pass
# 13/3
#
# % python3 pyinterp.py test.py
# expression at 1.1: value = 1
# expression at 1.3: value = 2
# expression at 1.5: value = 3
# expression at 1.3: value = 6
# expression at 1.1: value = 7
# statement at 2.1
# expression at 3.2: value = 2
# expression at 3.4: value = 21
# expression at 3.2: value = 42
# expression at 3.8: value = 5
# expression at 3.1: value = 2
# statement at 4.1
# expression at 5.1: value = 13
# expression at 5.4: value = 3
# expression at 5.1: value = 4.333333333333333
# done!

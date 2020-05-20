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

    trampoline(lambda: code(rte, cont))

def trampoline(execution_point):
    while execution_point is not None:
        #print('execution_point = ' + repr(execution_point))
        execution_point = execution_point()
    #print('exiting trampoline')



# Compilation of a module.

def comp_mod(cte, ast):

    if isinstance(ast, AST.Module):
        # Module(stmt* body, type_ignore *type_ignores)
        if debug: print('AST.Module')
        return comp_stmt_seq(cte, ast.body)

    else:
        assert False, 'comp_mod expected a module AST'

def comp_stmt_seq(cte, stmt_seq):
    if debug: print('comp_stmt_seq')
    if len(stmt_seq) == 0:
        return gen_stmt_empty(cte)
    else:
        (cte1, code1) = comp_stmt(cte, stmt_seq[0])
        if len(stmt_seq) == 1:
            return (cte1, code1)
        else:
            (cte2, code2) = comp_stmt_seq(cte1, stmt_seq[1:])
            return gen_stmt_seq(cte2, code1, code2)



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

    elif isinstance(ast, AST.Assign):
        # Assign(expr* targets, expr value, string? type_comment)
        if debug: print('AST.Assign')
        if len(ast.targets) == 1 and isinstance(ast.targets[0], AST.Name):
            id = ast.targets[0].id
            (cte1, code1) = comp_expr(cte, ast.value)
            return gen_var_set(cte1, ast, id, code1)
        else:
            assert False, 'comp_stmt only supports assigning to one variable'

    elif isinstance(ast, AST.While):
        # While(expr test, stmt* body, stmt* orelse)
        if debug: print('AST.While')
        (cte1, code1) = comp_expr(cte, ast.test)
        (cte2, code2) = comp_stmt_seq(cte1, ast.body)
        (cte3, code3) = comp_stmt_seq(cte1, ast.orelse)
        return gen_while(cte3, ast, code1, code2, code3)

    elif isinstance(ast, AST.If):
        # If(expr test, stmt* body, stmt* orelse)
        if debug: print('AST.If')
        (cte1, code1) = comp_expr(cte, ast.test)
        (cte2, code2) = comp_stmt_seq(cte1, ast.body)
        (cte3, code3) = comp_stmt_seq(cte1, ast.orelse)
        return gen_if(cte3, ast, code1, code2, code3)

    elif isinstance(ast, AST.Assert):
        # Assert(expr test, expr? msg)
        if debug: print('AST.Assert')
        (cte1, code1) = comp_expr(cte, ast.test)
        (cte2, code2) = comp_expr_opt(cte1, ast.msg)
        return gen_assert(cte2, ast, code1, code2)

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

    elif isinstance(ast, AST.Name):
        # Name(identifier id, expr_context ctx)
        if debug: print('AST.Name')
        return gen_var_get(cte, ast, ast.id)

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

def comp_expr_opt(cte, ast):
    if ast == None:
        return (cte, None)
    else:
        return comp_expr(cte, ast)


# Code generation functions.

# Note that 'code' is represented as a function closure and 'running'
# code consists of calling the function with the runtime environment (rte)
# and continuation (cont) that continues the execution.  The continuation
# receives the new rte and, if the code is for an expression, the result
# of the expression evaluation.


def gen_stmt_seq(cte, code1, code2):

    def code(rte, cont):
        return code1(rte, lambda rte1: code2(rte1, cont))

    return (cte, code)

def gen_stmt_empty(cte):

    def code(rte, cont):
        return cont(rte)

    return (cte, code)



def gen_Pass(cte, ast):

    def code(rte, cont):
        return stmt_end(rte, cont, ast)

    return (cte, code)



def gen_while(cte, ast, code1, code2, code3):

    def code(rte, cont):

        def dispatch(rte, val):
            if sem_false(val):
                return code3(rte, cont)
            else:
                return code2(rte, lambda rte2: code(rte2, cont))

        return code1(rte, dispatch)

    return (cte, code)



def gen_if(cte, ast, code1, code2, code3):

    def code(rte, cont):

        def dispatch(rte, val):
            if sem_false(val):
                return code3(rte, cont)
            else:
                return code2(rte, cont)

        return code1(rte, dispatch)

    return (cte, code)



def gen_assert(cte, ast, code1, code2):

    def code(rte, cont):

        def call_assertion_error(rte, val):
            raise AssertionError(val) # TODO: interface with interpreter exceptions

        def dispatch(rte, val):
            if sem_false(val):
                if code2 is None:
                    raise AssertionError # TODO: interface with interpreter exceptions
                else:
                    return code2(rte, call_assertion_error)
            else:
                return cont(rte)

        return code1(rte, dispatch)

    return (cte, code)



def gen_var_set(cte, ast, id, code1):

    def code(rte, cont):

        def var_set(rte, val):
            return sem_var_set(rte, cont, id, val, ast)

        return code1(rte, var_set)

    return (cte, code)



def gen_var_get(cte, ast, id):

    def code(rte, cont):
        return sem_var_get(rte, cont, id, ast)

    return (cte, code)



def gen_Expr(cte, ast, code1):

    def code(rte, cont):
        return code1(rte, lambda rte1, val1: cont(rte1))

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
        return code1(rte,
                     lambda rte1, val1:
                       code2(rte1,
                             lambda rte2, val2:
                               sem_op(rte2, cont, val1, val2, ast)))

    return (cte, code)

def sem_Add(rte, cont, val1, val2, ast):
    result = val1 + val2
    return expr_end(rte, cont, result, ast)

def sem_Sub(rte, cont, val1, val2, ast):
    result = val1 - val2
    return expr_end(rte, cont, result, ast)

def sem_Mult(rte, cont, val1, val2, ast):
    result = val1 * val2
    return expr_end(rte, cont, result, ast)

def sem_Div(rte, cont, val1, val2, ast):
    result = val1 / val2
    return expr_end(rte, cont, result, ast)

def sem_Mod(rte, cont, val1, val2, ast):
    result = val1 % val2
    return expr_end(rte, cont, result, ast)

def sem_FloorDiv(rte, cont, val1, val2, ast):
    result = val1 // val2
    return expr_end(rte, cont, result, ast)



def gen_constant(cte, ast, val):

    def code(rte, cont):
        return sem_constant(rte, cont, val, ast)

    return (cte, code)

def sem_constant(rte, cont, val, ast):
    result = val
    return expr_end(rte, cont, result, ast)

def sem_var_set(rte, cont, id, val, ast):
    rte[id] = val
    return stmt_end(rte, cont, ast)

def sem_var_get(rte, cont, id, ast):
    result = rte[id]
    return expr_end(rte, cont, result, ast)

def sem_false(val):
    return not val



def expr_end(rte, cont, val, ast):

    # Simulate codeBoot GUI that shows the value of the expression
    # and waits for the user to click "next step" to continue execution.
    # Note that codeBoot will also use rte to show the value of variables.

    return gui_wait_for_click(ast, ': value = '+repr(val), lambda: cont(rte, val))


def stmt_end(rte, cont, ast):

    # Simulate codeBoot GUI that shows the execution of a statement
    # and waits for the user to click "next step" to continue execution.
    # Note that codeBoot will also use rte to show the value of variables.

    return gui_wait_for_click(ast, '', lambda: cont(rte))


def gui_wait_for_click(ast, msg, continue_execution):

    print('at '+str(ast.lineno)+'.'+str(ast.col_offset+1)+'-'+str(ast.end_lineno)+'.'+str(ast.end_col_offset+1)+msg)

    if debug:
        return continue_execution  # trampoline will call continue_execution
    else:
        from threading import Timer
        Timer(0.1, lambda: trampoline(continue_execution)).start()
        return None  # exit trampoline


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

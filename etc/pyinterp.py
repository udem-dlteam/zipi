import argparse
import ast as AST

debug = False

absent = object()

class Context:
    def __init__(self, rte, cont, ast):
        self.rte = rte
        self.cont = cont
        self.ast = ast

    def set_continuation(self, cont):
        self.cont = cont

    def call(self):
        return self.cont(self.rte)

# object model
def make_dict():
    return dict()

def dict_get(d, key):
    if key in d:
        return d[key]
    else:
        return absent

def dict_set(d, key, value):
    d[key] = value

def class_getattribute(o, attr):
    return dict_get(o, attr)

def class_setattribute(o, attr, value):
    dict_set(o, attr, value)

def getattribute_from_class_mro(cls, name):
    __mro__ = class__mro__(cls)
    for cls in __mro__:
        attr = class_getattribute(cls, name)
        if attr is not absent:
            return attr
    return absent

def getattribute_from_obj_mro(o, name):
    __class__ = object_class(o)
    return getattribute_from_class_mro(__class__, name)

def make_class(name, module, bases):
    cls = make_dict()
    dict_set(cls, '__name__', name)
    dict_set(cls, '__module__', module)
    dict_set(cls, '__mro__', None)
    return cls

def make_builtin_class(name):
    # Set base classes when they do exist
    cls = make_class(name, 'builtins', None)
    return cls


def class_set__mro__(cls, mro):
    dict_set(cls, '__mro__', mro)

def class__mro__(cls):
    return dict_get(cls, '__mro__')

# Initialize integer class
def populate_builtin_int():
    dict_set(class_int, '__bool__', lifted_int_bool)
    dict_set(class_int, '__add__', lifted_int_add)
    dict_set(class_int, '__radd__', lifted_int_radd)
    dict_set(class_int, '__sub__', lifted_int_sub)
    dict_set(class_int, '__rsub__', lifted_int_rsub)
    dict_set(class_int, '__lt__', lifted_int_lt)
    dict_set(class_int, '__repr__', lifted_int_repr)

    class_set__mro__(class_int, [class_int, class_object])

def populate_builtin_object():
    # TODO: complete object magic method
    dict_set(class_object, '__repr__', lifted_object_repr)
    class_set__mro__(class_object, [class_object])

def populate_builtin_bool():
    # TODO: complete bool magic method
    dict_set(class_bool, '__bool__', lifted_bool_bool)

    class_set__mro__(class_bool, [class_bool, class_int, class_object])

def populate_builtin_str():
    # TODO: add the method of the str object
    class_set__mro__(class_str, [class_str, class_object])

def populate_builtin_NoneType():
    # TODO: add the method of the str object
    dict_set(class_NoneType, '__bool__', lifted_NoneType_bool)

    class_set__mro__(class_NoneType, [class_NoneType, class_object])

def make_object(cls):
    o = make_dict()
    dict_set(o, '__class__', cls)
    return o

def object_class(o):
    if o is None:
        return class_NoneType
    elif isinstance(o, int):
        return class_int
    elif isinstance(o, bool):
        return class_bool
    elif isinstance(o, str):
        return class_str
    else:
        __class__ = class_getattribute(o, '__class__')
        assert __class__ is absent, 'object does not have a class'
        return __class__

def lifted_object_repr(ctx, val):
    __name__ = getattribute_from_obj_mro(val, '__name__')
    result = "<class '" + __name__ + "'>"
    return expr_end(ctx, result)

def lifted_bool_bool(ctx, val):
    return expr_end(ctx, val)

def lifted_int_bool(ctx, val):
    if debug: print('int.__bool__')
    result = val != 0
    return ctx.cont(ctx.rte, result)

def lifted_int_add(ctx, val1, val2):
    # TODO: add type checking
    result = val1 + val2
    return expr_end(ctx, result)

lifted_int_radd = lifted_int_add

def lifted_int_sub(ctx, val1, val2):
    # TODO: add type check.
    result = val1 - val2
    return expr_end(ctx, result)

def lifted_int_rsub(ctx, val1, val2):
    return lifted_int_sub(ctx, val2, val1)

def lifted_int_lt(ctx, val1, val2):
    if debug: print('int.__lt__')
    # v1 = class_getattribute(val1, '**value**')
    # v2 = class_getattribute(val2, '**value**')
    # if v1 < v2:
    #     result = obj_True
    # else:
    #     result = obj_False
    result = val1 < val2
    return expr_end(ctx, result)

def lifted_int_floordiv(ctx, val1, val2):
    if val2 == 0:
        # TODO: implemented sem_raise
        #return sem_raise(ctx, lifted_ZeroDivisionError())
        assert False, 'Division by zero'
    else:
        result = val1 // val2
        return expr_end(ctx, result)

def lifted_int_repr(ctx, val):
    result = str(val)
    return expr_end(ctx, result)

def lifted_NoneType_bool(ctx, val):
    if debug: print('None.__bool__')
    result = False
    return ctx.cont(ctx.rte, result)

# XXX: need to decide if I keep this
def lower_object(obj):
    # dtype = class_getattribute(obj, '__class__')
    # if dtype in [class_int, class_bool, class_str]:
    #     value = class_getattribute(obj, '**value**')
    # else:
    #     value = obj
    value = obj
    return value

# XXX: need to decide if I keep this
def lift_object(obj):
    return obj
    # if isinstance(obj, int):
    #     return make_int(obj)
    # elif isinstance(obj, bool):
    #     # make_sure only one instance of bool
    #     if obj:
    #         return obj_True
    #     else:
    #         return obj_False
    # else:
    #     return obj

# Create builtins classes
class_object = make_builtin_class('object')
class_int = make_builtin_class('int')
class_bool = make_builtin_class('bool')
class_NoneType = make_builtin_class('NoneType')

class_str = make_builtin_class('str')
class_tuple = make_builtin_class('tuple')
class_list = make_builtin_class('list')

populate_builtin_object()
populate_builtin_int()
populate_builtin_bool()
populate_builtin_str()
populate_builtin_NoneType()
# TODO: populate other builtin classes


# Interpreter
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

    elif isinstance(ast, AST.BoolOp):
        if debug: print('AST.BoolOp')
        return gen_BoolOp(cte, ast, ast.op, ast.values)
        #return cte, lambda rte, cont: cont(rte, "WIP")
        assert False, 'WIP'

    elif isinstance(ast, AST.Compare):
        if debug: print('AST.Compare')
        result = gen_Compare(cte, ast, ast.left, ast.comparators, ast.ops)
        return result

    else:
        print(ast)
        print(dir(ast))
        assert False, 'comp_expr expected an expression AST'

def comp_expr_opt(cte, ast):
    if ast is None:
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
        return stmt_end(Context(rte, cont, ast))

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
            if val is False:
                return code3(rte, cont)
            else:
                return code2(rte, cont)

        def cast_bool(rte, val):
            ctx = Context(rte, dispatch, ast)
            return sem_bool(ctx, val)

        return code1(rte, cast_bool)

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

        def cast_bool(rte, val):
            ctx = Context(rte, dispatch, ast)
            return sem_bool(ctx, val)

        return code1(rte, cast_bool)

    return (cte, code)



def gen_var_set(cte, ast, id, code1):

    def code(rte, cont):

        def var_set(rte, val):
            return sem_var_set(Context(rte, cont, ast), id, val)

        return code1(rte, var_set)

    return (cte, code)



def gen_var_get(cte, ast, id):

    def code(rte, cont):
        return sem_var_get(Context(rte, cont, ast), id)

    return (cte, code)



def gen_Expr(cte, ast, code1):

    def code(rte, cont):
        return code1(rte, lambda rte1, val1: cont(rte1))

    return (cte, code)

def gen_logical_and(cte, ast, code1, code2):
    if debug: print('gen_logical_and')

    # XXX: look into runtime environment.

    def code(rte, cont):
        def cast_bool(rte1, val1):
            def dispatch(rte2, cond_val):
                if cond_val:
                    return code2(rte1, cont)
                else:
                    return cont(rte1, val1)

            ctx = Context(rte, dispatch, ast)
            return sem_bool(ctx, val1)

        return code1(rte, cast_bool)

        # return code1(rte,
        #              lambda rte1, val1:
        #                 cont(rte1, val1) if sem_false(val1) else code2(rte,
        #                                                         lambda rte2, val2:
        #                                                             cont(rte2, val2)))


    return (cte, code)

def gen_logical_or(cte, ast, code1, code2):
    if debug: print('gen_logical_or')

    def code(rte, cont):
        def cast_bool(rte1, val1):
            def dispatch(rte2, cond_val):
                if cond_val:
                    return cont(rte1, val1)
                else:
                    return code2(rte1, cont)
            return sem_bool(Context(rte1, dispatch, ast), val1)
        return code1(rte, cast_bool)

    return (cte, code)

def gen_BoolOp(cte, ast, op, values):
    if isinstance(op, AST.And):
        logical_op = gen_logical_and
    elif isinstance(op, AST.Or):
        logical_op = gen_logical_or
    else:
        assert False, 'Should not happen'
    return gen_BoolOp_seq(cte, ast, logical_op, values)


# Compilation of sequence of expressions

def gen_BoolOp_seq(cte, ast, logical_op, expr_seq):
    (cte1, code1) = comp_expr(cte, expr_seq[0])
    if len(expr_seq) == 1:
        return (cte1, code1)
    else:
        (cte2, code2) = gen_BoolOp_seq(cte, ast, logical_op, expr_seq[1:])
        return logical_op(cte, ast, code1, code2)

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
                               sem_op(Context(rte2, cont, ast),
                                      val1, val2)))

    return (cte, code)

# XXX: I don't know what name it should have
def comp_Compare_Op(op):
    if isinstance(op, AST.Eq):
        sem_op = sem_Eq
    elif isinstance(op, AST.NotEq):
        sem_op = sem_NotEq
    elif isinstance(op, AST.Lt):
        sem_op = sem_Lt
    elif isinstance(op, AST.Gt):
        sem_op = sem_Gt
    elif isinstance(op, AST.LtE):
        sem_op = sem_LtE
    elif isinstance(op, AST.GtE):
        sem_op = sem_GtE
    else:
        assert False, 'gen_Compare unimplemented compare'

    return sem_op


# NOTE: I hate this function but it works
def gen_Compare(cte, ast, left, comparators, ops):
    (cte1, code1) = comp_expr(cte, left)
    (cte2, code2) = comp_expr(cte, comparators[0])
    sem_op1 = comp_Compare_Op(ops[0])

    if len(ops) == 1:
        return (cte, lambda rte, cont:
                        code1(rte,
                             lambda rte1, val1:
                                code2(rte1,
                                      lambda rte2, val2:
                                         sem_op1(Context(rte2, cont, ast), val1, val2))))

    elif len(ops) == 2:
        (cte3, code3) = comp_expr(cte, comparators[1])
        sem_op2 = comp_Compare_Op(ops[1])

        def gen_cont3(cont, rte, comp1, val2):
            return cont(rte, comp1) if sem_false(comp1) else code3(rte,
                                                                   lambda rte1, val3:
                                                                      sem_op2(Context(rte1, cont, ast), val2, val3))

        return (cte, lambda rte, cont:
                        code1(rte,
                             lambda rte1, val1:
                                code2(rte1,
                                      lambda rte2, val2:
                                          sem_op1(Context(rte2,
                                                          lambda rte3, comp1:
                                                            gen_cont3(cont, rte3, comp1, val2),
                                                          ast),
                                                  val1, val2))))
    else:
        assert False, 'not implemented'

def sem_Add(ctx, val1, val2):
    __val1_add__ = getattribute_from_obj_mro(val1, '__add__')
    if __val1_add__ is absent:
        __val2_radd__ = getattribute_from_obj_mro(val2, '__radd__')
        if __val2_radd__ is absent:
            # TypeError: unsupported operand type(s) for +: type(val1).__name__ and type(val2).__name__"
            assert False, '__add__ and __radd__ are absent absent'
        else:
            return __val2_radd__(ctx, val2, val1)
    else:
        return __val1_add__(ctx, val1, val2)

def sem_Sub(ctx, val1, val2):
    __val1_sub__ = class_getattr(val1, '__sub__')
    if __val1_sub__ is absent:
        __val2_rsub__ = class_getattribute(val2, '__rsub__')
        if __val2_rsub__ is absent:
            # TypeError: unsupported operand type(s) for -: type(val1).__name__ and type(val2).__name__"
            assert False, '__sub__ and __rsub__ are absent absent'
        else:
            return __val2_rsub__(ctx, val1, val2)
    else:
        return __val1_sub__(ctx, val1, val2)

def sem_Mult(ctx, val1, val2):
    result = val1 * val2
    return expr_end(ctx, result)

def sem_Div(ctx, val1, val2):
    result = val1 / val2
    return expr_end(ctx, result)

def sem_Mod(ctx, val1, val2):
    result = val1 % val2
    return expr_end(ctx, result)

def sem_FloorDiv(ctx, val1, val2):
    result = val1 // val2
    return expr_end(ctx, result)

def sem_Eq(ctx, val1, val2):
    result = val1 == val2
    return expr_end(ctx, result)

def sem_NotEq(ctx, val1, val2):
    result = val1 != val2
    return expr_end(ctx, result)

def sem_Lt(ctx, val1, val2):
    __val1_lt__ = getattribute_from_obj_mro(val1, '__lt__')
    if __val1_lt__ is absent:
        __val2__gt__ = getattribute_from_obj_mro(val2, '__gt__')
        if __val2_gt__ is absent:
            # TypeError: '<' not supported between instances of type(val1).__name__ and type(val2).__name__
            # return sem_raise(ctx, make_TypeError())
            assert False, "'<' and '>' not supported"
        else:
            return __val2_gt__(ctx, val2, val1)
    else:
        return __val1_lt__(ctx, val1, val2)

def sem_LtE(ctx, val1, val2):
    result = val1 <= val2
    return expr_end(ctx, result)

def sem_Gt(ctx, val1, val2):
    result = val1 > val2
    return expr_end(ctx, result)

def sem_GtE(ctx, val1, val2):
    result = val1 >= val2
    return expr_end(ctx, result)

def sem_repr(ctx, val1):
    __repr__ = getattribute_from_obj_mro(val1, '__repr__')
    # TODO: proper exception
    #assert __repr__ is absent, '__repr__ not defined'
    return __repr__(ctx, val1)

def gen_constant(cte, ast, val):

    def code(rte, cont):
        return sem_constant(Context(rte, cont, ast), val)

    return (cte, code)

def sem_constant(ctx, val):
    result = val
    return expr_end(ctx, result)

def sem_var_set(ctx, id, val):
    ctx.rte[id] = val
    return stmt_end(ctx)

def sem_var_get(ctx, id):
    result = ctx.rte[id]
    return expr_end(ctx, result)

def sem_bool(ctx, val):
    __val_bool__ = getattribute_from_obj_mro(val, '__bool__')
    if __val_bool__ is absent:
        __val_len__ = getattribute_from_obj_mro(val, '__len__')
        if __val_len__ is absent:
            return expr_end(ctx, True)
        else:
            def nonzero(rte, val):
                result = val != 0
                return expr_end(ctx, result)

            ctx1 = Context(ctx.rte, nonzero, ctx.ast)
            return __val_len__(ctx1, val)
    else:
        return __val_bool__(ctx, val)

# XXX: decide if I keep this
def sem_false(val):
    return not val



def expr_end(ctx, val):

    # Simulate codeBoot GUI that shows the value of the expression
    # and waits for the user to click "next step" to continue execution.
    # Note that codeBoot will also use rte to show the value of variables.

    return gui_wait_for_click(ctx.ast, ': value = '+repr(val), lambda: ctx.cont(ctx.rte, val))


def stmt_end(ctx):

    # Simulate codeBoot GUI that shows the execution of a statement
    # and waits for the user to click "next step" to continue execution.
    # Note that codeBoot will also use rte to show the value of variables.

    return gui_wait_for_click(ctx.ast, '', lambda: ctx.cont(ctx.rte))


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

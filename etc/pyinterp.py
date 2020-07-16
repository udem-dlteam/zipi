#!/usr/bin/env python3
import argparse
import ast as AST

debug = False
single_step = True

absent = object()

class Context:
    def __init__(self, rte, cont, ast):
        self.rte = rte
        self.cont = cont
        self.ast = ast

    # NOTE: unused for now
    def copy(self):
        return Context(self.rte.copy(), self.cont, self.ast)

    def call(self):
        return self.cont(self.rte)

def make_frame(rte, cont, ast):
    return [rte, cont, ast]

def frame_rte(frame):
    return frame[0]

def frame_cont(frame):
    return frame[1]

def frame_ast(frame):
    return frame[2]

def make_rte(globals_env, locals_env, stack):
    return [globals_env, locals_env, stack]

def rte_globals(rte):
    return rte[0]

def rte_locals(rte):
    return rte[1]

def rte_stack(rte):
    return rte[2]

# Return variable value or absent.
def rte_lookup(rte, var):
    env = rte_locals(rte)
    if env is absent:
        env = rte_globals(rte)
        return env.get(var, absent)
    else:
        result = env.get(var, absent)
        if result is absent:
            env = rte_globals(rte)
            return env.get(var, absent)
        else:
            return result

# XXX: does not yet support undo.
def rte_set(rte, var, val):
    env = rte_locals(rte)
    if env is absent:
        env = rte_globals(rte)
        env[var] = val
    else:
        env[var] = val

def make_signature(args, posonlyargs, varargs, kwonlyargs, kw_defaults, kwargs, defaults):
    return [args, posonlyargs, varargs, kwonlyargs, kw_defaults, kwargs, defaults]

empty_sigature = make_signature([], [], False, [], [], False, [])

def make_posonly_only_signature(posonlyargs):
    return make_signature([], posonlyargs, absent, [], [], absent, [])

def make_posonly_defaults_only_signature(posonlyargs, defaults):
    return make_signature([], posonlyargs, absent, [], [], absent, defaults)

def make_vararg_only_signature(vararg):
    return make_signature([], [], varargs, [], [], absent, [])

def make_posonly_defaults_signature(posonlyargs, defaults):
    return make_signature([], posonlyargs, absent, [], [], absent, defaults)

def make_args_defaults_signature(args, defaults):
    return make_signature(args, [], absent, [], [], absent, defaults)

def signature_args(signature):
    return signature[0]

def signature_posonlyargs(signature):
    return signature[1]

def signature_varargs(signature):
    return signature[2]

def signature_kwonlyargs(signature):
    return signature[3]

def signature_kw_defaults(signature):
    return signature[4]

def signature_kwargs(signature):
    return signature[5]

def signature_defaults(signature):
    return signature[6]

def signature_arity(signature):
    args = signature_args(signature)
    posonlyargs = signature_posonlyargs(signature)
    vararg = signature_varargs(signature)
    kwonlyargs = signature_kwonlyargs(signature)
    kw_defaults = signature_kw_defaults(signature)
    kwargs = signature_kwargs(signature)
    defaults = signature_defaults(signature)

    if len(kwonlyargs) == 0 and \
       len(kw_defaults)  == 0 and \
       not kwargs and len(defaults) == 0:
        if vararg:
            return -1 - len(args) - len(posonlyargs)
        else:
            return len(args) + len(posonlyargs)
    else:
        return False

def align_args_with_signature(ctx, caller_args, signature):
    args = signature_args(signature)
    posonlyargs = signature_posonlyargs(signature)
    vararg = signature_varargs(signature)
    kwonlyargs = signature_kwonlyargs(signature)
    kw_default = signature_kw_defaults(signature)
    kwarg = signature_kwargs(signature)
    defaults = signature_defaults(signature)
    if kwarg is not absent and len(kwonlyargs) > 0:
        # TODO: implement kwarg
        assert False, 'kwarg not implemented'
    else:
        caller_args_len = len(caller_args)
        args_len = len(args)
        posonlyargs_len = len(posonlyargs)
        defaults_len = len(defaults)
        total_args_len = args_len + posonlyargs_len
        if caller_args_len == total_args_len:
            if vararg:
                # Copy to keep side effect local
                caller_index = 0

                locals_env = []
                for arg in posonlyargs:
                    locals_env.append((arg, caller_args[caller_index]))
                    caller_index += 1

                for arg in args:
                    locals_env.append((arg, caller_args[caller_index]))
                    caller_index += 1

                return locals_env
            else:
                return caller_args
        elif caller_args_len < total_args_len:
            missing_args_len = total_args_len - caller_args_len
            if defaults_len >= missing_args_len:
                result =  caller_args.copy()
                start = defaults_len - missing_args_len
                result.append(defaults[start:default_len])
                return result
        else:
            assert False, 'vararg not implemented'

# object model
def make_dict():
    return dict()

def dict_get(d, key):
    return d.get(key, absent)

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
        # TODO: check if attr.__get__ exists
        if attr is not absent:
            return attr
    return absent

def getattribute_from_obj_mro(o, name):
    __class__ = object_class(o)
    return getattribute_from_class_mro(__class__, name)

def make_class(name, module, bases):
    cls = make_dict()
    class_set(cls, '__name__', name)
    class_set(cls, '__module__', module)
    class_set(cls, '__mro__', None)
    return cls

def make_builtin_class(name):
    # Set base classes when they do exist
    cls = make_class(name, 'builtins', None)
    return cls


def class_set(cls, name, value):
    dict_set(cls, name, value)

def class_set__mro__(cls, mro):
    class_set(cls, '__mro__', mro)

def class__mro__(cls):
    return dict_get(cls, '__mro__')

# Initialize integer class
def populate_builtin_int():
    class_set(class_int, '__class__', class_type)

    #class_set(class_int, '__init__', mo_int_init)
    class_set(class_int, '__bool__', mo_int_bool)
    class_set(class_int, '__add__', mo_int_add)
    class_set(class_int, '__radd__', mo_int_radd)
    class_set(class_int, '__sub__', mo_int_sub)
    class_set(class_int, '__rsub__', mo_int_rsub)
    class_set(class_int, '__lt__', mo_int_lt)
    class_set(class_int, '__repr__', mo_int_repr)

    class_set__mro__(class_int, [class_int, class_object])

def populate_builtin_object():
    class_set(class_object, '__class__', class_type)

    # TODO: complete object magic method
    class_set(class_object, '__repr__', mo_object_repr)
    class_set__mro__(class_object, [class_object])

def populate_builtin_bool():
    class_set(class_type, '__class__', class_type)

    # TODO: complete bool magic method
    class_set(class_bool, '__bool__', mo_bool_bool)

    class_set__mro__(class_bool, [class_bool, class_int, class_object])

def populate_builtin_str():
    class_set(class_str, '__class__', class_type)
    # TODO: add all other methods
    class_set__mro__(class_str, [class_str, class_object])

def populate_builtin_NoneType():
    class_set(class_str, '__class__', class_type)
    # TODO: add all other methods
    class_set(class_NoneType, '__bool__', mo_NoneType_bool)

    class_set__mro__(class_NoneType, [class_NoneType, class_object])

def populate_builtin_FunctionType():
    class_set(class_function, '__class__', class_type)

    class_set(class_function, '__call__', mo_function_call)
    class_set__mro__(class_function, [class_function, class_object])

def object_class(o):
    if o is None:
        # Wrap None inside an object.
        return class_NoneType
    elif isinstance(o, bool):
        # This is equivalent to javascript bool
        return class_bool
    elif isinstance(o, str):
        return class_str
    else:
        __class__ = class_getattribute(o, '__class__')
        # NOTE: this assert should never trigger
        assert __class__ is not absent, 'object does not have a class'
        return __class__

def is_mo_type(o):
    return isinstance(o, dict) and \
            dict_get(o, '__class__') is not absent

def make_mo(cls):
    o = make_dict()
    mo_set(o, '__class__', cls)
    return o

def mo_set(o, name, val):
    dict_set(o, name, val)

def mo_get(o, name):
    return dict_get(o, name)

def mo_object_repr(ctx, val):
    __name__ = getattribute_from_obj_mro(val, '__name__')
    result = "<class '" + __name__ + "'>"
    return expr_end(ctx, result)

def mo_bool_bool(ctx, val):
    if debug: print('bool.__bool__')
    return expr_end(ctx, val)

def make_mo_int(val):
    obj = make_mo(class_int)
    class_set(obj, '**value**', val)
    return obj

def mo_int_bool(ctx, val):
    if debug: print('int.__bool__')
    val = class_getattribute(val, '**value**')
    result = val != 0
    return ctx.cont(ctx.rte, result)

def mo_int_add(ctx, val1, val2):
    # TODO: add type checking
    val1_unbox = class_getattribute(val1, '**value**')
    val2_unbox = class_getattribute(val2, '**value**')
    result = val1_unbox + val2_unbox
    return expr_end(ctx, make_mo_int(result))

mo_int_radd = mo_int_add

def mo_int_sub(ctx, val1, val2):
    val1_unbox = mo_get(val1, '**value**')
    val2_unbox = mo_get(val2, '**value**')
    # TODO: add type check.
    result = val1_unbox - val2_unbox
    return expr_end(ctx, make_mo_int(result))

def mo_int_rsub(ctx, val1, val2):
    return mo_int_sub(ctx, val2, val1)

def mo_int_lt(ctx, val1, val2):
    if debug: print('int.__lt__')
    v1 = class_getattribute(val1, '**value**')
    v2 = class_getattribute(val2, '**value**')
    if v1 < v2:
        result = True
    else:
        result = False
    return expr_end(ctx, result)

def mo_int_floordiv(ctx, val1, val2):
    val1_unbox = class_getattribute(val1, '**value**')
    val2_unbox = class_getattribute(val2, '**value**')
    if val2_unbox == 0:
        # TODO: implemented sem_raise
        #return sem_raise(ctx, mo_ZeroDivisionError())
        assert False, 'Division by zero'
    else:
        result = val1_unbox // val2_unbox
        return expr_end(ctx, make_mo_int(result))

def mo_int_repr(ctx, val):
    result = str(val)
    return expr_end(ctx, result)

def mo_NoneType_bool(ctx, val):
    if debug: print('None.__bool__')
    result = False
    return ctx.cont(ctx.rte, result)


def mo_function_call(ctx, self, args):
    signature = class_getattribute(self, '**signature**')

    arity = signature_arity(signature)

    ## test arity
    locals_env = align_args_with_signature(ctx, args, signature)

    def code():
        stack = make_frame(ctx.rte, ctx.cont, ctx.ast)
        rte = make_rte(rte_globals(ctx.rte), dict(locals_env), stack)
        body = class_getattribute(self, '**body**')
        return body(rte,
                    lambda rte1:
                       frame_cont(rte_stack(rte1))(frame_rte(rte_stack(rte1)), None))

    return code



# XXX: need to decide if I keep this
def unbox_object(obj):
    value = obj
    # Give a human readable representation of mo_type
    if is_mo_type(obj):
        dtype = class_getattribute(obj, '__class__')
        # class_int and class_str are representated with mo_*
        if dtype in [class_int, class_str]:
            value = class_getattribute(obj, '**value**')
        elif dtype is class_function:
            # NOTE: temporary
            name = class_getattribute(obj, '__name__')
            value = 'function {}(...)'.format(name)
    return value

# XXX: need to decide if I keep this
def box_object(obj):
    if isinstance(obj, bool):
        return obj
    if isinstance(obj, int):
        return make_mo_int(obj)
    else:
        return obj

# Create builtins classes
class_type = make_builtin_class('type')
class_object = make_builtin_class('object')
class_int = make_builtin_class('int')
class_bool = make_builtin_class('bool')
class_NoneType = make_builtin_class('NoneType')

class_str = make_builtin_class('str')
class_tuple = make_builtin_class('tuple')
class_list = make_builtin_class('list')
class_module = make_builtin_class('module')
class_function = make_builtin_class('function')

populate_builtin_object()
populate_builtin_int()
populate_builtin_bool()
populate_builtin_str()
populate_builtin_NoneType()
populate_builtin_FunctionType() # type function
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
    # NOTE: dummy internal implementation of print.
    def mo_print_code(rte, cont):
        x = rte_lookup(rte, 'x')
        print(unbox_object(x)) # should call object.__str__
        return cont(rte)

    mo_print = make_mo(class_function)
    mo_set(mo_print, '__name__', 'print')
    mo_set(mo_print, '**signature**', make_args_defaults_signature(['x'], []))
    mo_set(mo_print, '**body**', mo_print_code)

    locals_env = absent
    globals_env = dict()
    rte = make_rte(globals_env, locals_env, absent)

    globals_env['object'] = class_object
    globals_env['int'] = class_int
    globals_env['bool'] = class_bool
    globals_env['str'] = class_str
    globals_env['print'] = mo_print

    def cont(rte):
        print('done!')

    trampoline(lambda: code(rte, cont))

def trampoline(execution_point):
    while execution_point is not None:
        #print('execution_point = ' + repr(execution_point))
        execution_point = execution_point()
    #print('exiting trampoline')

    # XXX: manual single step
    # history = [execution_point]
    # current_index = 0
    # while execution_point is not None:
    #     # print(execution_point)
    #     print(history)
    #     opt = input('Operation (n, p): ')
    #     if opt == 'n':
    #         tmp = execution_point()
    #         current_index += 1
    #         if current_index == len(history):
    #             history.append(tmp)
    #         execution_point = tmp
    #     elif opt == 'r':
    #         current_index = 0
    #         execution_point = history[0]
    #     elif opt == 'p':
    #         prev_index = min(0, current_index - 1)
    #         current_index = prev_index
    #         execution_point = history[prev_index]
    #         execution_point()




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

# Compilation of function arguments
def comp_function_args(cte, args):

    if len(args) == 0:
        def code(rte, cont):
            return cont(rte, [])
        return (cte, code)
    else:
        index_last = len(args) - 1
        (cte1, code1) = comp_expr(cte, args[index_last])
        (cte2, code2) = comp_function_args(cte, args[0:index_last])
        return gen_function_args_seq(cte2, code1, code2)

def append_list(lst, val):
    result = lst.copy()
    result.append(val)
    return result


def gen_function_args_seq(cte, code1, code2):
    # code1: gives the function object
    # code2: gives positional arguments
    # TODO: add keyword arguments support.
    def code(rte, cont):
        return code2(rte,
                     lambda rte2, val2:
                        code1(rte2,
                              lambda rte1, val1:
                                 cont(rte1, append_list(val2, val1))))
    return (cte, code)

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

    elif isinstance(ast, AST.Return):
        # Return
        if debug: print('AST.Return')
        if ast.value is None:
            return cte, lambda rte, cont: frame_cont(rte_stack(rte))(frame_rte(rte_stack(rte)), None)
        else:
            (cte1, code1) = comp_expr(cte, ast.value)
            def unwindReturn(rte, val):
                frame = rte_stack(rte)
                ctx = Context(frame_rte(frame), frame_cont(frame), frame_ast(frame))
                return expr_end(ctx, val)

            return cte, lambda rte, cont: code1(rte, lambda rte1, val1: unwindReturn(rte1, val1))

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

    elif isinstance(ast, AST.FunctionDef):
        if debug: print('AST.FunctionDef')
        #print(dir(ast))
        function = make_mo(class_function)
        mo_set(function, '__name__', ast.name)

        signature = gen_signature(cte, ast)
        (cte1, body_code) = gen_funcdef_code(cte, ast, ast.body)

        mo_set(function, '**signature**', signature)
        mo_set(function, '**body**', body_code)
        # TODO: create closure

        (cte2, code) = gen_constant(cte1, ast, function)
        return gen_var_set(cte, ast, ast.name, code)



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

    elif isinstance(ast, AST.Compare):
        if debug: print('AST.Compare')
        result = gen_Compare(cte, ast, ast.left, ast.comparators, ast.ops)
        return result

    elif isinstance(ast, AST.Call):
        if debug: print('AST.Call')
        (cte1, code1) = comp_expr(cte, ast.func)
        (cte2, code2) = comp_function_args(cte1, ast.args)
        # TODO: compile ast.keywords args
        return gen_call(cte1, ast, code1, code2)
    else:
        if debug: print(ast)
        assert False, 'comp_expr expected an expression AST'

def comp_expr_opt(cte, ast):
    if ast is None:
        return (cte, None)
    else:
        return comp_expr(cte, ast)


def gen_signature(cte, ast):
    # make_signature(args, posonlyargs, vararg, kwonlyargs, kw_defaults, kwargs, defaults)

    args = []
    for arg in ast.args.args:
        args.append(arg.arg)

    posonlyargs = []
    for posonly in ast.args.posonlyargs:
        posonlyargs.append(posonly.arg)

    if ast.args.vararg is not None:
        vararg = ast.args.vararg.arg
    else:
        vararg = absent

    kwonlyargs = []
    for kwonly in ast.args.kwonlyargs:
        kwonlyargs.append(kwonly.arg)

    kw_defaults = []
    for kw_default in ast.args.kw_defaults:
        if kw_default is None:
            kw_defaults.append(absent)
        else:
            kw_defaults.append(kw_default.value)

    if ast.args.kwarg is not None:
        kwarg = ast.args.kwarg.arg
    else:
        kwarg = absent

    defaults = []
    for default in ast.args.defaults:
        defaults.append(default.value)

    return make_signature(args, posonlyargs, vararg, kwonlyargs, kw_defaults, kwarg, defaults)

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
            if val is False:
                return code3(rte, cont)
            else:
                return code2(rte, lambda rte2: code(rte2, cont))

        def cast_bool(rte, val):
            ctx = Context(rte, dispatch, ast)
            return sem_bool(ctx, val)

        return code1(rte, cast_bool)

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
            if val is False:
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
            ctx = Context(rte, cont, ast)
            return sem_var_set(ctx, id, val)

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

        def retrieve_val1(rte, cont):
            def retrieve_val2(rte1, val1):
                def retrieve_val3(rte3, val3):
                    ctx = Context(rte, cont, ast)
                    return sem_op1(ctx, val1, val2)

                def eval_compare(rte2, val2):
                    def dispatch(rte3, cond_var):
                        if cond_var is False:
                            return cont(rte3, cond_var)
                        else:
                            return code3(rte3, retrieve_val3)

                    ctx = Context(rte2, dispatch, ast)
                    return sem_op1(ctx, val1, val2)

                return code2(rte1, eval_compare)

            return code1(rte, retrieve_val2)

        return (cte, code)
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
    __val1_sub__ = getattribute_from_obj_mro(val1, '__sub__')
    if __val1_sub__ is absent:
        __val2_rsub__ = getattribute_from_obj_mro(val2, '__rsub__')
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

def sem_call(ctx, args):
    val1 = args[0]
    params = args[1]

    __call__ = getattribute_from_obj_mro(val1, '__call__')
    return __call__(ctx, val1, params)

def gen_constant(cte, ast, val):

    def code(rte, cont):
        obj = box_object(val)
        return sem_constant(Context(rte, cont, ast), obj)

    return (cte, code)

def sem_constant(ctx, val):
    result = val
    return expr_end(ctx, result)

def sem_var_set(ctx, id, val):
    # Clone the current context.
    # TODO: use link environment
    rte_set(ctx.rte, id, val)
    return stmt_end(ctx)

def sem_var_get(ctx, id):
    result = rte_lookup(ctx.rte, id)
    assert result is not absent, 'variable {} not found'.format(id)
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

#def gen_funcdef_code(cte, ast, name, args, body):
def gen_funcdef_code(cte, ast, body):

    # No param handling
    def code(rte, args):
        (cte1, body_code) = comp_stmt_seq(cte, body)
        return body_code(rte, args)

    return (cte, code)



def gen_call(cte, ast, code1, code2):


    def code(rte, cont):
        return code1(rte,
                     lambda rte1, val1:
                        code2(rte1,
                              lambda rte2, val2:
                                sem_call(Context(rte, cont, ast),
                                         [val1, val2])))
    return (cte, code)

def expr_end(ctx, val):

    # Simulate codeBoot GUI that shows the value of the expression
    # and waits for the user to click "next step" to continue execution.
    # Note that codeBoot will also use rte to show the value of variables.

    # This allow a more readable when not debugging
    if not debug: repr_val = unbox_object(val)
    return gui_wait_for_click(ctx.ast, ': value = '+repr(repr_val), lambda: ctx.cont(ctx.rte, val))


def stmt_end(ctx):

    # Simulate codeBoot GUI that shows the execution of a statement
    # and waits for the user to click "next step" to continue execution.
    # Note that codeBoot will also use rte to show the value of variables.

    return gui_wait_for_click(ctx.ast, '', lambda: ctx.cont(ctx.rte))


def gui_wait_for_click(ast, msg, continue_execution):

    print('at '+str(ast.lineno)+'.'+str(ast.col_offset+1)+'-'+str(ast.end_lineno)+'.'+str(ast.end_col_offset+1)+msg)

    # single_step allows faster execution
    if single_step:
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

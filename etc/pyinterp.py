#!/usr/bin/env python3
import argparse

# import ast as AST

import _zast as AST
import zast
AST.parse = zast.parse

def nocompile(f):
    return f

debug = False
single_step = True

absent = object()
om_None = absent
om_True = absent
om_False = absent

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

def make_rte(globals_env, locals_env, stack, ctrl_env):
    return [globals_env, locals_env, stack, ctrl_env]

def rte_globals(rte):
    return rte[0]

def rte_locals(rte):
    return rte[1]

def rte_stack(rte):
    return rte[2]

def rte_ctrl_env(rte):
    return rte[3]

# Return variable value or absent.
def rte_lookup(rte, name):
    env = rte_locals(rte)
    if env is absent:
        env = rte_globals(rte)
        return env.get(name, absent)
    else:
        result = env.get(name, absent)
        if result is absent:
            env = rte_globals(rte)
            return env.get(name, absent)
        else:
            return result

# XXX: does not yet support undo.
def rte_set(rte, varname, val):
    env = rte_locals(rte)
    if env is absent:
        env = rte_globals(rte)
        env[varname] = val
    else:
        env[varname] = val

# stack operation
def unwindReturn(rte, val):
    frame = rte_stack(rte)
    ctx = Context(frame_rte(frame), frame_cont(frame), frame_ast(frame))
    return expr_end(ctx, val)

# function signature
def make_signature(args, posonlyargs, varargs, kwonlyargs, kw_defaults, kwargs, defaults):
    return (args, posonlyargs, varargs, kwonlyargs, kw_defaults, kwargs, defaults)

empty_sigature = make_signature([], [], False, [], [], False, [])

def make_posonly_only_signature(posonlyargs):
    return make_signature([], posonlyargs, False, [], [], False, [])

def make_posonly_defaults_only_signature(posonlyargs, defaults):
    return make_signature([], posonlyargs, False, [], [], False, defaults)

def make_vararg_only_signature(vararg):
    return make_signature([], [], varargs, [], [], False, [])

def make_posonly_defaults_signature(posonlyargs, defaults):
    return make_signature([], posonlyargs, False, [], [], False, defaults)

def make_args_defaults_signature(args, defaults):
    return make_signature(args, [], False, [], [], False, defaults)

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

    if len(kwonlyargs) == 0 and len(kw_defaults) == 0 and \
       kwargs is absent and len(defaults) == 0:
        if vararg:
            return -1 - len(args) - len(posonlyargs)
        else:
            return len(args) + len(posonlyargs)
    else:
        return absent

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
            if not vararg:
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
                # XXX: not working.
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

def make_dict_from_list(lst):
    result = make_dict()
    for e in lst:
        result[e[0]] = e[1]
    return result

@nocompile
def dict_get(d, key):
    return d.get(key, absent)

def dict_set(d, key, value):
    d[key] = value

def class_getattr(o, attr):
    return dict_get(o, attr)

def class_getattribute(o, attr):
    # TODO: does not follow sementic missing __get__.
    return dict_get(o, attr)

def class_setattribute(o, attr, value):
    dict_set(o, attr, value)

def getattribute_from_class_mro(cls, name):
    __mro__ = class__mro__(cls)
    for cls in __mro__:
        fields = om_rawget(cls, '**public**')
        attr = fields_get(fields, name)
        if attr is not absent:
            return attr
    return absent

def getattribute_from_obj_mro(o, name):
    __class__ = object_class(o)
    if name == '__class__':
        return __class__
    # elif name == '__mro__':
    #    return class__mro__(__class__)
    else:
        return getattribute_from_class_mro(__class__, name)

def make_class(name, module, bases, metaclass):
    cls = om(metaclass)
    fields = make_fields()
    fields_set(fields, '__name__', name)
    fields_set(fields, '__module__', module)
    om_rawset(cls, '**public**', fields)

    om_rawset(cls, '__class__', metaclass)
    om_rawset(cls, '__mro__', bases)
    return cls

def make_builtin_class(name, metaclass):
    # Set base classes when they do exist
    cls = make_class(name, 'builtins', absent, metaclass)
    return cls

def class_set__mro__(cls, mro):
    om_rawset(cls, '__mro__', mro)

def class__mro__(cls):
    return om_rawget(cls, '__mro__')

# Initialize class type objects
def builtin_add_method(fields, name, code):
    wrapper = om_WrapperDescriptor(name, code)
    fields_set(fields, name, wrapper)

def populate_builtin_type():
    om_rawset(class_type, '__class__', class_type)

    fields = om_rawget(class_type, '**public**')
    builtin_add_method(fields, '__call__', om_type_call)
    builtin_add_method(fields, '__getattribute__', om_type_getattribute)

    class_set__mro__(class_type, [class_type, class_object])

def populate_builtin_object():
    # TODO: complete object magic method
    fields = om_rawget(class_object, '**public**')
    builtin_add_method(fields, '__getattribute__', om_object_getattribute)
    builtin_add_method(fields, '__repr__', om_object_repr)

    class_set__mro__(class_object, [class_object])

def populate_builtin_WrapperDescriptor():
    fields = om_rawget(class_WrapperDescriptor, '**public**')
    builtin_add_method(fields, '__get__', om_WrapperDescriptor_get)
    builtin_add_method(fields, '__call__', om_WrapperDescriptor_call)

    class_set__mro__(class_WrapperDescriptor, [class_WrapperDescriptor, class_object])

def populate_builtin_MethodWrapper():
    fields = om_rawget(class_MethodWrapper, '**public**')
    builtin_add_method(fields, '__call__', om_MethodWrapper_call)

    class_set__mro__(class_MethodWrapper, [class_MethodWrapper, class_object])

def populate_builtin_int():
    fields = om_rawget(class_int, '**public**')
    #fields_set(class_int, '__init__', om_int_init)
    builtin_add_method(fields, '__bool__', om_int_bool) # <class 'function'>
    builtin_add_method(fields, '__add__', om_int_add)
    builtin_add_method(fields, '__radd__', om_int_radd)
    builtin_add_method(fields, '__sub__', om_int_sub)
    builtin_add_method(fields, '__rsub__', om_int_rsub)
    builtin_add_method(fields, '__eq__', om_int_eq)
    builtin_add_method(fields, '__ne__', om_int_ne)
    builtin_add_method(fields, '__lt__', om_int_lt)
    builtin_add_method(fields, '__lte__', om_int_lte)
    builtin_add_method(fields, '__gt__', om_int_gt)
    builtin_add_method(fields, '__gte__', om_int_gte)
    builtin_add_method(fields, '__repr__', om_int_repr)

    class_set__mro__(class_int, [class_int, class_object])

def populate_builtin_bool():
    # TODO: complete bool magic method
    fields = om_rawget(class_bool, '**public**')
    builtin_add_method(fields, '__bool__', om_bool_bool)
    builtin_add_method(fields, '__repr__', om_bool_repr)

    class_set__mro__(class_bool, [class_bool, class_int, class_object])

def populate_builtin_str():
    # TODO: add all other methods
    class_set__mro__(class_str, [class_str, class_object])

def populate_builtin_NoneType():
    # TODO: add all other methods
    fields = om_rawget(class_NoneType, '**public**')
    builtin_add_method(fields, '__bool__', om_NoneType_bool)

    class_set__mro__(class_NoneType, [class_NoneType, class_object])

def populate_builtin_FunctionType():

    fields = om_rawget(class_function, '**public**')
    builtin_add_method(fields, '__call__', om_function_call)

    class_set__mro__(class_function, [class_function, class_object])

def object_class(o):
    if isinstance(o, bool):
        # This is equivalent to javascript bool
        return class_bool
    elif isinstance(o, str):
        return class_str
    else:
        __class__ = om_rawget(o, '__class__')

        # NOTE: this assert should never trigger
        assert __class__ is not absent, 'object does not have a class'
        return __class__

def is_om_type(o):
    return isinstance(o, dict) and \
            om_rawget(o, '**public**') is not absent

# Object model utilities
def om(cls):
    o = make_dict()
    ## XXX" should be setattribute
    public_fields = make_fields()
    om_rawset(o, '**public**', public_fields)
    om_rawset(o, '__class__', cls)
    return o

def om_str(val):
    obj = om(class_str)
    om_rawset(obj, '**value**', val)
    return obj

def om_int(val):
    obj = om(class_int)
    om_rawset(obj, '**value**', val)
    return obj

def om_WrapperDescriptor(name, code):
    obj = om(class_WrapperDescriptor)
    om_rawset(obj, '**code**', code)

    fields = om_rawget(obj, '**public**')
    fields_set(fields, '__name__', om_str(name))
    return obj


def om_MethodWrapper(name, instance, code):
    obj = om(class_MethodWrapper)
    om_rawset(obj, '**code**', code)
    om_rawset(obj, '**instance**', instance)

    fields = om_rawget(obj, '**public**')
    fields_set(fields, '__name__', om_str(name))
    return obj

def om_is(x, y):
    return x is y

def om_is_falsy(val):
    return om_is(val, om_False)

def om_rawset(o, name, val):
    dict_set(o, name, val)

def om_rawget(o, name):
    return dict_get(o, name)

def om_call(o, ctx, args):
    code = om_rawget(o, '**code**')
    if code is absent:
        return sem_call(ctx, args)
    else:
        return code(ctx, args)

def make_fields():
    return dict()

def fields_get(o, name):
    return dict_get(o, name)

def fields_set(o, name, value):
    dict_set(o, name, value)


# class_type magic methods
def om_type_call(ctx, args):
    assert False, 'Not implemented'

def om_type_getattribute(ctx, args):
    if debug: print('type.__getattribute__')
    self = args[0]
    name = args[1]

    dt = om_rawget(self, '__class__')
    assert dt is not class_str, \
            "TypeError: attribute name must be string, not 'typeof(name)'"

    name_unbox = om_rawget(name, '**value**')
    public_fields = om_rawget(self, '**public**')

    # Get field name
    attr = getattribute_from_class_mro(self, name_unbox)
    if attr is absent:
        assert False, "'object' object has no attribute '"+name_unbox+"'"

    # attr.__get__
    attr__get__ = getattribute_from_obj_mro(attr, '__get__')
    if attr__get__ is absent:
        return expr_end(ctx, attr)
    else:
        return om_call(attr__get__, ctx, [attr, om_None, dt])

# class_WrapperDescriptor methods
def om_WrapperDescriptor_get(ctx, args):
    if debug: print('wrapper_descriptor.__get__')
    self = args[0]
    obj = args[1]

    # unused for now.
    cls = args[2]

    if obj is om_None:
        return expr_end(ctx, self)
    else:
        method = om_rawget(self, '**method-wrapper**')
        if method is absent:
            code = om_rawget(self, '**code**')
            method = om_MethodWrapper(self, obj, code)
            om_rawset(self, '**method-wrapper**', method)
        return expr_end(ctx, method)

def om_WrapperDescriptor_call(ctx, args):
    if debug: print('wrapper_descriptor.__call__')
    self = args[0]
    params = args[1:]

    code = om_rawget(self, '**code**')

    def cont(rte, val):
        return expr_end(ctx, val)

    ctx1 = Context(ctx.rte, cont, ctx.ast)
    return code(ctx1, params)

# class_MethodWrapper methods
def om_MethodWrapper_call(ctx, args):
    if debug: print('method-wrapper.__call__')
    self = args[0]
    rest = args[1:]

    obj = om_rawget(self, '**instance**')
    params = [obj] + rest

    def cont(rte, val):
        return expr_end(ctx, val)
    ctx1 = Context(ctx.rte, cont, ctx.ast)
    return om_call(self, ctx1, params)

# class_object methods
def om_object_getattribute(ctx, args):
    if debug: print('object.__getattribute__')
    self = args[0]
    name = args[1]

    dt = om_rawget(self, '__class__')
    assert dt is not class_str, \
            "TypeError: attribute name must be string, not 'typeof(name)'"

    name_unbox = om_rawget(name, '**value**')
    public_fields = om_rawget(self, '**public**')

    # Get field name
    attr = getattribute_from_obj_mro(self, name_unbox)
    if attr is absent:
        assert False, "'object' object has no attribute '"+name_unbox+"'"

    # TODO: check if attr.__get__ exists
    attr__get__ = getattribute_from_obj_mro(attr, '__get__')
    if attr__get__ is absent:
        return expr_end(ctx, attr)
    else:
        return om_call(attr__get__, ctx, [attr, self, dt])

def om_object_repr(ctx, args):
    self = args[0]
    __name__ = getattribute_from_obj_mro(self, '__name__')
    result = om_str("<class '" + __name__ + "'>")
    return ctx.cont(ctx.rte, result)

# class_bool methods
def om_bool_repr(ctx, args):
    if debug: print('bool.__repr__')
    self = args[0]
    if om_is_falsy(self):
        result = om_str('False')
    else:
        result = om_str('True')
    return ctx.cont(ctx.rte, result)

def om_bool_bool(ctx, args):
    if debug: print('bool.__bool__')
    self = args[0]
    return expr_end(ctx, self)


# class_int methods
def om_int_bool(ctx, args):
    if debug: print('int.__bool__')
    self = args[0]
    val_unbox = om_rawget(self, '**value**')
    if val_unbox != 0:
        result = om_True
    else:
        result = om_False
    return ctx.cont(ctx.rte, result)

def om_int_add(ctx, args):
    val1 = args[0]
    val2 = args[1]

    # TODO: add type checking
    val1_unbox = om_rawget(val1, '**value**')
    val2_unbox = om_rawget(val2, '**value**')
    result = val1_unbox + val2_unbox
    return ctx.cont(ctx.rte, om_int(result))

om_int_radd = om_int_add

def om_int_sub(ctx, args):
    val1 = args[0]
    val2 = args[1]

    val1_unbox = om_rawget(val1, '**value**')
    val2_unbox = om_rawget(val2, '**value**')
    # TODO: add type check.
    result = val1_unbox - val2_unbox
    return ctx.cont(ctx.rte, om_int(result))

def om_int_rsub(ctx, args):
    val1 = args[0]
    val2 = args[1]

    return om_int_sub(ctx, [val2, val1])

def om_int_eq(ctx, args):
    if debug: print('int.__eq__')
    val1 = args[0]
    val2 = args[1]

    v1 = om_rawget(val1, '**value**')
    v2 = om_rawget(val2, '**value**')
    if v1 == v2:
        result = om_True
    else:
        result = om_False
    return expr_end(ctx, result)

def om_int_ne(ctx, args):
    if debug: print('int.__ne__')
    val1 = args[0]
    val2 = args[1]

    v1 = om_rawget(val1, '**value**')
    v2 = om_rawget(val2, '**value**')
    if v1 != v2:
        result = om_True
    else:
        result = om_False
    return expr_end(ctx, result)

def om_int_lt(ctx, args):
    if debug: print('int.__lt__')
    val1 = args[0]
    val2 = args[1]

    v1 = om_rawget(val1, '**value**')
    v2 = om_rawget(val2, '**value**')
    if v1 < v2:
        result = om_True
    else:
        result = om_False
    return expr_end(ctx, result)

def om_int_lte(ctx, args):
    if debug: print('int.__lte__')
    val1 = args[0]
    val2 = args[1]

    v1 = om_rawget(val1, '**value**')
    v2 = om_rawget(val2, '**value**')
    if v1 <= v2:
        result = om_True
    else:
        result = om_False
    return expr_end(ctx, result)

def om_int_gt(ctx, args):
    if debug: print('int.__gt__')
    val1 = args[0]
    val2 = args[1]

    v1 = om_rawget(val1, '**value**')
    v2 = om_rawget(val2, '**value**')
    if v1 > v2:
        result = om_True
    else:
        result = om_False
    return expr_end(ctx, result)

def om_int_gte(ctx, args):
    if debug: print('int.__gte__')
    val1 = args[0]
    val2 = args[1]

    v1 = om_rawget(val1, '**value**')
    v2 = om_rawget(val2, '**value**')
    if v1 >= v2:
        result = om_True
    else:
        result = om_False
    return expr_end(ctx, result)


def om_int_floordiv(ctx, args):
    val1 = args[0]
    val2 = args[1]

    val1_unbox = om_rawget(val1, '**value**')
    val2_unbox = om_rawget(val2, '**value**')
    if val2_unbox == 0:
        # TODO: implemented sem_raise
        #return sem_raise(ctx, om_ZeroDivisionError())
        assert False, 'Division by zero'
    else:
        result = val1_unbox // val2_unbox
        return expr_end(ctx, om_int(result))

def om_int_repr(ctx, args):
    self = args[0]
    result = str(om_rawget(self, '**value**'))
    return ctx.cont(ctx.rte, om_str(result))

# class_NoneType methods
def om_NoneType_bool(ctx, val):
    if debug: print('None.__bool__')
    result = om_False
    return ctx.cont(ctx.rte, result)

# class_function methods
def om_function_call(ctx, args):
    self = args[0]
    params = args[1:]

    fields = om_rawget(self, '**public**')
    signature = om_rawget(self, '**signature**')


    arity = om_rawget(self, '**arity**')

    ## test arity
    locals_env = align_args_with_signature(ctx, params, signature)

    def code():
        stack = make_frame(ctx.rte, ctx.cont, ctx.ast)
        rte = make_rte(rte_globals(ctx.rte), make_dict_from_list(locals_env), stack, absent)
        body = om_rawget(self, '**body**')
        return body(rte,
                    lambda rte1:
                       frame_cont(rte_stack(rte1))(frame_rte(rte_stack(rte1)), om_None))

    return code



# XXX: need to decide if I keep this
def unbox_object(obj):
    value = obj
    # Give a human readable representation of om_type
    if is_om_type(obj):
        # XXX: should be an getattribute protocol
        dtype = om_rawget(obj, '__class__')
        # class_int and class_str are representated with om_*
        if om_is(dtype, class_int) or om_is(dtype, class_str):
            value = om_rawget(obj, '**value**')
        elif dtype is class_function:
            # NOTE: should be
            name = class_getattribute(obj, '__name__')
            value = 'function ' + str(name) + '(...)'
    return value

# XXX: need to decide if I keep this
def box_object(obj):
    if obj is None:
        return om_None
    elif isinstance(obj, bool):
        return obj
    elif isinstance(obj, int):
        return om_int(obj)
    elif isinstance(obj, str):
        return om_str(obj)
    else:
        return obj

# Create builtins classes
class_type = make_builtin_class('type', absent)
class_object = make_builtin_class('object', class_type)

class_WrapperDescriptor = make_builtin_class('wrapper_descriptor', class_type)
class_MethodWrapper = make_builtin_class('method-wrapper', class_type)

class_int = make_builtin_class('int', class_type)
class_bool = make_builtin_class('bool', class_type)
class_NoneType = make_builtin_class('NoneType', class_type)

class_str = make_builtin_class('str', class_type)
class_tuple = make_builtin_class('tuple', class_type)
class_list = make_builtin_class('list', class_type)
class_module = make_builtin_class('module', class_type)
class_function = make_builtin_class('function', class_type)

populate_builtin_type()
populate_builtin_object()

# Internal types
populate_builtin_WrapperDescriptor()
populate_builtin_MethodWrapper()

# Basic type and date structure.
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

@nocompile
def read_file(path):
    with open(path, 'r') as f:
        content = f.read()
    return content

def interp_source(src):
    interp(parse(src))

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
    global om_None, om_True, om_False

    # NOTE: dummy internal implementation of print.
    def om_print_code(rte, cont):
        obj = rte_lookup(rte, 'obj')
        print(unbox_object(obj)) # should call object.__str__
        return cont(rte)

    om_None = om(class_NoneType)
    om_True = True
    om_False = False

    om_print = om(class_function)
    # XXX: this one should be a setattribute
    public_fields = make_fields()
    fields_set(om_print, '__name__', om_str('print'))

    om_rawset(om_print, '**public**', public_fields)
    om_rawset(om_print, '**signature**', make_posonly_only_signature(['obj']))
    om_rawset(om_print, '**body**', om_print_code)

    locals_env = absent
    globals_env = make_dict()
    rte = make_rte(globals_env, locals_env, absent, absent)

    globals_env['type'] = class_type
    globals_env['object'] = class_object
    globals_env['int'] = class_int
    globals_env['bool'] = class_bool
    globals_env['str'] = class_str
    globals_env['print'] = om_print

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

def gen_function_args_seq(cte, code1, code2):
    # code1: gives the function object
    # code2: gives positional arguments
    # TODO: add keyword arguments support.
    def code(rte, cont):
        return code2(rte,
                     lambda rte2, val2:
                        code1(rte2,
                              lambda rte1, val1:
                                 cont(rte1, val2 + [val1])))
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
            return cte, lambda rte, cont: frame_cont(rte_stack(rte))(frame_rte(rte_stack(rte)), om_None)
        else:
            (cte1, code1) = comp_expr(cte, ast.value)
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
        func = om(class_function)

        om_rawset(func, '__name__', ast.name)

        signature = gen_signature(cte, ast)
        (cte1, body_code) = gen_funcdef_code(cte, ast, ast.body)

        om_rawset(func, '**signature**', signature)
        om_rawset(func, '**body**', body_code)

        arity = signature_arity(signature)
        om_rawset(func, '**arity**', arity)

        # TODO: create closure

        def code(rte, cont):
            return cont(rte, func)

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
        return gen_UnaryOp(cte1, ast, ast.op, code1)

    elif isinstance(ast, AST.Name):
        # Name(identifier id, expr_context ctx)
        if debug: print('AST.Name')
        return gen_var_get(cte, ast, ast.id)

    elif isinstance(ast, AST.Constant):
        if debug: print('AST.Constant')
        return gen_constant(cte, ast, ast.value)

    elif isinstance(ast, AST.BoolOp):
        if debug: print('AST.BoolOp')
        return gen_BoolOp(cte, ast, ast.op, ast.values)

    elif isinstance(ast, AST.Compare):
        if debug: print('AST.Compare')
        result = gen_Compare(cte, ast, ast.left, ast.comparators, ast.ops)
        return result

    elif isinstance(ast, AST.Attribute):
        # {ast.value.id}.{ast.attr}
        (cte1, code1) = comp_expr(cte, ast.value)
        return gen_Attribute(cte1, ast, code1, ast.attr)


    elif isinstance(ast, AST.Call):
        if debug: print('AST.Call')
        (cte1, code1) = comp_expr(cte, ast.func)
        (cte2, code2) = comp_function_args(cte1, ast.args)
        # TODO: compile ast.keywords args
        return gen_call(cte1, ast, code1, code2)
    else:
        if not debug: print(ast)
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
        vararg = False

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
        kwarg = False

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
            if om_is_falsy(val):
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
            if om_is_falsy(val):
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
                def retrieve_val3(rte3, val2):
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

        return (cte, retrieve_val1)
    else:
        assert False, 'not implemented'

def sem_Add(ctx, val1, val2):
    def call_expr_end(rte, val):
        return expr_end(ctx, val)

    ctx1 = Context(ctx.rte, call_expr_end, ctx.ast)

    __val1_add__ = getattribute_from_obj_mro(val1, '__add__')
    if __val1_add__ is absent:
        __val2_radd__ = getattribute_from_obj_mro(val2, '__radd__')
        if __val2_radd__ is absent:
            # TypeError: unsupported operand type(s) for +: type(val1).__name__ and type(val2).__name__"
            assert False, '__add__ and __radd__ are absent absent'
        else:
            return om_call(__val2_radd__, ctx1, [val2, val1])
    else:
        return om_call(__val1_add__, ctx1, [val1, val2])

def sem_Sub(ctx, val1, val2):
    def call_expr_end(rte, val):
        return expr_end(ctx, val)

    ctx1 = Context(ctx.rte, call_expr_end, ctx.ast)

    __val1_sub__ = getattribute_from_obj_mro(val1, '__sub__')
    if __val1_sub__ is absent:
        __val2_rsub__ = getattribute_from_obj_mro(val2, '__rsub__')
        if __val2_rsub__ is absent:
            # TypeError: unsupported operand type(s) for -: type(val1).__name__ and type(val2).__name__"
            assert False, '__sub__ and __rsub__ are absent absent'
        else:
            return om_call(__val2_rsub__, ctx1, [val1, val2])
    else:
        return om_call(__val1_sub__, ctx1, [val1, val2])

# TODO: update those definition
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

def macro_sem_binary_operator_protocol(op, method, rmethod):
    def sem_comparator(ctx, val1, val2):
        __op__ = getattribute_from_obj_mro(val1, method)
        if __op__ is absent:
            __rop__ = getattribute_from_obj_mro(val2, rmethod)
            if __rop__ is absent:
                assert False, "TypeError: '"+op+"' not supported between instances of 'typeof(val1)' and 'typeof(val2)'"
            else:
                return om_call(__rop__, ctx, [val2, val1])
        else:
            return om_call(__op__, ctx, [val1, val2])

    return sem_comparator


sem_Eq = macro_sem_binary_operator_protocol('==', '__eq__', '__ne__')
sem_NotEq = macro_sem_binary_operator_protocol('!=', '__ne__', '__eq__')

sem_Lt = macro_sem_binary_operator_protocol('<', '__lt__', '__gt__')
sem_Gt = macro_sem_binary_operator_protocol('>', '__gt__', '__lt__')

sem_LtE = macro_sem_binary_operator_protocol('<=', '__lte__', '__gte__')
sem_GtE = macro_sem_binary_operator_protocol('>=', '__gte__', '__lte__')

def sem_repr(ctx, val1):
    __repr__ = getattribute_from_obj_mro(val1, '__repr__')
    # TODO: proper exception
    assert __repr__ is absent, '__repr__ not defined'
    return om_call(__repr__, ctx, [val1])

def sem_getattribute(ctx, args):
    obj = args[0]
    name = om_str(args[1])

    # XXX: Unused until exception is added to rte.
    def catch_AttributeError(rte, exn):
        __getattr__ = getattribute_from_obj_mro(obj, '__getattr__')
        if __getattr__ is absent:
            assert False, 'raise current exception'
        else:
            new_ctx = Context(rte, ctx.cont, ctx.ast)
            return __getattr__(ctx, args)

    __getattribute__ = getattribute_from_obj_mro(obj, '__getattribute__')

    # TODO: setup exn
    return om_call(__getattribute__, ctx, args)

def sem_call(ctx, args):
    self = args[0]
    params = args[1]

    __call__ = getattribute_from_obj_mro(self, '__call__')
    return om_call(__call__, ctx, [self] + params)

    # __call__code = om_rawget(__call__, '**code**')
    # return __call__code(ctx, val1, params)

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
    assert result is not absent, 'variable '+id+' not found'
    return expr_end(ctx, result)

def sem_bool(ctx, val):
    __val_bool__ = getattribute_from_obj_mro(val, '__bool__')
    if __val_bool__ is absent:
        __val_len__ = getattribute_from_obj_mro(val, '__len__')
        if __val_len__ is absent:
            return expr_end(ctx, om_True)
        else:
            def nonzero(rte, val):
                if val != 0:
                    result = om_True
                else:
                    result = om_False
                return expr_end(ctx, result)

            ctx1 = Context(ctx.rte, nonzero, ctx.ast)
            return om_call(__val_len__, ctx1, [val])
    else:
        return om_call(__val_bool__, ctx, [val])


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

def gen_Attribute(cte, ast, code, name):
    def call_getattribute(rte, cont, obj):
        ctx = Context(rte, cont, ast)
        return sem_getattribute(ctx, [obj, om_str(name)])

    def code1(rte, cont):
        return code(rte,
                    lambda rte, val:
                       call_getattribute(rte, cont, val))

    return (cte, code1)

def expr_end(ctx, val):

    # Simulate codeBoot GUI that shows the value of the expression
    # and waits for the user to click "next step" to continue execution.
    # Note that codeBoot will also use rte to show the value of variables.

    def call_gui(rte, repr_val):
        repr_val_unbox = om_rawget(repr_val, '**value**')
        return gui_wait_for_click(ctx.ast, ': value = '+repr_val_unbox, lambda: ctx.cont(rte, val))

    new_ctx = Context(ctx.rte, call_gui, ctx.ast)
    return sem_repr(new_ctx, val)
    # # This allow a more readable when not debugging
    # if debug:
    #     # This leak internal representation.
    #     repr_val = val
    # else:
    #     repr_val = unbox_object(val)
    # return gui_wait_for_click(ctx.ast, ': value = '+repr(repr_val), lambda: ctx.cont(ctx.rte, val))


def stmt_end(ctx):

    # Simulate codeBoot GUI that shows the execution of a statement
    # and waits for the user to click "next step" to continue execution.
    # Note that codeBoot will also use rte to show the value of variables.

    return gui_wait_for_click(ctx.ast, '', lambda: ctx.cont(ctx.rte))

@nocompile
def gui_wait_for_click(ast, msg, continue_execution):

    print('at '+str(ast.lineno)+'.'+str(ast.col_offset+1)+'-'+str(ast.end_lineno)+'.'+str(ast.end_col_offset+1)+msg)

    # single_step allows faster execution
    if single_step:
        return continue_execution  # trampoline will call continue_execution
    else:
        from threading import Timer
        Timer(0.1, lambda: trampoline(continue_execution)).start()
        return None  # exit trampoline

if __name__ == '__main__':
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

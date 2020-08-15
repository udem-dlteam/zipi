
from _runtime import make_dict, dict_get, dict_set, nocompile, \
        num_add, num_sub, num_mul, num_div, num_mod, num_to_string, \
        num_zero

# import ast as AST

import _zast as AST
import zast
AST.parse = zast.parse

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

# class RTE:
#     def __init__(self, global_env, locals_env, builtins, stack, ctrl_env):
#         self.globals_env = globals_env
#         self.locals_env = locals_env
#         self.builtins = builtins
#         self.stack = stack
#         self.ctrl_env = ctrl_env

class OM_object:
    """
    klass: the __class__ attribute of the object
    attribs: the attributes of the object
    serial: the serial number of the object.
    """

class OM_type(OM_object):
    """
    mro: the __mro__ attribute of class type
    """

# bool, int, str, ...
class OM_box(OM_object):
    """
    value: the inner value wrapped into the object model.
    """

class OM_function(OM_box):
    """
    arity: the arity of the function object
    signature: the signature of the function object
    body: the code of the function object
    """

# value is either class or instance
class OM_WrapperDescriptor(OM_object):
    """
    cls: the class which hold this WrapperDescriptor object
    code: the code of the WrapperDescriptor object
    """

class OM_MethodWrapper(OM_object):
    """
    instance: the obj from which the method is invoke
    code: the code of the method-wrapper
    """

def make_frame(rte, cont, ast):
    return [rte, cont, ast]

def frame_rte(frame):
    return frame[0]

def frame_cont(frame):
    return frame[1]

def frame_ast(frame):
    return frame[2]

def make_rte(rte, globals_env, locals_env, builtins, stack, ctrl_env):
    if rte is absent:
        serial_counter = [0]
    else:
        serial_counter = rte[0]
    return [serial_counter, globals_env, locals_env, builtins, stack, ctrl_env]

def rte_serial_counter(rte):
    boxed_serial = rte[0]
    serial = boxed_serial[0]
    boxed_serial[0] = serial + 1
    return serial

def rte_globals(rte):
    return rte[1]

def rte_locals(rte):
    return rte[2]

def rte_builtins(rte):
    return rte[3]

def rte_stack(rte):
    return rte[4]

def rte_ctrl_env(rte):
    return rte[5]


# Return variable value or absent.
def rte_lookup_globals(rte, name):
    env = rte_globals(rte)
    result = dict_get(env, name, absent)
    return result

def rte_lookup(rte, name):
    env = rte_locals(rte)
    if env is absent:
        return rte_lookup_globals(rte, name)
    else:
        result = dict_get(env, name, absent)
        if result is absent:
            return rte_lookup_globals(rte, name)
        else:
            return result

# XXX: does not yet support undo.
def rte_set(rte, varname, val):
    env = rte_locals(rte)
    if env is absent:
        env = rte_globals(rte)
    dict_set(env, varname, val)

def rte_unset(rte, varname):
    env = rte_locals(rte)
    if env is absent:
        env = rte_globals(rte)
    return env.pop(varname, absent)

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
def make_dict_from_list(lst):
    result = make_dict()
    for e in lst:
        result[e[0]] = e[1]
    return result

def class_getattr(o, attr):
    return dict_get(o, attr, absent)

def class_getattribute(o, attr):
    # TODO: does not follow sementic missing __get__.
    return dict_get(o, attr, absent)

def class_setattribute(o, attr, value):
    dict_set(o, attr, value)

def getattribute_from_class_mro(cls, name):
    mro = OM_get_type_mro(cls)
    mro_len = len(mro)
    i = 0
    while i < mro_len:
        cls = mro[i]
        attr = OM_get(cls, name)
        if attr is not absent:
            return attr
        i += 1
    return absent

def getattribute_from_obj_mro(o, name):
    cls = OM_get_type_class(o)
    if name == '__class__':
        return cls
    # elif name == '__mro__':
    #    return OM_get_type_mro(__class__)
    else:
        return getattribute_from_class_mro(cls, name)

def make_class(name, module, bases, metaclass):
    cls = om(metaclass, OM_type_create)
    OM_set(cls, '__name__', om_str(name))
    OM_set(cls, '__module__', om_str(module))

    OM_set_type_class(cls, metaclass)
    OM_set_type_mro(cls, bases)
    return cls

def make_builtin_class_str():
    cls = om(absent, OM_type_create)
    return cls

def make_builtin_class(name, metaclass):
    # Set base classes when they do exist
    cls = make_class(name, 'builtins', absent, metaclass)
    return cls

# Initialize class type objects
def builtin_add_method(o, name, code):
    wrapper = om_WrapperDescriptor(name, code)
    OM_set(o, name, wrapper)

def populate_builtin_type():
    OM_set_type_class(class_type, class_type)

    builtin_add_method(class_type, '__call__', om_type_call)
    builtin_add_method(class_type, '__getattribute__', om_type_getattribute)
    builtin_add_method(class_type, '__repr__', om_type_repr)

    OM_set_type_mro(class_type, [class_type, class_object])

def populate_builtin_object():
    # TODO: complete object magic method
    builtin_add_method(class_object, '__getattribute__', om_object_getattribute)
    builtin_add_method(class_object, '__repr__', om_object_repr)

    OM_set_type_mro(class_object, [class_object])

def populate_builtin_NotImplementedType():
    builtin_add_method(class_NotImplementedType, '__str__', om_NotImplementedType_str)
    builtin_add_method(class_NotImplementedType, '__repr__', om_NotImplementedType_repr)

    OM_set_type_mro(class_NotImplementedType, [class_NotImplementedType, class_object])

def populate_builtin_WrapperDescriptor():
    builtin_add_method(class_WrapperDescriptor, '__get__', om_WrapperDescriptor_get)
    builtin_add_method(class_WrapperDescriptor, '__call__', om_WrapperDescriptor_call)
    builtin_add_method(class_WrapperDescriptor, '__repr__', om_WrapperDescriptor_repr)

    OM_set_type_mro(class_WrapperDescriptor, [class_WrapperDescriptor, class_object])

def populate_builtin_MethodWrapper():
    builtin_add_method(class_MethodWrapper, '__call__', om_MethodWrapper_call)
    builtin_add_method(class_MethodWrapper, '__repr__', om_MethodWrapper_repr)

    OM_set_type_mro(class_MethodWrapper, [class_MethodWrapper, class_object])

def populate_builtin_int():
    #fields_set(class_int, '__init__', om_int_init)
    builtin_add_method(class_int, '__bool__', om_int_bool) # <class 'function'>
    builtin_add_method(class_int, '__add__', om_int_add)
    builtin_add_method(class_int, '__radd__', om_int_radd)
    builtin_add_method(class_int, '__sub__', om_int_sub)
    builtin_add_method(class_int, '__rsub__', om_int_rsub)
    builtin_add_method(class_int, '__mul__', om_int_mul)
    builtin_add_method(class_int, '__rmul__', om_int_rmul)
    builtin_add_method(class_int, '__floordiv__', om_int_floordiv)
    builtin_add_method(class_int, '__rfloordiv__', om_int_rfloordiv)
    builtin_add_method(class_int, '__mod__', om_int_mod)
    builtin_add_method(class_int, '__rmod__', om_int_rmod)
    builtin_add_method(class_int, '__eq__', om_int_eq)
    builtin_add_method(class_int, '__ne__', om_int_ne)
    builtin_add_method(class_int, '__lt__', om_int_lt)
    builtin_add_method(class_int, '__lte__', om_int_lte)
    builtin_add_method(class_int, '__gt__', om_int_gt)
    builtin_add_method(class_int, '__gte__', om_int_gte)
    builtin_add_method(class_int, '__repr__', om_int_repr)

    OM_set_type_mro(class_int, [class_int, class_object])

def populate_builtin_bool():
    # TODO: complete bool magic method
    builtin_add_method(class_bool, '__bool__', om_bool_bool)
    builtin_add_method(class_bool, '__repr__', om_bool_repr)

    OM_set_type_mro(class_bool, [class_bool, class_int, class_object])

def populate_builtin_str():
    OM_set_type_class(class_str, class_type)

    OM_set(class_str, '__name__', om_str('str'))
    OM_set(class_str, '__module__', om_str('builtins'))

    #builtin_add_method(fields, '__repr__', om_str_repr)
    builtin_add_method(class_str, '__str__', om_str_str)

    # TODO: add all other methods
    OM_set_type_mro(class_str, [class_str, class_object])

def populate_builtin_tuple():
    # TODO: not implemented
    #builtin_add_method(fields, '__repr__', om_tuple_repr)

    OM_set_type_mro(class_tuple, [class_tuple, class_object])

def populate_builtin_dict():
    OM_set_type_mro(class_dict, [class_dict, class_object])

def populate_builtin_module():
    builtin_add_method(class_module, '__getattribute__', om_module_getattribute)
    builtin_add_method(class_module, '__repr__', om_module_repr)
    OM_set_type_mro(class_module, [class_module, class_object])

def populate_builtin_NoneType():
    # TODO: add all other methods
    builtin_add_method(class_NoneType, '__bool__', om_NoneType_bool)

    OM_set_type_mro(class_NoneType, [class_NoneType, class_object])

def populate_builtin_FunctionType():

    builtin_add_method(class_function, '__call__', om_function_call)
    builtin_add_method(class_function, '__repr__', om_function_repr)

    OM_set_type_mro(class_function, [class_function, class_object])

def populate_builtin_BaseException():
    OM_set_type_mro(class_BaseException, [class_BaseException, class_object])

def populate_builtin_Exception():
    OM_set_type_mro(class_Exception, [class_BaseException, class_object])

def populate_builtin_NameError():
    OM_set_type_mro(class_NameError, [class_NameError, class_Exception, class_BaseException, class_object])

def populate_builtin_TypeError():
    OM_set_type_mro(class_TypeError, [class_TypeError, class_Exception, class_BaseException, class_object])

def populate_builtin_ValueError():
    OM_set_type_mro(class_ValueError, [class_ValueError, class_Exception, class_BaseException, class_object])

def populate_builtin_ArithmeticError():
    OM_set_type_mro(class_ArithmeticError, [class_ArithmeticError, class_Exception, class_BaseException, class_object])

def populate_builtin_ZeroDivisionError():
    OM_set_type_mro(class_ZeroDivisionError, [class_ZeroDivisionError, class_ArithmeticError, class_Exception, class_BaseException, class_object])

def object_class(o):
    if om_is(o, om_None):
        # This is equivalent to javascript bool
        return class_NoneType
    elif om_is(o, om_True) or om_is(o, om_False):
        return class_bool
    elif isinstance(o, str):
        return class_str
    else:
        klass = OM_get_type_class(o)

        # NOTE: this assert should never trigger
        assert klass is not absent, 'object does not have a class'
        return klass

# Object model utilities
def om(cls, maker):
    o = maker()
    OM_set_serial(o, absent)

    public_fields = make_dict()
    OM_set_object_attribs(o, public_fields)
    OM_set_type_class(o, cls)
    return o

def om_boxval(cls, val):
    obj = om(cls, OM_box_create)
    OM_set_boxed_value(obj, val)
    return obj

def om_module(name, val):
    obj = om(class_module, OM_object_create)

    dict_set(val, '__name__', om_str(name))

    OM_set(obj, '__dict__', om_dict(val))
    return obj

def om_dict(val):
    # assert isinstance(val, dict), 'om_dict expected dict'
    return om_boxval(class_dict, val)

def om_str(val):
    # assert isinstance(val, str), 'om_str expected str'
    return om_boxval(class_str, val)

def om_int(val):
    return om_boxval(class_int, val)

def om_WrapperDescriptor(name, code):
    obj = om(class_WrapperDescriptor, OM_WrapperDescriptor_create)
    OM_set_code(obj, code)
    OM_set_WrapperDescriptor_cls(obj, absent)

    OM_set(obj, '__name__', om_str(name))
    return obj


def om_MethodWrapper(name, instance, code):
    obj = om(class_MethodWrapper, OM_MethodWrapper_create)
    OM_set_code(obj, code)
    OM_set_MethodWrapper_instance(obj, instance)

    OM_set(obj, '__name__', name)
    return obj

def om_is(x, y):
    return x is y

def om_is_falsy(val):
    return om_is(val, om_False)

# Creation of om object from class
def OM_object_create():
    return OM_object()

def OM_type_create():
    return OM_type()

def OM_box_create():
    return OM_box()

def OM_function_create():
    return OM_function()

def OM_WrapperDescriptor_create():
    return OM_WrapperDescriptor()

def OM_MethodWrapper_create():
    return OM_MethodWrapper()

# Manipulation of om object.
def OM_set(o, name, value):
    attribs = OM_get_object_attribs(o)
    dict_set(attribs, name, value)

def OM_get(o, name):
    attribs = OM_get_object_attribs(o)
    return dict_get(attribs, name, absent)

def OM_set_object_attribs(o, attribs):
    o.attribs = attribs

def OM_get_object_attribs(o):
    return o.attribs

def OM_set_serial(self, serial):
    self.serial = serial

def OM_get_serial(o, rte):
    serial = o.serial
    if serial is absent:
        # allocate a new serial number.
        serial = rte_serial_counter(rte)
        OM_set_serial(o, serial)
    return serial

def OM_set_type_class(o, cls):
    o.klass = cls

def OM_get_type_class(o):
    return o.klass

def OM_set_type_mro(o, val):
    o.mro = val

def OM_get_type_mro(o):
    return o.mro

def OM_set_boxed_value(o, value):
    o.value = value

def OM_get_boxed_value(o):
    return o.value

def OM_set_code(o, code):
    o.code = code

def OM_get_code(o):
    return o.code


# hidden fields used by function
def OM_set_function_signature(o, value):
    o.signature = value

def OM_get_function_signature(o):
    return o.signature

def OM_set_function_arity(o, arity):
    o.arity = arity

def OM_get_function_arity(o):
    return o.arity

def OM_set_function_body(o, body):
    o.body = body

def OM_get_function_body(o):
    return o.body

# hidden fields in WrapperDescriptor
def OM_set_WrapperDescriptor_cls(o, cls):
    o.cls = cls

def OM_get_WrapperDescriptor_cls(o):
    return o.cls

def OM_set_MethodWrapper_instance(o, instance):
    o.instance = instance

def OM_get_MethodWrapper_instance(o):
    return o.instance

# Call om code.
def om_call(o, ctx, args):
    code = OM_get_code(o)
    if code is absent:
        return sem_call(ctx, args)
    else:
        return code(ctx, args)

# class_type magic methods
def om_type_call(ctx, args):
    assert False, 'Not implemented'

def om_type_getattribute(ctx, args):
    if debug: print('type.__getattribute__')
    self = args[0]
    name = args[1]

    name_value = OM_get_boxed_value(name)
    if name_value == '__class__':
        result = object_class(self)
        return expr_end(ctx, result)
    else:
        # Get field name
        attr = getattribute_from_class_mro(self, name_value)
        if attr is absent:
            assert False, "'type' object has no attribute '"+name_value+"'"

        # attr.__get__
        attr__get__ = getattribute_from_obj_mro(attr, '__get__')
        if attr__get__ is absent:
            return expr_end(ctx, attr)
        else:
            return om_call(attr__get__, ctx, [attr, om_None, self])

def om_type_repr(ctx, args):
    self = args[0]
    self_name = OM_get(self, '__name__')
    self_name_value = OM_get_boxed_value(self_name)
    result = om_str("<class '" + self_name_value + "'>")
    return ctx.cont(ctx.rte, result)

# class_WrapperDescriptor methods
def om_WrapperDescriptor_get(ctx, args):
    if debug: print('wrapper_descriptor.__get__')
    self = args[0]
    obj = args[1]
    cls = args[2]

    if obj is om_None:
        self_cls = OM_get_WrapperDescriptor_cls(self)
        if self_cls is absent:
            OM_set_WrapperDescriptor_cls(self, cls)
        return expr_end(ctx, self)
    else:
        self_name = OM_get(self, '__name__')
        code = OM_get_code(self)
        method = om_MethodWrapper(self_name, obj, code)
        return expr_end(ctx, method)

def om_WrapperDescriptor_call(ctx, args):
    if debug: print('wrapper_descriptor.__call__')
    self = args[0]
    params = args[1:]

    code = OM_get_code(self)

    def cont(rte, val):
        return expr_end(ctx, val)

    ctx1 = Context(ctx.rte, cont, ctx.ast)
    return code(ctx1, params)

def om_WrapperDescriptor_repr(ctx, args):
    if debug: print('wrapper_descriptor.__call__')
    self = args[0]

    self__name__ = OM_get(self, '__name__')
    self__name__value = OM_get_boxed_value(self__name__)

    cls = OM_get_WrapperDescriptor_cls(self)
    clsname = OM_get(cls, '__name__')
    clsname_value = OM_get_boxed_value(clsname)

    result = om_str("<slot wrapper '" + self__name__value + "' of '" + clsname_value + "' objects>")
    return ctx.cont(ctx.rte, result)

# class_MethodWrapper methods
def om_MethodWrapper_call(ctx, args):
    if debug: print('method-wrapper.__call__')
    self = args[0]
    rest = args[1:]

    obj = OM_get_MethodWrapper_instance(self)
    params = [obj] + rest

    def cont(rte, val):
        return expr_end(ctx, val)
    ctx1 = Context(ctx.rte, cont, ctx.ast)
    return om_call(self, ctx1, params)

def om_MethodWrapper_repr(ctx, args):
    if debug: print('method-wrapper.__call__')
    self = args[0]

    serial = OM_get_serial(self, ctx.rte)

    self__name__ = OM_get(self, '__name__')
    self__name__value = OM_get_boxed_value(self__name__)

    instance = OM_get_MethodWrapper_instance(self)

    cls = OM_get_type_class(instance)
    clsname = OM_get(cls, '__name__')
    clsname_value = OM_get_boxed_value(clsname)

    result = om_str("<method-wrapper '" + self__name__value + "' of " + clsname_value + " object #"+ str(serial) +">")
    return ctx.cont(ctx.rte, result)

# class_object methods
def om_object_getattribute(ctx, args):
    if debug: print('object.__getattribute__')
    self = args[0]
    name = args[1]

    dt = OM_get_type_class(name)
    assert dt is class_str, \
            "TypeError: attribute name must be string, not 'typeof(name)'"

    name_value = OM_get_boxed_value(name)

    # Get field name
    attr = getattribute_from_obj_mro(self, name_value)
    if attr is absent:
        assert False, "'object' object has no attribute '"+name_value+"'"

    # TODO: check if attr.__get__ exists
    attr__get__ = getattribute_from_obj_mro(attr, '__get__')
    if attr__get__ is absent:
        return expr_end(ctx, attr)
    else:
        return om_call(attr__get__, ctx, [attr, self, dt])

def om_object_repr(ctx, args):
    self = args[0]
    serial = OM_get_serial(self, ctx.rte)

    cls = OM_get_type_class(self)
    clsname = OM_get(cls, '__name__')
    clsname_value = OM_get_boxed_value(clsname)

    result = om_str("<" + clsname_value + " object at #" + str(serial) +">")
    return ctx.cont(ctx.rte, result)

# class_NotImplementedType
def om_NotImplementedType_str(ctx, args):
    if debug: print('NotImplementedType.__str__')
    self = args[0]
    result = om_str('NotImplemented')
    return ctx.cont(ctx.rte, result)

def om_NotImplementedType_repr(ctx, args):
    if debug: print('NotImplementedType.__repr__')
    self = args[0]
    result = om_str('NotImplemented')
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
    val_value = OM_get_boxed_value(self)
    if val_value != 0:
        result = om_True
    else:
        result = om_False
    return ctx.cont(ctx.rte, result)

def om_int_eq(ctx, args):
    if debug: print('int.__eq__')
    val1 = args[0]
    val2 = args[1]

    cls1 = OM_get_type_class(val1)
    cls2 = OM_get_type_class(val2)
    if om_is(cls2, class_int):
        v1 = OM_get_boxed_value(val1)
        v2 = OM_get_boxed_value(val2)
        if v1 == v2:
            result = om_True
        else:
            result = om_False
    else:
        result = om_NotImplemented
    return expr_end(ctx, result)

def om_int_ne(ctx, args):
    if debug: print('int.__ne__')
    val1 = args[0]
    val2 = args[1]

    v1 = OM_get_boxed_value(val1)
    v2 = OM_get_boxed_value(val2)
    if v1 != v2:
        result = om_True
    else:
        result = om_False
    return expr_end(ctx, result)

def om_int_lt(ctx, args):
    if debug: print('int.__lt__')
    val1 = args[0]
    val2 = args[1]

    v1 = OM_get_boxed_value(val1)
    v2 = OM_get_boxed_value(val2)
    if v1 < v2:
        result = om_True
    else:
        result = om_False
    return expr_end(ctx, result)

def om_int_lte(ctx, args):
    if debug: print('int.__lte__')
    val1 = args[0]
    val2 = args[1]

    v1 = OM_get_boxed_value(val1)
    v2 = OM_get_boxed_value(val2)
    if v1 <= v2:
        result = om_True
    else:
        result = om_False
    return expr_end(ctx, result)

def om_int_gt(ctx, args):
    if debug: print('int.__gt__')
    val1 = args[0]
    val2 = args[1]

    v1 = OM_get_boxed_value(val1)
    v2 = OM_get_boxed_value(val2)
    if v1 > v2:
        result = om_True
    else:
        result = om_False
    return expr_end(ctx, result)

def om_int_gte(ctx, args):
    if debug: print('int.__gte__')
    val1 = args[0]
    val2 = args[1]

    v1 = OM_get_boxed_value(val1)
    v2 = OM_get_boxed_value(val2)
    if v1 >= v2:
        result = om_True
    else:
        result = om_False
    return expr_end(ctx, result)

def om_int_repr(ctx, args):
    self = args[0]
    result = num_to_string(OM_get_boxed_value(self), 10)
    return ctx.cont(ctx.rte, om_str(result))

# class_str methods
def om_str_repr(ctx, args):
    # TODO: code is not working
    if debug: print('str.__repr__')
    self = args[0]
    self_value = OM_get_boxed_value(self)

    def wrap_simplequote(val):
        i = 0
        val_len = len(val)
        result = "'"
        while i < val_len:
            if val[i] == "'":
                result += "\\'"
            elif val[i] == '\\':
                result += '\\\\'
            else:
                result += val[i]
            i += 1
        result += "'"

        return om_str(result)

    self_unbox_len = len(self_unbox)
    i = 0
    while i < self_unbox_len:
        if self_unbox[i] == '"':
            result = wrap_simplequote(self_unbox)
            return ctx.cont(ctx.rte, result)
        i += 1

    result = om_str('"' + self_unbox + '"')
    return ctx.cont(ctx.rte, result)

def om_str_str(ctx, args):
    if debug: print('str.__str__')
    self = args[0]
    return ctx.cont(ctx.rte, self)

# class_dict methods

# class_module methods
def om_module_getattribute(ctx, args):
    if debug: print('module.__getattribute__')
    self = args[0]
    name = args[1]

    # XXX: name must be str
    name_value = OM_get_boxed_value(name)

    self_dict = OM_get(self, '__dict__')
    self_dict_value = OM_get_boxed_value(self_dict)
    result = dict_get(self_dict_value, name_value, absent)
    if result is absent:
        return om_object_getattribute(ctx, args)
    else:
        return expr_end(ctx, result)

def om_module_repr(ctx, args):
    if debug: print('module.__repr__')
    self = args[0]

    self_dict = OM_get(self, '__dict__')
    self_dict_value = OM_get_boxed_value(self_dict)

    name = dict_get(self_dict_value, '__name__', absent)
    # assert name is not absent, 'internal error'
    name_value = OM_get_boxed_value(name)

    env_builtins = rte_builtins(ctx.rte)
    if om_is(self_dict_value, env_builtins):
        result = om_str("<module '" + name_value +"' (built-in)>")
    else:
        result = om_str("<module '" + name_value +"'>")

    return ctx.cont(ctx.rte, result)


# class_NoneType methods
def om_NoneType_bool(ctx, val):
    if debug: print('None.__bool__')
    result = om_False
    return ctx.cont(ctx.rte, result)

# class_function methods
def om_function_call(ctx, args):
    self = args[0]
    params = args[1:]

    signature = OM_get_function_signature(self)

    arity = OM_get_function_arity(self)

    ## test arity
    locals_env = align_args_with_signature(ctx, params, signature)

    stack = make_frame(ctx.rte, ctx.cont, ctx.ast)
    rte = make_rte(ctx.rte, rte_globals(ctx.rte), make_dict_from_list(locals_env), rte_builtins(ctx.rte), stack, absent)
    body = OM_get_function_body(self)
    return body(rte,
                lambda rte1:
                   frame_cont(rte_stack(rte1))(frame_rte(rte_stack(rte1)), om_None))

def om_function_repr(ctx, args):
    self = args[0]
    nb_args = len(args)

    serial = OM_get_serial(self, ctx.rte)

    self__name__ = OM_get(self, '__name__')

    result = om_str('<function ' + OM_get_boxed_value(self__name__) + ' #' + str(serial) + '>')
    return ctx.cont(ctx.rte, result)

# XXX: need to decide if I keep this
def box_object(obj):
    if obj is None:
        return om_None
    elif obj is True:
        return om_True
    elif obj is False:
        return om_False
    elif isinstance(obj, int):
        return om_int(obj)
    elif isinstance(obj, str):
        return om_str(obj)
    else:
        return obj

# Create builtins classes
class_str = make_builtin_class_str()

class_type = make_builtin_class('type', absent)
class_object = make_builtin_class('object', class_type)

class_NotImplementedType = make_builtin_class('NotImplementedType', class_type)
class_WrapperDescriptor = make_builtin_class('wrapper_descriptor', class_type)
class_MethodWrapper = make_builtin_class('method-wrapper', class_type)

class_int = make_builtin_class('int', class_type)
class_bool = make_builtin_class('bool', class_type)
class_NoneType = make_builtin_class('NoneType', class_type)

class_tuple = make_builtin_class('tuple', class_type)
class_list = make_builtin_class('list', class_type)
class_dict = make_builtin_class('dict', class_type)
class_module = make_builtin_class('module', class_type)
class_function = make_builtin_class('function', class_type)

# Exception classes
class_BaseException = make_builtin_class('BaseException', class_type)
class_Exception = make_builtin_class('Exception', class_type)
class_NameError = make_builtin_class('NameError', class_type)
class_TypeError = make_builtin_class('TypeError', class_type)
class_ValueError = make_builtin_class('ValueError', class_type)
class_ArithmeticError = make_builtin_class('ArithmeticError', class_type)
class_ZeroDivisionError = make_builtin_class('ZeroDivisionError', class_type)

om_None = om_boxval(class_NoneType, None)
om_True = om_boxval(class_bool, True)
om_False = om_boxval(class_bool, False)
om_NotImplemented = om(class_NotImplementedType, OM_object_create)

# Primitive operators for doing actual computations
def gen_prim_Numeric_BinOp(py_class, method, prim, om_class, om_box):
    def prim_Numeric_BinOp(ctx, args):
        if debug: print(cls + "." + method)
        val1 = args[0]
        val2 = args[1]

        # This check is done in CPython:
        # >>> int.__add__('a', 1)
        # Traceback (most recent call last):
        #   File "<stdin>", line 1, in <module>
        # TypeError: descriptor '__add__' requires a 'int' object but received a 'str'
        if not om_is(OM_get_type_class(val1), om_class):
            assert False, "TypeError"

        # Primitive operations are only defined on same types.
        if om_is(OM_get_type_class(val2), om_class):
            val1_value = OM_get_boxed_value(val1)
            val2_value = OM_get_boxed_value(val2)
            result = prim(val1_value, val2_value)
            return ctx.cont(ctx.rte, om_box(result))
        else:
            # TODO: Return om_NotImplemented(rte) (in the proper rte)
            return ctx.cont(ctx.rte, om_NotImplemented)

    return prim_Numeric_BinOp

# Reversed operators reverse the order of their arguments when
# doing the computation.
def gen_prim_Numeric_rBinOp(py_class, method, prim, om_class, om_box):
    def prim_Numeric_rBinOp(ctx, args):
        if debug: print(cls + "." + method)
        val1 = args[0]
        val2 = args[1]

        if not om_is(OM_get_type_class(val1), om_class):
            assert False, "TypeError"

        if om_is(OM_get_type_class(val2), om_class):
            val1_value = OM_get_boxed_value(val1)
            val2_value = OM_get_boxed_value(val2)
            # Reverse the arguments.
            result = prim(val2_value, val1_value)
            return ctx.cont(ctx.rte, om_box(result))
        else:
            # TODO: Return om_NotImplemented(rte) (in the proper rte)
            return ctx.cont(ctx.rte, om_NotImplemented)

    return prim_Numeric_rBinOp

om_int_add = gen_prim_Numeric_BinOp('int', '__add__', num_add, class_int, om_int)
om_int_radd = om_int_add

om_int_sub = gen_prim_Numeric_BinOp('int', '__sub__', num_sub, class_int, om_int)
om_int_rsub = gen_prim_Numeric_rBinOp('int', '__rsub__', num_sub, class_int, om_int)

om_int_mul = gen_prim_Numeric_BinOp('int', '__mul__', num_mul, class_int, om_int)
om_int_rmul = om_int_mul

om_int_mod = gen_prim_Numeric_BinOp('int', '__mod__', num_mod, class_int, om_int)
om_int_rmod = gen_prim_Numeric_rBinOp('int', '__rmod__', num_mod, class_int, om_int)

# FloorDiv has another check for division by zero.
# Write it by hand.
def om_int_floordiv(ctx, args):
    if debug: print("int.__floordiv__")
    val1 = args[0]
    val2 = args[1]

    if not om_is(OM_get_type_class(val1), class_int):
        assert False, "TypeError"

    # Early break for ZeroDivisionError
    val2_value = OM_get_boxed_value(val2)
    if num_zero(val2_value):
        assert False, "ZeroDivisionError"

    # Primitive operations are only defined on same types.
    if om_is(OM_get_type_class(val2), class_int):
        val1_value = OM_get_boxed_value(val1)
        result = num_div(val1_value, val2_value)
        return ctx.cont(ctx.rte, om_int(result))
    else:
        # TODO: Return om_NotImplemented(rte) (in the proper rte)
        return ctx.cont(ctx.rte, om_NotImplemented)

def om_int_rfloordiv(ctx, args):
    if debug: print("int.__rfloordiv__")
    val1 = args[0]
    val2 = args[1]

    if not om_is(OM_get_type_class(val1), class_int):
        assert False, "TypeError"

    # Early break for ZeroDivisionError
    val1_value = OM_get_boxed_value(val1)
    if num_zero(val1_value):
        assert False, "ZeroDivisionError"

    # Primitive operations are only defined on same types.
    if om_is(OM_get_type_class(val2), class_int):
        val2_value = OM_get_boxed_value(val2)
        result = num_div(val2_value, val1_value)
        return ctx.cont(ctx.rte, om_int(result))
    else:
        # TODO: Return om_NotImplemented(rte) (in the proper rte)
        return ctx.cont(ctx.rte, om_NotImplemented)

populate_builtin_type()
populate_builtin_object()

# Internal types
populate_builtin_NotImplementedType()
populate_builtin_WrapperDescriptor()
populate_builtin_MethodWrapper()

# Basic type and date structure.
populate_builtin_int()
populate_builtin_bool()
populate_builtin_str()
populate_builtin_tuple()
populate_builtin_dict()
populate_builtin_module()
populate_builtin_NoneType()
populate_builtin_FunctionType() # type function

# Populate Exception classes
populate_builtin_BaseException()
populate_builtin_Exception()
populate_builtin_NameError()
populate_builtin_TypeError()
populate_builtin_ValueError()
populate_builtin_ArithmeticError()
populate_builtin_ZeroDivisionError()

# Interpreter
def interp_file(path):
    source = read_file(path)
    interp(parse(source, path, 'exec', False))

@nocompile
def read_file(path):
    with open(path, 'r') as f:
        content = f.read()
    return content

def interp_source(src):
    interp(parse(src, '<unknown>', 'exec', False))

def parse(source, filename, mode, context):
    return AST.parse(source, filename, mode, context)

def interp(ast):
    code = comp(ast)
    trampoline(prepare_execution(code, fresh_rte()))

def comp(ast):
    cte = dict()  # unused for now

    (cte1, code) = comp_mod(cte, ast)

    return code

def prepare_execution(code, rte):
    return lambda: code(rte, lambda rte: None)

def fresh_rte():

    # NOTE: dummy internal implementation of print.
    def om_print_code(rte, cont):
        obj = rte_lookup(rte, 'obj')
        #print(unbox_object(obj)) # should call object.__str__
        return cont(rte)

    om_print = om(class_function, OM_function_create)
    OM_set(om_print, '__name__', om_str('print'))

    OM_set_function_signature(om_print, make_posonly_only_signature(['obj']))
    OM_set_function_body(om_print, om_print_code)

    locals_env = absent
    globals_env = make_dict()
    builtins_env = make_dict()
    rte = make_rte(absent, globals_env, locals_env, builtins_env, absent, absent)

    dict_set(builtins_env, 'type', class_type)
    dict_set(builtins_env, 'object', class_object)
    dict_set(builtins_env, 'int', class_int)
    dict_set(builtins_env, 'bool', class_bool)
    dict_set(builtins_env, 'str', class_str)
    dict_set(builtins_env, 'NotImplemented', om_NotImplemented)
    dict_set(builtins_env, 'print', om_print)

    dict_set(builtins_env, 'BaseException', class_BaseException)
    dict_set(builtins_env, 'Exception', class_Exception)
    dict_set(builtins_env, 'NameError', class_NameError)
    dict_set(builtins_env, 'TypeError', class_TypeError)
    dict_set(builtins_env, 'ValueError', class_ValueError)
    dict_set(builtins_env, 'ArithmeticError', class_ArithmeticError)
    dict_set(builtins_env, 'ZeroDivisionError', class_ZeroDivisionError)

    dict_set(globals_env, '__name__', om_str('__main__'))
    dict_set(globals_env, '__builtins__', om_module('builtins', builtins_env))
    return rte

def trampoline(execution_point):

    while execution_point:

        #print('execution_point = ' + repr(execution_point))

        state = execution_point()

        if not state:
            break

        ast = state[0]
        msg = state[1]
        execution_point = state[2]
        ctx = state[3]

        if execution_point:

            print('at '+str(ast.lineno)+'.'+str(ast.col_offset+1)+'-'+str(ast.end_lineno)+'.'+str(ast.end_col_offset+1)+msg)


    #print('exiting trampoline')

    # XXX: manual single step
    # history = [execution_point]
    # current_index = 0
    # while execution_point is not None:
    #     # print(execution_point)
    #     print(hi<module '" + name_value +"'>")
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
        func = om(class_function, OM_function_create)

        OM_set(func, '__name__', om_str(ast.name))

        signature = gen_signature(cte, ast)
        (cte1, body_code) = gen_funcdef_code(cte, ast, ast.body)

        OM_set_function_signature(func, signature)
        OM_set_function_body(func, body_code)

        arity = signature_arity(signature)
        OM_set_function_arity(func, arity)

        # TODO: create closure

        def code(rte, cont):
            return cont(rte, func)

        return gen_var_set(cte, ast, ast.name, code)

    elif isinstance(ast, AST.Delete):
        if debug: print('AST.Delete')
        return gen_delete_seq(cte, ast, ast.targets)



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

def gen_delete(cte, ast, expr):
    (cte1, code) = comp_expr(cte, expr)


    def del_expr(rte, cont):
        def del_code(rte, val):
            if isinstance(expr, AST.Name):
                result = rte_unset(rte, expr.id)
                if result is absent:
                    assert False, "name '"+expr.id+"' is not defined"
                ctx = Context(rte, cont, ast)
                return stmt_end(ctx)
            else:
                assert False, 'only supports var deletion'
        return code(rte, del_code)

    return (cte1, del_expr)


def gen_delete_seq(cte, ast, targets):
    expr = targets[0]
    if len(targets) == 1:
        return gen_delete(cte, ast, expr)
    else:
        assert False, 'multiple targets not yet supported.'




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
                if om_is(cond_val, om_True):
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
                if om_is(cond_val, om_False):
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
                if om_is(cond_val, om_False):
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

# Generate BinOp semantics for python Numeric datatypes (or that which emulate)
# For the correct Python Data Model and interpreter, these are paired with
# generators for primitive operators which do the actual computation, defined later.
def gen_sem_Numeric_BinOp(op_symbol, method, rmethod):

    def sem_Numeric_BinOp(ctx, val1, val2):

        # Helpers
        def call_expr_end(rte, val):
            return expr_end(ctx, val)

        def test_method_result(rte, val):
            # C: Method not implemented for val2's type,
            #    fallback to reversed method.
            if om_is(val, om_NotImplemented):
                return call_rmethod(rte)
            else:
                # END0: val1 has method and can operate on val2.
                #       Return the result.
                return call_expr_end(rte, val)

        def test_rmethod_result(rte, val):
            # F: Rmethod not implemented for val1's type.
            #    Raise TypeError since both methods are absent (like CPython).
            if om_is(val, om_NotImplemented):
                assert False, "TypeError"
            else:
                # END1: val2 has rmethod and can operate on val1.
                #       Return the result.
                return call_expr_end(rte, val)

        def call_rmethod(rte):
            # D: Does val2 have rmethod?
            val2_rmethod = getattribute_from_obj_mro(val2, rmethod)

            # E: Yes, try val2.rmethod(val1)
            if val2_rmethod is not absent:
                # TODO: Refactor to 'with_cont' when it is available.
                ctx2 = Context(rte, test_rmethod_result, ctx.ast)
                # NOTE: Semantics don't switch arguments, primitives do.
                return om_call(val2_rmethod, ctx2, [val1, val2])
            else:
                # G: Method and rmethod are absent.
                #    Raise a TypeError (like CPython).
                assert False, "TypeError"

        # A: Does val1 have method?
        val1_method = getattribute_from_obj_mro(val1, method)

        # B: Yes, try val1.method(val2).
        if val1_method is not absent:
            # TODO: Refactor to 'with_cont' when it is available.
            ctx1 = Context(ctx.rte, test_method_result, ctx.ast)
            return om_call(val1_method, ctx1, [val1, val2])
        else:
            return call_rmethod(ctx.rte)

    return sem_Numeric_BinOp

sem_Add = gen_sem_Numeric_BinOp('+', '__add__', '__radd__')
sem_Sub = gen_sem_Numeric_BinOp('-', '__sub__', '__rsub__')
sem_Mult = gen_sem_Numeric_BinOp('*', '__mul__', '__rmul__')
sem_FloorDiv = gen_sem_Numeric_BinOp('//', '__floordiv__', '__rfloordiv__')
sem_Mod = gen_sem_Numeric_BinOp('%', '__mod__', '__rmod__')

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
    assert __repr__ is not absent, '__repr__ not defined'
    return om_call(__repr__, ctx, [val1])

def sem_getattribute(ctx, args):
    obj = args[0]
    name = args[1]

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
    if result is absent:
        env_builtins = rte_lookup(ctx.rte, '__builtins__')
        ## TODO: need to setup exceptions
        return sem_getattribute(ctx, [env_builtins, om_str(id)])
    else:
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

    def cont(rte, repr_val):
        repr_val_value = OM_get_boxed_value(repr_val)
        return return_to_trampoline(ctx.ast, ': value = '+repr_val_value, lambda: ctx.cont(rte, val), ctx)

    return sem_repr(Context(ctx.rte, cont, ctx.ast), val)

def stmt_end(ctx):
    return return_to_trampoline(ctx.ast, '', lambda: ctx.cont(ctx.rte), ctx)


def return_to_trampoline(ast, msg, continue_execution, ctx):
    # return to trampoline with current execution state
    return (ast, msg, continue_execution, ctx)


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

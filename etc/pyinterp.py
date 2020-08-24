
# from _runtime import make_dict, dict_get, dict_set, nocompile, \
#         int_add, int_sub, int_mul, int_div, int_mod, int_to_string, \
#         int_is_zero, print_stdout
from _runtime import *

# import ast as AST

import _zast as AST
import zast
AST.parse = zast.parse

debug = False
single_step = True

# Sentinel for marking an attribute as absent
class Absent:
    def __str__(self):
        return "<absent>"

absent = Absent()

# Sentinel returned by next for marking the end of a for-loop
class ForLoopEndMarker:
    def __str__(self):
        return "<for loop terminate marker>"

for_loop_end_marker = ForLoopEndMarker()

# Sentinel for marking empty cells in the dynamic array of a list
class EmptyCell:
    def __str__(self):
        return "<empty cell>"

empty_cell = EmptyCell()

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

# Label depth is use to limit the unwinding of
# the ctrl constructs (while, try/catch/finally, with, etc)
# NOTE: inspired from codeboot JS
class CTCtrlLabel:
    def __init__(self, ctrl_next, ids, ast):
        self.ctrl_next = ctrl_next
        self.ids = ids
        self.ast = ast

# While or For
class RTCtrlLabel:
    def __init__(self, ctrl_next, break_cont, continue_cont):
        self.ctrl_next = ctrl_next
        self.break_cont = break_cont
        self.continue_cont = continue_cont

class RTCtrlCatch:
    def __init__(self, ctrl_next, code_catch, lex_env):
        self.ctrl_next = ctrl_next
        self.code_catch = code_catch
        self.lex_env = lex_env


class RTCtrlFinally:
    def __init__(self, ctrl_next, code_finally, cont):
        self.ctrl_next = ctrl_next
        self.code_finally = code_catch
        self.lex_env = lex_env

# class RTE:
#     def __init__(self, global_env, locals_env, builtins, stack, ctrl_env):
#         self.globals_env = globals_env
#         self.locals_env = locals_env
#         self.builtins = builtins
#         self.stack = stack
#         self.ctrl_env = ctrl_env

class CTE:
    def __init__(self, callee, locals_env, lex_env, ctrl_env, external_context, parent):
        self.callee = callee
        self.locals_env = locals_env
        self.lex_env = lex_env
        self.ctrl_env = ctrl_env
        self.external_context = external_context
        self.parent = parent

# NOTE: inspired from codeboot JS
def CTCtrl_controlContext(cte, ast):
    ctrl_env = cte.ctrl_env
    if ctrl_env is None or ctrl_env.ast is not ast:
        ids = make_dict()
        ctrl_env = CTCtrlLabel(ctrl_env, ids, ast)
        cte = CTE(cte.callee,
                  cte.locals_env,
                  cte.lex_env,
                  ctrl_env,
                  cte.external_context,
                  cte.parent)
    # Could be simplify
    dict_set(ctrl_env.ids, 'break point', True)
    dict_set(ctrl_env.ids, 'continue point', True)
    return cte

def CTCtrl_labelLookup(cte, id_str):
    ctrl_env = cte.ctrl_env
    depth = 0
    while ctrl_env is not None:
        if isinstance(ctrl_env, CTCtrlLabel) and dict_get(ctrl_env.ids, id_str, False):
            result = make_dict()
            dict_set(result, 'depth', depth)
            dict_set(result, 'ast', ctrl_env.ast)
            return result
        ctrl_env = ctrl_env.ctrl_next
        depth += 1
    return None

def CT_raise_with_msg(cte, ast, msg):
    syntax_error = dict_get(cte.external_context,
                            'syntaxError',
                            default_syntax_error)
    return syntax_error(ast.lineno-1,
                        ast.col_offset,
                        ast.end_lineno-1,
                        ast.end_col_offset,
                        msg)

def with_cont(ctx, cont):
    return Context(ctx.rte, cont, ctx.ast)

def with_catch(ctx, catcher_cont):
    # Add a continuatin which removes the catcher from the rte before returning
    def unwind_catch_block(rte, val):
        unwinded_rte = unwind_rte_ctrl_env(rte)
        return ctx.cont(unwinded_rte, val)

    catcher = RTCtrlCatch(rte_ctrl_env(ctx.rte), catcher_cont, ctx.rte)
    next_rte = make_rte_from_new_ctrl_env(ctx.rte, catcher)
    return Context(next_rte, unwind_catch_block, ctx.ast)

def with_cont_and_catch(ctx, cont, catcher_cont):
    return with_catch(with_cont(ctx, cont), catcher_cont)

def make_out_of_ast_context(rte, cont):
    return Context(rte, cont, None)


class OM_object:
    """
    klass: the __class__ attribute of the object
    attribs: the attributes of the object
    serial: the serial number of the object.
    """

class OM_type(OM_object):
    """
    mro: the __mro__ attribute of class type
    bases: the bases of the class
    instance_creator: function which creates instances of this base type
    """

class OM_NotImplemented(OM_object):
    pass

# bool, int, str, ...
class OM_box(OM_object):
    """
    value: the inner value wrapped into the object model.
    """

    def __str__(self):
        value = OM_get_boxed_value(self)
        return "<OM_box (" + str(value) + ")>"

class OM_tuple(OM_object):
    """
    seq: the inner sequence of objects
    """

class OM_list(OM_object):
    """
    len: virtual number of elements in the list
    seq: the inner sequence of objects
    """

class OM_slice(OM_object):
    pass

class OM_dict(OM_object):
    pass

class OM_iterator(OM_object):
    """
    obj: object the iterator is iterating over
    index: current index
    """

class OM_module(OM_object):
    pass

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

class OM_NoneType(OM_object):
    pass

class OM_BaseException(OM_object):
    pass


def make_frame(rte, cont, ast):
    return [rte, cont, ast]

def frame_rte(frame):
    return frame[0]

def frame_cont(frame):
    return frame[1]

def frame_ast(frame):
    return frame[2]

def make_rte(rte, globals_env, locals_env, builtins, stack, ctrl_env, vm, trace):
    if rte is absent:
        serial_counter = [0]
    else:
        serial_counter = rte_serial_counter(rte)

    rte = make_dict()

    dict_set(rte, "serial_counter", serial_counter)
    dict_set(rte, "globals", globals_env)
    dict_set(rte, "locals", locals_env)
    dict_set(rte, "builtins", builtins)
    dict_set(rte, "stack", stack)
    dict_set(rte, "ctrl_env", ctrl_env)
    dict_set(rte, "vm", vm)
    dict_set(rte, "trace", trace)

    return rte

def make_rte_from_new_ctrl_env(rte, ctrl_env):
    return make_rte(rte,
                    rte_globals(rte),
                    rte_locals(rte),
                    rte_builtins(rte),
                    rte_stack(rte),
                    ctrl_env,
                    rte_vm(rte),
                    rte_trace(rte))

def unwind_rte_ctrl_env(rte):
    next_ctrl_env = rte_ctrl_env(rte).ctrl_next
    return make_rte_from_new_ctrl_env(rte, next_ctrl_env)

def rte_serial_counter(rte):
    return dict_get(rte, 'serial_counter', absent)

def rte_get_serial(rte):
    boxed_serial = dict_get(rte, 'serial_counter', absent)
    serial = boxed_serial[0]
    boxed_serial[0] = serial + 1
    return serial

def rte_globals(rte):
    return dict_get(rte, 'globals', absent)

def rte_locals(rte):
    return dict_get(rte, 'locals', absent)

def rte_builtins(rte):
    return dict_get(rte, 'builtins', absent)

def rte_stack(rte):
    return dict_get(rte, 'stack', absent)

def rte_ctrl_env(rte):
    return dict_get(rte, 'ctrl_env', absent)

def rte_vm(rte):
    return dict_get(rte, 'vm', absent)

def rte_trace(rte):
    return dict_get(rte, 'trace', True)

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
    return ctx.cont(ctx.rte, val)

# function signature
def make_signature(args, posonlyargs, varargs, kwonlyargs, kw_defaults, kwargs, defaults):
    return (args, posonlyargs, varargs, kwonlyargs, kw_defaults, kwargs, defaults)

empty_sigature = make_signature((), (), None, (), (), None, ())

def make_posonly_only_signature(posonlyargs):
    return make_signature((), posonlyargs, None, (), (), None, ())

def make_posonly_defaults_only_signature(posonlyargs, defaults):
    return make_signature((), posonlyargs, None, (), (), None, defaults)

def make_vararg_only_signature(vararg):
    return make_signature((), (), vararg, (), (), None, ())

def make_posonly_defaults_signature(posonlyargs, defaults):
    return make_signature((), posonlyargs, None, (), (), None, defaults)

def make_args_defaults_signature(args, defaults):
    return make_signature(args, (), None, (), (), None, defaults)

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
    if kwarg is not None and len(kwonlyargs) > 0:
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

                result = caller_args[0:caller_args_len]
                start = defaults_len - missing_args_len

                while start < defaults_len:
                    result.append(defaults[start])
                    start += 1

                return align_args_with_signature(ctx, result, signature)
            else:
                assert False, 'TypeError'
        else:
            assert False, 'vararg not implemented'

# object model
def make_dict_from_list(lst):
    result = make_dict()
    for e in lst:
        dict_set(result, e[0], e[1])
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
    cls = OM_get_object_class(o)
    if name == '__class__':
        return cls
    # elif name == '__mro__':
    #    return OM_get_type_mro(__class__)
    else:
        return getattribute_from_class_mro(cls, name)

def compute_mro(cls, bases):
    seqs = []

    if len(bases) == 0:
        bases = [class_object]

    for el in bases:
        seqs.append(OM_get_type_mro(el))

    seqs.append(bases)

    res = []
    while True:
        non_empty = []

        for seq in seqs:
            if len(seq) > 0:
                non_empty.append(seq)

        non_empty_len = len(non_empty)

        if non_empty_len == 0:
            res_mro = [cls]

            for c in res:
                res_mro.append(c)

            return res_mro

        for seq in non_empty:
            candidate = seq[0]
            for s in non_empty:
                tail = s[1:]

                # checks "candidate in tail"
                tail_len = len(tail)
                i = 0
                while i < tail_len:
                    if candidate is tail[i]:
                        candidate = None
                        break
                    i += 1

            if candidate is not None:
                break

        if candidate is None:
            return None
        else:
            res.append(candidate)

        # TODO: use a for loop with del if zp supports it
        seqs_len = len(seqs)
        i = 0
        while i < seqs_len:
            seq = seqs[i]
            if len(seq) > 0 and seq[0] is candidate:
                seqs[i] = seq[1:]
            i += 1

def make_class(name, module, bases, metaclass):
    cls = om(metaclass)
    # TODO: some builtin class are not compatible, add checks for that
    mro = compute_mro(cls, bases)

    if mro is None:
        # mro could not be resolved, should bubble up to raise a TypeError
        return None
    else:
        OM_set(cls, '__name__', om_str(name))
        OM_set(cls, '__module__', om_str(module))
        OM_set_object_class(cls, metaclass)
        OM_set_type_bases(cls, bases)
        OM_set_type_mro(cls, mro)
        # If X ad mro (X, A, B, C, ...) we reuse the instance_creator of A
        OM_set_type_instance_creator(cls, OM_get_type_instance_creator(mro[1]))
        return cls

def make_builtin_class(name, instance_creator, bases, metaclass):
    # Set base classes when they do exist
    cls = make_class(name, 'builtins', bases, metaclass)
    OM_set_type_instance_creator(cls, instance_creator)
    return cls

def bootstrap_base_types():
    # init class_type
    class_type = om_with_instance_creator(absent, OM_type_create)
    OM_set_object_class(class_type, class_type)
    OM_set_type_instance_creator(class_type, OM_type_create)

    # init class_str
    class_str = om_with_instance_creator(class_type, OM_type_create)
    OM_set_object_class(class_str, class_type)
    OM_set_type_instance_creator(class_str, OM_box_create)

    # init class_object
    class_object = om_with_instance_creator(class_type, OM_object_create)
    OM_set_object_class(class_object, class_type)
    OM_set_type_instance_creator(class_object, OM_object_create)

    # init class_WrapperDescriptor

    class_WrapperDescriptor = om_with_instance_creator(class_type, OM_WrapperDescriptor_create)
    OM_set_object_class(class_WrapperDescriptor, class_type)
    OM_set_type_instance_creator(class_WrapperDescriptor, OM_WrapperDescriptor_create)

    def om_bootstrap_str(value):
        om_value = om_with_instance_creator(class_str, OM_box_create)
        OM_set_boxed_value(om_value, value)
        return om_value

    # populate class_str base attributes
    OM_set(class_str, '__name__', om_bootstrap_str("str"))
    OM_set(class_str, '__module__', om_bootstrap_str("builtins"))
    OM_set_type_mro(class_str, (class_str, class_object))

    OM_set(class_type, '__name__', om_bootstrap_str("type"))
    OM_set(class_type, '__module__', om_bootstrap_str("builtins"))
    OM_set_type_mro(class_type, (class_type, class_object))

    OM_set(class_object, '__name__', om_bootstrap_str("object"))
    OM_set(class_object, '__module__', om_bootstrap_str("builtins"))
    OM_set_type_mro(class_object, (class_object,))

    OM_set(class_WrapperDescriptor, '__name__', om_bootstrap_str("wrapper_descriptor"))
    OM_set(class_WrapperDescriptor, '__module__', om_bootstrap_str("builtins"))
    OM_set_type_mro(class_WrapperDescriptor, (class_WrapperDescriptor, class_object))

    return class_object, class_str, class_type, class_WrapperDescriptor

def bootstrap_populate_base_types():
    buitlin_add_methods_to_class(
        class_type,
        (('__new__', om_type_new),
         ('__call__', om_type_call),
         ('__getattribute__', om_type_getattribute),
         ('__repr__', om_type_repr)))

    buitlin_add_methods_to_class(
        class_object,
        (('__new__', om_object_new),
         ('__init__', om_object_init),
         ('__getattribute__', om_object_getattribute),
         ('__str__', om_object_str),
         ('__repr__', om_object_repr)))

    buitlin_add_methods_to_class(
        class_WrapperDescriptor,
        (('__get__', om_WrapperDescriptor_get),
         ('__call__', om_WrapperDescriptor_call),
         ('__repr__', om_WrapperDescriptor_repr)))

    buitlin_add_methods_to_class(
        class_str,
        (('__new__', om_str_new),
         ('__repr__', om_str_repr),
         ('__str__', om_str_str)))

# Initialize class type objects
def builtin_add_method(o, name, code):
    wrapper = om_WrapperDescriptor(name, o, code)
    OM_set(o, name, wrapper)


def buitlin_add_methods_to_class(cls, methods_table):
    for pair in methods_table:
        name = pair[0]
        code = pair[1]
        builtin_add_method(cls, name, code)

def populate_builtin_NotImplementedType():
    builtin_add_method(class_NotImplementedType, '__str__', om_NotImplementedType_str)
    builtin_add_method(class_NotImplementedType, '__repr__', om_NotImplementedType_repr)

def populate_builtin_MethodWrapper():
    builtin_add_method(class_MethodWrapper, '__call__', om_MethodWrapper_call)
    builtin_add_method(class_MethodWrapper, '__repr__', om_MethodWrapper_repr)

def populate_builtin_int():
    builtin_add_method(class_int, '__bool__', om_int_bool) # <class 'function'>
    # Arithmetic
    builtin_add_method(class_int, '__add__', om_int_add)
    builtin_add_method(class_int, '__radd__', om_int_radd)
    builtin_add_method(class_int, '__sub__', om_int_sub)
    builtin_add_method(class_int, '__rsub__', om_int_rsub)
    builtin_add_method(class_int, '__mul__', om_int_mul)
    builtin_add_method(class_int, '__rmul__', om_int_rmul)
    builtin_add_method(class_int, '__floordiv__', om_int_floordiv)
    builtin_add_method(class_int, '__rfloordiv__', om_int_rfloordiv)
    builtin_add_method(class_int, '__truediv__', om_int_truediv)
    builtin_add_method(class_int, '__rtruediv__', om_int_rtruediv)
    builtin_add_method(class_int, '__mod__', om_int_mod)
    builtin_add_method(class_int, '__rmod__', om_int_rmod)
    builtin_add_method(class_int, '__abs__', om_int_abs)
    # Bitwise
    builtin_add_method(class_int, '__lshift__', om_int_lshift)
    builtin_add_method(class_int, '__rlshift__', om_int_rlshift)
    builtin_add_method(class_int, '__rshift__', om_int_rshift)
    builtin_add_method(class_int, '__rrshift__', om_int_rrshift)
    builtin_add_method(class_int, '__and__', om_int_and)
    builtin_add_method(class_int, '__rand__', om_int_rand)
    builtin_add_method(class_int, '__or__', om_int_or)
    builtin_add_method(class_int, '__ror__', om_int_ror)
    builtin_add_method(class_int, '__xor__', om_int_xor)
    builtin_add_method(class_int, '__rxor__', om_int_rxor)
    # Comparison
    builtin_add_method(class_int, '__eq__', om_int_eq)
    builtin_add_method(class_int, '__ne__', om_int_ne)
    builtin_add_method(class_int, '__lt__', om_int_lt)
    builtin_add_method(class_int, '__le__', om_int_le)
    builtin_add_method(class_int, '__gt__', om_int_gt)
    builtin_add_method(class_int, '__ge__', om_int_ge)
    builtin_add_method(class_int, '__repr__', om_int_repr)
    builtin_add_method(class_int, '__neg__', om_int_neg)
    builtin_add_method(class_int, '__pos__', om_int_pos)
    builtin_add_method(class_int, '__invert__', om_int_invert)


def populate_builtin_float():
    builtin_add_method(class_float, '__add__', om_float_add)
    builtin_add_method(class_float, '__radd__', om_float_radd)
    builtin_add_method(class_float, '__sub__', om_float_sub)
    builtin_add_method(class_float, '__rsub__', om_float_rsub)
    builtin_add_method(class_float, '__mul__', om_float_mul)
    builtin_add_method(class_float, '__rmul__', om_float_rmul)
    builtin_add_method(class_float, '__truediv__', om_float_truediv)
    builtin_add_method(class_float, '__rtruediv__', om_float_rtruediv)
    builtin_add_method(class_float, '__mod__', om_float_mod)
    builtin_add_method(class_float, '__rmod__', om_float_rmod)
    builtin_add_method(class_float, '__repr__', om_float_repr)
    builtin_add_method(class_float, '__pos__', om_float_pos)
    builtin_add_method(class_float, '__neg__', om_float_neg)
    builtin_add_method(class_float, '__abs__', om_float_abs)

def populate_builtin_bool():
    builtin_add_method(class_bool, '__bool__', om_bool_bool)
    builtin_add_method(class_bool, '__repr__', om_bool_repr)

def populate_builtin_tuple():
    builtin_add_method(class_tuple, '__new__', om_tuple_new)
    builtin_add_method(class_tuple, '__repr__', om_tuple_repr)
    builtin_add_method(class_tuple, '__len__', om_tuple_len)
    builtin_add_method(class_tuple, '__getitem__', om_tuple_getitem)

def populate_builtin_list():
    builtin_add_method(class_list, '__new__', om_list_new)
    builtin_add_method(class_list, '__repr__', om_list_repr)
    builtin_add_method(class_list, '__getitem__', om_list_getitem)
    builtin_add_method(class_list, '__setitem__', om_list_setitem)
    builtin_add_method(class_list, '__len__', om_list_len)
    builtin_add_method(class_list, 'append', om_list_append)

def populate_builtin_slice():
    pass

def populate_builtin_iterator():
    builtin_add_method(class_iterator, '__next__', om_iterator_next)

def populate_builtin_dict():
    pass

def populate_builtin_module():
    builtin_add_method(class_module, '__getattribute__', om_module_getattribute)
    builtin_add_method(class_module, '__repr__', om_module_repr)

def populate_builtin_NoneType():
    builtin_add_method(class_NoneType, '__bool__', om_NoneType_bool)
    builtin_add_method(class_NoneType, '__repr__', om_NoneType_repr)

def populate_builtin_FunctionType():
    builtin_add_method(class_function, '__call__', om_function_call)
    builtin_add_method(class_function, '__repr__', om_function_repr)

def populate_builtin_BaseException():
    builtin_add_method(class_BaseException, '__new__', om_BaseException_new)
    builtin_add_method(class_BaseException, '__str__', om_BaseException_str)

def populate_builtin_Exception():
    pass

def object_class(o):
    if om_is(o, om_None):
        # This is equivalent to javascript bool
        return class_NoneType
    elif om_is(o, om_True) or om_is(o, om_False):
        return class_bool
    elif isinstance(o, str):
        return class_str
    else:
        klass = OM_get_object_class(o)

        # NOTE: this assert should never trigger
        assert klass is not absent, 'object does not have a class'
        return klass

# Object model utilities
def om_with_instance_creator(cls, maker):
    o = maker()
    OM_set_serial(o, absent)

    public_fields = make_dict()
    OM_set_object_attribs(o, public_fields)
    OM_set_object_class(o, cls)
    return o

def om(cls):
    maker = OM_get_type_instance_creator(cls)
    return om_with_instance_creator(cls, maker)

def om_boxval(cls, val):
    obj = om(cls)
    OM_set_boxed_value(obj, val)
    return obj

def om_bool(n):
    if n is True:
        return om_True
    elif n is False:
        return om_False
    else:
        raise ValueError("Cannot cast to bool")

def om_tuple(seq):
    obj = om(class_tuple)
    OM_set_tuple_seq(obj, seq)
    return obj

def om_list(seq, len_):
    obj = om(class_list)
    OM_set_list_seq(obj, seq)
    OM_set_list_len(obj, len_)
    return obj

def om_iterator(obj, index):
    it = om(class_iterator)

    OM_set_iterator_obj(it, obj)
    OM_set_iterator_index(it, index)

    return it

def om_module(name, val):
    obj = om(class_module)

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

def om_float(val):
    return om_boxval(class_float, val)

def om_exception(exn, args):
    # NOTE: This assert only trigger if there is a bug in the code.
    obj = om(exn)
    # TODO: wrap in OM_tuple when it is available
    OM_set(obj, 'args', args)
    return obj

def om_WrapperDescriptor(name, cls, code):
    obj = om(class_WrapperDescriptor)
    OM_set_code(obj, code)
    OM_set_WrapperDescriptor_cls(obj, cls)

    OM_set(obj, '__name__', om_str(name))
    return obj


def om_MethodWrapper(name, instance, code):
    obj = om(class_MethodWrapper)
    OM_set_code(obj, code)
    OM_set_MethodWrapper_instance(obj, instance)

    OM_set(obj, '__name__', name)
    return obj

def om_is(x, y):
    return x is y

def om_is_falsy(val):
    return om_is(val, om_False)

def om_issubclass(subcls, cls):
    subcls_mro = OM_get_type_mro(subcls)

    len_mro = len(subcls_mro)

    i = 0
    while i < len_mro:
        if om_is(cls, subcls_mro[i]):
            return True
        i += 1
    return False

def om_isinstance(obj, cls):
    return om_issubclass(OM_get_object_class(obj), cls)

# Creation of om object from class
def OM_object_create():
    return OM_object()

def OM_module_create():
    return OM_module()

def OM_type_create():
    return OM_type()

def OM_NotImplemented_create():
    return OM_NotImplemented()

def OM_box_create():
    return OM_box()

def OM_tuple_create():
    return OM_tuple()

def OM_list_create():
    return OM_list()

def OM_dict_create():
    return OM_dict()

def OM_slice_create():
    return OM_slice()

def OM_iterator_create():
    return OM_iterator()

def OM_function_create():
    return OM_function()

def OM_WrapperDescriptor_create():
    return OM_WrapperDescriptor()

def OM_MethodWrapper_create():
    return OM_MethodWrapper()

def OM_NoneType_create():
    return OM_NoneType()

def OM_BaseException_create():
    return OM_BaseException()

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
        serial = rte_get_serial(rte)
        OM_set_serial(o, serial)
    return serial

def OM_set_object_class(o, cls):
    o.klass = cls

def OM_get_object_class(o):
    return o.klass

def OM_set_type_mro(o, val):
    o.mro = val

def OM_get_type_mro(o):
    return o.mro

def OM_get_type_bases(o):
    return o.bases

def OM_set_type_bases(o, bases):
    o.bases = bases

def OM_set_type_instance_creator(o, val):
    o.instance_creator = val

def OM_get_type_instance_creator(o):
    return o.instance_creator

def OM_set_boxed_value(o, value):
    o.value = value

def OM_get_boxed_value(o):
    return o.value

def OM_get_tuple_seq(o):
    return o.seq

def OM_set_tuple_seq(o, value):
    o.seq = value

def OM_get_list_seq(o):
    return o.seq

def OM_set_list_seq(o, value):
    o.seq = value

def OM_get_list_len(o):
    return o.len

def OM_set_list_len(o, value):
    o.len = value

def OM_get_iterator_obj(o):
    return o.obj

def OM_set_iterator_obj(o, it):
    o.obj = it

def OM_get_iterator_index(o):
    return o.index

def OM_set_iterator_index(o, index):
    o.index = index

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

# Create builtins classes
__base_types = bootstrap_base_types()

class_object = __base_types[0]
class_str = __base_types[1]
class_type = __base_types[2]
class_WrapperDescriptor = __base_types[3]

class_NotImplementedType = make_builtin_class('NotImplementedType', OM_NoneType_create, (), class_type)
class_MethodWrapper = make_builtin_class('method-wrapper', OM_MethodWrapper_create, (), class_type)

class_int = make_builtin_class('int', OM_box_create, (), class_type)
class_float = make_builtin_class('float', OM_box_create, (), class_type)
class_bool = make_builtin_class('bool', OM_box_create, (class_int,), class_type)
class_NoneType = make_builtin_class('NoneType', OM_NoneType_create, (), class_type)

class_tuple = make_builtin_class('tuple', OM_tuple_create, (), class_type)
class_iterator = make_builtin_class('iterator', OM_iterator_create, (), class_type)
class_list = make_builtin_class('list', OM_list_create, (), class_type)
class_dict = make_builtin_class('dict', OM_dict_create, (), class_type)
class_module = make_builtin_class('module', OM_module_create, (), class_type)
class_function = make_builtin_class('function', OM_function_create, (), class_type)
class_slice = make_builtin_class('slice', OM_slice_create, (), class_type)

# Exception classes
class_BaseException = make_builtin_class('BaseException', OM_BaseException_create, (), class_type)
class_Exception = make_builtin_class('Exception', OM_BaseException_create, (class_BaseException,), class_type)
class_NameError = make_builtin_class('NameError', OM_BaseException_create, (class_Exception,), class_type)
class_SyntaxError = make_builtin_class('SyntaxError', OM_BaseException_create, (class_Exception,),  class_type)
class_TypeError = make_builtin_class('TypeError', OM_BaseException_create, (class_Exception,), class_type)
class_ValueError = make_builtin_class('ValueError', OM_BaseException_create, (class_Exception,), class_type)
class_StopIteration = make_builtin_class('StopIteration', OM_BaseException_create, (class_Exception,), class_type)
class_NotImplementedError = make_builtin_class('NotImplementedError', OM_BaseException_create, (class_Exception,), class_type)
class_LookupError = make_builtin_class('LookupError', OM_BaseException_create, (class_Exception,), class_type)
class_EOFError = make_builtin_class('EOFError', OM_BaseException_create, (class_Exception,), class_type)
class_IndexError = make_builtin_class('IndexError', OM_BaseException_create, (class_LookupError,), class_type)
class_AttributeError = make_builtin_class('AttributeError', OM_BaseException_create, (class_Exception,), class_type)
class_ArithmeticError = make_builtin_class('ArithmeticError', OM_BaseException_create, (class_Exception,), class_type)
class_ZeroDivisionError = make_builtin_class('ZeroDivisionError', OM_BaseException_create, (class_ArithmeticError,), class_type)

om_None = om(class_NoneType)
om_True = om_boxval(class_bool, 1)
om_False = om_boxval(class_bool, 0)
om_NotImplemented = om(class_NotImplementedType)

# Call om code.
def om_call(o, ctx, args):
    code = OM_get_code(o)
    if code is absent:
        return sem_call(ctx, args)
    else:
        return code(ctx, args)

# Helper to build magic_methods

def do_check_method_self_arg(self_expected_cls, method_name):
    cls_name = OM_get_boxed_value(OM_get(self_expected_cls, "__name__"))
    method_qualname = cls_name + "." + method_name
    not_enough_arguments_msg = method_qualname + "(): not enough arguments"
    not_a_type_object_msg = method_qualname + "(X): X is not a type object"
    not_a_subtype_msg = method_qualname + "(object): object is not a subtype of " + cls_name

    def check_method_self_arg(ctx, cont, args):
        args_len = len(args)
        if args_len == 0:
            return sem_raise_with_message(ctx, class_TypeError, not_enough_arguments_msg)

        cls = args[0]

        if not om_isinstance(cls, self_expected_cls):
            return sem_raise_with_message(ctx, class_TypeError, not_a_subtype_msg)
        else:
            return cont(ctx, args)

    return check_method_self_arg

def do_check_static_method_cls_arg(expected_cls, method_name):
    cls_name = OM_get_boxed_value(OM_get(expected_cls, "__name__"))
    not_enough_arguments_msg = method_name + "(): not enough arguments"
    not_a_type_object_msg = method_name + "(X): X is not a type object"
    not_a_subtype_msg = method_name + "(object): object is not a subtype of " + cls_name

    def check_new_cls_arg(ctx, cont, args):
        args_len = len(args)
        if args_len == 0:
            return sem_raise_with_message(ctx, class_TypeError, not_enough_arguments_msg)

        cls = args[0]

        if not om_isinstance(cls, class_type):
            return sem_raise_with_message(ctx, class_TypeError, not_a_type_object_msg)
        elif not om_issubclass(cls, expected_cls):
            return sem_raise_with_message(ctx, class_TypeError, not_a_subtype_msg)
        else:
            return cont(ctx, args)

    return check_new_cls_arg


def do_static_magic_method(cls, method_name, code):
    check_static_method_cls_arg = do_check_static_method_cls_arg(cls, method_name)

    def magic_method(ctx, args):
        return check_static_method_cls_arg(ctx, code, args)

    return magic_method

def do_magic_method(cls, method_name, code):
    check_method_self_arg = do_check_method_self_arg(cls, method_name)

    def magic_method(ctx, args):
        return check_method_self_arg(ctx, code, args)

    return magic_method


# class_type magic methods
def om_type_new_code(ctx, args):
    args_len = len(args)
    if args_len == 2:
        obj = args[1]
        return ctx.cont(ctx.rte, OM_get_object_class(obj))
    elif args_len == 4:
        return sem_raise(ctx, class_NotImplementedError)
    else:
        return sem_raise_with_message(ctx, class_TypeError, "type() takes 1 or 3 arguments")

om_type_new = do_magic_method(class_type, "__new__", om_type_new_code)

def om_type_call(ctx, args):
    def on_instance_creation(rte, instance):
        if om_is(OM_get_object_class(instance), cls):
            cls__init__ = getattribute_from_class_mro(cls, "__init__")
            next_ctx = with_cont(ctx, lambda rte, _: ctx.cont(ctx.rte, instance))
            return om_call(cls__init__, next_ctx, args)
        else:
            return ctx.cont(ctx.rte, instance)

    cls = args[0]
    cls__new__ = getattribute_from_class_mro(cls, "__new__")
    next_ctx = with_cont(ctx, on_instance_creation)

    return om_call(cls__new__, next_ctx, args)


def om_type_getattribute(ctx, args):
    if debug: print('type.__getattribute__')
    self = args[0]
    name = args[1]

    name_value = OM_get_boxed_value(name)
    if name_value == '__class__':
        result = object_class(self)
        return ctx.cont(ctx.rte, result)
    else:
        # Get field name
        attr = getattribute_from_class_mro(self, name_value)
        if attr is absent:
            assert False, "'type' object has no attribute '"+name_value+"'"

        # attr.__get__
        attr__get__ = getattribute_from_obj_mro(attr, '__get__')
        if attr__get__ is absent:
            return ctx.cont(ctx.rte, attr)
        else:
            return om_call(attr__get__, ctx, [attr, om_None, self])

def om_format_type_repr(self, rte):
    self_name = OM_get(self, '__name__')
    self_name_value = OM_get_boxed_value(self_name)
    return "<class '" + self_name_value + "'>"

def om_type_repr(ctx, args):
    self = args[0]
    self_name = OM_get(self, '__name__')
    self_name_value = OM_get_boxed_value(self_name)
    result = om_format_type_repr(self, ctx.rte)
    return ctx.cont(ctx.rte, om_str(result))

# class_WrapperDescriptor methods
def om_WrapperDescriptor_get(ctx, args):
    if debug: print('wrapper_descriptor.__get__')
    self = args[0]
    obj = args[1]
    cls = args[2]

    if obj is om_None:
        return ctx.cont(ctx.rte, self)
    else:
        self_name = OM_get(self, '__name__')
        code = OM_get_code(self)
        method = om_MethodWrapper(self_name, obj, code)
        return ctx.cont(ctx.rte, method)

def om_WrapperDescriptor_call(ctx, args):
    if debug: print('wrapper_descriptor.__call__')
    self = args[0]
    params = args[1:]

    code = OM_get_code(self)

    return code(ctx, params)

def om_format_WrapperDescriptor_repr(self, rte):
    self__name__ = OM_get(self, '__name__')
    self__name__value = OM_get_boxed_value(self__name__)

    cls = OM_get_WrapperDescriptor_cls(self)
    clsname = OM_get(cls, '__name__')
    clsname_value = OM_get_boxed_value(clsname)

    return "<slot wrapper '" + self__name__value + "' of '" + clsname_value + "' objects>"

def om_WrapperDescriptor_repr(ctx, args):
    if debug: print('wrapper_descriptor.__call__')
    self = args[0]

    result = om_format_WrapperDescriptor_repr(self, ctx.rte)

    return ctx.cont(ctx.rte, om_str(result))

# class_MethodWrapper methods
def om_MethodWrapper_call(ctx, args):
    if debug: print('method-wrapper.__call__')
    self = args[0]
    rest = args[1:]

    obj = OM_get_MethodWrapper_instance(self)
    params = [obj] + rest

    return om_call(self, ctx, params)

def om_format_MethodWrapper_repr(self, rte):
    serial = OM_get_serial(self, rte)

    self__name__ = OM_get(self, '__name__')
    self__name__value = OM_get_boxed_value(self__name__)

    instance = OM_get_MethodWrapper_instance(self)

    cls = OM_get_object_class(instance)
    clsname = OM_get(cls, '__name__')
    clsname_value = OM_get_boxed_value(clsname)

    return "<method-wrapper '" + self__name__value + "' of " + clsname_value + " object #"+ str(serial) +">"


def om_MethodWrapper_repr(ctx, args):
    if debug: print('method-wrapper.__call__')
    self = args[0]

    result = om_format_MethodWrapper_repr(self, ctx.rte)

    return ctx.cont(ctx.rte, om_str(result))

# class_object methods
def om_object_new(ctx, args):
    args_len = len(args)

    if args_len == 0:
        return sem_raise_with_message(ctx, class_TypeError, "object.__new__(): not enough arguments")
    if args_len > 1:
        return sem_raise_with_message(ctx, class_TypeError, "object() takes no argument")

    cls = args[0]

    if not om_isinstance(cls, class_type):
        return sem_raise_with_message(ctx, class_TypeError, "object.__new__(X): X is not a type object")
    elif OM_get_type_instance_creator(cls) is not OM_get_type_instance_creator(class_object):
        return sem_raise_with_message(ctx, class_TypeError, "TypeError: object.__new__(X) is not safe, use X.__new__()")

    cls = args[0]
    return ctx.cont(ctx.rte, om(cls))

def om_object_init(ctx, args):
    return ctx.cont(ctx.rte, om_None)

def om_object_getattribute(ctx, args):
    if debug: print('object.__getattribute__')
    self = args[0]
    name = args[1]

    dt = OM_get_object_class(name)
    assert dt is class_str, \
            "TypeError: attribute name must be string, not 'typeof(name)'"

    name_value = OM_get_boxed_value(name)

    # Get field name
    attr = getattribute_from_obj_mro(self, name_value)
    if attr is absent:
        self_clsname = OM_get(OM_get_object_class(self), '__name__')
        self_clsname_value = OM_get_boxed_value(self_clsname)

        msg = om_str("'"+ self_clsname_value +"' object has no attribute '"+name_value+"'")
        exn = om_exception(class_AttributeError, om_tuple((msg,)))
        return sem_raise(ctx, exn)

    # TODO: check if attr.__get__ exists
    attr__get__ = getattribute_from_obj_mro(attr, '__get__')
    if attr__get__ is absent:
        return ctx.cont(ctx.rte, attr)
    else:
        return om_call(attr__get__, ctx, [attr, self, dt])

def om_object_str(ctx, args):
    self = args[0]
    return sem_repr(ctx, self)

def om_format_object_repr(self, rte):
    serial = OM_get_serial(self, rte)

    cls = OM_get_object_class(self)
    clsname = OM_get(cls, '__name__')
    clsname_value = OM_get_boxed_value(clsname)

    return "<" + clsname_value + " object #" + str(serial) +">"

def om_object_repr(ctx, args):
    self = args[0]

    result = om_format_object_repr(self, ctx.rte)

    return ctx.cont(ctx.rte, om_str(result))

# class_NotImplementedType
def om_format_NotImplementedType(self, rte):
    return "NotImplemented"

def om_NotImplementedType_str(ctx, args):
    if debug: print('NotImplementedType.__str__')
    self = args[0]
    result = om_format_NotImplementedType(self, ctx.rte)
    return ctx.cont(ctx.rte, om_str(result))

def om_NotImplementedType_repr(ctx, args):
    if debug: print('NotImplementedType.__repr__')
    self = args[0]
    result = om_str('NotImplemented')
    return ctx.cont(ctx.rte, result)

def om_format_bool_repr(self, rte):
    if om_is(self, om_True):
        return "True"
    else:
        return "False"

# class_bool methods
def om_bool_repr(ctx, args):
    if debug: print('bool.__repr__')
    self = args[0]
    result = om_boxval(class_str, om_format_bool_repr(self, ctx.rte))
    return ctx.cont(ctx.rte, result)

def om_bool_bool(ctx, args):
    if debug: print('bool.__bool__')
    self = args[0]
    return ctx.cont(ctx.rte, self)

def om_int_neg_code(ctx, args):
    if len(args) == 1:
        self = args[0]
        result = int_neg(OM_get_boxed_value(self))
        return ctx.cont(ctx.rte, om_boxval(class_int, result))
    else:
        return sem_raise_with_message(ctx, class_TypeError, "expected 0 arguments, got " + str(len(args) - 1))

om_int_neg = do_magic_method(class_int, "__neg__", om_int_neg_code)

def om_int_invert_code(ctx, args):
    if len(args) == 1:
        self = args[0]
        result = int_not(OM_get_boxed_value(self))
        return ctx.cont(ctx.rte, om_boxval(class_int, result))
    else:
        return sem_raise_with_message(ctx, class_TypeError, "expected 0 arguments, got " + str(len(args) - 1))

om_int_invert = do_magic_method(class_int, "__invert__", om_int_invert_code)

def om_int_pos_code(ctx, args):
    if len(args) == 1:
        return ctx.cont(ctx.rte, args[0])
    else:
        return sem_raise_with_message(ctx, class_TypeError, "expected 0 arguments, got " + str(len(args) - 1))

om_int_pos = do_magic_method(class_int, "__pos__", om_int_pos_code)

# class_tuple methods

def make_tuple(ctx, elements):
    return ctx.cont(ctx.rte, om_tuple(elements))

def om_tuple_elements_repr(ctx, elts, repr_acc):
    if len(elts) == 0:
        repr_acc_len = len(repr_acc)
        if repr_acc_len == 0:
            return ctx.cont(ctx.rte, om_str("()"))
        elif repr_acc_len == 1:
            result = '(' + repr_acc[0] + ',)'
            return ctx.cont(ctx.rte, om_str(result))
        else:
            result = '(' + ', '.join(repr_acc) + ')'
            return ctx.cont(ctx.rte, om_str(result))
    else:
        def cont(rte, value):
            repr_acc.append(OM_get_boxed_value(value))
            return om_tuple_elements_repr(ctx, elts[1:], repr_acc)

        return sem_repr(with_cont(ctx, cont), elts[0])

def om_tuple_new(ctx, args):
    args_len = len(args)
    if args_len == 0:
        return sem_raise_with_message(ctx, class_TypeError, "tuple.__new__(): not enough arguments")

    cls = args[0]

    if not om_isinstance(cls, class_type):
        return sem_raise_with_message(ctx, class_TypeError, "tuple.__new__(X): X is not a type object")
    elif not om_issubclass(cls, class_tuple):
        return sem_raise_with_message(ctx, class_TypeError, "tuple.__new__(object): object is not a subtype of tuple")
    if args_len == 1:
        return ctx.cont(ctx.rte, om_tuple(()))
    elif args_len == 2:
        def alloc(rte, seq):
            return ctx.cont(ctx.rte, om_tuple(seq))
        return om_unpack_iterable(with_cont(ctx, alloc), args[1])
    else:
        return sem_raise_with_message(ctx, class_TypeError, "tuple expected at most 1 argument, got " + str(args_len))

def om_tuple_repr(ctx, args):
    if debug: print('tuple.__repr__')
    self = args[0]

    elements = OM_get_tuple_seq(self)

    return om_tuple_elements_repr(ctx, elements, [])

def om_tuple_len(ctx, args):
    if debug: print('tuple.__len__')
    self = args[0]
    elements = OM_get_tuple_seq(self)
    elements_len = len(elements)

    return ctx.cont(ctx.rte, om_int(elements_len))

def om_tuple_getitem(ctx, args):
    if debug: print('tuple.__getitem__')

    self = args[0]
    item = args[1]

    # TODO: cover subtypes of int
    if om_is(OM_get_object_class(item), class_int):
        item_box_index = OM_get_boxed_value(item)
        elements = OM_get_tuple_seq(self)
        elements_len = len(elements)
        if item_box_index >= 0 and item_box_index < elements_len:
            return ctx.cont(ctx.rte, elements[item_box_index])
        elif item_box_index < 0 and item_box_index >= -elements_len:
            return ctx.cont(ctx.rte, elements[item_box_index + elements_len])
        else:
            return sem_raise(ctx, class_IndexError)
    else:
        return sem_raise(ctx, class_TypeError)

# class_list methods

def list_seq_grow(seq):
    seq_len = len(seq)
    new_len = seq_len  * 5 // 4 + 1

    new_seq = []
    i = 0
    while i < seq_len:
        new_seq.append(seq[i])
        i += 1

    while i < new_len:
        new_seq.append(empty_cell)
        i += 1

    return new_seq

def make_list(ctx, elements):
    list_len = len(elements)
    dynamic_array = list_seq_grow(elements)
    return ctx.cont(ctx.rte, om_list(dynamic_array, list_len))

def om_list_new_code(ctx, args):
    if debug: print("list.__new__")

    args_len = len(args)

    if args_len == 1:
        return ctx.cont(ctx.rte, om_list([], 0))
    elif args_len == 2:
        def alloc(rte, seq):
            return make_list(ctx, seq)
        return om_unpack_iterable(with_cont(ctx, alloc), args[1])
    else:
        return sem_raise_with_message(ctx, class_TypeError, "list expected at most 1 argument, got " + str(args_len))

om_list_new = do_static_magic_method(class_list, "__new__", om_list_new_code)


def om_list_elements_repr(ctx, elts, repr_acc, i):
    if len(elts) == i or elts[i] is empty_cell:
        result = '[' + ', '.join(repr_acc) + ']'
        return ctx.cont(ctx.rte, om_str(result))
    else:
        def cont(rte, value):
            repr_acc.append(OM_get_boxed_value(value))
            return om_list_elements_repr(ctx, elts, repr_acc, i + 1)

        return sem_repr(with_cont(ctx, cont), elts[i])

def om_list_repr_code(ctx, args):
    if debug: print('list.__repr__')

    self = args[0]
    elements = OM_get_list_seq(self)
    return om_list_elements_repr(ctx, elements, [], 0)

om_list_repr = do_magic_method(class_list, "__repr__", om_list_repr_code)


def om_list_getitem_code(ctx, args):
    args_len = len(args)
    if args_len == 2:
        self = args[0]
        item = args[1]

        if om_isinstance(item, class_int):
            index = OM_get_boxed_value(item)
            self_len = OM_get_list_len(self)
            elements = OM_get_list_seq(self)
            if index >= 0 and index < self_len:
                return ctx.cont(ctx.rte, elements[index])
            elif index < 0 and index >= -self_len:
                return ctx.cont(ctx.rte, elements[index + self_len])
            else:
                return sem_raise_with_message(ctx, class_IndexError, "list index out of range")
        elif om_isinstance(item, class_slice):
            return sem_raise_with_message(ctx, class_NotImplementedError, "list[slice] not yet implemented")
    else:
        return sem_raise_with_message(ctx, class_TypeError, "__getitem__() takes exactly one argument (" + str(args_len) + " given)")

om_list_getitem = do_magic_method(class_list, "__getitem__", om_list_getitem_code)

def om_list_setitem_code(ctx, args):
    args_len = len(args)
    if args_len == 3:
        self = args[0]
        item = args[1]
        value = args[2]

        if om_isinstance(item, class_int):
            index = OM_get_boxed_value(item)
            self_len = OM_get_list_len(self)
            elements = OM_get_list_seq(self)
            if index >= 0 and index < self_len:
                elements[index] = value
                return ctx.cont(ctx.rte, om_None)
            elif index < 0 and index >= -self_len:
                elements[index + self_len] = value
                return ctx.cont(ctx.rte, om_None)
            else:
                return sem_raise_with_message(ctx, class_IndexError, "list index out of range")
        elif om_isinstance(item, class_slice):
            return sem_raise_with_message(ctx, class_NotImplementedError, "list[slice] not yet implemented")
    else:
        return sem_raise_with_message(ctx, class_TypeError, "__getitem__() takes exactly two argument (" + str(args_len) + " given)")

om_list_setitem = do_magic_method(class_list, "__setitem__", om_list_setitem_code)

def om_list_len_code(ctx, args):
    args_len = len(args)
    if args_len == 1:
        self = args[0]
        elements_len = OM_get_list_len(self)
        return ctx.cont(ctx.rte, om_int(elements_len))
    else:
        return sem_raise_with_message(ctx, class_TypeError,
                                      "__len__() takes exactly one argument (" + str(args_len) + " given)")


om_list_len = do_magic_method(class_list, "__len__", om_list_len_code)

def om_list_append_code(ctx, args):
    if debug: print('list.append')
    self = args[0]
    value = args[1]

    elements = OM_get_list_seq(self)
    list_len = OM_get_list_len(self)
    elements_len = len(elements)

    if list_len < elements_len:
        elements[list_len] = value
        OM_set_list_len(self, list_len + 1)
    else:
        new_elements = list_seq_grow(elements)
        new_elements[list_len] = value
        OM_set_list_seq(self, new_elements)
        OM_set_list_len(self, list_len + 1)

    return ctx.cont(ctx.rte, om_None)

om_list_append = do_magic_method(class_list, "append", om_list_append_code)

# class_iterator methods

def om_iterator_next(ctx, args):
    if debug: print('iterator.__next__')

    self = args[0]

    obj = OM_get_iterator_obj(self)
    index = OM_get_iterator_index(self)

    def increment_index(rte, val):
        OM_set_iterator_index(self, om_int(OM_get_boxed_value(index) + 1))
        return ctx.cont(rte, val)

    def catch_IndexError(rte, exn):
        if om_isinstance(exn, class_IndexError):
            return sem_raise(ctx, class_StopIteration)
        else:
            return sem_raise(ctx, exn)

    next_ctx = with_cont_and_catch(ctx, increment_index, catch_IndexError)

    return sem_getitem(next_ctx, obj, index)

# class_str methods
def om_convert_to_str(ctx, value):
    value_str = getattribute_from_obj_mro(value, "__str__")
    next_ctx = with_cont(ctx, lambda rte, value: ctx.cont(rte, value))
    return om_call(value_str, next_ctx, (value,))

def om_str_new(ctx, args):
    cls = args[0]

    if len(args) == 1:
        return ctx.cont(ctx, om_boxval(cls, ""))
    elif len(args) == 2:
        value = args[1]
        return om_convert_to_str(ctx, value)
    else:
        assert False, "TypeError: str() takes 0 or 1 argument"

def om_format_str_repr(self, rte):
    def wrap_doublequote(s):
        i = 0
        val_len = len(s)
        result = '"'
        while i < val_len:
            if s[i] == '"':
                result += '\\"'
            elif s[i] == '\\':
                result += '\\\\'
            else:
                result += s[i]
            i += 1
        result += '"'

        return result

    value = OM_get_boxed_value(self)
    value_len = len(value)
    i = 0
    while i < value_len:
        if value[i] == "'":
            return wrap_doublequote(value)
        i += 1

    return "'" + value + "'"

def om_str_repr(ctx, args):
    if debug: print('str.__repr__')
    self = args[0]

    formatted_str = om_format_str_repr(self, ctx.rte)

    return ctx.cont(ctx.rte, om_str(formatted_str))

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
        return ctx.cont(ctx.rte, result)

def om_format_module_repr(self, rte):
    self_dict = OM_get(self, '__dict__')
    self_dict_value = OM_get_boxed_value(self_dict)

    name = dict_get(self_dict_value, '__name__', absent)
    # assert name is not absent, 'internal error'
    name_value = OM_get_boxed_value(name)

    env_builtins = rte_builtins(rte)
    if om_is(self_dict_value, env_builtins):
        return "<module '" + name_value +"' (built-in)>"
    else:
        return "<module '" + name_value +"'>"

def om_module_repr(ctx, args):
    if debug: print('module.__repr__')
    self = args[0]

    result = om_format_module_repr(self, ctx.rte)

    return ctx.cont(ctx.rte, om_str(result))


# class_NoneType methods
def om_NoneType_bool(ctx, val):
    if debug: print('None.__bool__')
    result = om_False
    return ctx.cont(ctx.rte, result)

def om_format_NoneType_repr(value, rte):
    return "None"

def om_NoneType_repr(ctx, val):
    if debug: print('None.__repr__')
    return ctx.cont(ctx.rte, om_str(om_format_NoneType_repr(val, ctx.rte)))

# class_function methods
def om_make_function_with_signature(name, code, signature):
    om_fn = om(class_function)

    OM_set(om_fn, '__name__', om_str(name))
    OM_set_function_signature(om_fn, signature)
    OM_set_function_body(om_fn, code)

    return om_fn

def om_function_call(ctx, args):
    self = args[0]
    params = args[1:]

    signature = OM_get_function_signature(self)

    ## test arity
    locals_env = align_args_with_signature(ctx, params, signature)

    stack = make_frame(ctx.rte, ctx.cont, ctx.ast)
    rte = make_rte(ctx.rte, rte_globals(ctx.rte), make_dict_from_list(locals_env), rte_builtins(ctx.rte), stack, rte_ctrl_env(ctx.rte), rte_vm(ctx.rte), rte_trace(ctx.rte))
    body = OM_get_function_body(self)
    return body(rte,
                lambda rte1:
                   frame_cont(rte_stack(rte1))(frame_rte(rte_stack(rte1)), om_None))

def om_format_function_repr(self, rte):
    serial = OM_get_serial(self, rte)
    self__name__ = OM_get(self, '__name__')
    return '<function ' + OM_get_boxed_value(self__name__) + ' #' + str(serial) + '>'

def om_function_repr(ctx, args):
    self = args[0]
    result = om_str(om_format_function_repr(self, ctx.rte))
    return ctx.cont(ctx.rte, result)

# class_BaseException methods
def om_BaseException_new(ctx, args):
    cls = args[0]
    # TODO: use vararg once available
    exn_args = om_tuple(args[1:])

    return ctx.cont(ctx.rte, om_exception(cls, exn_args))

def om_BaseException_str(ctx, args):
    self = args[0]
    self_args = OM_get(self, 'args')

    def cont(rte, seq):
        if len(seq) == 0:
            return ctx.cont(ctx.rte, om_str(""))
        elif len(seq) == 1:
            return om_convert_to_str(ctx, seq[0])
        else:
            acc = []
            # TODO: hack to avoid using nonlocal in map_repr
            i_ref = [0]

            def map_repr(_, val):
                acc.append(val)
                i_ref[0] += 1
                if i_ref[0] < len(seq):
                    return sem_repr(with_cont(ctx, map_repr), seq[i_ref[0]])
                else:
                    acc_str = []
                    i = 0
                    while i < len(acc):
                        acc_str.append(OM_get_boxed_value(acc[i]))
                        i += 1
                    return ctx.cont(ctx.rte, om_str("(" + ", ".join(acc_str) + ")"))

            return sem_repr(with_cont(ctx, map_repr), seq[i_ref[0]])


    return om_unpack_iterable(with_cont(ctx, cont), self_args)


# XXX: need to decide if I keep this
def box_object(obj):
    if obj is None:
        return om_None
    elif obj is True:
        return om_True
    elif obj is False:
        return om_False
    elif float_instance(obj):
        return om_float(obj)
    elif int_instance(obj):
        return om_int(obj)
    elif isinstance(obj, str):
        return om_str(obj)
    else:
        raise ValueError("Cannot box object " + str(obj))

# Primitive operators for doing actual computations
def gen_dunder_Numeric_BinOp(py_class, method, prim, om_class, om_box):
    def dunder_Numeric_BinOp(ctx, args):
        if debug: print(py_class + "." + method)
        val1 = args[0]
        val2 = args[1]

        # Primitive operations are only defined on same types.
        if om_issubclass(OM_get_object_class(val2), om_class):
            val1_value = OM_get_boxed_value(val1)
            val2_value = OM_get_boxed_value(val2)
            result = prim(val1_value, val2_value)
            return ctx.cont(ctx.rte, om_box(result))
        else:
            # TODO: Return om_NotImplemented(rte) (in the proper rte)
            return ctx.cont(ctx.rte, om_NotImplemented)

    return do_magic_method(om_class, method, dunder_Numeric_BinOp)

# Reversed operators reverse the order of their arguments when
# doing the computation.
def gen_dunder_Numeric_rBinOp(py_class, method, prim, om_class, om_box):
    def dunder_Numeric_rBinOp(ctx, args):
        if debug: print(py_class+ "." + method)
        val1 = args[0]
        val2 = args[1]

        if om_issubclass(OM_get_object_class(val2), om_class):
            val1_value = OM_get_boxed_value(val1)
            val2_value = OM_get_boxed_value(val2)
            # Reverse the arguments.
            result = prim(val2_value, val1_value)
            return ctx.cont(ctx.rte, om_box(result))
        else:
            # TODO: Return om_NotImplemented(rte) (in the proper rte)
            return ctx.cont(ctx.rte, om_NotImplemented)

    return do_magic_method(om_class, method, dunder_Numeric_rBinOp)

# Arithmetic
om_int_add = gen_dunder_Numeric_BinOp('int', '__add__', int_add, class_int, om_int)
om_int_radd = om_int_add

om_int_sub = gen_dunder_Numeric_BinOp('int', '__sub__', int_sub, class_int, om_int)
om_int_rsub = gen_dunder_Numeric_rBinOp('int', '__rsub__', int_sub, class_int, om_int)

om_int_mul = gen_dunder_Numeric_BinOp('int', '__mul__', int_mul, class_int, om_int)
om_int_rmul = om_int_mul

# Bitwise
om_int_lshift = gen_dunder_Numeric_BinOp('int', '__lshift__', int_lshift, class_int, om_int)
om_int_rlshift = gen_dunder_Numeric_BinOp('int', '__rlshift__', int_lshift, class_int, om_int)
om_int_rshift = gen_dunder_Numeric_BinOp('int', '__rshift__', int_rshift, class_int, om_int)
om_int_rrshift = gen_dunder_Numeric_BinOp('int', '__rrshift__', int_rshift, class_int, om_int)
om_int_or = gen_dunder_Numeric_BinOp('int', '__or__', int_or, class_int, om_int)
om_int_ror = gen_dunder_Numeric_BinOp('int', '__ror__', int_or, class_int, om_int)
om_int_and = gen_dunder_Numeric_BinOp('int', '__and__', int_and, class_int, om_int)
om_int_rand = gen_dunder_Numeric_BinOp('int', '__rand__', int_and, class_int, om_int)
om_int_xor = gen_dunder_Numeric_BinOp('int', '__xor__', int_xor, class_int, om_int)
om_int_rxor = gen_dunder_Numeric_BinOp('int', '__xror__', int_xor, class_int, om_int)

# class_int methods
def om_int_bool_code(ctx, args):
    if debug: print('int.__bool__')
    self = args[0]
    val_value = OM_get_boxed_value(self)
    if val_value != 0:
        result = om_True
    else:
        result = om_False
    return ctx.cont(ctx.rte, result)

def om_int_abs_code(ctx, args):
    if len(args) == 1:
        self = args[0]
        result = int_abs(OM_get_boxed_value(self))
        return ctx.cont(ctx.rte, om_int(result))
    else:
        return sem_raise_with_message(ctx, class_TypeError, "expected 0 arguments, got " + str(len(args) - 1))

om_int_abs = do_magic_method(class_int, "__abs__", om_int_abs_code)
om_int_bool = do_magic_method(class_int, "__bool__", om_int_bool_code)

# Comparison
om_int_eq = gen_dunder_Numeric_BinOp('int', '__eq__', int_eq, class_int, om_bool)
om_int_ne = gen_dunder_Numeric_BinOp('int', '__ne__', int_ne, class_int, om_bool)
om_int_lt = gen_dunder_Numeric_BinOp('int', '__lt__', int_lt, class_int, om_bool)
om_int_le = gen_dunder_Numeric_BinOp('int', '__le__', int_le, class_int, om_bool)
om_int_gt = gen_dunder_Numeric_BinOp('int', '__gt__', int_gt, class_int, om_bool)
om_int_ge = gen_dunder_Numeric_BinOp('int', '__ge__', int_ge, class_int, om_bool)

def om_format_int_repr(self, rte):
    return int_to_string(OM_get_boxed_value(self), 10)

def om_format_float_repr(self, rte):
    return float_to_string(OM_get_boxed_value(self))

def om_int_repr_code(ctx, args):
    self = args[0]
    result = om_format_int_repr(self, ctx.rte)
    return ctx.cont(ctx.rte, om_str(result))

om_int_repr = do_magic_method(class_int, "__repr__", om_int_repr_code)


# Mod has a check for division by zero.
def om_int_mod_code(ctx, args):
    if debug: print("int.__mod__")
    val1 = args[0]
    val2 = args[1]

    # Early break for ZeroDivisionError
    val2_value = OM_get_boxed_value(val2)
    if int_is_zero(val2_value):
        return sem_raise(ctx, class_ZeroDivisionError)

    # Primitive operations are only defined on same types.
    if om_issubclass(OM_get_object_class(val2), class_int):
        val1_value = OM_get_boxed_value(val1)
        result = int_mod(val1_value, val2_value)
        return ctx.cont(ctx.rte, om_int(result))
    else:
        # TODO: Return om_NotImplemented(rte) (in the proper rte)
        return ctx.cont(ctx.rte, om_NotImplemented)

om_int_mod = do_magic_method(class_int, "__mod__", om_int_mod_code)

def om_int_rmod_code(ctx, args):
    if debug: print("int.__rmod__")
    val1 = args[0]
    val2 = args[1]

    # Early break for ZeroDivisionError
    val1_value = OM_get_boxed_value(val1)
    if int_is_zero(val1_value):
        return sem_raise(ctx, class_ZeroDivisionError)

    # Primitive operations are only defined on same types.
    if om_issubclass(OM_get_object_class(val2), class_int):
        val2_value = OM_get_boxed_value(val2)
        result = int_mod(val2_value, val1_value)
        return ctx.cont(ctx.rte, om_int(result))
    else:
        # TODO: Return om_NotImplemented(rte) (in the proper rte)
        return ctx.cont(ctx.rte, om_NotImplemented)

om_int_rmod = do_magic_method(class_int, "__rmod__", om_int_rmod_code)

# FloorDiv has another check for division by zero.
# Write it by hand.
def om_int_floordiv_code(ctx, args):
    if debug: print("int.__floordiv__")
    val1 = args[0]
    val2 = args[1]

    # Early break for ZeroDivisionError
    val2_value = OM_get_boxed_value(val2)
    if int_is_zero(val2_value):
        return sem_raise(ctx, class_ZeroDivisionError)

    # Primitive operations are only defined on same types.
    if om_issubclass(OM_get_object_class(val2), class_int):
        val1_value = OM_get_boxed_value(val1)
        result = int_div(val1_value, val2_value)
        return ctx.cont(ctx.rte, om_int(result))
    else:
        # TODO: Return om_NotImplemented(rte) (in the proper rte)
        return ctx.cont(ctx.rte, om_NotImplemented)

om_int_floordiv = do_magic_method(class_int, "__floordiv__", om_int_floordiv_code)


def om_int_rfloordiv_code(ctx, args):
    if debug: print("int.__rfloordiv__")
    val1 = args[0]
    val2 = args[1]

    # Early break for ZeroDivisionError
    val1_value = OM_get_boxed_value(val1)
    if int_is_zero(val1_value):
        return sem_raise(ctx, class_ZeroDivisionError)

    # Primitive operations are only defined on same types.
    if om_issubclass(OM_get_object_class(val2), class_int):
        val2_value = OM_get_boxed_value(val2)
        result = int_div(val2_value, val1_value)
        return ctx.cont(ctx.rte, om_int(result))
    else:
        # TODO: Return om_NotImplemented(rte) (in the proper rte)
        return ctx.cont(ctx.rte, om_NotImplemented)

om_int_rfloordiv = do_magic_method(class_int, "__rfloordiv__", om_int_rfloordiv_code)

def om_int_truediv_code(ctx, args):
    if debug: print("int.__truediv__")
    val1 = args[0]
    val2 = args[1]

    # Early break for ZeroDivisionError
    val2_value = OM_get_boxed_value(val2)
    if int_is_zero(val2_value):
        return sem_raise(ctx, class_ZeroDivisionError)

    # Primitive operations are only defined on same types.
    if om_issubclass(OM_get_object_class(val2), class_int):
        val1_value = OM_get_boxed_value(val1)
        result = float_div(int_to_float(val1_value), int_to_float(val2_value))
        return ctx.cont(ctx.rte, om_float(result))
    else:
        # TODO: Return om_NotImplemented(rte) (in the proper rte)
        return ctx.cont(ctx.rte, om_NotImplemented)

om_int_truediv = do_magic_method(class_int, "__truediv__", om_int_truediv_code)


def om_int_rtruediv_code(ctx, args):
    if debug: print("int.__rtruediv__")
    val1 = args[0]
    val2 = args[1]

    # Early break for ZeroDivisionError
    val1_value = OM_get_boxed_value(val1)
    if int_is_zero(val1_value):
        return sem_raise(ctx, class_ZeroDivisionError)

    # Primitive operations are only defined on same types.
    if om_issubclass(OM_get_object_class(val2), class_int):
        val2_value = OM_get_boxed_value(val2)
        result = float_div(int_to_float(val2_value), int_to_float(val1_value))
        return ctx.cont(ctx.rte, om_float(result))
    else:
        # TODO: Return om_NotImplemented(rte) (in the proper rte)
        return ctx.cont(ctx.rte, om_NotImplemented)

om_int_rtruediv = do_magic_method(class_int, "__rtruediv__", om_int_rtruediv_code)

# Float dunders
om_float_add = gen_dunder_Numeric_BinOp('float', '__add__', float_add, class_float, om_float)
om_float_radd = om_float_add

om_float_sub = gen_dunder_Numeric_BinOp('float', '__sub__', float_sub, class_float, om_float)
om_float_rsub = gen_dunder_Numeric_BinOp('float', '__rsub__', float_sub, class_float, om_float)

om_float_mul = gen_dunder_Numeric_BinOp('float', '__mul__', float_mul, class_float, om_float)
om_float_rmul = gen_dunder_Numeric_BinOp('float', '__rmul__', float_mul, class_float, om_float)

def om_float_mod(ctx, args):
    if debug: print("float.__mod__")
    val1 = args[0]
    val2 = args[1]

    if not om_issubclass(OM_get_object_class(val1), class_float):
        return sem_raise(ctx, class_TypeError)

    # Early break for ZeroDivisionError
    val2_value = OM_get_boxed_value(val2)
    if float_is_zero(val2_value):
        return sem_raise(ctx, class_ZeroDivisionError)

    # Primitive operations are only defined on same types.
    if om_issubclass(OM_get_object_class(val2), class_float):
        val1_value = OM_get_boxed_value(val1)
        result = float_mod(val1_value, val2_value)
        return ctx.cont(ctx.rte, om_float(result))
    else:
        # TODO: Return om_NotImplemented(rte) (in the proper rte)
        return ctx.cont(ctx.rte, om_NotImplemented)

def om_float_rmod(ctx, args):
    if debug: print("float.__rmod__")
    val1 = args[0]
    val2 = args[1]

    if not om_issubclass(OM_get_object_class(val1), class_float):
        return sem_raise(ctx, class_TypeError)

    # Early break for ZeroDivisionError
    val1_value = OM_get_boxed_value(val1)
    if float_is_zero(val1_value):
        return sem_raise(ctx, class_ZeroDivisionError)

    # Primitive operations are only defined on same types.
    if om_issubclass(OM_get_object_class(val2), class_float):
        val2_value = OM_get_boxed_value(val2)
        result = float_mod(val2_value, val1_value)
        return ctx.cont(ctx.rte, om_float(result))
    else:
        # TODO: Return om_NotImplemented(rte) (in the proper rte)
        return ctx.cont(ctx.rte, om_NotImplemented)

def om_float_truediv(ctx, args):
    if debug: print("float.__truediv__")
    val1 = args[0]
    val2 = args[1]

    if not om_issubclass(OM_get_object_class(val1), class_float):
        return sem_raise(ctx, class_TypeError)

    # Early break for ZeroDivisionError
    val2_value = OM_get_boxed_value(val2)
    if float_is_zero(val2_value):
        return sem_raise(ctx, class_ZeroDivisionError)

    # Primitive operations are only defined on same types.
    if om_issubclass(OM_get_object_class(val2), class_float):
        val1_value = OM_get_boxed_value(val1)
        result = float_div(val1_value, val2_value)
        return ctx.cont(ctx.rte, om_float(result))
    else:
        # TODO: Return om_NotImplemented(rte) (in the proper rte)
        return ctx.cont(ctx.rte, om_NotImplemented)

def om_float_rtruediv(ctx, args):
    if debug: print("float.__rtruediv__")
    val1 = args[0]
    val2 = args[1]

    if not om_issubclass(OM_get_object_class(val1), class_float):
        return sem_raise(ctx, class_TypeError)

    # Early break for ZeroDivisionError
    val1_value = OM_get_boxed_value(val1)
    if float_is_zero(val1_value):
        return sem_raise(ctx, class_ZeroDivisionError)

    # Primitive operations are only defined on same types.
    if om_issubclass(OM_get_object_class(val2), class_float):
        val2_value = OM_get_boxed_value(val2)
        result = float_div(val2_value, val1_value)
        return ctx.cont(ctx.rte, om_float(result))
    else:
        # TODO: Return om_NotImplemented(rte) (in the proper rte)
        return ctx.cont(ctx.rte, om_NotImplemented)

def om_float_abs_code(ctx, args):
    if len(args) == 1:
        self = args[0]
        result = float_abs(OM_get_boxed_value(self))
        return ctx.cont(ctx.rte, om_float(result))
    else:
        return sem_raise_with_message(ctx, class_TypeError, "expected 0 arguments, got " + str(len(args) - 1))

om_float_abs = do_magic_method(class_float, "__abs__", om_float_abs_code)

def om_float_repr(ctx, args):
    self = args[0]
    result = om_format_float_repr(self, ctx.rte)
    return ctx.cont(ctx.rte, om_str(result))

def om_float_neg_code(ctx, args):
    if len(args) == 1:
        self = args[0]
        result = float_neg(OM_get_boxed_value(self))
        return ctx.cont(ctx.rte, om_boxval(class_float, result))
    else:
        return sem_raise_with_message(ctx, class_TypeError, "expected 0 arguments, got " + str(len(args) - 1))

om_float_neg = do_magic_method(class_float, "__neg__", om_float_neg_code)

def om_float_pos_code(ctx, args):
    if len(args) == 1:
        return ctx.cont(ctx.rte, args[0])
    else:
        return sem_raise_with_message(ctx, class_TypeError, "expected 0 arguments, got "+ str(len(args) - 1))

om_float_pos = do_magic_method(class_float, "__pos__", om_float_pos_code)

bootstrap_populate_base_types()

# Internal types
populate_builtin_NotImplementedType()
populate_builtin_MethodWrapper()

# Basic type and date structure.
populate_builtin_int()
populate_builtin_float()
populate_builtin_bool()
populate_builtin_tuple()
populate_builtin_list()
populate_builtin_slice()
populate_builtin_iterator()
populate_builtin_dict()
populate_builtin_module()
populate_builtin_NoneType()
populate_builtin_FunctionType() # type function

# Populate Exception classes
populate_builtin_BaseException()

# Builtin functions code

def om_input_code(rte, cont):
    def return_value(rte1, obj_str):
        obj_str_value = OM_get_boxed_value(obj_str)
        # TODO: raise EOFError on EOF
        result = input_stdin(obj_str_value)
        if om_is(result, None):
            ctx = make_out_of_ast_context(rte, cont)
            return sem_raise(ctx, class_EOFError)
        else:
            return unwindReturn(rte1, om_str(result))

    obj = rte_lookup(rte, 'obj')
    ctx = make_out_of_ast_context(rte, return_value)
    return om_convert_to_str(ctx, obj)

def gen_int_to_string_conv_code(radix, prefix):
    def conv_code(rte, cont):
        obj = rte_lookup(rte, 'obj')
        obj_cls = OM_get_object_class(obj)
        if om_issubclass(obj_cls, class_int):
            obj_value = OM_get_boxed_value(obj)
            result = prefix + int_to_string(obj_value, radix)
            return unwindReturn(rte, om_str(result))
        else:
            obj_cls_name = OM_get(obj_cls, '__name__')
            obj_cls_name_value = OM_get_boxed_value(obj_cls_name)
            msg = "'"+obj_cls_name_value+"' object cannot be interpreted as an integer"
            ctx = make_out_of_ast_context(rte, cont)
            return sem_raise_with_message(ctx, class_TypeError, msg)

    return conv_code

om_hex_code = gen_int_to_string_conv_code(16, '0x')
om_oct_code = gen_int_to_string_conv_code(8, '0o')
om_bin_code = gen_int_to_string_conv_code(2, '0b')

def om_print_code(rte, _):
    def cont(rte, str_result):
        print_stdout(OM_get_boxed_value(str_result), rte)
        return unwindReturn(rte, om_None)

    next_ctx = make_out_of_ast_context(rte, cont)
    return om_convert_to_str(next_ctx, rte_lookup(rte, 'obj'))

def om_repr_code(rte, _):
    def cont(rte, res):
        return unwindReturn(rte, res)
    next_ctx = make_out_of_ast_context(rte, cont)
    return sem_repr(next_ctx, rte_lookup(rte, 'obj'))

def om_len_code(rte, _):
    def cont(rte, res):
        return unwindReturn(rte, res)
    next_ctx = make_out_of_ast_context(rte, cont)
    return sem_len(next_ctx, rte_lookup(rte, 'obj'))

def om_next_code(rte, _):
    def cont(rte, res):
        return unwindReturn(rte, res)
    next_ctx = make_out_of_ast_context(rte, cont)
    return sem_next(next_ctx, rte_lookup(rte, 'obj'), rte_lookup(rte, 'default'))

def om_iter_code(rte, _):
    next_ctx = make_out_of_ast_context(rte, unwindReturn)

    obj = rte_lookup(rte, 'obj')
    sentinel = rte_lookup(rte, 'sentinel')

    if sentinel is absent:
        return sem_iter(next_ctx, obj)
    else:
        return sem_raise(next_ctx, class_NotImplementedError)

def om_abs_code(rte, _):
    next_ctx = make_out_of_ast_context(rte, unwindReturn)

    obj = rte_lookup(rte, 'obj')
    return sem_abs(next_ctx, obj)

# Built-in Modules
def init_module_math():

    def math_sqrt_code(rte, cont):
        val = rte_lookup(rte, 'obj')
        obj_class = OM_get_object_class(val)
        unboxed_val = OM_get_boxed_value(val)

        if om_is(obj_class, class_int):
            unboxed_val = int_to_float(unboxed_val)
            obj_class = class_float

        if om_is(obj_class, class_float):
            if float_is_neg(unboxed_val):
                ctx = make_out_of_ast_context(rte, cont)
                return sem_raise_with_message(ctx, class_ValueError, 'math domain error')
            return unwindReturn(rte, om_float(float_sqrt(unboxed_val)))

        elif om_is(obj_class, class_float):
            return unwindReturn(rte, om_float(float_sqrt(unboxed_val)))

        else:
            ctx = make_out_of_ast_context(rte, cont)
            return sem_raise(ctx, class_TypeError)

    def math_floor_code(rte, cont):
        val = rte_lookup(rte, 'obj')
        obj_class = OM_get_object_class(val)
        unboxed_val = OM_get_boxed_value(val)

        if om_is(obj_class, class_int):
            return unwindReturn(rte, val)

        elif om_is(obj_class, class_float):
            return unwindReturn(rte, om_int(int_from_float(float_floor(unboxed_val))))

        else:
            ctx = make_out_of_ast_context(rte, cont)
            return sem_raise(ctx, class_TypeError)

    def math_ceil_code(rte, cont):
        val = rte_lookup(rte, 'obj')
        obj_class = OM_get_object_class(val)
        unboxed_val = OM_get_boxed_value(val)

        if om_is(obj_class, class_int):
            return unwindReturn(rte, val)

        elif om_is(obj_class, class_float):
            return unwindReturn(rte, om_int(int_from_float(float_ceil(unboxed_val))))

        else:
            ctx = make_out_of_ast_context(rte, cont)
            return sem_raise(ctx, class_TypeError)

    def math_pow_code(rte, cont):

        val1 = rte_lookup(rte, 'obj1')
        obj1_class = OM_get_object_class(val1)
        unboxed_val1 = OM_get_boxed_value(val1)

        val2 = rte_lookup(rte, 'obj2')
        obj2_class = OM_get_object_class(val2)
        unboxed_val2 = OM_get_boxed_value(val2)

        if om_is(obj1_class, class_int):
            unboxed_val1 = int_to_float(unboxed_val1)
            obj1_class = class_float

        if om_is(obj2_class, class_int):
            unboxed_val2 = int_to_float(unboxed_val2)
            obj2_class = class_float

        if om_is(obj1_class, class_float) and om_is(obj2_class, class_float):
            return unwindReturn(rte, om_float(float_pow(unboxed_val1, unboxed_val2)))

        else:
            ctx = make_out_of_ast_context(rte, cont)
            return sem_raise(ctx, class_TypeError)


    def math_exp_code(rte, cont):
        val = rte_lookup(rte, 'obj')
        obj_class = OM_get_object_class(val)
        unboxed_val = OM_get_boxed_value(val)

        if om_is(obj_class, class_int):
            unboxed_val = int_to_float(unboxed_val)
            return unwindReturn(rte, om_float(float_exp(unboxed_val)))

        if om_is(obj_class, class_float):
            return unwindReturn(rte, om_float(float_exp(unboxed_val)))

        else:
            ctx = make_out_of_ast_context(rte, cont)
            return sem_raise(ctx, class_TypeError)

    def math_log_code(rte, cont):
        val = rte_lookup(rte, 'obj')
        obj_class = OM_get_object_class(val)
        unboxed_val = OM_get_boxed_value(val)

        if om_is(obj_class, class_int):
            unboxed_val = int_to_float(unboxed_val)
            obj_class = class_float

        if om_is(obj_class, class_float):
            if float_is_neg(unboxed_val) or float_is_zero(unboxed_val):
                ctx = make_out_of_ast_context(rte, cont)
                return sem_raise_with_message(ctx, class_ValueError, 'math domain error')
            return unwindReturn(rte, om_float(float_sin(unboxed_val)))

        else:
            ctx = make_out_of_ast_context(rte, cont)
            return sem_raise(ctx, class_TypeError)

    def math_sin_code(rte, cont):
        val = rte_lookup(rte, 'obj')
        obj_class = OM_get_object_class(val)
        unboxed_val = OM_get_boxed_value(val)

        if om_is(obj_class, class_int):
            unboxed_val = int_to_float(unboxed_val)
            return unwindReturn(rte, om_float(float_sin(unboxed_val)))
        elif om_is(obj_class, class_float):
            return unwindReturn(rte, om_float(float_sin(unboxed_val)))
        else:
            ctx = make_out_of_ast_context(rte, cont)
            return sem_raise(ctx, class_TypeError)

    def math_cos_code(rte, cont):
        val = rte_lookup(rte, 'obj')
        obj_class = OM_get_object_class(val)
        unboxed_val = OM_get_boxed_value(val)

        if om_is(obj_class, class_int):
            unboxed_val = int_to_float(unboxed_val)
            return unwindReturn(rte, om_float(float_cos(unboxed_val)))
        elif om_is(obj_class, class_float):
            return unwindReturn(rte, om_float(float_cos(unboxed_val)))
        else:
            ctx = make_out_of_ast_context(rte, cont)
            return sem_raise(ctx, class_TypeError)

    def math_tan_code(rte, cont):
        val = rte_lookup(rte, 'obj')
        obj_class = OM_get_object_class(val)
        unboxed_val = OM_get_boxed_value(val)

        if om_is(obj_class, class_int):
            unboxed_val = int_to_float(unboxed_val)
            return unwindReturn(rte, om_float(float_tan(unboxed_val)))
        elif om_is(obj_class, class_float):
            return unwindReturn(rte, om_float(float_tan(unboxed_val)))
        else:
            ctx = make_out_of_ast_context(rte, cont)
            return sem_raise(ctx, class_TypeError)

    def math_asin_code(rte, cont):
        val = rte_lookup(rte, 'obj')
        obj_class = OM_get_object_class(val)
        unboxed_val = OM_get_boxed_value(val)

        if om_is(obj_class, class_int):
            unboxed_val = int_to_float(unboxed_val)
            return unwindReturn(rte, om_float(float_asin(unboxed_val)))
        elif om_is(obj_class, class_float):
            return unwindReturn(rte, om_float(float_asin(unboxed_val)))
        else:
            ctx = make_out_of_ast_context(rte, cont)
            return sem_raise(ctx, class_TypeError)

    def math_acos_code(rte, cont):
        val = rte_lookup(rte, 'obj')
        obj_class = OM_get_object_class(val)
        unboxed_val = OM_get_boxed_value(val)

        if om_is(obj_class, class_int):
            unboxed_val = int_to_float(unboxed_val)
            return unwindReturn(rte, om_float(float_acos(unboxed_val)))
        elif om_is(obj_class, class_float):
            return unwindReturn(rte, om_float(float_acos(unboxed_val)))
        else:
            ctx = make_out_of_ast_context(rte, cont)
            return sem_raise(ctx, class_TypeError)

    def math_atan_code(rte, cont):
        val = rte_lookup(rte, 'obj')
        obj_class = OM_get_object_class(val)
        unboxed_val = OM_get_boxed_value(val)

        if om_is(obj_class, class_int):
            unboxed_val = int_to_float(unboxed_val)
            return unwindReturn(rte, om_float(float_atan(unboxed_val)))
        elif om_is(obj_class, class_float):
            return unwindReturn(rte, om_float(float_atan(unboxed_val)))
        else:
            ctx = make_out_of_ast_context(rte, cont)
            return sem_raise(ctx, class_TypeError)


    module_math_env = make_dict()

    om_module_math_sqrt = om_make_function_with_signature('sqrt', math_sqrt_code, make_posonly_only_signature(('obj',)))
    dict_set(module_math_env, 'sqrt', om_module_math_sqrt)

    om_module_math_floor = om_make_function_with_signature('floor', math_floor_code, make_posonly_only_signature(('obj',)))
    dict_set(module_math_env, 'floor', om_module_math_floor)

    om_module_math_ceil = om_make_function_with_signature('ceil', math_ceil_code, make_posonly_only_signature(('obj',)))
    dict_set(module_math_env, 'ceil', om_module_math_ceil)

    om_module_math_exp = om_make_function_with_signature('exp', math_exp_code, make_posonly_only_signature(('obj',)))
    dict_set(module_math_env, 'exp', om_module_math_exp)

    om_module_math_log = om_make_function_with_signature('log', math_log_code, make_posonly_only_signature(('obj',)))
    dict_set(module_math_env, 'log', om_module_math_log)

    om_module_math_pow = om_make_function_with_signature('pow', math_pow_code, make_posonly_only_signature(('obj1', 'obj2',)))
    dict_set(module_math_env, 'pow', om_module_math_pow)

    om_module_math_sin = om_make_function_with_signature('sin', math_sin_code, make_posonly_only_signature(('obj',)))
    dict_set(module_math_env, 'sin', om_module_math_sin)

    om_module_math_cos = om_make_function_with_signature('cos', math_cos_code, make_posonly_only_signature(('obj',)))
    dict_set(module_math_env, 'cos', om_module_math_cos)

    om_module_math_tan = om_make_function_with_signature('tan', math_tan_code, make_posonly_only_signature(('obj',)))
    dict_set(module_math_env, 'tan', om_module_math_tan)

    om_module_math_asin = om_make_function_with_signature('asin', math_asin_code, make_posonly_only_signature(('obj',)))
    dict_set(module_math_env, 'asin', om_module_math_asin)

    om_module_math_acos = om_make_function_with_signature('acos', math_acos_code, make_posonly_only_signature(('obj',)))
    dict_set(module_math_env, 'acos', om_module_math_acos)

    om_module_math_atan = om_make_function_with_signature('atan', math_atan_code, make_posonly_only_signature(('obj',)))
    dict_set(module_math_env, 'atan', om_module_math_atan)

    dict_set(module_math_env, 'pi', om_float(float_pi()))
    dict_set(module_math_env, 'e', om_float(float_e()))

    return module_math_env

# Interpreter
def interp_file(path, options):
    source = read_file(path)
    interp(parse(source, path, 'exec', False), options)

@nocompile
def read_file(path):
    with open(path, 'r') as f:
        content = f.read()
    return content

# used by pyinterp CLI
def default_syntax_error(start_line0,
                         start_column0,
                         end_line0,
                         end_column0, msg):
    raise SyntaxError(msg)

def interp_source(src):
    options = {}
    dict_set(options, 'trace', True)
    interp(parse(src, '<unknown>', 'exec', False), options)

def parse(source, filename, mode, context):
    return AST.parse(source, filename, mode, context)

def interp(ast, options):
    # TODO: move outside of this function
    external_context = make_dict()
    dict_set(external_context, 'syntaxError', default_syntax_error)

    code = comp(ast, external_context)
    trampoline(prepare_execution(code, fresh_rte(options)))

def comp(ast, external_context):
    cte = CTE(None, None, None, None, external_context, None)

    (cte1, code) = comp_mod(cte, ast)

    return code

def prepare_execution(code, rte):
    return lambda: code(rte, lambda rte: None)

def fresh_rte(options):
    locals_env = absent
    globals_env = make_dict()
    builtins_env = make_dict()

    trace = dict_get(options, 'trace', False)

    rte = make_rte(absent, globals_env, locals_env, builtins_env, absent, absent, absent, trace)

    om_builtin_print = om_make_function_with_signature('print', om_print_code, make_posonly_only_signature(('obj',)))
    om_builtin_input = om_make_function_with_signature('input', om_input_code, make_posonly_only_signature(('obj',)))
    om_builtin_hex = om_make_function_with_signature('hex', om_hex_code, make_posonly_only_signature(('obj',)))
    om_builtin_oct = om_make_function_with_signature('oct', om_oct_code, make_posonly_only_signature(('obj',)))
    om_builtin_bin = om_make_function_with_signature('bin', om_bin_code, make_posonly_only_signature(('obj',)))
    om_builtin_repr = om_make_function_with_signature('repr', om_repr_code, make_posonly_only_signature(('obj',)))
    om_builtin_len = om_make_function_with_signature('len', om_len_code, make_posonly_only_signature(('obj',)))
    om_builtin_next = om_make_function_with_signature('next', om_next_code,
                                                      make_posonly_defaults_signature(('obj', 'default'), (absent,)))
    om_builtin_iter = om_make_function_with_signature('iter', om_iter_code,
                                                      make_posonly_defaults_signature(('obj', 'sentinel'), (absent,)))

    om_builtin_abs = om_make_function_with_signature('abs', om_abs_code, make_posonly_only_signature(('obj',)))

    dict_set(builtins_env, 'type', class_type)
    dict_set(builtins_env, 'object', class_object)
    dict_set(builtins_env, 'int', class_int)
    dict_set(builtins_env, 'float', class_float)
    dict_set(builtins_env, 'bool', class_bool)
    dict_set(builtins_env, 'str', class_str)
    dict_set(builtins_env, 'tuple', class_tuple)
    dict_set(builtins_env, 'list', class_list)
    dict_set(builtins_env, 'NotImplemented', om_NotImplemented)
    dict_set(builtins_env, 'print', om_builtin_print)
    dict_set(builtins_env, 'input', om_builtin_input)
    dict_set(builtins_env, 'hex', om_builtin_hex)
    dict_set(builtins_env, 'oct', om_builtin_oct)
    dict_set(builtins_env, 'bin', om_builtin_bin)
    dict_set(builtins_env, 'repr', om_builtin_repr)
    dict_set(builtins_env, 'len', om_builtin_len)
    dict_set(builtins_env, 'next', om_builtin_next)
    dict_set(builtins_env, 'iter', om_builtin_iter)
    dict_set(builtins_env, 'abs', om_builtin_abs)

    dict_set(builtins_env, 'BaseException', class_BaseException)
    dict_set(builtins_env, 'Exception', class_Exception)
    dict_set(builtins_env, 'NameError', class_NameError)
    dict_set(builtins_env, 'SyntaxError', class_SyntaxError)
    dict_set(builtins_env, 'TypeError', class_TypeError)
    dict_set(builtins_env, 'ValueError', class_ValueError)
    dict_set(builtins_env, 'LookupError', class_LookupError)
    dict_set(builtins_env, 'IndexError', class_IndexError)
    dict_set(builtins_env, 'StopIteration', class_StopIteration)
    dict_set(builtins_env, 'ArithmeticError', class_ArithmeticError)
    dict_set(builtins_env, 'ZeroDivisionError', class_ZeroDivisionError)

    # Modules
    module_math_env = init_module_math()
    dict_set(globals_env, 'math', om_module('math', module_math_env))

    dict_set(globals_env, '__name__', om_str('__main__'))
    dict_set(globals_env, '__builtins__', om_module('builtins', builtins_env))
    return rte

def trampoline(cont):

    while cont:

        state = cont()

        if not state:
            break

        ast = dict_get(state, "ast", None)
        msg = dict_get(state, "msg", None)
        display_result = dict_get(state, "display_result", None)
        error = dict_get(state, "error", None)
        cont = dict_get(state, "cont", None)
        ctx = dict_get(state, "ctx", None)

        if cont and rte_trace(ctx.rte):
            if error is not None:
                print('at '+str(ast.lineno)+'.'+str(ast.col_offset+1)+'-'+str(ast.end_lineno)+'.'+str(ast.end_col_offset+1)+': exception = ' +error)
            elif msg is not None:
                if len(msg) > 0:
                    msg = ' '+msg

                print('at '+str(ast.lineno)+'.'+str(ast.col_offset+1)+'-'+str(ast.end_lineno)+'.'+str(ast.end_col_offset+1)+msg)


# Compilation of a module.

def comp_mod(cte, ast):

    if isinstance(ast, AST.Module):
        # Module(stmt* body, type_ignore *type_ignores)
        if debug: print('AST.Module')
        return comp_stmt_seq(cte, ast.body)

    elif isinstance(ast, AST.Interactive):
        # Interactive(stmt* body)
        if debug: print('AST.Interactive')
        return comp_stmt_seq(cte, ast.body)

    elif isinstance(ast, AST.Expression):
        # Expression(expr body)
        if debug: print('AST.Interactive')
        return CT_raise_with_msg(cte, ast, "AST.Expression not supported")

    else:
        return CT_raise_with_msg(cte, ast, "unknown ast type")
        #assert False, 'comp_mod expected a AST.Module or AST.Interactive'

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

    elif isinstance(ast, AST.Return):
        # Return
        if debug: print('AST.Return')

        # return point indicate that we are in a function
        # NOTE: inpired from codeboot JS
        depth_ast = CTCtrl_labelLookup(cte, "return point")
        if depth_ast is None:
            return CT_raise_with_msg(cte, ast, "'return' outside of function")
        elif ast.value is None:
            return cte, lambda rte, cont: frame_cont(rte_stack(rte))(frame_rte(rte_stack(rte)), om_None)
        else:
            (cte1, code1) = comp_expr(cte, ast.value)
            return cte, lambda rte, cont: code1(rte, lambda rte1, val1: unwindReturn(rte1, val1))

    elif isinstance(ast, AST.Break):
        if debug: print('AST.Break')
        return gen_break(cte, ast)

    elif isinstance(ast, AST.Continue):
        if debug: print('AST.Continue')
        return gen_continue(cte, ast)

    elif isinstance(ast, AST.Assign):
        # Assign(expr* targets, expr value, string? type_comment)
        if debug: print('AST.Assign')
        if len(ast.targets) == 1:
            target = ast.targets[0]
            if isinstance(target, AST.Name):
                id = ast.targets[0].id
                (cte1, code1) = comp_expr(cte, ast.value)
                return gen_var_set(cte1, ast, id, code1)
            elif isinstance(target, AST.Subscript):
                return gen_Subscript_Store(cte, ast, target, ast.value)
        else:
            return CT_raise_with_msg(cte, ast, 'Only assignments to one element is supported')


    elif isinstance(ast, AST.AugAssign):
        if debug: print("AST.AugAssign")
        target = ast.target
        if isinstance(target, AST.Name):
            op = ast.op
            id = ast.target.id
            (cte1, code1) = comp_expr(cte, ast.value)
            return gen_aug_op(cte1, ast, id, op, code1)


    elif isinstance(ast, AST.While):
        # While(expr test, stmt* body, stmt* orelse)
        if debug: print('AST.While')
        (cte1, code1) = comp_expr(cte, ast.test)
        while_cte = CTCtrl_controlContext(cte1, ast)
        (cte2, code2) = comp_stmt_seq(while_cte, ast.body)
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
        func = om(class_function)

        OM_set(func, '__name__', om_str(ast.name))

        signature = gen_signature(cte, ast)

        ids = make_dict()
        dict_set(ids, "return point", True)

        fn_cte = CTE(ast.name,
                     signature,
                     cte.lex_env,
                     CTCtrlLabel(None, ids, ast),
                     cte.external_context,
                     cte)

        (cte1, body_code) = comp_stmt_seq(fn_cte, ast.body)

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

    elif isinstance(ast, AST.For) and isinstance(ast.target, AST.Name):
        # TODO: support else block
        if debug: print('AST.For')
        #for_cte = CTCtrl_controlContext(cte, ast)
        return gen_for(cte, ast.target, ast.iter, ast.body)

    elif isinstance(ast, AST.Raise):
        if debug: print('AST.Raise')
        (cte1, code1) = comp_expr(cte, ast.exc)
        return gen_raise(cte1, ast, code1)

    else:
        return CT_raise_with_msg(cte, ast, "unsupported statements")



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
        (func_cte, func_code) = comp_expr(cte, ast.func)
        (args_cte, args_code) = comp_elements(func_cte, ast.args)
        # TODO: compile ast.keywords args
        return gen_call(func_cte, ast, func_code, args_code)
    elif isinstance(ast, AST.Tuple):
        if debug: print('AST.Tuple')
        (cte, code_elts) = comp_elements(cte, ast.elts)
        return gen_Tuple(cte, ast, code_elts)
    elif isinstance(ast, AST.List):
        if debug: print('AST.List')
        (cte, code_elts) = comp_elements(cte, ast.elts)
        return gen_List(cte, ast, code_elts)
    elif isinstance(ast, AST.Subscript) and isinstance(ast.ctx, AST.Load):
        if debug: print("AST.Subscript Load")
        obj_cte, obj_code = comp_expr_opt(cte, ast.value)
        index_cte, index_code = comp_expr(obj_cte, ast.slice.value)
        return gen_Subscript_Load(index_cte, ast, obj_code, index_code)
    else:
        return CT_raise_with_msg(cte, ast, "unsupported expression AST")

def comp_elements(cte, args):
    elements_code = []
    next_cte = cte
    for arg in args:
        next_cte, arg_code = comp_expr(next_cte, arg)
        elements_code.append(arg_code)

    return gen_elements_seq(next_cte, elements_code)

def gen_elements_seq(cte, elements_code):
    elements_len = len(elements_code)

    def do_elements_cont(cont):
        i = elements_len - 1
        next_cont = cont
        while i >= 0:
            current_element_code = elements_code[i]

            # Required to create a closure for next_cont, i and current_element_code
            def create_code(next_cont, i, current_element_code):
                def code(rte, acc):
                    def store(rte, val):
                        acc[i] = val
                        return next_cont(rte, acc)
                    return current_element_code(rte, store)
                return code

            next_cont = create_code(next_cont, i, current_element_code)
            i = i - 1
        return next_cont

    def alloc_list(rte, cont):
        # TODO: Replace by acc = [None] * len(elements_comp) once supported
        acc = []
        for _ in elements_code: acc.append(None)

        elements_cont = do_elements_cont(cont)
        return elements_cont(rte, acc)

    return (cte, alloc_list)


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
    for default_ in ast.args.defaults:
        defaults.append(default_.value)

    return make_signature(args, posonlyargs, vararg, kwonlyargs, kw_defaults, kwarg, defaults)

# Code generation functions.

# Note that 'code' is represented as a function closure and 'running'
# code consists of calling the function with the runtime environment (rte)
# and continuation (cont) that continues the execution.  The continuation
# receives the new rte and, if the code is for an expression, the result
# of the expression evaluation.

def do_stmt_end(cont, ast):
    return lambda rte: stmt_end(Context(rte, cont, ast))

def do_stmt_end_with_message(cont, ast):
    return lambda rte, msg: stmt_end_with_message(Context(rte, cont, ast), msg)

def do_expr_end(cont, ast):
    return lambda rte, val: expr_end(Context(rte, cont, ast), val)

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

        def dispatch(rte1, val):
            if om_is_falsy(val):
                return code3(rte1, cont)
            else:
                ctrl_env = rte_ctrl_env(rte)
                ctrl_label = RTCtrlLabel(ctrl_env,
                                         lambda rte2, _: cont(rte1),
                                         lambda rte2, _: code(rte1, cont))
                new_rte = make_rte_from_new_ctrl_env(rte1, ctrl_label)
                return code2(new_rte, lambda rte2: code(rte, cont))

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
            msg = id + " ← " + om_simple_repr(Context(rte, None, ast), val)
            cont_stmt_end_with_message = do_stmt_end_with_message(cont, ast)
            return sem_var_set(Context(rte, lambda rte: cont_stmt_end_with_message(rte, msg), ast), id, val)
        return code1(rte, var_set)
    return (cte, code)


def gen_var_get(cte, ast, id):
    def code(rte, cont):
        return sem_var_get(Context(rte, do_expr_end(cont, ast), ast), id)
    return (cte, code)

def gen_delete(cte, ast, expr):
    if isinstance(expr, AST.Name):
        (expr_cte, code) = comp_expr(cte, expr)

        def del_expr(rte, cont):
            return sem_var_del(Context(rte, do_stmt_end(cont, ast), ast), expr.id)

        return (expr_cte, del_expr)
    else:
        assert False, 'del: only supports var deletion'


def gen_delete_seq(cte, ast, targets):
    expr = targets[0]
    if len(targets) == 1:
        return gen_delete(cte, ast, expr)
    else:
        assert False, 'del: multiple targets not yet supported.'

def gen_for(cte, target, iterable, body):

    iterable_cte, iterable_code = comp_expr(cte, iterable)
    body_cte, body_code = comp_stmt_seq(iterable_cte, body)

    def get_iterable(get_iterable_rte, cont):
        def get_iterator(get_iterator_rte, iterable):
            def get_next(get_next_rte, iterator):
                def assign_target(assign_target_rte, nxt_value):
                    if nxt_value is for_loop_end_marker:
                        return cont(get_next_rte)
                    else:
                        def run_body(rte):
                            return body_code(rte, lambda rte: get_next(rte, iterator))

                        msg = target.id + " ← " + om_simple_repr(Context(assign_target_rte, None, target), nxt_value)
                        cont_stmt_end_with_message = do_stmt_end_with_message(run_body, target)
                        return sem_var_set(Context(assign_target_rte, lambda rte: cont_stmt_end_with_message(rte, msg), target), target.id, nxt_value)
                return sem_next(Context(get_next_rte, assign_target, iterable), iterator, for_loop_end_marker)
            return sem_iter(Context(get_iterator_rte, get_next, iterable), iterable)
        return iterable_code(get_iterable_rte, get_iterator)
    return body_cte, get_iterable

def unwindBreakContinue(rte, depth, cont):
    def loop(rte):
        local_depth = depth
        ctrl_env = rte_ctrl_env(rte)
        while local_depth != 0 and ctrl_env is not absent:
            # TODO: handle Try-finally-else here
            local_depth -= 1
            ctrl_env = ctrl_env.ctrl_next

        # environmnent of the control label
        new_rte = make_rte_from_new_ctrl_env(rte, ctrl_env)
        return cont(new_rte)
    return loop(rte)

def unwindBreak(rte, depth):
    def cont(rte):
        ctrl_env = rte_ctrl_env(rte)
        return ctrl_env.break_cont(rte, om_None)
    return unwindBreakContinue(rte, depth, cont)

def unwindContinue(rte, depth):
    def cont(rte):
        ctrl_env = rte_ctrl_env(rte)
        return ctrl_env.continue_cont(rte, om_None)
    return unwindBreakContinue(rte, depth, cont)

def gen_break(cte, ast):
    depth_ast = CTCtrl_labelLookup(cte, "break point")
    if depth_ast is None:
        return CT_raise_with_msg(cte, ast, "'break' outside loop")
    else:
        def code(rte, _):
            depth = dict_get(depth_ast, 'depth', 0)
            ctx = Context(rte, lambda rte: unwindBreak(rte, depth), ast)
            return stmt_end(ctx)
        return (cte, code)

def gen_continue(cte, ast):
    depth_ast = CTCtrl_labelLookup(cte, "break point")
    if depth_ast is None:
        return CT_raise_with_msg(cte, ast, "'continue' not properly in loop")
    else:
        def code(rte, _):
            depth = dict_get(depth_ast, 'depth', 0)
            ctx = Context(rte, lambda rte: unwindContinue(rte, depth), ast)
            return stmt_end(ctx)
        return (cte, code)

def gen_raise(cte, ast, code):
    def eval_raise_param(rte, cont):
        def raise_exn(rte1, exn):
            ctx = Context(rte1, cont, ast)
            return sem_raise(ctx, exn)
        return code(rte, raise_exn)
    return (cte, eval_raise_param)

def gen_Expr(cte, ast, code1):

    def code(rte, cont):
        return code1(rte, lambda rte1, val1: cont(rte1))

    return (cte, code)

def gen_logical_and(cte, ast, code1, code2):
    if debug: print('gen_logical_and')

    # XXX: look into runtime environment.

    def code(rte, cont):
        expr_end_cont = do_expr_end(cont, ast)
        def cast_bool(rte1, val1):
            def dispatch(rte2, cond_val):
                if om_is(cond_val, om_True):
                    return code2(rte1, expr_end_cont)
                else:
                    return expr_end_cont(rte1, val1)

            ctx = Context(rte, dispatch, ast)
            return sem_bool(ctx, val1)

        return code1(rte, cast_bool)

    return (cte, code)

def gen_logical_or(cte, ast, code1, code2):
    if debug: print('gen_logical_or')

    def code(rte, cont):
        expr_end_cont = do_expr_end(cont, ast)
        def cast_bool(rte1, val1):
            def dispatch(rte2, cond_val):
                if om_is(cond_val, om_False):
                    return expr_end_cont(rte1, val1)
                else:
                    return code2(rte1, expr_end_cont)
            return sem_bool(Context(rte1, dispatch, ast), val1)
        return code1(rte, cast_bool)

    return (cte, code)

def gen_BoolOp(cte, ast, op, values):
    if isinstance(op, AST.And):
        logical_op = gen_logical_and
    elif isinstance(op, AST.Or):
        logical_op = gen_logical_or
    else:
        return CT_raise_with_msg(cte, ast, "unknown boolean operation")
    return gen_BoolOp_seq(cte, ast, logical_op, values)

# Compilation of sequence of expressions

def gen_BoolOp_seq(cte, ast, logical_op, expr_seq):
    (cte1, code1) = comp_expr(cte, expr_seq[0])
    if len(expr_seq) == 1:
        return (cte1, code1)
    else:
        (cte2, code2) = gen_BoolOp_seq(cte, ast, logical_op, expr_seq[1:])
        return logical_op(cte, ast, code1, code2)

# Compilation of sequence of expressions

def gen_UnaryOp(cte, ast, op, code1):
    if debug: print(op)

    if isinstance(op, AST.USub):
        sem_op = sem_Neg
    elif isinstance(op, AST.UAdd):
        sem_op = sem_Pos
    elif isinstance(op, AST.Invert):
        sem_op = sem_Invert
    elif isinstance(op, AST.Not):
        sem_op = sem_Not
    else:
        return CT_raise_with_msg(cte, ast, "unimplemented unary operator")

    def code(rte, cont):
        return code1(rte,
                lambda rte1, val1:
                    sem_op(Context(rte1, do_expr_end(cont, ast), ast), val1))

    return (cte, code)


def gen_aug_op(cte, ast, id, op, code1):
    if debug: print(op)

    if isinstance(op, AST.Add):
        sem_op = sem_IAdd
    elif isinstance(op, AST.Sub):
        sem_op = sem_ISub
    elif isinstance(op, AST.Mult):
        sem_op = sem_IMul
    elif isinstance(op, AST.Div):
        sem_op = sem_ITrueDiv
    elif isinstance(op, AST.FloorDiv):
        sem_op = sem_IFloorDiv
    elif isinstance(op, AST.Mod):
        sem_op = sem_IMod
    else:
        return CT_raise_with_msg(cte, ast, "Unimplemented assignment operator")

    def code(rte, cont):
        return code1(rte,
                     lambda rte1, val1:
                       sem_op(Context(rte1, do_stmt_end(cont, ast), ast),
                                      id, val1))
    return (cte, code)


def gen_BinOp(cte, ast, op, code1, code2):
    if debug: print(op)

    # Arithmetic
    if isinstance(op, AST.Add):
        sem_op = sem_Add
    elif isinstance(op, AST.Sub):
        sem_op = sem_Sub
    elif isinstance(op, AST.Mult):
        sem_op = sem_Mult
    # TODO: Normalize nomenclature
    elif isinstance(op, AST.Div):
        sem_op = sem_TrueDiv
    elif isinstance(op, AST.Mod):
        sem_op = sem_Mod
    elif isinstance(op, AST.FloorDiv):
        sem_op = sem_FloorDiv
    # Bitwise
    elif isinstance(op, AST.LShift):
        sem_op = sem_LShift
    elif isinstance(op, AST.RShift):
        sem_op = sem_RShift
    elif isinstance(op, AST.BitAnd):
        sem_op = sem_BitAnd
    elif isinstance(op, AST.BitOr):
        sem_op = sem_BitOr
    elif isinstance(op, AST.BitXor):
        sem_op = sem_BitXor
    else:
        return CT_raise_with_msg(cte, ast, "unimplemented binary operator")

    def code(rte, cont):
        return code1(rte,
                     lambda rte1, val1:
                       code2(rte1,
                             lambda rte2, val2:
                               sem_op(Context(rte2, do_expr_end(cont, ast), ast),
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
        sem_op = None

    return sem_op


# NOTE: I hate this function but it works
# NOTE2: I see why, but yes... it works
def gen_Compare(cte, ast, left, comparators, ops):
    (cte1, code1) = comp_expr(cte, left)
    (cte2, code2) = comp_expr(cte, comparators[0])
    sem_op1 = comp_Compare_Op(ops[0])

    if sem_op1 is None:
        return CT_raise_with_msg(cte, ast, "unimplemented comparison")
    elif len(ops) == 1:
        return (cte, lambda rte, cont:
                        code1(rte,
                             lambda rte1, val1:
                                code2(rte1,
                                      lambda rte2, val2:
                                         sem_op1(Context(rte2, do_expr_end(cont, ast), ast), val1, val2))))

    elif len(ops) == 2:
        (cte3, code3) = comp_expr(cte, comparators[1])
        sem_op2 = comp_Compare_Op(ops[1])

        def retrieve_val1(rte, cont):
            expr_end_cont = do_expr_end(cont, ast)
            def retrieve_val2(rte1, val1):
                def retrieve_val3(rte3, val2):
                    ctx = Context(rte, expr_end_cont, ast)
                    return sem_op1(ctx, val1, val2)

                def eval_compare(rte2, val2):
                    def dispatch(rte3, cond_var):
                        if cond_var is False:
                            return expr_end_cont(rte3, cond_var)
                        else:
                            return code3(rte3, retrieve_val3)

                    ctx = Context(rte2, dispatch, ast)
                    return sem_op1(ctx, val1, val2)

                return code2(rte1, eval_compare)

            return code1(rte, retrieve_val2)

        return (cte, retrieve_val1)
    else:
        return CT_raise_with_msg(cte, ast, "compare with more than 2 ops not supported")

# Generate BinOp semantics for python Numeric datatypes (or that which emulate)
# For the correct Python Data Model and interpreter, these are paired with
# generators for primitive operators which do the actual computation, defined later.
def gen_sem_Numeric_BinOp(op_symbol, method, rmethod):

    def sem_Numeric_BinOp(ctx, val1, val2):

        def test_method_result(rte, val):
            # C: Method not implemented for val2's type,
            #    fallback to reversed method.
            if om_is(val, om_NotImplemented):
                return call_rmethod(rte)
            else:
                # END0: val1 has method and can operate on val2.
                #       Return the result.
                return ctx.cont(rte, val)

        def test_rmethod_result(rte, val):
            # F: Rmethod not implemented for val1's type.
            #    Raise TypeError since both methods are absent (like CPython).
            if om_is(val, om_NotImplemented):
                return sem_raise(ctx, class_TypeError)
            else:
                # END1: val2 has rmethod and can operate on val1.
                #       Return the result.
                return ctx.cont(rte, val)

        def call_rmethod(rte):
            # D: Does val2 have rmethod?
            val2_rmethod = getattribute_from_obj_mro(val2, rmethod)

            # E: Yes, try val2.rmethod(val1)
            if val2_rmethod is not absent:
                ctx2 = with_cont(ctx, test_rmethod_result)
                # NOTE: self parameter is now val2
                return om_call(val2_rmethod, ctx2, [val2, val1])
            else:
                # G: Method and rmethod are absent.
                #    Raise a TypeError (like CPython).
                return sem_raise(ctx, class_TypeError)

        # A: Does val1 have method?
        val1_method = getattribute_from_obj_mro(val1, method)

        # B: Yes, try val1.method(val2).
        if val1_method is not absent:
            ctx1 = with_cont(ctx, test_method_result)
            return om_call(val1_method, ctx1, [val1, val2])
        else:
            return call_rmethod(ctx.rte)

    return sem_Numeric_BinOp

# Arithmetic
sem_Add = gen_sem_Numeric_BinOp('+', '__add__', '__radd__')
sem_Sub = gen_sem_Numeric_BinOp('-', '__sub__', '__rsub__')
sem_Mult = gen_sem_Numeric_BinOp('*', '__mul__', '__rmul__')
sem_FloorDiv = gen_sem_Numeric_BinOp('//', '__floordiv__', '__rfloordiv__')
sem_TrueDiv = gen_sem_Numeric_BinOp('/', '__truediv__', '__rtruediv__')
sem_Mod = gen_sem_Numeric_BinOp('%', '__mod__', '__rmod__')
# Bitwise
sem_LShift = gen_sem_Numeric_BinOp('<<', '__lshift__', '__rlshift__')
sem_RShift = gen_sem_Numeric_BinOp('>>', '__rshift__', '__rrshift__')
sem_BitOr = gen_sem_Numeric_BinOp('|', '__or__', '__ror__')
sem_BitAnd = gen_sem_Numeric_BinOp('&', '__and__', '__rand__')
sem_BitXor = gen_sem_Numeric_BinOp('^', '__xor__', '__rxor__')
# Comparison
sem_Eq = gen_sem_Numeric_BinOp('==', '__eq__', '__eq__')
sem_NotEq = gen_sem_Numeric_BinOp('==', '__ne__', '__ne__')
sem_Lt = gen_sem_Numeric_BinOp('<', '__lt__', '__gt__')
sem_Gt = gen_sem_Numeric_BinOp('>', '__gt__', '__lt__')
sem_LtE = gen_sem_Numeric_BinOp('<=', '__le__', '__ge__')
sem_GtE = gen_sem_Numeric_BinOp('>=', '__ge__', '__le__')

def sem_Neg(ctx, val1):
    val1_neg = getattribute_from_obj_mro(val1, '__neg__')
    if val1_neg is absent:
        cls = OM_get_object_class(val1)
        cls_name = OM_get_boxed_value(OM_get(cls, "__name__"))
        return sem_raise_with_message(ctx, class_TypeError, "bad operand type for unary -: '"+cls_name+"'")
    else:
        return om_call(val1_neg, ctx, [val1])

def sem_Pos(ctx, val1):
    val1_pos = getattribute_from_obj_mro(val1, '__pos__')
    if val1_pos is absent:
        cls = OM_get_object_class(val1)
        cls_name = OM_get_boxed_value(OM_get(cls, "__name__"))
        return sem_raise_with_message(ctx, class_TypeError, "bad operand type for unary +: '"+cls_name+"'")
    else:
        return om_call(val1_pos, ctx, [val1])

def sem_Invert(ctx, val1):
    val1_pos = getattribute_from_obj_mro(val1, '__invert__')
    if val1_pos is absent:
        cls = OM_get_object_class(val1)
        cls_name = OM_get_boxed_value(OM_get(cls, "__name__"))
        return sem_raise_with_message(ctx, class_TypeError, "bad operand type for unary ~: '"+cls_name+"'")
    else:
        return om_call(val1_pos, ctx, [val1])

def gen_sem_IOperator(method_name, op_name):

    def gen_isem(ctx, id, val):
        def cont_var_get(rte, self):
            def cont_iadd(rte, result):
                new_ctx = Context(rte, ctx.cont, ctx.ast)
                if om_is(result, om_NotImplemented):
                    return sem_raise_with_message(new_ctx, class_TypeError, "unsupported operand type(s) for " + op_name)
                else:
                    return sem_var_set(new_ctx, id, result)

            self_iadd = getattribute_from_obj_mro(self, method_name)
            if self_iadd is absent:
                return sem_raise_with_message(ctx, class_TypeError, 'bad operand type for binary ' + op_name)
            else:
                return om_call(self_iadd, with_cont(ctx, cont_iadd), [ self , val ])

        return sem_var_get(with_cont(ctx, cont_var_get), id)

    return gen_isem

sem_IAdd = gen_sem_IOperator("__add__", "+=")
sem_ISub = gen_sem_IOperator("__sub__", "-=")
sem_IMul = gen_sem_IOperator("__mul__", "*=")
sem_ITrueDiv = gen_sem_IOperator("__truediv__", "/=")
sem_IFloorDiv = gen_sem_IOperator("__floordiv__", "//=")
sem_IMod = gen_sem_IOperator("__mod__", "%=")


def sem_Not(ctx, obj):

    def flip(rte, res):
        if om_is(res, om_True):
            return ctx.cont(rte, om_False)
        else:
            return ctx.cont(rte, om_True)

    return sem_bool(with_cont(ctx, flip), obj)

def sem_repr(ctx, val1):
    val1_repr = getattribute_from_obj_mro(val1, '__repr__')
    # assert val1_repr is not absent, '__repr__ not defined'

    def check_string(rte, res):
        cls = OM_get_type_class(res)
        if om_is(cls, class_str):
            return ctx.cont(rte, res)
        else:
            err = om(class_TypeError)
            return sem_raise(ctx, err)

    ctx1 = with_cont(ctx, check_string)
    return om_call(val1_repr, ctx, [val1])

def sem_getattribute(ctx, args):
    obj = args[0]
    name = args[1]

    def catch_AttributeError(rte, exn):
        if om_isinstance(exn, class_AttributeError):
            obj_getattr = getattribute_from_obj_mro(obj, '__getattr__')
            new_ctx = Context(rte, ctx.cont, ctx.ast)
            if obj_getattr is absent:
                return sem_raise(new_ctx, exn)
            else:
                return om_call(obj_getattr, new_ctx, args)
        else:
            return sem_raise(Context(rte, ctx.cont, ctx.ast), exn)

    obj_getattribute = getattribute_from_obj_mro(obj, '__getattribute__')

    return om_call(obj_getattribute, with_catch(ctx, catch_AttributeError), args)

def sem_call(ctx, args):
    self = args[0]
    params = args[1]

    __call__ = getattribute_from_obj_mro(self, '__call__')
    return om_call(__call__, ctx, [self] + params)

def sem_getitem(ctx, obj, item):
    obj_getitem = getattribute_from_obj_mro(obj, "__getitem__")
    if obj_getitem is absent:
        return sem_raise_with_message(ctx, class_TypeError, 'object is not subscriptable')
    else:
        return om_call(obj_getitem, ctx, (obj, item))

def sem_setitem(ctx, obj, item, val):
    obj_setitem = getattribute_from_obj_mro(obj, "__setitem__")
    if obj_setitem is absent:
        return sem_raise_with_message(ctx, class_TypeError, 'object does not support item assignment')
    else:
        return om_call(obj_setitem, with_cont(ctx, lambda rte, val: ctx.cont(rte)), (obj, item, val))

def sem_next(ctx, obj, default_):
    obj_next = getattribute_from_obj_mro(obj, "__next__")
    if obj_next is absent:
        return sem_raise(ctx, class_TypeError)
    elif default_ is absent:
        return om_call(obj_next, ctx, (obj,))
    else:
        def catch_StopIteration(rte, exn):
            if om_isinstance(exn, class_StopIteration):
                return ctx.cont(rte, default_)
            else:
                return sem_raise(ctx, exn)

        next_ctx = with_catch(ctx, catch_StopIteration)
        return om_call(obj_next, next_ctx, (obj,))

def sem_iter(ctx, obj):
    obj_iter = getattribute_from_obj_mro(obj, "__iter__")
    if obj_iter is absent:
        obj_getitem = getattribute_from_obj_mro(obj, "__getitem__")
        if obj_getitem is absent:
            return sem_raise_with_message(ctx, class_TypeError, "object is not iterable")
        else:
            return ctx.cont(ctx.rte, om_iterator(obj, om_int(0)))
    else:
        return om_call(obj_iter, ctx, (obj,))

def om_unpack_iterable(ctx, it):
    seq = []

    def get_next(rte, iterator):
        def accumulate(rte, val):
            if val is for_loop_end_marker:
                return ctx.cont(ctx.rte, seq)
            else:
                seq.append(val)
                return get_next(rte, iterator)
        return sem_next(Context(rte, accumulate, ctx.ast), iterator, for_loop_end_marker)

    return sem_iter(with_cont(ctx, get_next), it)

def sem_maybe_len(ctx, obj):
    obj_len = getattribute_from_obj_mro(obj, "__len__")
    if obj_len is absent:
        return ctx.cont(ctx.rte, absent)
    else:
        return om_call(obj_len, ctx, (obj,))

def sem_len(ctx, obj):
    def cont(rte, val):
        if val is absent:
            obj_cls_name = OM_get_boxed_value(OM_get(OM_get_object_class(obj), "__name__"))
            error_msg = "object of type '" + obj_cls_name + "' has no len()"
            return sem_raise_with_message(ctx, class_TypeError, error_msg)
        else:
            return ctx.cont(rte, val)

    return sem_maybe_len(with_cont(ctx, cont), obj)

def sem_abs(ctx, obj):
    obj_abs = getattribute_from_obj_mro(obj, '__abs__')

    if obj_abs is absent:
        return sem_raise_with_message(ctx, class_TypeError, "bad operand type for abs()")
    else:
        return om_call(obj_abs, ctx, [obj])

def gen_constant(cte, ast, val):

    def code(rte, cont):
        obj = box_object(val)
        return sem_constant(Context(rte, do_expr_end(cont, ast), ast), obj)

    return (cte, code)

def gen_Tuple(cte, ast, code_elts):
    return gen_elements(cte, ast, code_elts, make_tuple)

def gen_List(cte, ast, elts_code):
    return gen_elements(cte, ast, elts_code, make_list)

def gen_elements(cte, ast, code_elts, make_container):
    def code(rte, cont):
        return code_elts(rte,
                         lambda rte1, elts:
                            make_container(Context(rte1,
                                                   do_expr_end(cont, ast),
                                                   ast),
                                           elts))
    return (cte, code)


def gen_Subscript_Load(cte, ast, obj_code, index_code):
    def get_obj(rte, cont):
        def get_index(rte, obj):
            def get_item(getitem_rte, index):
                return sem_getitem(Context(getitem_rte, cont, ast), obj, index)
            return index_code(rte, get_item)
        return obj_code(rte, get_index)

    def code(rte, cont):
        return get_obj(rte, do_expr_end(cont, ast))
    return cte, code

def gen_Subscript_Store(cte, ast, target, value):
    target_obj = target.value
    target_index = target.slice.value

    obj_cte, obj_code = comp_expr(cte, target_obj)
    index_cte, index_code = comp_expr(obj_cte, target_index)
    value_cte, value_code = comp_expr(index_cte, value)

    def get_obj(rte, cont):
        def get_index(rte, obj):
            def get_value(get_value_rte, index):
                def set_item(setitem_rte, value):
                    return sem_setitem(Context(setitem_rte, cont, ast), obj, index, value)
                return value_code(get_value_rte, set_item)
            return index_code(rte, get_value)
        return obj_code(rte, get_index)

    def code(rte, cont):
        return get_obj(rte, do_stmt_end(cont, ast))

    return value_cte, code



def sem_constant(ctx, val):
    return ctx.cont(ctx.rte, val)

def sem_var_set(ctx, id, val):
    # Clone the current context.
    # TODO: use link environment
    rte_set(ctx.rte, id, val)
    return ctx.cont(ctx.rte)

def sem_var_get(ctx, id):
    def catch_AttributeError(rte, exn):
        if om_isinstance(exn, class_AttributeError):
            error_msg = "name '" + id + "' is not defined"
            return sem_raise_with_message(Context(rte, ctx.cont, ctx.ast), class_NameError, error_msg)
        else:
            return sem_raise(Context(rte, ctx.cont, ctx.ast), exn)

    result = rte_lookup(ctx.rte, id)
    if result is absent:
        env_builtins = rte_lookup(ctx.rte, '__builtins__')
        return sem_getattribute(with_catch(ctx, catch_AttributeError), [env_builtins, om_str(id)])
    else:
        return ctx.cont(ctx.rte, result)

def sem_var_del(ctx, id):
    result = rte_unset(ctx.rte, id)
    if result is absent:
        return sem_raise_with_message(ctx, class_NameError, id)
    else:
        return ctx.cont(ctx.rte)

def sem_bool(ctx, val):
    __val_bool__ = getattribute_from_obj_mro(val, '__bool__')
    if __val_bool__ is absent:
        __val_len__ = getattribute_from_obj_mro(val, '__len__')
        if __val_len__ is absent:
            return ctx.cont(ctx.rte, om_True)
        else:
            def nonzero(rte, val):
                if OM_get_boxed_value(val) != 0:
                    return ctx.cont(ctx.rte, om_True)
                else:
                    return ctx.cont(ctx.rte, om_False)

            ctx1 = with_cont(ctx, nonzero)
            return om_call(__val_len__, ctx1, [val])
    else:
        return om_call(__val_bool__, ctx, [val])


def sem_raise(ctx, exn):
    ctrl_env = rte_ctrl_env(ctx.rte)

    # create the exn_object to be created
    if om_isinstance(exn, class_type) and om_issubclass(exn, class_BaseException):
        exn_obj = om_exception(exn, om_tuple(()))
    elif om_isinstance(exn, class_BaseException):
        exn_obj = exn
    else:
        exn_obj = om_exception(class_TypeError, om_tuple(()))

    # XXX: does not unwind all the way
    while not om_is(ctrl_env, absent):
        if isinstance(ctrl_env, RTCtrlCatch):
            ctrl_rte = ctrl_env.lex_env
            code_catch = ctrl_env.code_catch
            return code_catch(ctrl_rte, exn_obj)
        ctrl_env = ctrl_env.ctrl_next

    def find_frame_with_ast(rte):
        frame = rte_stack(rte)
        while frame is not None and frame_ast(frame) is None:
            frame = rte_stack(frame_rte(frame))
        return frame

    if ctx.ast is None:
        frame = find_frame_with_ast(ctx.rte)
        ctx = Context(frame_rte(frame),
                      frame_cont(frame),
                      frame_ast(frame))

    result = om_simple_exception_format(ctx, exn_obj)
    return expr_end_with_error(ctx, result)

def sem_raise_with_message(ctx, exn_type, msg):
    args = om_tuple((om_str(msg),))
    return sem_raise(ctx, om_exception(exn_type, args))

def gen_call(cte, ast, func_code, args_code):
    def code(rte, cont):
        expr_end_cont = do_expr_end(cont, ast)
        return func_code(rte,
                     lambda rte1, val1:
                        args_code(rte1,
                              lambda rte2, val2:
                                sem_call(Context(rte, expr_end_cont, ast),
                                         [val1, val2])))
    return (cte, code)

def gen_Attribute(cte, ast, code, name):
    def call_getattribute(rte, cont, obj):
        ctx = Context(rte, cont, ast)
        return sem_getattribute(ctx, [obj, om_str(name)])

    def code1(rte, cont):
        expr_end_cont = do_expr_end(cont, ast)
        return code(rte,
                    lambda rte, val:
                       call_getattribute(rte, expr_end_cont, val))

    return (cte, code1)

# TODO: Replace class names with class objects once this is supported
def om_tuple_simple_repr(tuple_, rte):
    elements = OM_get_tuple_seq(tuple_)
    elements_len = len(elements)
    acc = []
    i = 0
    while i < elements_len:
        next_ctx = make_out_of_ast_context(rte, None)
        acc.append(om_simple_repr(next_ctx, elements[i]))
        i += 1

    if elements_len == 1:
        return '(' + ', '.join(acc) + ',)'
    else:
        return '(' + ', '.join(acc) + ')'

def om_list_simple_repr(tuple_, rte):
    elements = OM_get_tuple_seq(tuple_)
    elements_len = len(elements)
    acc = []
    i = 0
    while i < elements_len and elements[i] is not empty_cell:
        next_ctx = make_out_of_ast_context(rte, None)
        acc.append(om_simple_repr(next_ctx, elements[i]))
        i += 1

    return '[' + ', '.join(acc) + ']'

simple_repr_formatters = {
    "NoneType": om_format_NoneType_repr,
    "int": om_format_int_repr,
    "float": om_format_float_repr,
    "bool": om_format_bool_repr,
    "str": om_format_str_repr,
    "tuple": om_tuple_simple_repr,
    "list": om_list_simple_repr,
    "type": om_format_type_repr,
    "function": om_format_function_repr,
    "method-wrapper": om_format_MethodWrapper_repr,
    "wrapper_descriptor": om_format_WrapperDescriptor_repr,
    "module": om_format_module_repr,
    "object": om_format_object_repr,
    "NotImplementedType" : om_format_NotImplementedType
}

def om_simple_repr(ctx, value):
    value_cls = OM_get_object_class(value)
    cls_name = OM_get_boxed_value(OM_get(value_cls, "__name__"))
    formatter = dict_get(simple_repr_formatters, cls_name, om_format_object_repr)
    return formatter(value, ctx.rte)

def om_simple_exception_format(ctx, exn):
    exn_name = OM_get(OM_get_object_class(exn), '__name__')
    exn_name_value = OM_get_boxed_value(exn_name)
    exn_args = OM_get(exn, 'args')

    if exn_args is absent or not om_isinstance(exn_args, class_tuple):
        return exn_name_value + ': <unknown exception message>'
    else:
        seq = OM_get_tuple_seq(exn_args)
        if len(seq) == 0:
            return exn_name_value
        elif len(seq) == 1:
            el = seq[0]
            if om_isinstance(el, class_str):
                return exn_name_value + ": " + OM_get_boxed_value(el)
            else:
                return exn_name_value + ": " + om_simple_repr(ctx, seq[0])
        else:
            return exn_name_value + ": " + om_simple_repr(ctx, exn_args)


def expr_end_with_error(ctx, error):
    return return_to_trampoline(ctx.ast, '', False, error, lambda: None, ctx)

def expr_end(ctx, val):
    if om_is(val, om_None):
        return return_to_trampoline(ctx.ast, om_simple_repr(ctx, val), False, None, lambda: ctx.cont(ctx.rte, val), ctx)
    else:
        return return_to_trampoline(ctx.ast, om_simple_repr(ctx, val), True, None, lambda: ctx.cont(ctx.rte, val), ctx)

def stmt_end(ctx):
    return return_to_trampoline(ctx.ast, '', False, None, lambda: ctx.cont(ctx.rte), ctx)

def stmt_end_with_message(ctx, msg):
    return return_to_trampoline(ctx.ast, msg, False, None, lambda: ctx.cont(ctx.rte), ctx)


def return_to_trampoline(ast, msg, display_result, error, cont, ctx):
    # return to trampoline with current execution state
    res = make_dict()
    dict_set(res, "ast", ast)
    dict_set(res, "msg", msg)
    dict_set(res, "display_result", display_result)
    dict_set(res, "error", error)
    dict_set(res, "cont", cont)
    dict_set(res, "ctx", ctx)
    return res


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

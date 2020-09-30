from zipi._runtime import *

# NOTE: required to be able to instantiate ast nodes from pyinterp
from zipi.zast._zast import *

import zipi.zast._zast as AST
import zipi.zast as zast
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


# class RTE:
#     def __init__(self, global_env, locals_env, builtins, stack, ctrl_env):
#         self.globals_env = globals_env
#         self.locals_env = locals_env
#         self.builtins = builtins
#         self.stack = stack
#         self.ctrl_env = ctrl_env

class CTE:
    def __init__(self, callee, locals_env, closure_table, lex_env, ctrl_env, external_context, parent):
        self.callee = callee
        self.locals_env = locals_env
        self.closure_table = closure_table
        self.lex_env = lex_env
        self.ctrl_env = ctrl_env
        self.external_context = external_context
        self.parent = parent

def get_cte_locals_env(cte):
    return cte.locals_env

def get_cte_closure_table(cte):
    return cte.closure_table

def get_cte_locals_env_var(cte, name):
    le = get_cte_locals_env(cte)
    return dict_get(le, name, None)

def get_cte_safe_for_space(cte):
    return dict_get(cte.external_context, 'safe_for_space', True)

# NOTE: inspired from codeboot JS
def CTCtrl_controlContext(cte, ast):
    ctrl_env = cte.ctrl_env
    if ctrl_env is None or ctrl_env.ast is not ast:
        ids = make_dict()
        ctrl_env = CTCtrlLabel(ctrl_env, ids, ast)
        cte = CTE(cte.callee,
                  cte.locals_env,
                  cte.closure_table,
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

def CT_raise_with_msg(cte, ast, error_kind, msg):
    compilationError = dict_get(cte.external_context,
                            'compilationError',
                            default_compilation_error)
    return compilationError(ast.lineno-1,
                        ast.col_offset,
                        ast.end_lineno-1,
                        ast.end_col_offset,
                        error_kind,
                        msg)

def CT_raise_syntax_error_with_msg(cte, ast, msg):
    return CT_raise_with_msg(cte, ast, "SyntaxError", msg)

# continuation call helper
def cont_no_val(ctx):
    return ctx.cont(ctx.rte)

def cont_obj(ctx, val):
    return ctx.cont(ctx.rte, val)

def cont_bool(ctx, val):
    return ctx.cont(ctx.rte, om_bool(val))

def cont_int(ctx, val):
    return ctx.cont(ctx.rte, om_int(val))

def cont_float(ctx, val):
    return ctx.cont(ctx.rte, om_float(val))

def cont_str(ctx, val):
    return ctx.cont(ctx.rte, om_str(val))

def cont_list(ctx, val):
    return ctx.cont(ctx.rte, om_list(val, len(val)))

def cont_tuple(ctx, val):
    return ctx.cont(ctx.rte, om_tuple(val))

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

class OM_range(OM_object):
    """
    start: start of the range (om int)
    stop: stop of the range (om int)
    step: step of the range (om int)
    """

class OM_slice(OM_object):
    """
    start: start of the slice
    stop: stop of the slice
    step: step of the slice
    """

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
    closure: array of variable closure
    locals: names of local variables
    var_context: context of all accessible variables in scope
    parent_lexical_scope: in non safe_for_space mode, stores the parent scope
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

def make_rte(rte, globals_env, locals_env, current_func, builtins, stack, ctrl_env, vm, options):
    if rte is absent:
        serial_counter = [0]
    else:
        serial_counter = rte_serial_counter(rte)

    rte = make_dict()

    dict_set(rte, "serial_counter", serial_counter)
    dict_set(rte, "globals", globals_env)
    dict_set(rte, "locals", locals_env)
    dict_set(rte, 'current_func', current_func)
    dict_set(rte, "builtins", builtins)
    dict_set(rte, "stack", stack)
    dict_set(rte, "ctrl_env", ctrl_env)
    dict_set(rte, "vm", vm)
    dict_set(rte, "options", options)

    return rte

def make_rte_from_new_ctrl_env(rte, ctrl_env):
    return make_rte(rte,
                    rte_globals(rte),
                    rte_locals(rte),
                    rte_current_func(rte),
                    rte_builtins(rte),
                    rte_stack(rte),
                    ctrl_env,
                    rte_vm(rte),
                    rte_options(rte))

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

def rte_current_func(rte):
    return dict_get(rte, 'current_func', absent)

def rte_builtins(rte):
    return dict_get(rte, 'builtins', absent)

def rte_stack(rte):
    return dict_get(rte, 'stack', absent)

def rte_ctrl_env(rte):
    return dict_get(rte, 'ctrl_env', absent)

def rte_vm(rte):
    return dict_get(rte, 'vm', absent)

def rte_safe_for_space(rte):
    opt = rte_options(rte)
    if opt is None:
        return True
    else:
        return dict_get(opt, 'safe_for_space', True)

def rte_trace(rte):
    opt = rte_options(rte)
    if opt is None:
        return True
    else:
        return dict_get(opt, 'trace', True)

def rte_options(rte):
    return dict_get(rte, 'options', None)

# Return variable value or absent.
def rte_lookup_globals(rte, name):
    env = rte_globals(rte)
    result = dict_get(env, name, absent)
    return result

def rte_lookup_locals(rte, name):
    env = rte_locals(rte)
    result = dict_get(env, name, absent) # should always recover a value, it may be absent
    return result

def rte_lookup_locals_boxed(rte, name):
    env = rte_locals(rte)
    result = dict_get(env, name, absent)[0] # should always recover a value, it may be absent
    return result

def rte_lookup_closure(rte, pos):
    func = rte_current_func(rte)
    value = OM_get_function_closure(func)[pos][0]

    return value

def rte_set_locals(rte, varname, val):
    env = rte_locals(rte)
    dict_set(env, varname, val)

def rte_set_locals_boxed(rte, varname, val):
    env = rte_locals(rte)
    slot = dict_get(env, varname, None) # Return None to cause crash of the varname is not present
    slot[0] = val

def rte_set_globals(rte, varname, val):
    env = rte_globals(rte)
    dict_set(env, varname, val)

def rte_set_closure(rte, pos, val):
    func = rte_current_func(rte)
    slot = OM_get_function_closure(func)[pos]
    slot[0] = val


# stack operation
def unwindReturn(rte, val):
    frame = rte_stack(rte)
    ctx = Context(frame_rte(frame), frame_cont(frame), frame_ast(frame))
    return ctx.cont(ctx.rte, val)

# function signature
def make_signature(args, posonlyargs, varargs, kwonlyargs, kw_defaults, kwargs, defaults):
    return (args, posonlyargs, varargs, kwonlyargs, kw_defaults, kwargs, defaults)

empty_signature = make_signature((), (), None, (), (), None, ())

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

def align_args_with_signature(ctx, funcname, caller_args, signature):
    args = signature_args(signature)
    posonlyargs = signature_posonlyargs(signature)
    vararg = signature_varargs(signature)
    kwonlyargs = signature_kwonlyargs(signature)
    kw_default = signature_kw_defaults(signature)
    kwarg = signature_kwargs(signature)
    defaults = signature_defaults(signature)
    if kwarg is not None and len(kwonlyargs) > 0:
        return sem_raise_with_message(ctx, class_NotImplementedError, "keyword arguments not yet supported")
    else:
        caller_args_len = len(caller_args)
        args_len = len(args)
        posonlyargs_len = len(posonlyargs)
        defaults_len = len(defaults)
        total_args_len = args_len + posonlyargs_len
        if caller_args_len == total_args_len:
            locals_env = []
            caller_index = 0
            for arg in posonlyargs:
                locals_env.append((arg, caller_args[caller_index]))
                caller_index += 1

            for arg in args:
                locals_env.append((arg, caller_args[caller_index]))
                caller_index += 1

            if vararg is not None:
                locals_env.append((vararg, om_tuple([])))

            return ctx.cont(ctx.rte, locals_env)
        elif caller_args_len < total_args_len:
            missing_args_len = total_args_len - caller_args_len
            if defaults_len >= missing_args_len:

                result = caller_args[0:caller_args_len]
                start = defaults_len - missing_args_len

                while start < defaults_len:
                    result.append(defaults[start])
                    start += 1

                return align_args_with_signature(ctx, funcname, result, signature)
            else:
                def add_punctuation(msg, remaining_args_count):
                    result = msg
                    if missing_args_len == 2 and remaining_args_count == 1:
                        result += ' and '
                    elif missing_args_len > 2 and remaining_args_count == 1:
                        result += ', and '
                    elif remaining_args_count < missing_args_len:
                        result += ', '

                    return result

                s = 's' if missing_args_len != 1 else ''
                msg = funcname + "() missing " + str(missing_args_len) + " required positional argument"+ s +": "

                remaining = missing_args_len

                i = caller_args_len
                while i < posonlyargs_len:
                    arg = posonlyargs[i]
                    msg = add_punctuation(msg, remaining)+"'"+arg+"'"
                    remaining -= 1
                    i += 1

                i -= posonlyargs_len
                while i < args_len:
                    arg = args[i]
                    msg = add_punctuation(msg, remaining)+"'"+arg+"'"
                    remaining -= 1
                    i += 1

                return sem_raise_with_message(ctx, class_TypeError, msg)
        else:
            locals_env = []
            caller_index = 0
            for arg in posonlyargs:
                locals_env.append((arg, caller_args[caller_index]))
                caller_index += 1

            for arg in args:
                locals_env.append((arg, caller_args[caller_index]))
                caller_index += 1

            vararg_value = caller_args[caller_index:]
            vararg_len = len(vararg_value)
            if vararg is None:
                s = 's' if total_args_len != 1 else ''
                was_or_were = 'was' if caller_args_len == 1 else 'were'
                msg = funcname + "() takes " + str(total_args_len) + " positional argument" + s + " but " + str(caller_args_len) + " " + was_or_were + " given"
                return sem_raise_with_message(ctx, class_TypeError, msg)
            else:
                locals_env.append((vararg, om_tuple(vararg_value)))
                return cont_obj(ctx, locals_env)

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

def getattribute_from_class_mro_with_owner(cls, name):
    mro = OM_get_type_mro(cls)
    mro_len = len(mro)
    i = 0
    while i < mro_len:
        cls = mro[i]
        attr = OM_get(cls, name)
        if attr is not absent:
            return attr, cls
        i += 1
    return absent, absent

def getattribute_from_obj_mro(o, name):
    cls = OM_get_object_class(o)
    if name == '__class__':
        return cls
    else:
        return getattribute_from_class_mro(cls, name)

def getattribute_from_obj_mro_with_owner(o, name):
    cls = OM_get_object_class(o)
    if name == '__class__':
        return cls, o
    else:
        return getattribute_from_class_mro_with_owner(cls, name)

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
         ('__repr__', om_object_repr),
         ('__eq__', om_object_eq),
         ('__ne__', om_object_ne)))

    buitlin_add_methods_to_class(
        class_WrapperDescriptor,
        (('__get__', om_WrapperDescriptor_get),
         ('__call__', om_WrapperDescriptor_call),
         ('__repr__', om_WrapperDescriptor_repr)))

    buitlin_add_methods_to_class(
        class_str,
        (('__new__', om_str_new),
         ('__repr__', om_str_repr),
         ('__str__', om_str_str),
         ('__getitem__', om_str_getitem),
         ('__eq__', om_str_eq),
         ('__ne__', om_str_ne),
         ('__gt__', om_str_gt),
         ('__ge__', om_str_ge),
         ('__lt__', om_str_lt),
         ('__le__', om_str_le),
         ('__add__', om_str_add),
         ('__mul__', om_str_mul),
         ('__rmul__', om_str_rmul),
         ('__len__', om_str_len)))

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
    builtin_add_method(class_int, '__new__', om_int_new)
    builtin_add_method(class_int, '__int__', om_int_int)
    builtin_add_method(class_int, '__index__', om_int_index)
    builtin_add_method(class_int, '__float__', om_int_float)
    builtin_add_method(class_int, '__bool__', om_int_bool) # <class 'function'>
    # Arithmetic
    builtin_add_method(class_int, '__add__', om_int_add)
    builtin_add_method(class_int, '__radd__', om_int_radd)
    builtin_add_method(class_int, '__sub__', om_int_sub)
    builtin_add_method(class_int, '__rsub__', om_int_rsub)
    builtin_add_method(class_int, '__mul__', om_int_mul)
    builtin_add_method(class_int, '__rmul__', om_int_rmul)
    builtin_add_method(class_int, '__pow__', om_int_pow)
    builtin_add_method(class_int, '__rpow__', om_int_rpow)
    builtin_add_method(class_int, '__floordiv__', om_int_floordiv)
    builtin_add_method(class_int, '__rfloordiv__', om_int_rfloordiv)
    builtin_add_method(class_int, '__truediv__', om_int_truediv)
    builtin_add_method(class_int, '__rtruediv__', om_int_rtruediv)
    builtin_add_method(class_int, '__mod__', om_int_mod)
    builtin_add_method(class_int, '__rmod__', om_int_rmod)
    builtin_add_method(class_int, '__abs__', om_int_abs)
    builtin_add_method(class_int, '__pow__', om_int_pow)
    builtin_add_method(class_int, '__rpow__', om_int_rpow)


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
    builtin_add_method(class_int, '__round__', om_int_round)


def populate_builtin_float():
    builtin_add_method(class_float, '__new__', om_float_new)
    builtin_add_method(class_float, '__bool__', om_float_bool)
    builtin_add_method(class_float, '__float__', om_float_float)
    builtin_add_method(class_float, '__int__', om_float_int)
    builtin_add_method(class_float, '__add__', om_float_add)
    builtin_add_method(class_float, '__radd__', om_float_radd)
    builtin_add_method(class_float, '__sub__', om_float_sub)
    builtin_add_method(class_float, '__rsub__', om_float_rsub)
    builtin_add_method(class_float, '__mul__', om_float_mul)
    builtin_add_method(class_float, '__rmul__', om_float_rmul)
    builtin_add_method(class_float, '__truediv__', om_float_truediv)
    builtin_add_method(class_float, '__rtruediv__', om_float_rtruediv)
    builtin_add_method(class_float, '__floordiv__', om_float_floordiv)
    builtin_add_method(class_float, '__rfloordiv__', om_float_rfloordiv)
    builtin_add_method(class_float, '__pow__', om_float_pow)
    builtin_add_method(class_float, '__rpow__', om_float_rpow)
    builtin_add_method(class_float, '__mod__', om_float_mod)
    builtin_add_method(class_float, '__rmod__', om_float_rmod)
    builtin_add_method(class_float, '__repr__', om_float_repr)
    builtin_add_method(class_float, '__pos__', om_float_pos)
    builtin_add_method(class_float, '__neg__', om_float_neg)
    builtin_add_method(class_float, '__abs__', om_float_abs)
    builtin_add_method(class_float, '__eq__', om_float_eq)
    builtin_add_method(class_float, '__ne__', om_float_ne)
    builtin_add_method(class_float, '__lt__', om_float_lt)
    builtin_add_method(class_float, '__le__', om_float_le)
    builtin_add_method(class_float, '__gt__', om_float_gt)
    builtin_add_method(class_float, '__ge__', om_float_ge)
    builtin_add_method(class_float, '__round__', om_float_round)


def populate_builtin_bool():
    builtin_add_method(class_bool, '__new__', om_bool_new)
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

def populate_builtin_range():
    buitlin_add_methods_to_class(
        class_range,
        (('__new__', om_range_new),
         ('__repr__', om_range_repr),
         ('__len__', om_range_len),
         ('__getitem__', om_range_getitem)))

def populate_builtin_slice():
    pass

def populate_builtin_iterator():
    builtin_add_method(class_iterator, '__iter__', om_iterator_iter)
    builtin_add_method(class_iterator, '__next__', om_iterator_next)

def populate_builtin_dict():
    pass

def populate_builtin_module():
    builtin_add_method(class_module, '__getattribute__', om_module_getattribute)
    builtin_add_method(class_module, '__repr__', om_module_repr)

def populate_builtin_NoneType():
    builtin_add_method(class_NoneType, '__new__', om_NoneType_new)
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

def om_slice(start, stop, step):
    obj = om(class_slice)
    OM_set_slice_start(obj, start)
    OM_set_slice_stop(obj, stop)
    OM_set_slice_step(obj, step)
    return obj

def om_range(start, stop, step):
    obj = om(class_range)
    OM_set_range_start(obj, start)
    OM_set_range_stop(obj, stop)
    OM_set_range_step(obj, step)
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

def om_int_from_num(val):
    return om_boxval(class_int, int_from_num(val))

def om_int_subtype(cls, val):
    return om_boxval(cls, val)

def om_float(val):
    return om_boxval(class_float, val)

def om_float_subtype(cls, val):
    return om_boxval(cls, val)

def om_exception(exn, args):
    obj = om(exn)
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

def om_is_not(x, y):
    return x is not y

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

def OM_range_create():
    return OM_range()

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

def OM_get_slice_start(o):
    return o.start

def OM_set_slice_start(o, start):
    o.start = start

def OM_get_slice_stop(o):
    return o.stop

def OM_set_slice_stop(o, stop):
    o.stop = stop

def OM_get_slice_step(o):
    return o.step

def OM_set_slice_step(o, step):
    o.step = step

def OM_get_range_start(o):
    return o.start

def OM_set_range_start(o, v):
    o.start = v

def OM_get_range_stop(o):
    return o.stop

def OM_set_range_stop(o, v):
    o.stop = v

def OM_get_range_step(o):
    return o.step

def OM_set_range_step(o, v):
    o.step = v

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

def OM_get_function_locals(o):
    return o.locals

def OM_set_function_locals(o, locals):
    o.locals = locals

def OM_get_function_closure(o):
    return o.closure

def OM_set_function_closure(o, closure):
    o.closure = closure

def OM_get_function_var_context(o):
    return o.var_context

def OM_set_function_var_context(o, var_context):
    o.var_context = var_context

def OM_get_function_lexical_scope(o):
    return o.lexical_scope

def OM_set_function_lexical_scope(o, lexical_scope):
    o.lexical_scope = lexical_scope

# hidden fields in WrapperDescriptor
def OM_set_WrapperDescriptor_cls(o, cls):
    o.cls = cls

def OM_get_WrapperDescriptor_cls(o):
    return o.cls

def OM_set_MethodWrapper_instance(o, instance):
    o.instance = instance

def OM_get_MethodWrapper_instance(o):
    return o.instance

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
                return error(rte)
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
                return error(rte)

        def error(rte):
            val1_type = OM_get_object_class(val1)
            val2_type = OM_get_object_class(val2)

            type1_name = OM_get(val1_type, "__name__")
            type2_name = OM_get(val2_type, "__name__")

            msg = "unsupported operand type(s) for " + op_symbol + ": " + om_format_str_repr(type1_name, rte) + " and "\
                  + om_format_str_repr(type2_name, rte)

            return sem_raise_with_message(ctx, class_TypeError, msg)

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
sem_Pow = gen_sem_Numeric_BinOp('**', '__pow__', '__rpow__')
# Bitwise
sem_LShift = gen_sem_Numeric_BinOp('<<', '__lshift__', '__rlshift__')
sem_RShift = gen_sem_Numeric_BinOp('>>', '__rshift__', '__rrshift__')
sem_Or = gen_sem_Numeric_BinOp('|', '__or__', '__ror__')
sem_And = gen_sem_Numeric_BinOp('&', '__and__', '__rand__')
sem_Xor = gen_sem_Numeric_BinOp('^', '__xor__', '__rxor__')
# Comparison
sem_Lt = gen_sem_Numeric_BinOp('<', '__lt__', '__gt__')
sem_Gt = gen_sem_Numeric_BinOp('>', '__gt__', '__lt__')
sem_LtE = gen_sem_Numeric_BinOp('<=', '__le__', '__ge__')
sem_GtE = gen_sem_Numeric_BinOp('>=', '__ge__', '__le__')

# sem_Eq and sem_NotEq are different in the sense they cannot raise a TypeError

def gen_sem_Numeric_EqComp(op_symbol, method, fall_back):

    def sem_Numeric_EqComp(ctx, val1, val2):
        def test_val1_result(rte, val):
            if om_is(val, om_NotImplemented):
                return call_val2_op(rte)
            else:
                return ctx.cont(rte, val)

        def test_val2_result(rte, val):
            if om_is(val, om_NotImplemented):
                return cont_bool(ctx, fall_back(val1, val2))
            else:
                return ctx.cont(rte, val)

        def call_val2_op(rte):
            val2_ne = getattribute_from_obj_mro(val2, method)

            if val2_ne is absent:
                return cont_bool(ctx, fall_back(val1, val2))
            else:
                return om_call(val2_ne, with_cont(ctx, test_val2_result), [val2, val1])

        val1_ne = getattribute_from_obj_mro(val1, method)

        if val1_ne is absent:
            return call_val2_op(ctx.rte)
        else:
            return om_call(val1_ne, with_cont(ctx, test_val1_result), [val1, val2])

    return sem_Numeric_EqComp

sem_Eq = gen_sem_Numeric_EqComp("==", "__eq__", om_is)
sem_NotEq = gen_sem_Numeric_EqComp("!=", "__ne__", om_is_not)

def sem_Round(ctx, obj, ndigits):
    obj_round = getattribute_from_obj_mro(obj, "__round__")

    if obj_round is absent:
        return sem_raise_with_message(ctx, class_TypeError, "type doesn't define __round__ method")
    elif ndigits is absent:
        return om_call(obj_round, ctx, (obj,))
    else:
        return om_call(obj_round, ctx, (obj, ndigits))

def sem_PowMod(ctx, base, power, mod):

    def test_method_result(rte, val):
        if om_is(val, om_NotImplemented):
            return call_rmethod(rte)
        else:
            return ctx.cont(rte, val)

    def test_rmethod_result(rte, val):
        if om_is(val, om_NotImplemented):
            return sem_raise_with_message(ctx, class_TypeError, "unsupported operand type(s) for pow()")

        else:
            return ctx.cont(rte, val)

    def call_rmethod(rte):
        power_rmethod = getattribute_from_obj_mro(power, "__rpow__")

        if power_rmethod is not absent:
            ctx2 = with_cont(ctx, test_rmethod_result)
            return om_call(power_rmethod, ctx2, (power, base, mod))
        else:
            return sem_raise_with_message(ctx, class_TypeError, "unsupported operand type(s) for pow()")

    base_method = getattribute_from_obj_mro(base, "__pow__")

    if base_method is not absent:
        ctx1 = with_cont(ctx, test_method_result)
        return om_call(base_method, ctx1, (base, power, mod))
    else:
        return call_rmethod(ctx.rte)
    
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
class_range = make_builtin_class('range', OM_range_create, (), class_type)
class_dict = make_builtin_class('dict', OM_dict_create, (), class_type)
class_module = make_builtin_class('module', OM_module_create, (), class_type)
class_function = make_builtin_class('function', OM_function_create, (), class_type)
class_slice = make_builtin_class('slice', OM_slice_create, (), class_type)

# Exception classes
class_BaseException = make_builtin_class('BaseException', OM_BaseException_create, (), class_type)
class_Exception = make_builtin_class('Exception', OM_BaseException_create, (class_BaseException,), class_type)
class_NameError = make_builtin_class('NameError', OM_BaseException_create, (class_Exception,), class_type)
class_UnboundLocalError = make_builtin_class('UnboundLocalError:', OM_BaseException_create, (class_Exception,), class_type)
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
class_OverflowError = make_builtin_class('OverflowError', OM_BaseException_create, (class_ArithmeticError,), class_type)
class_ZeroDivisionError = make_builtin_class('ZeroDivisionError', OM_BaseException_create, (class_ArithmeticError,), class_type)
class_AssertionError = make_builtin_class('AssertionError', OM_BaseException_create, (class_Exception,), class_type)

om_None = om(class_NoneType)
om_True = om_boxval(class_bool, int_from_num(1))
om_False = om_boxval(class_bool, int_from_num(0))
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

# Primitive operators for doing actual computations
def gen_dunder_Homogenous_Numeric_BinOp(py_class, method, prim, om_class, om_box):
    debug_msg = py_class + "." + method
    def dunder_Numeric_BinOp(ctx, args):
        if debug: print(debug_msg)
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
def gen_dunder_Homogenous_Numeric_rBinOp(py_class, method, prim, om_class, om_box):
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
            return sem_raise_with_message(ctx, class_AttributeError, "type has no attribute '" + name_value + "'")

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
        return sem_raise_with_message(ctx, class_TypeError, "object.__new__(X) is not safe, use X.__new__()")

    cls = args[0]
    return ctx.cont(ctx.rte, om(cls))

def om_object_init_code(ctx, args):
    return ctx.cont(ctx.rte, om_None)

om_object_init = do_magic_method(class_object, "__init__", om_object_init_code)

def om_object_getattribute_code(ctx, args):
    if debug: print('object.__getattribute__')

    if len(args) == 2:
        self = args[0]
        name = args[1]

        if not om_isinstance(name, class_str):
            return sem_raise_with_message(ctx, class_TypeError, "attribute name must be string")

        name_value = OM_get_boxed_value(name)

        # Get field name
        attr, owner = getattribute_from_obj_mro_with_owner(self, name_value)
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
            return om_call(attr__get__, ctx, [attr, self, owner])
    else:
        return sem_raise_with_message(ctx, class_TypeError, "expected 1 arguments, got " + str(len(args) - 1))

om_object_getattribute = do_magic_method(class_object, "__getattribute__", om_object_getattribute_code)

def om_object_str_code(ctx, args):
    if len(args) == 1:
        return sem_repr(ctx, args[0])
    else:
        return sem_raise_with_message(ctx, class_TypeError, "expected 0 arguments, got " + str(len(args) - 1))

om_object_str = do_magic_method(class_object, "__repr__", om_object_str_code)

def om_format_object_repr(self, rte):
    serial = OM_get_serial(self, rte)

    cls = OM_get_object_class(self)
    clsname = OM_get(cls, '__name__')
    clsname_value = OM_get_boxed_value(clsname)

    return "<" + clsname_value + " object #" + str(serial) +">"

def om_object_repr_code(ctx, args):
    if len(args) == 1:
        return cont_str(ctx, om_format_object_repr(args[0], ctx.rte))
    else:
        return sem_raise_with_message(ctx, class_TypeError, "expected 0 arguments, got " + str(len(args) - 1))

om_object_repr = do_magic_method(class_object, "__repr__", om_object_repr_code)

def om_object_eq_code(ctx, args):
    if len(args) == 2:
        return cont_obj(ctx, om_NotImplemented)
    else:
        return sem_raise_with_message(ctx, class_TypeError, "expected 1 arguments, got " + str(len(args) - 1))

om_object_eq = do_magic_method(class_object, "__eq__", om_object_eq_code)

def om_object_ne_code(ctx, args):
    # As per: https://github.com/python/cpython/blob/fabd7bb8e0450f16ed5c5c0ad575aa413d65712d/Objects/typeobject.c#L3989
    if len(args) == 2:
        self = args[0]
        other = args[1]
        self_eq = getattribute_from_obj_mro(self, "__eq__")

        def check_result(check_result_rte, res):
            if om_is(res, om_NotImplemented):
                return cont_obj(ctx, om_NotImplemented)
            else:
                def invert_result(invert_rte, bool_res):
                    if om_is(bool_res, om_True):
                        return cont_obj(ctx, om_False)
                    else:
                        return cont_obj(ctx, om_True)
                return sem_bool(with_cont(ctx, invert_result), res)
        return om_call(self_eq, with_cont(ctx, check_result), (self, other))
    else:
        return sem_raise_with_message(ctx, class_TypeError, "expected 1 arguments, got " + str(len(args) - 1))

om_object_ne = do_magic_method(class_object, "__ne__", om_object_ne_code)

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

# class_bool methods
def om_bool_new_code(ctx, args):
    if len(args) == 1:
        return cont_bool(ctx, False)
    elif len(args) == 2:
        return sem_bool(ctx, args[1])
    else:
        return sem_raise_with_message(ctx, class_TypeError, "expected at most 1 arguments, got " + str(len(args) - 1))

om_bool_new = do_static_magic_method(class_bool, "__new__", om_bool_new_code)

def om_format_bool_repr(self, rte):
    if om_is(self, om_True):
        return "True"
    else:
        return "False"

def om_bool_repr_code(ctx, args):
    if debug: print('bool.__repr__')

    if len(args) == 1:
        self = args[0]
        return cont_str(ctx, om_format_bool_repr(self, ctx.rte))
    else:
        return sem_raise_with_message(ctx, class_TypeError, "expected 0 arguments, got " + str(len(args) - 1))

om_bool_repr = do_magic_method(class_bool, "__repr__", om_bool_repr_code)

def om_bool_bool_code(ctx, args):
    if debug: print('bool.__bool__')

    if len(args) == 1:
        self = args[0]
        return cont_obj(ctx, self)
    else:
        return sem_raise_with_message(ctx, class_TypeError, "expected 0 arguments, got " + str(len(args) - 1))

om_bool_bool = do_magic_method(class_bool, "__bool__", om_bool_bool_code)


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

# compute pow_mod with unboxed value.
def compute_pow_mod(ctx, num, power, mod):
    if int_is_zero(mod):
        return sem_raise_with_message(ctx, class_ValueError, "pow() 3rd argument cannot be 0")
    elif int_is_nonneg(power):
        result = int_pow_mod(num, power, mod)
        return cont_int(ctx, result)
    else:
        num_mod = int_mod_floor(num, mod)
        fl_num_mod = int_to_num(num_mod)
        fl_power = int_to_num(power)

        # NOTE: NaN should not happen
        # raise an Overflow error when it cannot be exactly represent as a floating point
        if float_is_infinite(fl_num_mod) or float_is_nan(fl_num_mod) or float_is_nan(fl_power):
            return sem_raise_with_message(ctx, class_OverflowError, "int too large to convert to float")
        elif float_is_neg(fl_power):
            # modular inverse computation
            return sem_raise_with_message(ctx, class_NotImplementedError, "modular inverse unimplemented")
        elif float_is_infinite(fl_power):
            # the result tends to 0 when power tends to -Infinity
            return cont_float(ctx, float_from_num(0.0))
        else:
            # the result is less than the mod value because fl_power < 0
            result = float_pow(fl_num_mod, fl_power)
            return cont_float(ctx, result)

# compute pow with unboxed value
def compute_pow(ctx, num, power):
    if int_is_nonneg(power):
        result = int_pow(num, power)
        return cont_int(ctx, result)
    else:
        fl_num = int_to_num(num)
        fl_power = int_to_num(power)

        # NOTE: NaN should not happen
        # raise an Overflow error when it cannot be exactly represent as a floating point
        if float_is_infinite(fl_num) or float_is_nan(fl_num) or float_is_nan(fl_power):
            return sem_raise_with_message(ctx, class_OverflowError, "int too large to convert to float")
        elif not float_is_finite(fl_power):
            # the result tends to 0 when power tends to -Infinity
            return cont_float(ctx, float_from_num(0.0))
        else:
            result = float_pow(fl_num, fl_power)
            return cont_float(ctx, result)

def om_int_pow_code(ctx, args):
    args_len = len(args)
    if args_len < 2:
        return sem_raise_with_message(ctx, class_TypeError, "expected at least 1 argument, got " + str(args_len - 1))
    elif args_len > 3:
        return sem_raise_with_message(ctx, class_TypeError, "expected at most 3 arguments, got " + str(args_len - 1))
    else:
        self = args[0]
        power = args[1]

        if om_isinstance(power, class_int):
            self_value = OM_get_boxed_value(self)
            power_value = OM_get_boxed_value(power)

            if args_len == 2:
                return compute_pow(ctx, self_value, power_value)
            else:
                mod = args[2]
                if om_isinstance(mod, class_int):
                    mod_value = OM_get_boxed_value(mod)
                    return compute_pow_mod(ctx, self_value, power_value, mod_value)
                elif om_isinstance(mod, class_float):
                    return sem_raise_with_message(ctx, class_TypeError, "3rd argument not allowed unless all arguments are integers")
        return cont_obj(ctx, om_NotImplemented)

om_int_pow = do_magic_method(class_int, "__pow__", om_int_pow_code)

# XXX: code repetition...
def om_int_rpow_code(ctx, args):
    args_len = len(args)
    if args_len < 2:
        return sem_raise_with_message(ctx, class_TypeError, "expected at least 1 argument, got " + str(args_len - 1))
    elif args_len > 3:
        return sem_raise_with_message(ctx, class_TypeError, "expected at most 3 arguments, got " + str(args_len - 1))
    else:
        self = args[0]
        num = args[1]

        if om_isinstance(num, class_int):
            self_value = OM_get_boxed_value(self)
            num_value = OM_get_boxed_value(num)

            if args_len == 2:
                return compute_pow(ctx, num_value, self_value)
            else:
                mod = args[2]
                if om_isinstance(mod, class_int):
                    mod_value = OM_get_boxed_value(mod)
                    return compute_pow_mod(ctx, num_value, self_value, mod_value)
                elif om_isinstance(mod, class_float):
                    return sem_raise_with_message(ctx, class_TypeError, "3rd argument not allowed unless all arguments are integers")
        return cont_obj(ctx, om_NotImplemented)

om_int_rpow = do_magic_method(class_int, "__rpow__", om_int_rpow_code)

# int round if tie_up is False, then tie break is done to even
# if tie_up is True, then tie break is done to upper number
def int_round(x, ndigits, tie_even):
    pow_limit = int_mul(int_from_num(10), int_abs(x))

    # Version of pow which abort if the power is unnecessrily big
    def round_pow(y, n):
        if int_gt(x, pow_limit) and not int_is_zero(n):
            return False
        elif int_is_zero(n):
            return int_from_num(1)
        else:
            sq = int_mul(y, y)
            temp = round_pow(sq, int_rshift(n, int_from_num(1)))
            if temp is False:
                return False
            elif int_is_even(n):
                return temp
            else:
                return int_mul(y, temp)

    if int_is_nonneg(ndigits):
        return x
    else:
        low_digits_range = round_pow(int_from_num(10), int_neg(ndigits))

        # abs(ndigits) may be so big that we don't need to know the result of its power
        if low_digits_range is False:
            return int_from_num(0)
        else:
            low_digits = int_mod_floor(x, low_digits_range)
            tmp_cmp = int_mul(low_digits, int_from_num(2))
            x_rounded_down = int_sub(x, low_digits)

            if int_gt(tmp_cmp, low_digits_range): # Round up
                return int_add(x_rounded_down, low_digits_range)
            elif int_eq(tmp_cmp, low_digits_range): # Round toward even if tie_up is False
                if tie_even and int_is_even(int_div_floor(x_rounded_down, low_digits_range)):
                    return x_rounded_down
                else:
                    return int_add(x_rounded_down, low_digits_range)
            else: # Round down
                return x_rounded_down

def om_int_round_code(ctx, args):
    if len(args) == 1:
        self = args[0]
        return cont_obj(ctx, self)
    elif len(args) == 2:
        self = args[0]
        ndigits = args[1]

        def apply_round(rte, n):
            self_value = OM_get_boxed_value(self)
            n_value = OM_get_boxed_value(n)
            if int_is_nonneg(n_value):
                return cont_obj(ctx, self)
            else:
                return cont_int(ctx, int_round(self_value, n_value, True))

        return sem_index(with_cont(ctx, apply_round), ndigits)
    else:
        return sem_raise_with_message(ctx, class_TypeError, "expected 1 arguments, got " + str(len(args) - 1))

om_int_round = do_magic_method(class_int, "__round__", om_int_round_code)

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

    return cont_int(ctx,int_from_num(elements_len))

def om_tuple_getitem(ctx, args):
    if debug: print('tuple.__getitem__')

    self = args[0]
    item = args[1]

    # TODO: cover subtypes of int
    if om_is(OM_get_object_class(item), class_int):
        item_box_index = OM_get_boxed_value(item)
        elements = OM_get_tuple_seq(self)
        elements_len = int_from_num(len(elements))
        if int_ge(item_box_index, elements_len):
            return sem_raise_with_message(ctx, class_IndexError, "tuple index out of range")
        elif int_is_nonneg(item_box_index):
            return cont_obj(ctx, elements[int_to_num(item_box_index)])
        else:
            reversed_index = int_add(item_box_index, elements_len)
            if int_is_nonneg(reversed_index):
                return cont_obj(ctx, elements[int_to_num(reversed_index)])
            else:
                return sem_raise_with_message(ctx, class_IndexError, "tuple index out of range")
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
            self_len = int_from_num(OM_get_list_len(self))
            elements = OM_get_list_seq(self)
            if int_ge(index, self_len):
                return sem_raise_with_message(ctx, class_IndexError, "list index out of range")
            elif int_is_nonneg(index):
                return ctx.cont(ctx.rte, elements[index])
            else:
                reversed_index = int_add(index, self_len)
                if int_is_nonneg(reversed_index):
                    return ctx.cont(ctx.rte, elements[int_to_num(reversed_index)])
                else:
                    return sem_raise_with_message(ctx, class_IndexError, "list index out of range")
        elif om_isinstance(item, class_slice):
            return sem_raise_with_message(ctx, class_NotImplementedError, "list slicing is not yet supported")
    else:
        return sem_raise_with_message(ctx, class_TypeError, "__getitem__() takes exactly one argument (" + str(args_len - 1) + " given)")

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
        return sem_raise_with_message(ctx, class_TypeError, "__setitem__() takes exactly two argument (" + str(args_len - 1) + " given)")

om_list_setitem = do_magic_method(class_list, "__setitem__", om_list_setitem_code)

def om_list_len_code(ctx, args):
    args_len = len(args)
    if args_len == 1:
        self = args[0]
        elements_len = OM_get_list_len(self)
        return cont_int(ctx, int_from_num(elements_len))
    else:
        return sem_raise_with_message(ctx, class_TypeError,
                                      "__len__() takes no argument (" + str(args_len) + " given)")


om_list_len = do_magic_method(class_list, "__len__", om_list_len_code)

def om_list_append_code(ctx, args):
    if debug: print('list.append')

    args_len = len(args)

    if args_len == 2:
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
    else:
        return sem_raise_with_message(ctx, class_TypeError,
                                      "append() takes exactly one argument (" + str(args_len - 1) + " given)")

om_list_append = do_magic_method(class_list, "append", om_list_append_code)

# class_range methods

def om_range_new_code(ctx, args):
    args_len = len(args)

    if args_len == 2:
        stop = args[1]
        if om_isinstance(stop, class_int):
            return cont_obj(ctx, om_range(om_int_from_num(0), stop, om_int_from_num(1)))
        else:
            def alloc_range(alloc_rte, stop_int):
                return cont_obj(ctx, om_range(om_int_from_num(0), stop_int, om_int_from_num(1)))
            return sem_index(with_cont(ctx, alloc_range), stop)
    if args_len == 3:
        start = args[1]
        stop = args[2]

        def get_start(start_rte, start_int):
            def alloc_range(alloc_rte, stop_int):
                return cont_obj(ctx, om_range(start_int, stop_int, om_int_from_num(1)))

            if om_isinstance(stop, class_int):
                return alloc_range(start_rte, stop)
            else:
                return sem_index(with_cont(ctx, alloc_range), stop)

        if om_isinstance(start, class_int):
            return get_start(ctx.rte, start)
        else:
            return sem_index(with_cont(ctx, get_start), start)
    elif args_len == 4:
        start = args[1]
        stop = args[2]
        step = args[3]

        def get_start(start_rte, start_int):
            def get_stop(stop_rte, stop_int):
                def check_step(alloc_rte, step_int):
                    step_value = OM_get_boxed_value(step_int)

                    if int_is_zero(step_value):
                        return sem_raise_with_message(ctx, class_ValueError, "range() arg 3 must not be zero")
                    else:
                        return cont_obj(ctx, om_range(start_int, stop_int, step_int))

                if om_isinstance(step, class_int):
                    return check_step(stop_rte, step)
                else:
                    return sem_index(with_cont(ctx, check_step), step)

            if om_isinstance(stop, class_int):
                return get_stop(start_rte, stop)
            else:
                return sem_index(with_cont(ctx, get_stop), stop)

        if om_isinstance(start, class_int):
            return get_start(ctx.rte, start)
        else:
            return sem_index(with_cont(ctx, get_start), start)
    else:
        return sem_raise_with_message(ctx, class_TypeError, "range expected 1 to 3 arguments, got " + str(len(args) - 1))

om_range_new = do_static_magic_method(class_range, "__new__", om_range_new_code)

def om_range_repr_code(ctx, args):
    args_len = len(args)

    if args_len == 1:
        self = args[0]
        start = OM_get_range_start(self)
        stop = OM_get_range_stop(self)
        step = OM_get_range_step(self)

        def get_start_str(start_rte, start_str):
            start_str_value = OM_get_boxed_value(start_str)
            def get_stop_str(stop_rte, stop_str):
                stop_str_value = OM_get_boxed_value(stop_str)

                step_value = OM_get_boxed_value(step)
                if int_eq(step_value, int_from_num(1)):
                    return cont_str(ctx, "range(" + start_str_value + ", " + stop_str_value + ")")
                else:
                    def get_step_str(step_rte, step_str):
                        step_str_value = OM_get_boxed_value(step_str)
                        return cont_str(ctx, "range(" + start_str_value + ", " + stop_str_value + ", " + step_str_value + ")")
                    return sem_repr(with_cont(ctx, get_step_str), step)
            return sem_repr(with_cont(ctx, get_stop_str), stop)
        return sem_repr(with_cont(ctx, get_start_str), start)

    else:
        return sem_raise_with_message(ctx, class_TypeError, "expected 0 arguments, got " + str(args_len - 1))

om_range_repr = do_magic_method(class_range, "__repr__", om_range_repr_code)

def compute_range_len(start, stop, step):
    _1 = int_from_num(1)

    if int_is_nonneg(step) and int_lt(start, stop):
        res = int_add(_1, int_div_floor(int_sub(stop, int_add(start, _1)), step))
        return res
    elif int_is_neg(step) and int_gt(start, stop):
        res = int_add(_1, int_div_floor(int_sub(start, int_add(stop, _1)), int_neg(step)))
        return res
    else:
        return int_from_num(0)

def om_range_len_code(ctx, args):
    args_len = len(args)

    if args_len == 1:
        self = args[0]
        start = OM_get_range_start(self)
        stop = OM_get_range_stop(self)
        step = OM_get_range_step(self)

        start_value = OM_get_boxed_value(start)
        stop_value = OM_get_boxed_value(stop)
        step_value = OM_get_boxed_value(step)

        return cont_int(ctx, compute_range_len(start_value, stop_value, step_value))
    else:
        return sem_raise_with_message(ctx, class_TypeError, "expected 0 arguments, got " + str(args_len - 1))

om_range_len = do_magic_method(class_range, "__len__", om_range_len_code)


def compute_range_item(start, stop, step, index):
    length = compute_range_len(start, stop, step)

    if int_ge(index, length):
        return None
    elif int_is_nonneg(index):
        return int_add(start, int_mul(index, step))
    elif int_ge(index, int_neg(length)):
        return int_add(start, int_mul(int_add(length, index), step))
    else:
        return None

def om_range_getitem_code(ctx, args):
    args_len = len(args)

    if args_len == 2:
        item = args[1]

        def get_item(rte, index):
            self = args[0]
            start = OM_get_range_start(self)
            stop = OM_get_range_stop(self)
            step = OM_get_range_step(self)

            start_value = OM_get_boxed_value(start)
            stop_value = OM_get_boxed_value(stop)
            step_value = OM_get_boxed_value(step)
            index_value = OM_get_boxed_value(index)

            res = compute_range_item(start_value, stop_value, step_value, index_value)

            if res is None:
                return sem_raise_with_message(ctx, class_IndexError, "range object index out of range")
            else:
                return cont_int(ctx, res)

        return sem_index(with_cont(ctx, get_item), item)
    else:
        return sem_raise_with_message(ctx, class_TypeError, "expected 1 arguments, got " + str(args_len - 1))

om_range_getitem = do_magic_method(class_range, "__getitem__", om_range_getitem_code)

# class_iterator methods

def om_iterator_iter_code(ctx, args):
    if debug: print('iterator.__iter__')

    if len(args) == 1:
        return cont_obj(ctx, args[0])
    else:
        return sem_raise_with_message(ctx, class_TypeError, "expected 0 arguments, got " + str(len(args) - 1))


om_iterator_iter = do_magic_method(class_iterator, "__iter__", om_iterator_iter_code)

def om_iterator_next_code(ctx, args):
    if debug: print('iterator.__next__')

    if len(args) == 1:

        self = args[0]

        obj = OM_get_iterator_obj(self)
        index = OM_get_iterator_index(self)

        def increment_index(rte, val):
            OM_set_iterator_index(self, om_int(int_add(OM_get_boxed_value(index), int_from_num(1))))
            return ctx.cont(rte, val)

        def catch_IndexError(rte, exn):
            if om_isinstance(exn, class_IndexError):
                return sem_raise(ctx, class_StopIteration)
            else:
                return sem_raise(ctx, exn)

        next_ctx = with_cont_and_catch(ctx, increment_index, catch_IndexError)

        return sem_getitem(next_ctx, obj, index)
    else:
        return sem_raise_with_message(ctx, class_TypeError, "expected 0 arguments, got " + str(len(args) - 1))

om_iterator_next = do_magic_method(class_iterator, "__next__", om_iterator_next_code)

# class_str methods
def om_str_new_code(ctx, args):
    cls = args[0]

    if len(args) == 1:
        return ctx.cont(ctx, om_boxval(cls, ""))
    elif len(args) == 2:
        value = args[1]
        return sem_str(ctx, value)
    else:
        return sem_raise_with_message(ctx, class_TypeError, "str() takes 0 or 1 argument")

om_str_new = do_static_magic_method(class_str, "__new__", om_str_new_code)

def om_format_str_repr(self, rte):
    def char_code_to_hex(code):
        if code < 16:
            return "\\x0" + int_to_string(int_from_num(char_code), 16)
        else:
            return "\\x" + int_to_string(int_from_num(char_code), 16)

    value = OM_get_boxed_value(self)
    value_len = len(value)
    contains_single_quote = False
    contains_double_quote = False

    char_lst = []
    i = 0
    while i < value_len:
        char = value[i]

        if char == '"':
            contains_double_quote = True
        elif char == "'":
            contains_single_quote = True

        char_lst.append(char)
        i += 1

    use_single_quote = not contains_single_quote or contains_double_quote

    j = 0
    while j < value_len:
        char = char_lst[j]
        char_code = ord(char)

        if char_code < 32:
            if char_code == 9: # \t
                char_lst[j] = "\\t"
            elif char_code == 10: # \n
                char_lst[j] = "\\n"
            elif char_code == 13: # \r
                char_lst[j] = "\\r"
            else:
                char_lst[j] = char_code_to_hex(char_code)
        elif char_code < 127:
            if char_code == 39: # '
                if use_single_quote:
                    char_lst[j] = "\\'"
            elif char_code == 92: # \
                char_lst[j] = "\\\\"
        elif char_code < 161:
            char_lst[j] = char_code_to_hex(char_code)

        j += 1

    if use_single_quote:
        return "'" + ''.join(char_lst) + "'"
    else:
        return '"' + ''.join(char_lst) + '"'

def om_str_repr_code(ctx, args):
    if debug: print('str.__repr__')

    if len(args) == 1:
        self = args[0]

        formatted_str = om_format_str_repr(self, ctx.rte)

        return ctx.cont(ctx.rte, om_str(formatted_str))
    else:
        return sem_raise_with_message(ctx, class_TypeError, "expected 0 arguments, got " + str(len(args) - 1))

om_str_repr = do_magic_method(class_str, "__repr__", om_str_repr_code)

def om_str_add_code(ctx, args):
    if debug: print('str.__add__')

    if len(args) == 2:
        self = args[0]
        other = args[1]

        if om_isinstance(other, class_str):
            self_val = OM_get_boxed_value(self)
            other_value = OM_get_boxed_value(other)

            return cont_str(ctx, self_val + other_value)
        else:
            return cont_obj(ctx, om_NotImplemented)
    else:
        return sem_raise_with_message(ctx, class_TypeError, "expected 1 arguments, got " + str(len(args) - 1))

om_str_add = do_magic_method(class_str, "__add__", om_str_add_code)

def om_str_mul_code(ctx, args):
    if debug: print('str.__mul__')

    if len(args) == 2:
        self = args[0]
        other = args[1]

        def do_mul(rte, res):
            if res is absent:
                return sem_raise_with_message(ctx, class_TypeError, "can't multiply sequence by non-int")
            else:
                times = OM_get_boxed_value(res)
                num_times = int_to_num(times, True)

                if num_times is False:
                    # NOTE: This is not strictly Python, but we cannot handle too big multpilciations for now
                    return sem_raise_with_message(ctx, class_OverflowError, "int too large to multiply sequence")
                else:
                    return cont_str(ctx, string_mul(OM_get_boxed_value(self), num_times))
        return sem_maybe_index(with_cont(ctx, do_mul), other)
    else:
        return sem_raise_with_message(ctx, class_TypeError, "expected 1 arguments, got " + str(len(args) - 1))

om_str_mul = do_magic_method(class_str, "__mul__", om_str_mul_code)
om_str_rmul = do_magic_method(class_str, "__rmul__", om_str_mul_code)

om_str_eq = gen_dunder_Homogenous_Numeric_BinOp('str', '__eq__', string_eq, class_str, om_bool)
om_str_ne = gen_dunder_Homogenous_Numeric_BinOp('str', '__ne__', string_ne, class_str, om_bool)
om_str_lt = gen_dunder_Homogenous_Numeric_BinOp('str', '__lt__', string_lt, class_str, om_bool)
om_str_le = gen_dunder_Homogenous_Numeric_BinOp('str', '__le__', string_le, class_str, om_bool)
om_str_gt = gen_dunder_Homogenous_Numeric_BinOp('str', '__gt__', string_gt, class_str, om_bool)
om_str_ge = gen_dunder_Homogenous_Numeric_BinOp('str', '__ge__', string_ge, class_str, om_bool)

def om_str_getitem_code(ctx, args):
    if debug: print('str.__getitem__')

    if len(args) == 2:
        self = args[0]
        item = args[1]

        def get_char(rte, index):
            index_val = OM_get_boxed_value(index)
            self_val = OM_get_boxed_value(self)
            self_len = int_from_num(len(self_val))

            if int_ge(index_val, self_len):
                return sem_raise_with_message(ctx, class_IndexError, "string index out of range")
            elif int_is_nonneg(index_val):
                return cont_str(ctx, self_val[int_to_num(index_val)])
            else:
                reversed_index = int_add(index_val, self_len)
                if int_is_nonneg(reversed_index):
                    return cont_str(ctx, self_val[int_to_num(reversed_index)])
                else:
                    return sem_raise_with_message(ctx, class_IndexError, "string index out of range")
        return sem_index(with_cont(ctx, get_char), item)
    else:
        return sem_raise_with_message(ctx, class_TypeError, "expected 1 arguments, got " + str(len(args) - 1))

om_str_getitem = do_magic_method(class_str, "__getitem__", om_str_getitem_code)

def om_str_len_code(ctx, args):
    if debug: print('str.__len__')

    if len(args) == 1:
        self = args[0]

        self_len = len(OM_get_boxed_value(self))

        return cont_int(ctx, int_from_num(self_len))
    else:
        return sem_raise_with_message(ctx, class_TypeError, "expected 0 arguments, got " + str(len(args) - 1))

om_str_len = do_magic_method(class_str, "__len__", om_str_len_code)

def om_str_str_code(ctx, args):
    if debug: print('str.__str__')

    if len(args) == 1:
        self = args[0]

        if om_is(OM_get_object_class(self), class_str):
            return ctx.cont(ctx.rte, self)
        else:
            new_str = om_str(OM_get_boxed_value(self))
            ctx.cont(ctx.rte, new_str)
    else:
        return sem_raise_with_message(ctx, class_TypeError, "expected 0 arguments, got " + str(len(args) - 1))

om_str_str = do_magic_method(class_str, "__str__", om_str_str_code)

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
def om_NoneType_bool_code(ctx, val):
    if debug: print('None.__bool__')
    result = om_False
    return ctx.cont(ctx.rte, result)

om_NoneType_bool = do_magic_method(class_NoneType, "__bool__", om_NoneType_bool_code)

def om_NoneType_new_code(ctx, val):
    if debug: print('None.__new__')
    return ctx.cont(ctx.rte, om_None)

om_NoneType_new = do_static_magic_method(class_NoneType, "__new__", om_NoneType_new_code)

def om_format_NoneType_repr(value, rte):
    return "None"


def om_NoneType_repr_code(ctx, val):
    if debug: print('None.__repr__')
    return ctx.cont(ctx.rte, om_str(om_format_NoneType_repr(val, ctx.rte)))

om_NoneType_repr = do_magic_method(class_NoneType, "__repr__", om_NoneType_repr_code)

# class_function methods
def om_make_function_with_signature(name, code, signature):
    om_fn = om(class_function)

    OM_set(om_fn, '__name__', om_str(name))
    OM_set_function_signature(om_fn, signature)
    OM_set_function_body(om_fn, code)
    arity = signature_arity(signature)
    OM_set_function_arity(om_fn, arity)
    # setting an empty local env is ok because hand-written builtin have no closure/assignments
    OM_set_function_locals(om_fn, [])

    return om_fn

def om_function_call(ctx, args):
    self = args[0]
    params = args[1:]

    signature = OM_get_function_signature(self)

    ## test arity
    def execute_body(rte, locals_env):
        stack = make_frame(rte, ctx.cont, ctx.ast)

        call_locals_env = make_dict_from_list(locals_env)

        for item in OM_get_function_locals(self):
            name = item[0]
            must_box = item[1]

            value = dict_get(call_locals_env, name, absent)

            if must_box:
                dict_set(call_locals_env, name, [value])
            else:
                dict_set(call_locals_env, name, value)


        rte = make_rte(ctx.rte, rte_globals(ctx.rte), call_locals_env, self, rte_builtins(ctx.rte), stack, rte_ctrl_env(ctx.rte), rte_vm(ctx.rte), rte_options(ctx.rte))
        body = OM_get_function_body(self)
        return body(rte,
                    lambda rte1:
                       frame_cont(rte_stack(rte1))(frame_rte(rte_stack(rte1)), om_None))

    new_ctx = with_cont(ctx, execute_body)
    self_name_value = OM_get_boxed_value(OM_get(self, '__name__'))
    return align_args_with_signature(new_ctx, self_name_value, params, signature)

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
            return sem_str(ctx, seq[0])
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

# Arithmetic
om_int_add = gen_dunder_Homogenous_Numeric_BinOp('int', '__add__', int_add, class_int, om_int)
om_int_radd = gen_dunder_Homogenous_Numeric_rBinOp('int', '__radd__', int_add, class_int, om_int)

om_int_sub = gen_dunder_Homogenous_Numeric_BinOp('int', '__sub__', int_sub, class_int, om_int)
om_int_rsub = gen_dunder_Homogenous_Numeric_rBinOp('int', '__rsub__', int_sub, class_int, om_int)

om_int_mul = gen_dunder_Homogenous_Numeric_BinOp('int', '__mul__', int_mul, class_int, om_int)
om_int_rmul = gen_dunder_Homogenous_Numeric_rBinOp('int', '__rmul__', int_mul, class_int, om_int)

# Bitwise
om_int_lshift = gen_dunder_Homogenous_Numeric_BinOp('int', '__lshift__', int_lshift, class_int, om_int)
om_int_rlshift = gen_dunder_Homogenous_Numeric_rBinOp('int', '__rlshift__', int_lshift, class_int, om_int)
om_int_rshift = gen_dunder_Homogenous_Numeric_BinOp('int', '__rshift__', int_rshift, class_int, om_int)
om_int_rrshift = gen_dunder_Homogenous_Numeric_rBinOp('int', '__rrshift__', int_rshift, class_int, om_int)
om_int_or = gen_dunder_Homogenous_Numeric_BinOp('int', '__or__', int_or, class_int, om_int)
om_int_ror = gen_dunder_Homogenous_Numeric_rBinOp('int', '__ror__', int_or, class_int, om_int)
om_int_and = gen_dunder_Homogenous_Numeric_BinOp('int', '__and__', int_and, class_int, om_int)
om_int_rand = gen_dunder_Homogenous_Numeric_rBinOp('int', '__rand__', int_and, class_int, om_int)
om_int_xor = gen_dunder_Homogenous_Numeric_BinOp('int', '__xor__', int_xor, class_int, om_int)
om_int_rxor = gen_dunder_Homogenous_Numeric_rBinOp('int', '__rxor__', int_xor, class_int, om_int)

def is_space(c):
    return c == " " or c == "\t" or c == "\f" or c =="\r" or c == "\n"


def get_trimmed_str_range(s):
    end = len(s)
    start = 0
    while start < end:
        if is_space(s[start]):
            start += 1
        else:
            break

    while start < end:
        if is_space(s[end-1]):
            end -= 1
        else:
            break

    return start, end


# class_int methods
def int_from_str(s, base):
    base = int_to_num(base)

    disallow_heading_zeros = base == 0

    # base is 0 or 2 <= base <= 36
    start, end = get_trimmed_str_range(s)

    if start >= end:
        return False

    sign = s[start]

    if sign == '+' or sign == '-':
        start += 1

    if end - start >= 3 and s[start] == '0':
        c = s[start+1]
        if c == 'b' or c == 'B':
            prefix_base = 2
        elif c == 'o' or c == 'O':
            prefix_base = 8
        elif c == 'x' or c == 'X':
            prefix_base = 16
        else:
            prefix_base = base - 1
        if prefix_base > 0 if base == 0 else prefix_base == base:
            disallow_heading_zeros = False
            base = prefix_base
            start += 2

    if start >= end:
        return False

    # disallow heading zero in base 0 without prefix-base
    if disallow_heading_zeros and s[start] == '0':
        start += 1
        while start < end:
            if s[start] == '0':
                start += 1
            else:
                # non-zero in base 10 with heading 0 or non-digit character
                return False
        # If we consumed a chain of legal '0', the result can only be 0
        return int_from_num(0)


    if base == 0:
        base = 10

    n = int_from_substring(s, start, end, base)

    if n is False:
        return False

    if sign == '-':
        return int_neg(n)
    else:
        return n

def om_int_str_conversion(ctx, obj, radix):
    if not om_isinstance(obj, class_str):
        return sem_raise_with_message(ctx, class_TypeError, "int() can't convert non-string with explicit base")

    def check_range(rte, index):
        str_value = OM_get_boxed_value(obj)
        base = OM_get_boxed_value(index)

        res = int_from_str(str_value, base)

        if res is False:
            return sem_raise_with_message(ctx, class_ValueError, "invalid literal for int() with base " + str(
                base) + ": '" + str_value + "'")
        else:
            return ctx.cont(rte, om_int(res))
    return sem_index(with_cont(ctx, check_range), radix)

def om_int_new_code(ctx, args):
    args_len = len(args)

    if args_len == 1:
        cls = args[0]
        return ctx.cont(ctx.rte, om_int_subtype(cls, int_from_num(0)))
    elif args_len == 2:
        cls = args[0]
        obj = args[1]

        def check_result(rte, res):
            if res is absent:
                if om_isinstance(obj, class_str):
                    return om_int_str_conversion(ctx, obj, om_int(int_from_num(10)))
                else:
                    return sem_raise_with_message(
                        Context(rte, ctx.cont, ctx.ast),
                        class_TypeError,
                        "int() argument must be a string, a bytes-like object or a number")
            else:
                return ctx.cont(ctx.rte, om_int_subtype(cls, OM_get_boxed_value(res)))
        return sem_maybe_int(with_cont(ctx, check_result), obj)
    elif args_len == 3:
        obj = args[1]
        radix = args[2]

        if om_isinstance(obj, class_str):
            def check_radix_range(rte, res):
                res_value = OM_get_boxed_value(res)
                if int_is_zero(res_value) or int_ge(res_value, int_from_num(2)) and int_le(res_value, int_from_num(36)):
                    return om_int_str_conversion(ctx, obj, res)
                else:
                    return sem_raise_with_message(ctx, class_ValueError, "int() base must be >= 2 and <= 36, or 0")

            return sem_index(with_cont(ctx, check_radix_range), radix)
        else:
            return sem_raise_with_message(ctx, class_TypeError, "int() can't convert non-string with explicit base")
    else:
        return sem_raise_with_message(ctx, class_TypeError, "int() takes at most 2 argument, got " + str(args_len))

om_int_new = do_static_magic_method(class_int, "__new__", om_int_new_code)

def om_int_int_code(ctx, args):
    args_len = len(args)

    if args_len == 1:
        self = args[0]
        return ctx.cont(ctx.rte, self)
    else:
        return sem_raise_with_message(ctx, class_TypeError, "expected 0 arguments, got " + str(args_len - 1))

om_int_int = do_magic_method(class_int, "__int__", om_int_int_code)

def om_int_index_code(ctx, args):
    args_len = len(args)

    if args_len == 1:
        self = args[0]
        return ctx.cont(ctx.rte, self)
    else:
        return sem_raise_with_message(ctx, class_TypeError, "expected 0 arguments, got " + str(args_len - 1))

om_int_index = do_magic_method(class_int, "__index__", om_int_index_code)

def om_int_float_code(ctx, args):
    args_len = len(args)

    if args_len == 1:
        self = args[0]
        float_val = int_to_num(OM_get_boxed_value(self))
        return ctx.cont(ctx.rte, om_float(float_val))
    else:
        return sem_raise_with_message(ctx, class_TypeError, "expected 0 arguments, got " + str(args_len - 1))

om_int_float = do_magic_method(class_int, "__float__", om_int_float_code)

def om_int_bool_code(ctx, args):
    if debug: print('int.__bool__')
    args_len = len(args)
    if args_len != 1:
        return sem_raise_with_message(ctx, class_TypeError, "expected 0 arguments, got " + str(args_len - 1))

    self = args[0]
    val_value = OM_get_boxed_value(self)
    return cont_bool(ctx, not int_is_zero(val_value))

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
om_int_eq = gen_dunder_Homogenous_Numeric_BinOp('int', '__eq__', int_eq, class_int, om_bool)
om_int_ne = gen_dunder_Homogenous_Numeric_BinOp('int', '__ne__', int_ne, class_int, om_bool)
om_int_lt = gen_dunder_Homogenous_Numeric_BinOp('int', '__lt__', int_lt, class_int, om_bool)
om_int_le = gen_dunder_Homogenous_Numeric_BinOp('int', '__le__', int_le, class_int, om_bool)
om_int_gt = gen_dunder_Homogenous_Numeric_BinOp('int', '__gt__', int_gt, class_int, om_bool)
om_int_ge = gen_dunder_Homogenous_Numeric_BinOp('int', '__ge__', int_ge, class_int, om_bool)

def om_format_int_repr(self, rte):
    return int_to_string(OM_get_boxed_value(self), 10)


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

    # Primitive operations are only defined on same types.
    if om_issubclass(OM_get_object_class(val2), class_int):
        # Early break for ZeroDivisionError
        val2_value = OM_get_boxed_value(val2)
        if int_is_zero(val2_value):
            return sem_raise_with_message(ctx, class_ZeroDivisionError, "modulo by zero")
        else:
            val1_value = OM_get_boxed_value(val1)
            result = int_mod_floor(val1_value, val2_value)
            return ctx.cont(ctx.rte, om_int(result))
    else:
        # TODO: Return om_NotImplemented(rte) (in the proper rte)
        return ctx.cont(ctx.rte, om_NotImplemented)

om_int_mod = do_magic_method(class_int, "__mod__", om_int_mod_code)

def om_int_rmod_code(ctx, args):
    if debug: print("int.__rmod__")
    val1 = args[0]
    val2 = args[1]

    # Primitive operations are only defined on same types.
    if om_issubclass(OM_get_object_class(val2), class_int):
        # Early break for ZeroDivisionError
        val1_value = OM_get_boxed_value(val1)
        if int_is_zero(val1_value):
            return sem_raise_with_message(ctx, class_ZeroDivisionError, "modulo by zero")
        else:
            val2_value = OM_get_boxed_value(val2)
            result = int_mod_floor(val2_value, val1_value)
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


    # Primitive operations are only defined on same types.
    if om_issubclass(OM_get_object_class(val2), class_int):
        # Early break for ZeroDivisionError
        val2_value = OM_get_boxed_value(val2)
        if int_is_zero(val2_value):
            return sem_raise_with_message(ctx, class_ZeroDivisionError, "division by zero")
        else:
            val1_value = OM_get_boxed_value(val1)
            result = int_div_floor(val1_value, val2_value)
            return ctx.cont(ctx.rte, om_int(result))
    else:
        # TODO: Return om_NotImplemented(rte) (in the proper rte)
        return ctx.cont(ctx.rte, om_NotImplemented)

om_int_floordiv = do_magic_method(class_int, "__floordiv__", om_int_floordiv_code)


def om_int_rfloordiv_code(ctx, args):
    if debug: print("int.__rfloordiv__")
    val1 = args[0]
    val2 = args[1]

    # Primitive operations are only defined on same types.
    if om_issubclass(OM_get_object_class(val2), class_int):
        # Early break for ZeroDivisionError
        val1_value = OM_get_boxed_value(val1)
        if int_is_zero(val1_value):
            return sem_raise_with_message(ctx, class_ZeroDivisionError, "division by zero")
        else:
            val2_value = OM_get_boxed_value(val2)
            result = int_div_floor(val2_value, val1_value)
            return ctx.cont(ctx.rte, om_int(result))
    else:
        # TODO: Return om_NotImplemented(rte) (in the proper rte)
        return ctx.cont(ctx.rte, om_NotImplemented)

om_int_rfloordiv = do_magic_method(class_int, "__rfloordiv__", om_int_rfloordiv_code)

def om_int_truediv_code(ctx, args):
    if debug: print("int.__truediv__")
    val1 = args[0]
    val2 = args[1]

    # Primitive operations are only defined on same types.
    if om_issubclass(OM_get_object_class(val2), class_int):
        # Early break for ZeroDivisionError
        val2_value = OM_get_boxed_value(val2)
        if int_is_zero(val2_value):
            return sem_raise_with_message(ctx, class_ZeroDivisionError, "division by zero")
        else:
            val1_value = OM_get_boxed_value(val1)
            result = float_div(int_to_num(val1_value), int_to_num(val2_value))
            return ctx.cont(ctx.rte, om_float(result))
    else:
        # TODO: Return om_NotImplemented(rte) (in the proper rte)
        return ctx.cont(ctx.rte, om_NotImplemented)

om_int_truediv = do_magic_method(class_int, "__truediv__", om_int_truediv_code)


def om_int_rtruediv_code(ctx, args):
    if debug: print("int.__rtruediv__")
    val1 = args[0]
    val2 = args[1]

    # Primitive operations are only defined on same types.
    if om_issubclass(OM_get_object_class(val2), class_int):
        # Early break for ZeroDivisionError
        val1_value = OM_get_boxed_value(val1)
        if int_is_zero(val1_value):
            return sem_raise_with_message(ctx, class_ZeroDivisionError, "division by zero")
        else:
            val2_value = OM_get_boxed_value(val2)
            result = float_div(int_to_num(val2_value), int_to_num(val1_value))
            return ctx.cont(ctx.rte, om_float(result))
    else:
        # TODO: Return om_NotImplemented(rte) (in the proper rte)
        return ctx.cont(ctx.rte, om_NotImplemented)

om_int_rtruediv = do_magic_method(class_int, "__rtruediv__", om_int_rtruediv_code)

# Float dunders

def float_str_is_decimal_float(s, start, end):
    if start >= end:
        return False

    dot_pos = -1

    i = start
    while i < end:
        c_code = ord(s[i])

        if c_code >= 48 and c_code <= 57:
            i += 1
        elif c_code == 46 and dot_pos == -1:
            dot_pos = i
            i += 1
        else:
            return False

    return dot_pos == - 1 or dot_pos > start or dot_pos < end - 1


def float_str_is_integral_float(s, start, end):
    if start >= end:
        return False

    i = start
    while i < end:
        c_code = ord(s[i])

        if c_code >= 48 and c_code <= 57:
            i += 1
        else:
            return False

    return True


def float_str_segment_is_inf(s, start, end):
    if end - start == 3:
        c1 = s[start]
        c2 = s[start+1]
        c3 = s[start+2]
        return c1 == "i" or c1 == "I" and c2 == "n" or c2 == "N" and c3 == "f" or c3 == "F"
    else:
        return False

def float_str_segment_is_nan(s, start, end):
    if end - start == 3:
        c1 = s[start]
        c2 = s[start+1]
        c3 = s[start+2]
        return c1 == "n" or c1 == "N" and c2 == "a" or c2 == "A" and c3 == "n" or c3 == "N"
    else:
        return False

def float_str_find_e_in_segment(s, start, end):
    while start < end:
        c = s[start]
        if c == "e" or c == "E":
            return start
        start += 1
    return None

def float_str_conversion(s):
    start, end = get_trimmed_str_range(s)

    if start >= end:
        return None

    sign = s[start]

    if sign == '+' or sign == '-':
        start += 1

    if float_str_segment_is_inf(s, start, end):
        if sign == "-":
            return float_neg_inf()
        else:
            return float_inf()

    if float_str_segment_is_nan(s, start, end):
        return float_nan()

    e_pos = float_str_find_e_in_segment(s, start, end)

    if e_pos is None:
        if float_str_is_decimal_float(s, start, end):
            return float_from_string(s)
        else:
            return None
    else:
        e_start = e_pos + 1
        e_sign = s[e_start]

        if e_sign == "+" or e_sign == "-":
            e_start += 1

        if not (float_str_is_integral_float(s, e_start, end) and float_str_is_decimal_float(s, start, e_pos)):
            return None
        else:
            return float_from_string(s)

def om_float_str_conversion(ctx, obj):
    if om_isinstance(obj, class_str):
        s = OM_get_boxed_value(obj)
        res = float_str_conversion(s)
        if res is None:
            return sem_raise_with_message(ctx, class_ValueError,
                                          "could not convert string to float: " + om_format_str_repr(obj, ctx.rte))
        else:
            return cont_float(ctx, res)
    else:
        return sem_raise_with_message(ctx, class_TypeError, "float() argument must be a string or a number")

def om_float_new_code(ctx, args):
    args_len = len(args)

    if args_len == 1:
        cls = args[0]
        return ctx.cont(ctx.rte, om_float_subtype(cls, 0))
    elif args_len == 2:
        cls = args[0]
        obj = args[1]

        def check_result(rte, res):
            if res is absent:
                return om_float_str_conversion(ctx, obj)
            else:
                return ctx.cont(ctx.rte, om_float_subtype(cls, OM_get_boxed_value(res)))
        return sem_maybe_float(with_cont(ctx, check_result), obj)
    else:
        return sem_raise_with_message(ctx, class_TypeError, "int() takes at most 1 argument, got " + str(args_len))

om_float_new = do_static_magic_method(class_float, "__new__", om_float_new_code)

def om_float_bool_code(ctx, args):
    if debug: print('int.__bool__')
    args_len = len(args)
    if args_len != 1:
        return sem_raise_with_message(ctx, class_TypeError, "expected 0 arguments, got " + str(args_len - 1))
    self = args[0]
    val_value = OM_get_boxed_value(self)
    return cont_bool(ctx, not float_is_zero(val_value))

om_float_bool = do_magic_method(class_float, "__bool__", om_float_bool_code)

def om_float_int_code(ctx, args):
    if len(args) == 1:
        self = args[0]
        val = OM_get_boxed_value(self)

        if float_is_pos(val):
            int_val = int_from_num(float_floor(val))
            return ctx.cont(ctx.rte, om_int(int_val))
        else:
            int_val = int_from_num(float_ceil(val))
            return ctx.cont(ctx.rte, om_int(int_val))

om_float_int = do_magic_method(class_float, "__int__", om_float_int_code)

def om_float_float_code(ctx, args):
    args_len = len(args)

    if args_len == 1:
        self = args[0]
        return ctx.cont(ctx.rte, self)
    else:
        return sem_raise_with_message(ctx, class_TypeError, "expected 0 arguments, got " + str(args_len - 1))

om_float_float = do_magic_method(class_float, "__float__", om_float_float_code)

def gen_dunder_Float_BinOp(py_class, method, prim, cont_box):
    debug_msg = py_class + "." + method

    def dunder_Float_BinOp(ctx, args):
        if debug: print(debug_msg)

        val1 = args[0]
        val2 = args[1]

        val2_class = OM_get_object_class(val2)

        # Primitive operations are only defined on same types.
        if om_issubclass(val2_class, class_float):
            val1_value = OM_get_boxed_value(val1)
            val2_value = OM_get_boxed_value(val2)
            result = prim(val1_value, val2_value)
            return ctx.cont(ctx.rte, om_float(result))
        elif om_issubclass(val2_class, class_int):
            val1_value = OM_get_boxed_value(val1)
            val2_value = OM_get_boxed_value(val2)
            val2_float_value = int_to_num(val2_value)
            if float_is_infinite(val2_float_value) or float_is_nan(val2_float_value):
                return sem_raise_with_message(ctx, class_OverflowError, "int too large to convert to float")
            else:
                res = prim(val1_value, val2_float_value)
                return cont_box(ctx, res)
        else:
            return cont_obj(ctx, om_NotImplemented)

    return do_magic_method(class_float, method, dunder_Float_BinOp)


def gen_dunder_Float_rBinOp(py_class, method, prim, cont_box):
    debug_msg = py_class + "." + method

    def dunder_Float_rBinOp(ctx, args):
        if debug: print(debug_msg)

        val1 = args[0]
        val2 = args[1]


        val2_class = OM_get_object_class(val2)

        # Primitive operations are only defined on same types.
        if om_issubclass(val2_class, class_float):
            val1_value = OM_get_boxed_value(val1)
            val2_value = OM_get_boxed_value(val2)
            result = prim(val1_value, val2_value)
            return ctx.cont(ctx.rte, om_float(result))
        elif om_issubclass(val2_class, class_int):
            val1_value = OM_get_boxed_value(val1)
            val2_value = OM_get_boxed_value(val2)
            val2_float_value = int_to_num(val2_value)
            if float_is_infinite(val2_float_value) or float_is_nan(val2_float_value):
                return sem_raise_with_message(ctx, class_OverflowError, "int too large to convert to float")

            res = prim(val2_float_value, val1_value)
            return cont_box(ctx, res)
        else:
            return cont_obj(ctx, om_NotImplemented)

    return do_magic_method(class_float, method, dunder_Float_rBinOp)


def gen_dunder_Float_DivideOp(py_class, method, prim, cont_box):
    debug_msg = py_class + "." + method

    def dunder_Float_DivideOp(ctx, args):
        if debug: print(debug_msg)
        val1 = args[0]
        val2 = args[1]

        val2_class = OM_get_object_class(val2)

        # Primitive operations are only defined on same types.
        if om_issubclass(val2_class, class_float):
            val1_value = OM_get_boxed_value(val1)
            val2_value = OM_get_boxed_value(val2)

            if float_is_zero(val2_value):
                return sem_raise_with_message(ctx, class_ZeroDivisionError, "float division or modulo by zero")

            result = prim(val1_value, val2_value)
            return ctx.cont(ctx.rte, om_float(result))
        elif om_issubclass(val2_class, class_int):
            val1_value = OM_get_boxed_value(val1)
            val2_value = OM_get_boxed_value(val2)
            val2_float_value = int_to_num(val2_value, True)
            if val2_float_value is False:
                return sem_raise_with_message(ctx, class_OverflowError, "int too large to convert to float")

            if float_is_zero(val2_float_value):
                return sem_raise_with_message(ctx, class_ZeroDivisionError, "float division or modulo by zero")

            res = prim(val1_value, val2_float_value)
            return cont_box(ctx, res)
        else:
            return cont_obj(ctx, om_NotImplemented)

    return do_magic_method(class_float, method, dunder_Float_DivideOp)

def gen_dunder_Float_rDivideOp(py_class, method, prim, cont_box):
    debug_msg = py_class + "." + method

    def dunder_Float_rDivideOp(ctx, args):
        if debug: print(debug_msg)
        val1 = args[0]
        val2 = args[1]

        val2_class = OM_get_object_class(val2)

        # Primitive operations are only defined on same types.
        if om_issubclass(val2_class, class_float):
            val1_value = OM_get_boxed_value(val1)
            val2_value = OM_get_boxed_value(val2)

            if float_is_zero(val1_value):
                return sem_raise_with_message(ctx, class_ZeroDivisionError, "float division or modulo by zero")

            result = prim(val1_value, val2_value)
            return ctx.cont(ctx.rte, om_float(result))
        elif om_issubclass(val2_class, class_int):
            val1_value = OM_get_boxed_value(val1)
            val2_value = OM_get_boxed_value(val2)
            val2_float_value = int_to_num(val2_value, True)
            if val2_float_value is False:
                return sem_raise_with_message(ctx, class_OverflowError, "int too large to convert to float")

            if float_is_zero(val1_value):
                return sem_raise_with_message(ctx, class_ZeroDivisionError, "float division or modulo by zero")

            res = prim(val2_float_value, val1_value)
            return cont_box(ctx, res)
        else:
            return cont_obj(ctx, om_NotImplemented)

    return do_magic_method(class_float, method, dunder_Float_rDivideOp)


def gen_dunder_Float_EqComp(py_class, method, float_comp, res_on_overflow, cont_box):
    debug_msg = py_class + "." + method

    def dunder_Float_EqComp(ctx, args):
        if debug: print(debug_msg)
        val1 = args[0]
        val2 = args[1]

        val2_class = OM_get_object_class(val2)

        # Primitive operations are only defined on same types.
        if om_issubclass(val2_class, class_float):
            val1_value = OM_get_boxed_value(val1)
            val2_value = OM_get_boxed_value(val2)
            result = float_comp(val1_value, val2_value)
            return cont_bool(ctx, result)
        elif om_issubclass(val2_class, class_int):
            val1_value = OM_get_boxed_value(val1)
            val2_value = OM_get_boxed_value(val2)
            val2_float_value = int_to_num(val2_value, True)

            if val2_float_value is False:
                cont_bool(ctx, res_on_overflow)
            else:
                res = float_comp(val1_value, val2_float_value)
                return cont_bool(ctx, res)
        else:
            return cont_obj(ctx, om_NotImplemented)

    return do_magic_method(class_float, method, dunder_Float_EqComp)

def gen_dunder_Float_Comp(py_class, method, float_comp, int_comp, neg_inf_res, pos_inf_res, cont_box):
    debug_msg = py_class + "." + method

    def dunder_Float_Comp(ctx, args):
        if debug: print(debug_msg)
        val1 = args[0]
        val2 = args[1]

        val2_class = OM_get_object_class(val2)

        # Primitive operations are only defined on same types.
        if om_issubclass(val2_class, class_float):
            val1_value = OM_get_boxed_value(val1)
            val2_value = OM_get_boxed_value(val2)
            result = float_comp(val1_value, val2_value)
            return cont_box(ctx, result)
        elif om_issubclass(val2_class, class_int):
            val1_value = OM_get_boxed_value(val1)
            val2_value = OM_get_boxed_value(val2)
            val2_float_value = int_to_num(val2_value, True)

            if val2_float_value is False:
                if float_is_finite(val1_value):
                    val1_int_value = int_from_num(float_trunc(val1_value))
                    res = int_comp(val1_int_value, val2_value)
                    return cont_box(ctx, res)
                elif float_is_nan(val1_value):
                    return cont_box(ctx, False)
                elif float_is_pos(val1_value):
                    # case: +inf
                    return cont_box(ctx, pos_inf_res)
                else:
                    #case: -inf
                    return cont_box(ctx, neg_inf_res)
            else:
                res = float_comp(val1_value, val2_float_value)
                return cont_box(ctx, res)
        else:
            return cont_obj(ctx, om_NotImplemented)

    return do_magic_method(class_float, method, dunder_Float_Comp)


om_float_add = gen_dunder_Float_BinOp('float', '__add__', float_add, cont_float)
om_float_radd = gen_dunder_Float_rBinOp('float', '__add__', float_add, cont_float)

om_float_sub = gen_dunder_Float_BinOp('float', '__sub__', float_sub, cont_float)
om_float_rsub = gen_dunder_Float_rBinOp('float', '__rsub__', float_sub, cont_float)

om_float_mul = gen_dunder_Float_BinOp('float', '__mul__', float_mul, cont_float)
om_float_rmul = gen_dunder_Float_rBinOp('float', '__rmul__', float_mul, cont_float)

om_float_truediv = gen_dunder_Float_DivideOp('float', '__truediv__', float_div, cont_float)
om_float_rtruediv = gen_dunder_Float_rDivideOp('float', '__rtruediv__', float_div, cont_float)

def float_floordiv(u, v):
    return float_floor(u / v)

om_float_floordiv = gen_dunder_Float_DivideOp('float', '__floordiv__', float_floordiv, cont_float)
om_float_rfloordiv = gen_dunder_Float_rDivideOp('float', '__rfloordiv__', float_floordiv, cont_float)

def om_float_mod_code(ctx, args):
    args_len = len(args)

    if args_len == 2:
        val1 = args[0]
        val2 = args[1]

        if om_isinstance(val2, class_float):
            val1_value = OM_get_boxed_value(val1)
            val2_value = OM_get_boxed_value(val2)

            if float_is_zero(val2_value):
                return sem_raise_with_message(ctx, class_ZeroDivisionError, "float modulo")
            elif float_is_infinite(val2_value) and float_is_finite(val1_value):
                if float_is_neg(val1_value):
                    # Return inf
                    return cont_float(ctx, val2_value)
                else:
                    return cont_float(ctx, val1_value)
            else:
                return cont_float(ctx, float_mod_floor(val1_value, val2_value))
        elif om_isinstance(val2, class_int):
            val1_value = OM_get_boxed_value(val1)
            val2_value = OM_get_boxed_value(val2)
            val2_float_value = int_to_num(val2_value)

            if float_is_infinite(val2_float_value):
                return sem_raise_with_message(ctx, class_OverflowError, "int too large to convert to float")
            elif float_is_zero(val2_float_value):
                return sem_raise_with_message(ctx, class_ZeroDivisionError, "float modulo")
            elif float_is_infinite(val2_float_value) and float_is_finite(val1_value):
                if float_is_neg(val1_value):
                    # Return inf
                    return cont_float(ctx, val2_float_value)
                else:
                    return cont_float(ctx, val1_value)
            else:
                return cont_float(ctx, float_mod_floor(val1_value, val2_float_value))
        else:
            return cont_obj(ctx, om_NotImplemented)
    else:
        return sem_raise_with_message(ctx, class_TypeError, "expected 1 arguments, got " + str(args_len - 1))

om_float_mod = do_magic_method(class_float, '__mod__', om_float_mod_code)


def om_float_rmod_code(ctx, args):
    args_len = len(args)

    if args_len == 2:
        val1 = args[0]
        val2 = args[1]

        if om_isinstance(val2, class_float):
            val1_value = OM_get_boxed_value(val1)
            val2_value = OM_get_boxed_value(val2)

            if float_is_zero(val1_value):
                return sem_raise_with_message(ctx, class_ZeroDivisionError, "float modulo")
            elif float_is_infinite(val1_value) and float_is_finite(val2_value):
                if float_is_neg(val2_value):
                    # Return inf
                    return cont_float(ctx, val1_value)
                else:
                    return cont_float(ctx, val2_value)
            else:
                return cont_float(ctx, float_mod_floor(val2_value, val1_value))
        elif om_isinstance(val2, class_int):
            val1_value = OM_get_boxed_value(val1)
            val2_value = OM_get_boxed_value(val2)
            val2_float_value = int_to_num(val2_value)

            if float_is_infinite(val2_float_value):
                return sem_raise_with_message(ctx, class_OverflowError, "int too large to convert to float")
            elif float_is_zero(val1_value):
                return sem_raise_with_message(ctx, class_ZeroDivisionError, "float modulo")
            elif float_is_infinite(val1_value) and float_is_finite(val2_float_value):
                if float_is_neg(val2_float_value):
                    # Return inf
                    return cont_float(ctx, val1_value)
                else:
                    return cont_float(ctx, val2_float_value)
            else:
                return cont_float(ctx, float_mod_floor(val2_float_value, val1_value))
        else:
            return cont_obj(ctx, om_NotImplemented)
    else:
        return sem_raise_with_message(ctx, class_TypeError, "expected 1 arguments, got " + str(args_len - 1))

om_float_rmod = do_magic_method(class_float, '__rmod__', om_float_rmod_code)

def om_float_pow_code(ctx, args):
    args_len = len(args)

    if args_len == 2:
        val1 = args[0]
        val2 = args[1]

        if om_isinstance(val2, class_float):
            val1_value = OM_get_boxed_value(val1)
            val2_value = OM_get_boxed_value(val2)

            abs_val1_value = float_abs(val1_value)

            if float_is_infinite(val2_value) and float_eq(abs_val1_value, float_from_num(1.0)):
                # Special case in Python where +-1.0 ** inf returns 1.0
                return cont_float(ctx, abs_val1_value)
            else:
                return cont_float(ctx, float_pow(val1_value, val2_value))

        elif om_isinstance(val2, class_int):
            val1_value = OM_get_boxed_value(val1)
            val2_value = OM_get_boxed_value(val2)
            val2_float_value = int_to_num(val2_value)
            if float_is_infinite(val2_float_value):
                return sem_raise_with_message(ctx, class_OverflowError, "int too large to convert to float")
            else:
                return cont_float(ctx, float_pow(val1_value, val2_float_value))
        else:
            return cont_obj(ctx, om_NotImplemented)
    elif args_len == 3:
        return sem_raise_with_message(ctx, class_TypeError, "pow() 3rd argument not allowed unless all arguments are integers")
    else:
        return sem_raise_with_message(ctx, class_TypeError, "expected 1 arguments, got " + str(args_len - 1))

om_float_pow = do_magic_method(class_float, "__pow__", om_float_pow_code)


def om_float_rpow_code(ctx, args):
    args_len = len(args)

    if args_len == 2:
        val1 = args[0]
        val2 = args[1]

        if om_isinstance(val2, class_float):
            val1_value = OM_get_boxed_value(val1)
            val2_value = OM_get_boxed_value(val2)

            abs_val2_value = float_abs(val2_value)

            if float_is_infinite(val1_value) and float_eq(abs_val2_value, float_from_num(1.0)):
                # Special case in Python where +-1.0 ** inf returns 1.0
                return cont_float(ctx, abs_val2_value)
            else:
                return cont_float(ctx, float_pow(val2_value, val1_value))

        elif om_isinstance(val2, class_int):
            val1_value = OM_get_boxed_value(val1)
            val2_value = OM_get_boxed_value(val2)
            val2_float_value = int_to_num(val2_value)
            if float_is_infinite(val2_float_value):
                return sem_raise_with_message(ctx, class_OverflowError, "int too large to convert to float")
            elif float_is_infinite(val1_value) and float_eq(val2_float_value, float_from_num(1.0)):
                # Special case in Python where 1.0 ** inf returns 1.0
                return cont_float(ctx, val2_float_value)
            else:
                return cont_float(ctx, float_pow(val2_float_value, val1_value))
        else:
            return cont_obj(ctx, om_NotImplemented)
    elif args_len == 3:
        return sem_raise_with_message(ctx, class_TypeError, "pow() 3rd argument not allowed unless all arguments are integers")
    else:
        return sem_raise_with_message(ctx, class_TypeError, "expected 1 arguments, got " + str(args_len - 1))

om_float_rpow = do_magic_method(class_float, "__rpow__", om_float_rpow_code)

## float comparisons
def float_ne(x, y):
    return not float_eq(x, y)

om_float_eq = gen_dunder_Float_EqComp('float', '__eq__', float_eq, False, cont_bool)
om_float_ne = gen_dunder_Float_EqComp('float', '__ne__', float_ne, True, cont_bool)
om_float_lt = gen_dunder_Float_Comp('float', '__lt__', float_lt, int_lt, True, False, cont_bool)
om_float_le = gen_dunder_Float_Comp('float', '__le__', float_le, int_le, True, False, cont_bool)
om_float_gt = gen_dunder_Float_Comp('float', '__gt__', float_gt, int_gt, False, True, cont_bool)
om_float_ge = gen_dunder_Float_Comp('float', '__ge__', float_ge, int_ge, False, True, cont_bool)

def float_round_even(x):
    if float_is_neg(x):
        sign = float_from_num(-1.0)
    else:
        sign = float_from_num(1.0)

    norm = float_abs(x)
    norm_integral_part = float_floor(norm)
    norm_dec_part = float_sub(norm, norm_integral_part)

    half = float_from_num(0.5)

    if float_lt(norm_dec_part, half):
        return float_mul(sign, norm_integral_part)
    elif float_eq(norm_dec_part, half) and float_is_zero(float_mod(norm_integral_part, float_from_num(2.0))):
        return float_mul(sign, norm_integral_part)
    else:
        return float_mul(sign, float_add(norm_integral_part, float_from_num(1.0)))


def om_float_round_code(ctx, args):
    if len(args) == 1:
        self = args[0]
        return cont_int(ctx, int_from_num(float_round_even(OM_get_boxed_value(self))))
    elif len(args) == 2:
        self = args[0]
        ndigits = args[1]

        def apply_round(rte, n):
            self_value = OM_get_boxed_value(self)
            n_value = OM_get_boxed_value(n)

            if int_is_zero(n_value):
                return cont_float(ctx, float_round_even(self_value))
            elif float_is_infinite(self_value):
                return cont_float(ctx, self_value)
            elif int_is_neg(n_value):
                # When n is a negative value we want to raise to a power of 10
                # In that case use the int_round algorithm on the norm of self

                if float_is_neg(self_value):
                    sign = float_from_num(-1.0)
                else:
                    sign = float_from_num(1.0)

                norm = float_abs(self_value)

                # NOTE: We are using int_round which breaks ties to even
                # Although a number such as 5.1 would be casted to 5 and rounded to 0
                # For this reason we indicate to int_round to break ties by rounding up if self has a decimal part
                norm_integral_part = float_floor(norm)
                int_norm_integral_part = int_from_num(norm_integral_part)

                if float_eq(norm, norm_integral_part):
                    # Break int_round ties by rounding to even
                    res = int_to_num(int_round(int_norm_integral_part, n_value, True))
                else:
                    # Break int_round ties by rounding up
                    res = int_to_num(int_round(int_norm_integral_part, n_value, False))

                if float_is_infinite(res):
                    return sem_raise_with_message(ctx, class_OverflowError, "rounded value too large to represent")
                else:
                    return cont_float(ctx, float_mul(sign, res))
            else:
                n_float_value = int_to_num(n_value)
                # We do not want to pass a BigInt to float_round so we handle Overflows prior
                if float_is_infinite(n_float_value):
                    if int_is_neg(n_value):
                        return cont_obj(ctx, self)
                    else:
                        return cont_float(ctx, float_from_num(0.0))
                else:
                    scale = float_pow(float_from_num(10.0), n_float_value)
                    res = float_div(float_round_even(float_mul(self_value, scale)), scale)
                    if float_is_infinite(res):
                        # Value precision > 1: nothing to round
                        return cont_obj(ctx, self)
                    else:
                        return cont_float(ctx, res)

        return sem_index(with_cont(ctx, apply_round), ndigits)
    else:
        return sem_raise_with_message(ctx, class_TypeError, "expected 1 arguments, got " + str(len(args) - 1))

om_float_round = do_magic_method(class_float, "__round__", om_float_round_code)

def om_float_abs_code(ctx, args):
    if len(args) == 1:
        self = args[0]
        result = float_abs(OM_get_boxed_value(self))
        return ctx.cont(ctx.rte, om_float(result))
    else:
        return sem_raise_with_message(ctx, class_TypeError, "expected 0 arguments, got " + str(len(args) - 1))

om_float_abs = do_magic_method(class_float, "__abs__", om_float_abs_code)


def digit_to_char(x):
    return chr(x + 48)

def float_repr_scale(r, s, m_pos, m_neg, must_round, v):
    """
    r is an int
    s is an int
    m_pos is int
    m_neg is int
    must_round is a boolean
    v is a float
    """
    epsilon = float_pow(float_from_num(10.0), float_from_num(-10.0))

    est = int_from_num(float_to_num(float_ceil(float_sub(float_log10(v), epsilon))))

    if int_is_neg(est):
        factor = int_pow(int_from_num(10), int_neg(est))
        return float_repr_fixup(
            int_mul(r, factor),
            s,
            int_mul(m_pos, factor),
            int_mul(m_neg, factor),
            est,
            must_round)
    else:
        factor = int_pow(int_from_num(10), est)
        return float_repr_fixup(
            r,
            int_mul(s, factor),
            m_pos,
            m_neg,
            est,
            must_round)

def float_repr_fixup(r, s, m_pos, m_neg, k, must_round):
    if int_ge(int_add(r, m_pos), s) if must_round else int_lt(s, int_add(r, m_pos)):
        return (int_add(k, int_from_num(1)),
                float_repr_generate(r, s, m_pos, m_neg, must_round, int_from_num(0)))
    else:
        return (k,
                float_repr_generate(
                    int_mul(r, int_from_num(10)),
                    s,
                    int_mul(m_pos, int_from_num(10)),
                    int_mul(m_neg, int_from_num(10)),
                    must_round,
                    int_from_num(0)))

def float_repr_generate(r, s, m_pos, m_neg, must_round, n):
    dr = int_divmod_floor(r, s)
    d = dr[0]
    r = dr[1]

    n_num = int_to_num(n)

    if int_ge(m_neg, r) if must_round else int_lt(r, m_neg):
        if int_ge(int_add(r, m_pos), s) if must_round else int_lt(s, int_add(r, m_pos)):
            _2r = int_add(r, r)
            if int_is_even(d) and int_eq(_2r, s) or int_lt(_2r, s):
                last_digit = d
            else:
                last_digit = int_add(d, int_from_num(1))
        else:
            last_digit = d

        str_chars = list_new(n_num + 1, 0)
        str_chars[n_num] = int_to_num(last_digit)
        return str_chars
    elif int_ge(int_add(r, m_pos), s) if must_round else int_lt(s, int_add(r, m_pos)):
        str_chars = list_new(n_num + 1, 0)
        str_chars[n_num] = int_to_num(d) + 1
        return str_chars
    else:
        str_chars = float_repr_generate(
            int_mul(r, int_from_num(10)),
            s,
            int_mul(m_pos, int_from_num(10)),
            int_mul(m_neg, int_from_num(10)),
            must_round,
            int_add(n, int_from_num(1)))
        str_chars[n_num] = int_to_num(d)
        return str_chars

float_repr_e_bias = int_from_num(1023)
float_repr_m_bits = int_from_num(52)
float_repr_m_min = int_from_num(4503599627370496)
float_repr_m_min_float = float_from_num(4503599627370496.0)
float_repr_m_max = int_from_num(9007199254740991)
float_repr_num_e_min = int_from_num(-1074)
float_repr_m_pos_min = int_from_num(4503599627370496)

def float_repr_decompose(x):
    """x: strictly positive finite float number"""

    def exp_form(x):
        if float_lt(x, float_from_num(1.0)):
            r = exp_form_neg(x, float_from_num(0.5), int_from_num(1))
            return float_mul(r[0], float_to_num(2.0)), int_sub(int_from_num(-1), r[1])
        else:
            return exp_form_pos(x, float_from_num(2.0), int_from_num(1))

    def exp_form_pos(x, y, i):
        i2 = int_mul(i, int_from_num(2))

        if int_ge(float_repr_e_bias, i2) and float_ge(x, y):
            r = exp_form_pos(x, float_mul(y, y), i2)
        else:
            r = (x, int_from_num(0))

        a = r[0]
        b = r[1]

        ib = int_add(i, b)

        if int_ge(float_repr_e_bias, ib) and float_ge(a, y):
            return float_div(a, y), ib
        else:
            return r

    def exp_form_neg(x, y, i):
        i2 = int_mul(i, int_from_num(2))

        if int_lt(i2, int_sub(float_repr_e_bias, int_from_num(1))) and float_lt(x, y):
            r = exp_form_neg(x, float_mul(y, y), i2)
        else:
            r = (x, int_from_num(0))

        a = r[0]
        b = r[1]
        ib = int_add(i, b)

        if int_lt(ib, int_sub(float_repr_e_bias, int_from_num(1))) and float_lt(a, y):
            return float_div(a, y), ib
        else:
            return r

    r = exp_form(float_abs(x))
    y = r[0]

    if float_lt(y, float_from_num(2.0)):
        return int_from_num(float_to_num(float_trunc(float_mul(r[0], float_repr_m_min_float)))), int_sub(r[1], float_repr_m_bits)
    else:
        if float_gt(y, float_from_num(0.0)):
            return float_repr_m_min, int_sub(int_add(float_repr_e_bias, int_from_num(1)), float_repr_m_bits) # inf
        else:
            return float_repr_m_max, int_sub(int_add(float_repr_e_bias, int_from_num(1)), float_repr_m_bits) # nanprint(float_decompose(0.0))

def float_repr_pow_mantissa_pair(v):
    x = float_repr_decompose(v)

    f = x[0]
    e = x[1]
    must_round = int_is_even(f)

    if int_is_neg(e):
        if int_ne(e, float_repr_num_e_min) and int_eq(f, float_repr_m_pos_min):
            return float_repr_scale(
                int_lshift(f, int_from_num(2)),
                int_lshift(int_from_num(1), int_sub(int_from_num(2), e)),
                int_from_num(2),
                int_from_num(1),
                must_round,
                v)
        else:
            return float_repr_scale(
                int_lshift(f, int_from_num(1)),
                int_lshift(int_from_num(1), int_sub(int_from_num(1), e)),
                int_from_num(1),
                int_from_num(1),
                must_round,
                v)
    else:
        _2_pow_e = int_lshift(int_from_num(1), e)
        if int_eq(f, float_repr_m_pos_min):
            return float_repr_scale(
                int_lshift(f, int_add(e, int_from_num(2))),
                int_from_num(4),
                int_lshift(int_from_num(1), int_add(e, int_from_num(1))),
                _2_pow_e,
                must_round,
                v)
        else:
            return float_repr_scale(
                int_lshift(f, int_add(e, int_from_num(1))),
                int_from_num(2),
                _2_pow_e,
                _2_pow_e,
                must_round,
                v)

def format_float_repr_pow(exponent):
    exponent_abs = -exponent if exponent < 0 else exponent
    return ("e-" if exponent < 0 else "e+") + ("0" if exponent_abs < 10 else "") + str(exponent_abs)

def format_float_repr(v):
    if float_is_nan(v):
        return "nan"

    sign = "-" if float_is_neg(v) else ""

    if float_is_infinite(v):
        return sign + "inf"
    elif float_is_zero(v):
        return sign + "0.0"

    abstract_exponent, digits = float_repr_pow_mantissa_pair(float_abs(v))
    exponent_inc = int_to_num(abstract_exponent)
    exponent = exponent_inc - 1

    m = []
    for d in digits:
        m.append(digit_to_char(d))

    if exponent >= 16:
        if len(m) == 1:
            return sign + m[0] + format_float_repr_pow(exponent)
        else:
            m[0] = m[0] + "."
            return sign + "".join(m) + format_float_repr_pow(exponent)
    elif exponent >= 0:
        m_len = len(m)
        if exponent_inc >= m_len:
            m = list_concat(m, list_new(exponent_inc - m_len, "0"))
            m.append(".0")
        else:
            m[exponent_inc] = "." + m[exponent_inc]
        return sign + "".join(m)
    elif exponent >= -4:
        return sign + "0." + "".join(list_new(-exponent_inc, "0")) + "".join(m)
    elif len(m) == 1:
        return sign + m[0] + format_float_repr_pow(exponent)
    else:
        m[0] = m[0] + "."
        return sign + "".join(m) + format_float_repr_pow(exponent)

def om_format_float_repr(self, rte):
    value = OM_get_boxed_value(self)
    return format_float_repr(value)

def om_float_repr_code(ctx, args):
    if len(args) == 1:
        self = args[0]
        result = om_format_float_repr(self, ctx.rte)
        return ctx.cont(ctx.rte, om_str(result))
    else:
        return sem_raise_with_message(ctx, class_TypeError, "expected 0 arguments, got " + str(len(args) - 1))

om_float_repr = do_magic_method(class_float, "__repr__", om_float_repr_code)

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
populate_builtin_range()
populate_builtin_slice()
populate_builtin_iterator()
populate_builtin_dict()
populate_builtin_module()
populate_builtin_NoneType()
populate_builtin_FunctionType() # type function

# Populate Exception classes
populate_builtin_BaseException()

# Builtin functions code

def om_breakpoint_code(rte, cont):
    def return_none(_):
        return unwindReturn(rte, om_None)

    frame = rte_stack(rte)
    parent_ast = frame_ast(frame)
    parent_rte = frame_rte(frame)

    # The rte is used to display the variables, so we provide the caller rte
    ctx = Context(parent_rte, return_none, parent_ast)

    return stmt_end_breakpoint(ctx)


def om_input_code(rte, cont):
    def return_value(rte1, obj_str):
        obj_str_value = OM_get_boxed_value(obj_str)
        # TODO: raise EOFError on EOF
        result = runtime_input(obj_str_value)
        if om_is(result, None):
            ctx = make_out_of_ast_context(rte, cont)
            return sem_raise(ctx, class_EOFError)
        else:
            return unwindReturn(rte1, om_str(result))

    obj = rte_lookup_locals(rte, 'obj')
    ctx = make_out_of_ast_context(rte, return_value)
    return sem_str(ctx, obj)

def gen_int_to_string_conv_code(radix, prefix):
    def conv_code(rte, cont):
        obj = rte_lookup_locals(rte, 'obj')
        obj_cls = OM_get_object_class(obj)
        if om_issubclass(obj_cls, class_int):
            obj_value = OM_get_boxed_value(obj)
            if int_is_nonneg(obj_value):
                result = prefix + int_to_string(obj_value, radix)
            else:
                result = "-" + prefix + int_to_string(int_neg(obj_value), radix)
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

def om_chr_code(rte, cont):
    obj = rte_lookup_locals(rte, "obj")
    if om_isinstance(obj, class_int):
        obj_value = OM_get_boxed_value(obj)
        if int_gt(obj_value, -1) and int_lt(obj_value,1114112):
            obj_int_val = int_to_num(obj_value)
            return unwindReturn(rte, om_str(chr(obj_int_val)))
        else:
            ctx = make_out_of_ast_context(rte, cont)
            return sem_raise_with_message(ctx, class_ValueError, "chr() arg not in range(0x110000)")
    else:
        ctx = make_out_of_ast_context(rte, cont)
        return sem_raise_with_message(ctx, class_TypeError, "an interger is required")

def om_ord_code(rte, cont):
    obj = rte_lookup_locals(rte, "obj")
    if om_isinstance(obj, class_str):
        obj_value = OM_get_boxed_value(obj)
        obj_value_len = len(obj_value)
        if obj_value_len == 1:
            obj_value_int = int_from_num(ord(obj_value))
            return unwindReturn(rte, om_int(obj_value_int))
        else:
            ctx = make_out_of_ast_context(rte, cont)
            return sem_raise_with_message(ctx, class_ValueError, "ord() expected a character, but string of length " + str(obj_value_len) + " found")
    else:
        ctx = make_out_of_ast_context(rte, cont)
        return sem_raise_with_message(ctx, class_TypeError, "ord() expected string of length 1")

def om_print_code(rte, _):
    args = rte_lookup_locals(rte, 'args')
    args_seq = OM_get_list_seq(args)
    args_len = len(args_seq)

    result = []
    for i in args_seq:
        result.append(None)

    def loop(rte, i):
        def print_value(rte, str_result):
            result[i] = OM_get_boxed_value(str_result)

            new_index = i + 1
            if new_index < args_len:
                return loop(rte, new_index)
            else:
                # sep=' '
                runtime_print(' '.join(result), rte)
                return unwindReturn(rte, om_None)

        next_ctx = make_out_of_ast_context(rte, print_value)
        return sem_str(next_ctx, args_seq[i])

    if args_len > 0:
        return loop(rte, 0)
    else:
        runtime_print('', rte)
        return unwindReturn(rte, om_None)

def om_alert_code(rte, _):
    obj = rte_lookup_locals(rte, "obj")
    def alert_str(rte, obj_str):
        obj_str_value = OM_get_boxed_value(obj_str)
        runtime_alert(obj_str_value)
        return unwindReturn(rte, om_None)

    ctx = make_out_of_ast_context(rte, alert_str)
    return sem_str(ctx, obj)

def om_confirm_code(rte, _):
    obj = rte_lookup_locals(rte, "obj")
    def confirm_dialog(rte, obj_str):
        obj_str_value = OM_get_boxed_value(obj_str)
        result = runtime_confirm(obj_str_value)
        return unwindReturn(rte, om_bool(result))

    ctx = make_out_of_ast_context(rte, confirm_dialog)
    return sem_str(ctx, obj)

def om_prompt_code(rte, _):
    obj = rte_lookup_locals(rte, "obj")
    def prompt_str(rte, obj_str):
        obj_str_value = OM_get_boxed_value(obj_str)
        result = runtime_prompt(obj_str_value)
        if om_is(result, None):
            return unwindReturn(rte, om_None)
        else:
            return unwindReturn(rte, om_str(result))

    ctx = make_out_of_ast_context(rte, prompt_str)
    return sem_str(ctx, obj)

def om_repr_code(rte, _):
    def cont(rte, res):
        return unwindReturn(rte, res)
    next_ctx = make_out_of_ast_context(rte, cont)
    return sem_repr(next_ctx, rte_lookup_locals(rte, 'obj'))

def om_len_code(rte, _):
    def cont(rte, res):
        return unwindReturn(rte, res)
    next_ctx = make_out_of_ast_context(rte, cont)
    return sem_len(next_ctx, rte_lookup_locals(rte, 'obj'))

def om_next_code(rte, _):
    def cont(rte, res):
        return unwindReturn(rte, res)
    next_ctx = make_out_of_ast_context(rte, cont)
    return sem_next(next_ctx, rte_lookup_locals(rte, 'obj'), rte_lookup_locals(rte, 'default'))

def om_iter_code(rte, _):
    next_ctx = make_out_of_ast_context(rte, unwindReturn)

    obj = rte_lookup_locals(rte, 'obj')
    sentinel = rte_lookup_locals(rte, 'sentinel')

    if sentinel is absent:
        return sem_iter(next_ctx, obj)
    else:
        return sem_raise(next_ctx, class_NotImplementedError)

def om_abs_code(rte, _):
    next_ctx = make_out_of_ast_context(rte, unwindReturn)

    obj = rte_lookup_locals(rte, 'obj')
    return sem_abs(next_ctx, obj)

def do_min_max(name, sem_Comp):
    expected_argument_error_msg = name + " expected 1 argument, got 0"
    empty_sequence_error_msg = name + "() arg is an empty sequence"

    def code(rte, cont):
        args = rte_lookup_locals(rte, 'args')
        args_elements = OM_get_tuple_seq(args)
        args_len = len(args_elements)
        if args_len == 0:
            return sem_raise_with_message(make_out_of_ast_context(rte, cont), class_TypeError, expected_argument_error_msg)
        elif args_len == 1:
            iterable = args_elements[0]
        else:
            iterable = args

        def loop_iterator(loop_iterator_rte, iterator):
            def get_first(get_first_rte, first_element):
                if first_element is for_loop_end_marker:
                    return sem_raise_with_message(make_out_of_ast_context(get_first_rte, cont), class_ValueError, empty_sequence_error_msg)
                candidate_ref = [first_element]
                def get_next(get_next_rte, next_element):
                    if next_element is for_loop_end_marker:
                        return cont_obj(make_out_of_ast_context(get_next_rte, unwindReturn), candidate_ref[0])
                    else:
                        def compare_candidates(compare_rte, res):
                            def pick_next_candidate(pick_rte, bool_res):
                                if om_is(bool_res, om_True):
                                    candidate_ref[0] = next_element
                                return sem_next(make_out_of_ast_context(pick_rte, get_next), iterator, for_loop_end_marker)
                            return sem_bool(make_out_of_ast_context(compare_rte, pick_next_candidate), res)
                        return sem_Comp(make_out_of_ast_context(get_next_rte, compare_candidates), next_element, candidate_ref[0])
                return sem_next(make_out_of_ast_context(get_first_rte, get_next), iterator, for_loop_end_marker)
            return sem_next(make_out_of_ast_context(loop_iterator_rte, get_first), iterator, for_loop_end_marker)
        return sem_iter(make_out_of_ast_context(rte, loop_iterator), iterable)

    return code

om_min_code = do_min_max("min", sem_Lt)
om_max_code = do_min_max("max", sem_Gt)

def om_round_code(rte, cont):
    number = rte_lookup_locals(rte, 'number')
    ndigits = rte_lookup_locals(rte, 'ndigits')

    # NOTE: sem_Round handles the case where ndigits is 'absent'
    return sem_Round(make_out_of_ast_context(rte, unwindReturn), number, ndigits)

def om_pow_code(rte, _):
    next_ctx = make_out_of_ast_context(rte, unwindReturn)

    base = rte_lookup_locals(rte, 'base')
    power = rte_lookup_locals(rte, 'power')
    mod = rte_lookup_locals(rte, 'mod')

    if mod is absent:
        return sem_Pow(next_ctx, base, power)
    else:
        return sem_PowMod(next_ctx, base, power, mod)

# Built-in Modules
def om_make_math_unary_real_function(fn_name, float_fn, arg):
    def float_code(rte, cont):
        val = rte_lookup_locals(rte, arg)

        def apply_float_fn(float_rte, float_val):
            if float_val is absent:
                return sem_raise_with_message(make_out_of_ast_context(float_rte, cont), class_TypeError, "must be real number")
            else:
                res = float_fn(OM_get_boxed_value(float_val))
                return unwindReturn(float_rte, om_float(res))

        return sem_maybe_float(make_out_of_ast_context(rte, apply_float_fn), val)

    return om_make_function_with_signature(fn_name, float_code, make_posonly_only_signature((arg,)))

def om_make_math_unary_real_to_int_function(fn_name, float_fn, arg):
    def float_code(rte, cont):
        val = rte_lookup_locals(rte, arg)

        def apply_float_fn(float_rte, float_val):
            if float_val is absent:
                return sem_raise_with_message(make_out_of_ast_context(float_rte, cont), class_TypeError, "must be real number")
            else:
                res = float_fn(OM_get_boxed_value(float_val))

                if float_is_infinite(res):
                    return sem_raise_with_message(make_out_of_ast_context(float_rte, cont), class_ValueError,
                                                         "cannot convert float infinity to integer")
                elif float_is_nan(res):
                    return sem_raise_with_message(make_out_of_ast_context(float_rte, cont), class_ValueError,
                                                  "cannot convert float NaN to integer")
                else:
                    int_res = int_from_num(float_to_num(res))
                    return unwindReturn(float_rte, om_int(int_res))

        return sem_maybe_float(make_out_of_ast_context(rte, apply_float_fn), val)

    return om_make_function_with_signature(fn_name, float_code, make_posonly_only_signature((arg,)))

def om_make_math_unary_real_domain_function(fn_name, float_fn, arg, arg_domain):
    def float_code(rte, cont):
        val = rte_lookup_locals(rte, arg)

        def apply_float_fn(float_rte, float_val):
            if float_val is absent:
                return sem_raise_with_message(make_out_of_ast_context(float_rte, cont), class_TypeError, "must be real number")
            else:
                float_unboxed_val = OM_get_boxed_value(float_val)

                if float_is_nan(float_unboxed_val):
                    return unwindReturn(float_rte, om_float(float_nan()))
                elif arg_domain(float_unboxed_val):
                    res = float_fn(OM_get_boxed_value(float_val))
                    return unwindReturn(float_rte, om_float(res))
                else:
                    return sem_raise_with_message(make_out_of_ast_context(float_rte, cont), class_ValueError, "math domain error")

        return sem_maybe_float(make_out_of_ast_context(rte, apply_float_fn), val)

    return om_make_function_with_signature(fn_name, float_code, make_posonly_only_signature((arg,)))

def make_math_domain_function(cmp, bound):
    float_bound = float_from_num(bound)
    return lambda x: cmp(x, float_bound)

def make_math_domain_range_function(cmp1, bound1, cmp2, bound2):
    float_bound1 = float_from_num(bound1)
    float_bound2 = float_from_num(bound2)
    return lambda x: cmp1(x, float_bound1) and cmp2(x, float_bound2)

def make_module_math():
    # NOTE: the math module does not generally defers to corresponding semantics.
    # By example, math.pow does not call __pow__ and __rpow__, instead it calls __float__ on both operands
    # and does a native float exponentiation. This behaviour is the same for most math methods.
    # This also means math methods always return floats and have different error than arithmetic semantics

    sqrt_domain = make_math_domain_function(float_ge, 0)
    om_math_sqrt = om_make_math_unary_real_domain_function("sqrt", float_sqrt, "x", sqrt_domain)

    om_math_floor = om_make_math_unary_real_to_int_function("floor", float_floor, "x")
    om_math_ceil = om_make_math_unary_real_to_int_function("ceil", float_ceil, "x")

    def math_pow_code(rte, cont):
        obj1 = rte_lookup_locals(rte, 'x')
        obj2 = rte_lookup_locals(rte, 'y')

        def check_obj1(obj1_rte, obj1_res):
            if obj1_res is absent:
                return sem_raise_with_message(make_out_of_ast_context(obj1_rte, cont), class_TypeError,
                                              "must be real number")
            else:
                def check_obj2(obj2_rte, obj2_res):
                    if obj2_res is absent:
                        return sem_raise_with_message(make_out_of_ast_context(obj2_rte, cont), class_ValueError,
                                                      "must be real number")
                    else:
                        float_res1 = OM_get_boxed_value(obj1_res)
                        float_res2 = OM_get_boxed_value(obj2_res)

                        res = float_pow(float_res1, float_res2)

                        if float_is_infinite(res):
                            return sem_raise_with_message(make_out_of_ast_context(obj2_rte, cont), class_OverflowError,
                                                          "math range error")
                        elif float_is_nan(res):
                            return sem_raise_with_message(make_out_of_ast_context(obj2_rte, cont), class_ValueError,
                                                          "math domain error")
                        else:
                            return unwindReturn(obj2_rte, om_float(res))

                return sem_maybe_float(make_out_of_ast_context(obj1_rte, check_obj2), obj2)
        return sem_maybe_float(make_out_of_ast_context(rte, check_obj1), obj1)

    # Exponentiation
    om_math_pow = om_make_function_with_signature("pow", math_pow_code, make_posonly_only_signature(("x", "y")))
    om_math_exp = om_make_math_unary_real_function("exp", float_exp, "x")

    # Logarithms
    log_domain = make_math_domain_function(float_gt, 0)
    om_math_log = om_make_math_unary_real_domain_function("log", float_log, "x", log_domain)
    om_math_log2 = om_make_math_unary_real_domain_function("log2", float_log2, "x", log_domain)
    om_math_log10 = om_make_math_unary_real_domain_function("log10", float_log10, "x", log_domain)

    log1p_domain = make_math_domain_function(float_gt, -1)
    om_math_log1p = om_make_math_unary_real_domain_function("log1p", float_log1p, "x", log1p_domain)

    # Trigonometry
    om_math_sin = om_make_math_unary_real_function("sin", float_sin, "x")
    om_math_cos = om_make_math_unary_real_function("cos", float_cos, "x")
    om_math_tan = om_make_math_unary_real_function("tan", float_tan, "x")

    inverse_trig_domain = make_math_domain_range_function(float_ge, -1, float_le, 1)
    om_math_asin = om_make_math_unary_real_domain_function("asin", float_asin, "x", inverse_trig_domain)
    om_math_acos = om_make_math_unary_real_domain_function("acos", float_acos, "x", inverse_trig_domain)
    om_math_atan = om_make_math_unary_real_function("atan", float_atan, "x")


    module_math_env = make_dict()

    # functions
    dict_set(module_math_env, 'sqrt', om_math_sqrt)
    dict_set(module_math_env, 'floor', om_math_floor)
    dict_set(module_math_env, 'ceil', om_math_ceil)
    dict_set(module_math_env, 'log', om_math_log)
    dict_set(module_math_env, 'log2', om_math_log2)
    dict_set(module_math_env, 'log10', om_math_log10)
    dict_set(module_math_env, 'log1p', om_math_log1p)
    dict_set(module_math_env, 'pow', om_math_pow)
    dict_set(module_math_env, 'exp', om_math_exp)
    dict_set(module_math_env, 'sin', om_math_sin)
    dict_set(module_math_env, 'cos', om_math_cos)
    dict_set(module_math_env, 'tan', om_math_tan)
    dict_set(module_math_env, 'asin', om_math_asin)
    dict_set(module_math_env, 'acos', om_math_acos)
    dict_set(module_math_env, 'atan', om_math_atan)

    # constants
    dict_set(module_math_env, 'pi', om_float(float_pi()))
    dict_set(module_math_env, 'e', om_float(float_e()))
    dict_set(module_math_env, 'inf', om_float(float_inf()))
    dict_set(module_math_env, 'nan', om_float(float_nan()))

    return om_module('math', module_math_env)

# init module turtle
def make_module_turtle():
    # returns unbox number or absent
    def convert_to_number(val):
        if om_isinstance(val, class_float):
            return float_to_num(OM_get_boxed_value(val))
        elif om_isinstance(val, class_int):
            return int_to_num(OM_get_boxed_value(val))
        else:
            return absent

    # Generate code for 0 argument native function
    def make_set_option_fn(fct, name):
        def code(rte, cont):
            fct(rte)
            return unwindReturn(rte, om_None)
        return om_make_function_with_signature(name, code, empty_signature)

    def make_translation_fn(fn, name, arg1_name, arg2_name):
        def code(rte, cont):
            arg1 = rte_lookup_locals(rte, arg1_name)
            arg2 = rte_lookup_locals(rte, arg2_name)

            def get_arg1_float(arg1_rte, arg1_float):
                def get_arg2_float(arg2_rte, arg2_float):
                    val1 = float_to_num(OM_get_boxed_value(arg1_float))
                    val2 = float_to_num(OM_get_boxed_value(arg2_float))

                    if not float_is_finite(val1) or not float_is_finite(val2):
                        return sem_raise_with_message(make_out_of_ast_context(arg2_rte, cont), class_ValueError, name + "() arguments must be finite numbers")
                    else:
                        fn(rte, val1, val2)
                        return unwindReturn(rte, om_None)

                return sem_float(make_out_of_ast_context(arg1_rte, get_arg2_float), arg2)
            return sem_float(make_out_of_ast_context(rte, get_arg1_float), arg1)
        return om_make_function_with_signature(name, code,
                                               make_posonly_defaults_signature((arg1_name, arg2_name),
                                                                               (om_float(float_from_num(0)),)))

    def clear_code(rte, cont):
        width = rte_lookup_locals(rte, 'width')
        height = rte_lookup_locals(rte, 'height')

        if width is absent:
            drawing_cs(rte)
            return unwindReturn(rte, om_None)
        elif height is absent:
            return sem_raise_with_message(make_out_of_ast_context(rte, cont), class_TypeError,
                                          'clear() expected 0 or 2 arguments, got 1')
        else:
            def get_width_float(width_rte, width_float):
                def get_height_float(height_rte, height_float):
                    width_val = float_to_num(OM_get_boxed_value(width_float))
                    height_val = float_to_num(OM_get_boxed_value(height_float))

                    if not float_is_finite(width_val) or not float_is_finite(height_val):
                        return sem_raise_with_message(make_out_of_ast_context(height_rte, cont),
                                                      class_ValueError,
                                                      "clear() arguments must be finite numbers")
                    else:
                        drawing_cs(rte, width_val, height_val)
                        return unwindReturn(rte, om_None)
                return sem_float(make_out_of_ast_context(width_rte, get_height_float), height)
            return sem_float(make_out_of_ast_context(rte, get_width_float), width)

    om_module_turtle_clear = om_make_function_with_signature('clear', clear_code,
                                                             make_posonly_defaults_only_signature(('width', 'height'),
                                                                                                  (absent, absent)))
    def goto_code(rte, cont):
        x = rte_lookup_locals(rte, 'x')
        y = rte_lookup_locals(rte, 'y')

        def get_x_float(x_rte, x_float):
            def get_y_float(y_rte, y_float):
                x_val = float_to_num(OM_get_boxed_value(x_float))
                y_val = float_to_num(OM_get_boxed_value(y_float))

                if not float_is_finite(x_val) or not float_is_finite(y_val):
                    return sem_raise_with_message(make_out_of_ast_context(y_rte, cont),
                                                  class_ValueError,
                                                  "goto() arguments must be finite numbers")
                else:
                    drawing_mv(y_rte, x_val, y_val)
                    return unwindReturn(rte, om_None)

            return sem_float(make_out_of_ast_context(x_rte, get_y_float), y)
        return sem_float(make_out_of_ast_context(rte, get_x_float), x)

    om_module_turtle_goto = om_make_function_with_signature('goto', goto_code, make_posonly_only_signature(('x', 'y')))

    def lt_code(rte, cont):
        angle = rte_lookup_locals(rte, 'angle')
        angle_value = convert_to_number(angle)
        if angle_value is absent:
            return sem_raise_with_message(make_out_of_ast_context(rte, cont), class_TypeError, "'angle' must be a 'int' or 'float'")
        else:
            drawing_lt(rte, angle_value)
            return unwindReturn(rte, om_None)

    def rt_code(rte, cont):
        angle = rte_lookup_locals(rte, 'angle')
        angle_value = convert_to_number(angle)
        if angle_value is absent:
            return sem_raise_with_message(make_out_of_ast_context(rte, cont), class_TypeError, "'angle' must be a 'int' or 'float'")
        else:
            drawing_rt(rte, angle_value)
            return unwindReturn(rte, om_None)

    def pencolor_code(rte, cont):
        r = rte_lookup_locals(rte, 'r')
        g = rte_lookup_locals(rte, 'g')
        b = rte_lookup_locals(rte, 'b')

        rval = convert_to_number(r)
        gval = convert_to_number(g)
        bval = convert_to_number(b)

        if rval is absent or gval is absent or bval is absent:
            return sem_raise_with_message(make_out_of_ast_context(rte, cont), class_TypeError, "'r', 'g' and 'b' must be a 'int' or 'float'")
        else:
            drawing_setpc(rte, rval, gval, bval)
            return unwindReturn(rte, om_None)

    def pensize_code(rte, cont):
        width = rte_lookup_locals(rte, 'width')
        width_value = convert_to_number(width)
        if width_value is absent:
            return sem_raise_with_message(make_out_of_ast_context(rte, cont), class_TypeError, "'width' must be a 'int' or 'float'")
        else:
            drawing_setpw(rte, width_value)
            return unwindReturn(rte, om_None)

    def write_code(rte, cont):
        text = rte_lookup_locals(rte, 'text')
        if om_isinstance(text, class_str):
            text_value = OM_get_boxed_value(text)
            drawing_drawtext(rte, text_value)
            return unwindReturn(rte, om_None)
        else:
            return sem_raise_with_message(make_out_of_ast_context(rte, cont), class_TypeError, "'text' must be of type 'str'")

    om_module_turtle_lt = om_make_function_with_signature('lt', lt_code,
                                                          make_posonly_only_signature(('angle',)))
    om_module_turtle_rt = om_make_function_with_signature('rt', rt_code,
                                                          make_posonly_only_signature(('angle',)))
    om_module_turtle_pencolor = om_make_function_with_signature('pencolor', pencolor_code,
                                                             make_posonly_only_signature(('r', 'g', 'b')))
    om_module_turtle_pensize = om_make_function_with_signature('pensize', pensize_code,
                                                             make_posonly_only_signature(('width',)))
    om_module_turtle_write = om_make_function_with_signature('write', write_code,
                                                                make_posonly_only_signature(('text',)))

    module_turtle_env = make_dict()
    om_module_turtle_st = make_set_option_fn(drawing_st, 'st')
    om_module_turtle_ht = make_set_option_fn(drawing_ht, 'ht')
    om_module_turtle_pu = make_set_option_fn(drawing_pu, 'pu')
    om_module_turtle_pd = make_set_option_fn(drawing_pd, 'pd')
    om_module_turtle_fd = make_translation_fn(drawing_fd, 'fd', 'xdist', 'ydist')
    om_module_turtle_bk = make_translation_fn(drawing_bk, 'bk', 'xdist', 'ydist')

    dict_set(module_turtle_env, 'clear', om_module_turtle_clear)
    dict_set(module_turtle_env, 'st', om_module_turtle_st)
    dict_set(module_turtle_env, 'ht', om_module_turtle_ht)
    dict_set(module_turtle_env, 'pu', om_module_turtle_pu)
    dict_set(module_turtle_env, 'pd', om_module_turtle_pd)
    dict_set(module_turtle_env, 'fd', om_module_turtle_fd)
    dict_set(module_turtle_env, 'bk', om_module_turtle_bk)
    dict_set(module_turtle_env, 'goto', om_module_turtle_goto)
    dict_set(module_turtle_env, 'lt', om_module_turtle_lt)
    dict_set(module_turtle_env, 'rt', om_module_turtle_rt)
    dict_set(module_turtle_env, 'pencolor', om_module_turtle_pencolor)
    dict_set(module_turtle_env, 'pensize', om_module_turtle_pensize)
    dict_set(module_turtle_env, 'write', om_module_turtle_write)

    return om_module('turtle', module_turtle_env)

def make_module_random():
    module_random_env = make_dict()

    def om_random_code(rte, _):
        result = runtime_random()
        return unwindReturn(rte, om_float(result))

    om_random_random = om_make_function_with_signature('random', om_random_code, empty_signature)

    dict_set(module_random_env, 'random', om_random_random)

    return om_module('random', module_random_env)


def make_module_time():
    module_time_env = make_dict()

    def om_sleep_code(rte, cont):
        secs = rte_lookup_locals(rte, 'secs')

        def return_none(_):
            return unwindReturn(rte, om_None)

        frame = rte_stack(rte)
        parent_ast = frame_ast(frame)
        parent_rte = frame_rte(frame)

        # The rte is used to display the variables, so we provide the caller rte
        sleep_ctx = Context(parent_rte, return_none, parent_ast)

        if om_isinstance(secs, class_float):
            sleep_time = float_to_num(OM_get_boxed_value(secs))
            if sleep_time < 0:
                return sem_raise_with_message(make_out_of_ast_context(rte, cont), class_ValueError,
                                              "sleep length must be non-negative")
            else:
                return stmt_end_with_sleep(sleep_ctx, sleep_time * 1000)
        else:
            def sleep_int_amount(int_rte, int_res):
                if int_res is absent:
                    return sem_raise_with_message(make_out_of_ast_context(int_rte, cont), class_TypeError,
                                                  "a number is required")
                else:
                    sleep_time = int_to_num(OM_get_boxed_value(int_res))
                    if sleep_time < 0:
                        return sem_raise_with_message(make_out_of_ast_context(int_rte, cont), class_ValueError,
                                                      "sleep length must be non-negative")
                    else:
                        return stmt_end_with_sleep(sleep_ctx, sleep_time * 1000)
            return sem_maybe_index(make_out_of_ast_context(rte, sleep_int_amount), secs)

    om_time_sleep = om_make_function_with_signature('sleep', om_sleep_code, make_posonly_only_signature(('secs',)))

    dict_set(module_time_env, 'sleep', om_time_sleep)

    return om_module('time', module_time_env)

# add the mouse event functions to a specify environment
def make_module_mouse():
    def getMouseX_code(rte, cont):
        if getMouseX is None:
            ctx = make_out_of_ast_context(rte, cont)
            return sem_raise(ctx, class_NotImplementedError)
        else:
            return unwindReturn(rte, om_int(getMouseX(rte)))

    def getMouseY_code(rte, cont):
        if getMouseY is None:
            ctx = make_out_of_ast_context(rte, cont)
            return sem_raise(ctx, class_NotImplementedError)
        else:
            return unwindReturn(rte, om_int(getMouseY(rte)))

    def getMouseDown_code(rte, cont):
        if getMouseDown is None:
            ctx = make_out_of_ast_context(rte, cont)
            return sem_raise(ctx, class_NotImplementedError)
        else:
            print(getMouseDown(rte))
            return unwindReturn(rte, om_bool(getMouseDown(rte)))

    module_mouse_env = make_dict()
    dict_set(module_mouse_env, 'getMouseX', om_make_function_with_signature('getMouseX', getMouseX_code, empty_signature))
    dict_set(module_mouse_env, 'getMouseY', om_make_function_with_signature('getMouseY', getMouseY_code, empty_signature))
    dict_set(module_mouse_env, 'getMouseDown', om_make_function_with_signature('getMouseDown', getMouseDown_code, empty_signature))
    return om_module('mouse', module_mouse_env)

# pixels graphics:
#   setScreenMode(width, height)
#   getScreenWidth()
#   getScreenHeight()
#   setPixel(x, y, color)
#   fillRectangle(x, y, color)
#   exportScreen()
#   getMouse()

# Interpreter
@nocompile
def interp_file(path, options):
    source = read_file(path)
    interp(parse(source, path, 'exec', False), options)

@nocompile
def read_file(path):
    with open(path, 'r') as f:
        content = f.read()
    return content

# used by pyinterp CLI
def default_compilation_error(start_line0,
                         start_column0,
                         end_line0,
                         end_column0, error_kind, msg):
    raise SyntaxError(msg + " at line " + str(end_line0))

def interp_source(src, options=None):
    if options is None:
        options = {}
    interp(parse(src, '<unknown>', 'exec', False), options)

def parse(source, filename, mode, context):
    return AST.parse(source, filename, mode, context)

def interp(ast, options):
    # TODO: move outside of this function
    safe_for_space = dict_get(options, 'safe_for_space', True)

    external_context = make_dict()
    dict_set(external_context, 'safe_for_space', safe_for_space)

    code = comp(ast, external_context)
    trampoline(prepare_execution(code, fresh_rte(options)))

def comp(ast, external_context):
    cte = CTE(None, make_dict(), [], None, None, external_context, None)

    if hasattr(ast, 'container'):
        container = ast.container
        filename = container.tostr if container.tostr is not False else None
    else:
        filename = None

    cte, code = comp_mod(cte, ast)

    return code

def prepare_execution(code, rte):
    return lambda: code(rte, lambda rte: None)

def module_to_dict(module):
    module_dict = OM_get(module, '__dict__')
    return OM_get_boxed_value(module_dict)

def inject_module_in_env(module, env):
    module_env = module_to_dict(module)
    for key_value in dict_items(module_env):
        key = key_value[0]
        value = key_value[1]
        dict_set(env, key, value)

def fresh_rte(options):
    locals_env = absent
    globals_env = make_dict()
    builtins_env = make_dict()

    rte = make_rte(absent, globals_env, locals_env, absent, builtins_env, absent, absent, absent, options)

    # Vanilla Python builtins
    om_builtin_print = om_make_function_with_signature('print', om_print_code, make_vararg_only_signature('args'))
    om_builtin_breakpoint = om_make_function_with_signature('breakpoint', om_breakpoint_code, empty_signature)
    om_builtin_input = om_make_function_with_signature('input', om_input_code, make_posonly_defaults_signature(('obj',), (om_str(''),)))
    om_builtin_hex = om_make_function_with_signature('hex', om_hex_code, make_posonly_only_signature(('obj',)))
    om_builtin_oct = om_make_function_with_signature('oct', om_oct_code, make_posonly_only_signature(('obj',)))
    om_builtin_bin = om_make_function_with_signature('bin', om_bin_code, make_posonly_only_signature(('obj',)))
    om_builtin_chr = om_make_function_with_signature('chr', om_chr_code, make_posonly_only_signature(('obj',)))
    om_builtin_ord = om_make_function_with_signature('ord', om_ord_code, make_posonly_only_signature(('obj',)))
    om_builtin_repr = om_make_function_with_signature('repr', om_repr_code, make_posonly_only_signature(('obj',)))
    om_builtin_len = om_make_function_with_signature('len', om_len_code, make_posonly_only_signature(('obj',)))
    om_builtin_next = om_make_function_with_signature('next', om_next_code,
                                                      make_posonly_defaults_signature(('obj', 'default'), (absent,)))
    om_builtin_iter = om_make_function_with_signature('iter', om_iter_code,
                                                      make_posonly_defaults_signature(('obj', 'sentinel'), (absent,)))
    om_builtin_abs = om_make_function_with_signature('abs', om_abs_code, make_posonly_only_signature(('obj',)))
    om_builtin_min = om_make_function_with_signature('min', om_min_code, make_vararg_only_signature('args'))
    om_builtin_max = om_make_function_with_signature('max', om_max_code, make_vararg_only_signature('args'))
    om_builtin_round = om_make_function_with_signature('round', om_round_code, make_posonly_defaults_signature(('number', 'ndigits'), (absent,)))
    om_builtin_pow = om_make_function_with_signature('pow', om_pow_code, make_posonly_defaults_only_signature(('base', 'power', 'mod'), (absent,)))

    dict_set(builtins_env, 'type', class_type)
    dict_set(builtins_env, 'object', class_object)
    dict_set(builtins_env, 'int', class_int)
    dict_set(builtins_env, 'float', class_float)
    dict_set(builtins_env, 'bool', class_bool)
    dict_set(builtins_env, 'str', class_str)
    dict_set(builtins_env, 'tuple', class_tuple)
    dict_set(builtins_env, 'list', class_list)
    dict_set(builtins_env, 'range', class_range)
    dict_set(builtins_env, 'NotImplemented', om_NotImplemented)
    dict_set(builtins_env, 'print', om_builtin_print)
    dict_set(builtins_env, 'breakpoint', om_builtin_breakpoint)
    dict_set(builtins_env, 'input', om_builtin_input)
    dict_set(builtins_env, 'hex', om_builtin_hex)
    dict_set(builtins_env, 'oct', om_builtin_oct)
    dict_set(builtins_env, 'bin', om_builtin_bin)
    dict_set(builtins_env, 'chr', om_builtin_chr)
    dict_set(builtins_env, 'ord', om_builtin_ord)
    dict_set(builtins_env, 'repr', om_builtin_repr)
    dict_set(builtins_env, 'len', om_builtin_len)
    dict_set(builtins_env, 'next', om_builtin_next)
    dict_set(builtins_env, 'iter', om_builtin_iter)
    dict_set(builtins_env, 'abs', om_builtin_abs)
    dict_set(builtins_env, 'min', om_builtin_min)
    dict_set(builtins_env, 'max', om_builtin_max)
    dict_set(builtins_env, 'round', om_builtin_round)
    dict_set(builtins_env, 'pow', om_builtin_pow)

    dict_set(builtins_env, 'BaseException', class_BaseException)
    dict_set(builtins_env, 'Exception', class_Exception)
    dict_set(builtins_env, 'NameError', class_NameError)
    dict_set(builtins_env, 'UnboundLocalError', class_UnboundLocalError)
    dict_set(builtins_env, 'SyntaxError', class_SyntaxError)
    dict_set(builtins_env, 'TypeError', class_TypeError)
    dict_set(builtins_env, 'ValueError', class_ValueError)
    dict_set(builtins_env, 'LookupError', class_LookupError)
    dict_set(builtins_env, 'IndexError', class_IndexError)
    dict_set(builtins_env, 'StopIteration', class_StopIteration)
    dict_set(builtins_env, 'ArithmeticError', class_ArithmeticError)
    dict_set(builtins_env, 'ZeroDivisionError', class_ZeroDivisionError)
    dict_set(builtins_env, 'AssertionError', class_AssertionError)

    # Pyinterp functions
    om_builtin_alert = om_make_function_with_signature('alert', om_alert_code, make_posonly_defaults_signature(('obj',), (om_str(''),)))
    om_builtin_confirm = om_make_function_with_signature('confirm', om_confirm_code, make_posonly_defaults_signature(('obj',), (om_str(''),)))
    om_builtin_prompt = om_make_function_with_signature('prompt', om_prompt_code, make_posonly_defaults_signature(('obj',), (om_str(''),)))

    dict_set(builtins_env, 'alert', om_builtin_alert)
    dict_set(builtins_env, 'confirm', om_builtin_confirm)
    dict_set(builtins_env, 'prompt', om_builtin_prompt)


    # Preloaded modules
    math_module = make_module_math()
    turtle_module = make_module_turtle()
    random_module = make_module_random()
    time_module = make_module_time()
    mouse_module = make_module_mouse()

    # Inject some module into the builtins
    dict_set(builtins_env, 'math', math_module)
    dict_set(builtins_env, 'mouse', mouse_module)
    dict_set(builtins_env, 'turtle', turtle_module)
    dict_set(builtins_env, 'time', time_module)

    inject_module_in_env(mouse_module, builtins_env)
    inject_module_in_env(random_module, builtins_env)
    inject_module_in_env(turtle_module, builtins_env)
    inject_module_in_env(time_module, builtins_env)

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
        sleep_time = dict_get(state, "sleep_time", None)
        error = dict_get(state, "error", None)
        cont = dict_get(state, "cont", None)
        ctx = dict_get(state, "ctx", None)

        if error is not None:
            print(error)
        if sleep_time is not None:
            runtime_sleep(sleep_time)
        if cont and rte_trace(ctx.rte) and msg is not None:
                if len(msg) > 0:
                    msg = ' '+msg

                print('at '+str(ast.lineno)+'.'+str(ast.col_offset+1)+'-'+str(ast.end_lineno)+'.'+str(ast.end_col_offset+1)+msg)


# Compilation of a module.

def set_ast_property(ast, name, value):
    props = getattr(ast, "_pyinterp", None)

    if props is None:
        props = make_dict()
        ast._pyinterp = props

    dict_set(props, name, value)

def get_ast_property(ast, name, default_):
    props = getattr(ast, "_pyinterp", None)

    if props is None:
        props = make_dict()
        ast.__pyinterp__ = props

    return dict_get(props, name, default_)


def walk(cte, ast, fn, args):
    # Hack to check child is an instance of AST while zp does not support class hierarchy
    if hasattr(ast, '_fields'):
        res = fn(cte, ast, args)
        # If fn return True continue walk, else abort recursive walk
        if res:
            for field in ast._fields:
                child = getattr(ast, field)

                if isinstance(child, list):
                    for item in child:
                        walk(cte, item, fn, args)
                else:
                    walk(cte, child, fn, args)

def walk_with_abort(cte, ast, fn, abort_fn, args):
    # Provides an 'abort' as first argument to 'fn' which call is detected to interrupt walk and return result
    # The provided abort function can only take a single argument, multiple arguments must be passed as a tuple
    error_occured = [False]
    abort_res = [None]

    def abort(args):
        error_occured[0] = True
        abort_res[0] = abort_fn(args)

    new_args = [abort]
    for a in args:
        new_args.append(a)

    def inner_walk(cte, ast, fn, args):
        if hasattr(ast, '_fields'):
            res = fn(cte, ast, args)

            if error_occured[0]:
                return

            # If fn return True continue walk, else abort recursive walk
            if res:
                for field in ast._fields:
                    child = getattr(ast, field)

                    if isinstance(child, list):
                        for item in child:
                            walk(cte, item, fn, args)
                            if error_occured[0]:
                                return
                    else:
                        walk(cte, child, fn, args)
                        if error_occured[0]:
                            return

    inner_walk(cte, ast, fn, new_args)
    return abort_res[0] if error_occured[0] else None

def raise_walk_syntax_error(args):
    cte, ast, msg = args
    return CT_raise_syntax_error_with_msg(cte, ast, msg)

# Flags for
LOCAL_VAR = ["LOCAL_VAR"]
CLOSURE_VAR = ["CLOSURE_VAR"]
GLOBAL_VAR = ["GLOBAL_VAR"]

def make_local_var_token(cte, name, current_fn):
    # Second element indicates if the variable needs to be boxed for a closure
    n_vars = get_ast_property(current_fn, 'n_vars', None)
    set_ast_property(current_fn, 'n_vars', n_vars + 1)

    locals_env = get_ast_property(current_fn, 'locals_env', None)

    # If safe_for_space is False, then box all variables by default
    tk = [LOCAL_VAR, not get_cte_safe_for_space(cte), n_vars]

    dict_set(locals_env, name, tk)
    return tk

def get_local_var_is_boxed(token):
    return token[1]

def get_local_var_index(token):
    return token[2]

def mark_local_var_token_as_boxed(token):
    token[1] = True

def is_local_var(token):
    return token[0] is LOCAL_VAR


def make_closure_var_token(id_, stack, current_fn):
    # This function both mutates the ast to add a free variable and return the created token or None
    # Exception: a nonlocal variable can be bound to a global variable when there is a 'global' statement for the var
    last = len(stack) - 1
    i = 0
    while i <= last:
        fn = stack[last - i]
        fn_locals_env = get_ast_property(fn, "locals_env", None) # Should never be None
        var_token = dict_get(fn_locals_env, id_, None)

        if var_token is not None:
            if is_local_var(var_token):
                mark_local_var_token_as_boxed(var_token)
            elif is_closure_var(var_token):
                pass
            else: # global variable case
                tk = make_global_var_token()
                dict_set(fn_locals_env, id_, tk)
                return tk

            j = 0
            while j < i:
                fn = stack[last - j]
                fn_locals_env = get_ast_property(fn, "locals_env", None)  # Should never be None

                fn_n_freevars = get_ast_property(fn, 'n_freevars', None)  # Should never be None
                set_ast_property(fn, 'n_freevars', fn_n_freevars + 1)

                tk = [CLOSURE_VAR, fn_n_freevars]
                dict_set(fn_locals_env, id_, tk)

                j += 1

            n_freevars = get_ast_property(current_fn, 'n_freevars', None)  # Should never be None
            set_ast_property(current_fn, 'n_freevars', n_freevars + 1)
            locals_env = get_ast_property(current_fn, 'locals_env', None)
            current_fn_tk = [CLOSURE_VAR, n_freevars]
            dict_set(locals_env, id_, current_fn_tk)

            return current_fn_tk

        else:
            i += 1
    return None

def is_closure_var(token):
    return token[0] is CLOSURE_VAR

def get_closure_var_index(token):
    return token[1]

def make_global_var_token():
    return [GLOBAL_VAR]

def is_global_var(token):
    return token[0] is GLOBAL_VAR

def init_compute_variables_scope(cte, ast):
    # Init computing variables scopes on function definitions, ignore variables since they are all global at top-level

    def walk_fn(cte, ast, args):
        if isinstance(ast, AST.FunctionDef):
            locals_env = make_dict()
            locals_ref = make_dict()
            stack = []
            function_defs = []

            res = compute_variables_scope(cte, ast, locals_env, locals_ref, stack)

            syntax_error = args[0]

            if res is not None:
                return syntax_error(res)
            else:
                return False
        else:
            return True

    return walk_with_abort(cte, ast, walk_fn, raise_walk_syntax_error, ())

def init_locals_env_from_args(cte, locals_env, current_fn):
    # Populate a function local cte with its arguments
    args = current_fn.args
    args_group = [args.args, args.posonlyargs, args.kwonlyargs]
    for group in args_group:
        for arg in group:
            name = arg.arg
            make_local_var_token(cte, name, current_fn)

    vararg = args.vararg
    kwarg = args.kwarg

    if vararg:
        make_local_var_token(cte, vararg.arg, current_fn)

    if kwarg:
        make_local_var_token(cte, kwarg.arg, current_fn)

    return locals_env

def compute_variables_scope(cte, ast, locals_env, locals_ref, stack):
    # Intermediate function which computes a function variables' scope, then recursively computes it for nested functions

    # init function variables counters and env
    set_ast_property(ast, 'n_freevars', 0)
    set_ast_property(ast, 'n_vars', 0)
    set_ast_property(ast, 'locals_env', locals_env)

    function_defs = []
    args = (locals_env, locals_ref, stack, function_defs, ast)

    init_locals_env_from_args(cte, locals_env, ast)

    for stmt in ast.body:

        res = walk_with_abort(cte, stmt, compute_function_variables_scope, raise_walk_syntax_error, args)

        # A syntax error was detected
        if res is not None:
            return res

    # Now that all assignations have been treated, we can determine the scope of variables' references

    for name in dict_keys(locals_ref):
        # If the variable is already in the env, we were able to determine its scope
        if not dict_has(locals_env, name):
            # else it is either from a closure or global
            closure_token = make_closure_var_token(name, stack, ast)

            if closure_token is None:
                # The variable can only be global since it is not local, nor in a closure
                dict_set(locals_env, name, make_global_var_token())
            # Else the closure token was already assigned

    # recursively visit nested functions which were collected in 'function_defs'
    for nested_fn in function_defs:
        nested_locals_env = make_dict()
        nested_locals_ref = make_dict()
        nested_stack = stack + [ast]

        res = compute_variables_scope(cte, nested_fn, nested_locals_env, nested_locals_ref, nested_stack)

        if res is not None:
            return res

    return None

def compute_function_variables_scope(cte, ast, args):
    syntax_error, locals_env, locals_ref, stack, function_defs, current_fn = args
    if isinstance(ast, AST.FunctionDef):
        # FunctionDef are treated recursively after the current scope has been analysed
        function_defs.append(ast)

        id_ = ast.name

        if not dict_has(locals_env, id_):
            make_local_var_token(cte, id_, current_fn)

        return False

    elif isinstance(ast, AST.Name):
        ctx = ast.ctx
        id_ = ast.id

        if isinstance(ctx, AST.Store):
            # If the variable is in locals_env, its scope is already known, this is a reassignment, else we mark it as local
            if not dict_has(locals_env, id_):
                make_local_var_token(cte, id_, current_fn)
        elif isinstance(ctx, AST.Load):
            # If the variable is in locals_env, its scope is already known
            # Else, we cannot determine its scope yet because there could be an assignation later
            # In both case, there is nothing to be done at that point but mark it as seen
            # See 'compute_variables_scope' for the rest of the analysis
            dict_set(locals_ref, id_, True)

        return True

    elif isinstance(ast, AST.Nonlocal):
        for id_ in ast.names:
            if dict_has(locals_env, id_) or dict_has(locals_ref, id_):
                return syntax_error((cte, ast, "name '" + id_ + "' is used prior to nonlocal declaration"))
            else:
                closure_token = make_closure_var_token(id_, stack, current_fn)
                if closure_token is None or is_global_var(closure_token):
                    # a 'nonlocal' statement cannot refer to a variable from a 'global' statement
                    return syntax_error((cte, ast, "no binding for nonlocal '" + id_ + "' found"))
                else:
                    dict_set(locals_env, id_, closure_token)
        return True

    elif isinstance(ast, AST.Global):
        for id_ in ast.names:
            if dict_has(locals_env, id_) or dict_has(locals_ref, id_):
                return syntax_error((cte, ast, "name '" + id_ + "' is used prior to global declaration"))
            else:
                dict_set(locals_env, id_, make_global_var_token())
        return True

    else:
        return True


def get_scope_variables(rte):

    def filter_scope(env):
        # Remove private names such as __name__ from displayed environment
        filtered_env = make_dict()
        for name in dict_keys(env):
            if len(name) < 2 or name[:2] != '__':
                dict_set(filtered_env, name, dict_get(env, name, None))
        return filtered_env

    current_func = rte_current_func(rte)
    safe_for_space = rte_safe_for_space(rte)

    if not safe_for_space:
        globals_ = rte_globals(rte)

        # In non-safe-for-space mode, each function has access to its whole lexical scope, we return it
        if current_func is absent:
            env = filter_scope(globals_)
        else:
            var_context = OM_get_function_var_context(current_func)
            filtered_globals = filter_scope(globals_)
            lexical_scope = OM_get_function_lexical_scope(current_func)
            locals_ = rte_locals(rte)
            env = make_dict()

            # Add non-shadowed global variables
            for name in dict_keys(filtered_globals):
                var_from_context = dict_get(var_context, name, None)
                is_global = var_from_context is not None and is_global_var(var_from_context)
                if not dict_has(lexical_scope, name) and not dict_has(locals_, name) or is_global:
                    val = dict_get(filtered_globals, name, None)
                    dict_set(env, name, val)

            # Add non-shadowed bound variables from the lexical scope which are not skipped by a 'global' statement
            for name in dict_keys(lexical_scope):
                var_from_context = dict_get(var_context, name, None)
                is_global = var_from_context is not None and is_global_var(var_from_context)
                if not dict_has(locals_, name) and not is_global:
                    val = dict_get(lexical_scope, name, None)[0] # All variables are boxed in non-safe-for-space mode
                    if val is not absent:
                        dict_set(env, name, val)

            # Add bound local variables to the environment
            for name in dict_keys(locals_):
                val = dict_get(locals_, name, None)[0] # All variables are boxed in non-safe-for-space mode
                if val is not absent:
                    dict_set(env, name, val)

    elif current_func is absent:
        # At top-level
        env = filter_scope(rte_globals(rte))
    else:
        local_vars = rte_locals(rte)
        global_vars = filter_scope(rte_globals(rte))
        closure = OM_get_function_closure(current_func)

        env = make_dict()

        var_context = OM_get_function_var_context(current_func)

        for key in dict_keys(var_context):
            var_val = dict_get(var_context, key, None)
            if is_local_var(var_val):
                boxed = get_local_var_is_boxed(var_val)
                if boxed:
                    val = dict_get(local_vars, key, None)[0]
                else:
                    val = dict_get(local_vars, key, None)
                if val is not absent:
                    dict_set(env, key, val)
            elif is_closure_var(var_val):
                index = get_closure_var_index(var_val)
                val = closure[index][0]
                if val is not absent:
                    dict_set(env, key, val)
            else: # case global
                val = dict_get(global_vars, key, absent)

                # NOTE: value may be absent because key is a builtin name
                if val is not absent:
                    dict_set(env, key, val)

    # Reverse the order so latest assignments come first
    # This will only work on Python and JS version which make_dict() is order preserving
    return list_reversed(dict_items(env))

def get_scope_variables_repr(rte):
    env = get_scope_variables(rte)
    env_repr = []

    for pair in env:
        key, val = pair
        val_repr = om_simple_repr(Context(rte, None, None), val)
        env_repr.append((key, val_repr))

    return env_repr

def comp_mod(cte, ast):

    if isinstance(ast, AST.Module):
        # Module(stmt* body, type_ignore *type_ignores)
        if debug: print('AST.Module')

        init_compute_variables_scope(cte, ast)

        return comp_stmt_seq(cte, ast.body)

    elif isinstance(ast, AST.Interactive):
        # Interactive(stmt* body)
        if debug: print('AST.Interactive')

        init_compute_variables_scope(cte, ast)

        return comp_stmt_seq(cte, ast.body)

    elif isinstance(ast, AST.Expression):
        # Expression(expr body)
        if debug: print('AST.Interactive')
        return CT_raise_syntax_error_with_msg(cte, ast, "AST.Expression not supported")

    else:
        return CT_raise_syntax_error_with_msg(cte, ast, "unknown ast type")
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

    elif isinstance(ast, AST.Nonlocal) or isinstance(ast, AST.Global):
        return gen_stmt_empty(cte)

    elif isinstance(ast, AST.Return):
        # Return
        if debug: print('AST.Return')

        # return point indicate that we are in a function
        # NOTE: inpired from codeboot JS
        depth_ast = CTCtrl_labelLookup(cte, "return point")
        if depth_ast is None:
            return CT_raise_syntax_error_with_msg(cte, ast, "'return' outside of function")
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
        return comp_Assign(cte, ast)

    elif isinstance(ast, AST.AugAssign):
        if debug: print("AST.AugAssign")
        target = ast.target
        if isinstance(target, AST.Name):
            op = ast.op
            target = ast.target
            value = ast.value
            return gen_aug_assign(cte, ast, target, op, value)
        else:
            return CT_raise_syntax_error_with_msg(cte, ast, "illegal expression for augmented assignment")


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
        return gen_assert(cte, ast)

    elif isinstance(ast, AST.FunctionDef):
        if debug: print('AST.FunctionDef')
        return gen_FunctionDef(cte, ast)

    elif isinstance(ast, AST.Delete):
        if debug: print('AST.Delete')
        return gen_delete_seq(cte, ast, ast.targets)

    elif isinstance(ast, AST.For) and isinstance(ast.target, AST.Name):
        # TODO: support else block
        if debug: print('AST.For')
        for_cte = CTCtrl_controlContext(cte, ast)
        return gen_for(for_cte, ast, ast.target, ast.iter, ast.body, ast.orelse)

    elif isinstance(ast, AST.Raise):
        if debug: print('AST.Raise')
        (cte1, code1) = comp_expr(cte, ast.exc)
        return gen_raise(cte1, ast, code1)

    else:
        return CT_raise_syntax_error_with_msg(cte, ast, "unsupported statements")



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
    elif isinstance(ast, AST.IfExp):
        (cte1, test_code) = comp_expr(cte, ast.test)
        (cte2, body_code) = comp_expr(cte1, ast.body)
        (cte3, orelse_code) = comp_expr(cte2, ast.orelse)
        return gen_ifexpr(cte3, ast, test_code, body_code, orelse_code)

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

        index_ast = ast.slice

        if isinstance(index_ast, AST.Index):
            index_cte, index_code = comp_expr(obj_cte, index_ast.value)
            return gen_Subscript_Load(index_cte, ast, obj_code, index_code)
        elif isinstance(index_ast, AST.Slice):
            slice_cte, slice_code = gen_Slice(obj_cte, index_ast)
            return gen_Subscript_Load(slice_cte, ast, obj_code, slice_code)
        else:
            return CT_raise_syntax_error_with_msg(cte, ast, "unsupported expression AST")
    else:
        return CT_raise_syntax_error_with_msg(cte, ast, "unsupported expression AST")

def comp_elements(cte, args):
    elements_code = []
    next_cte = cte
    for arg in args:
        next_cte, arg_code = comp_expr(next_cte, arg)
        elements_code.append(arg_code)

    return gen_elements_seq(next_cte, elements_code)


def comp_Assign(cte, ast):
    targets = ast.targets
    value = ast.value
    if len(targets) == 1:
        target = targets[0]
        if isinstance(target, AST.Name):
            id = ast.targets[0].id
            expr_cte, expr_code = comp_expr(cte, value)
            set_cte, set_code = gen_var_set(expr_cte, ast, id)

            def code(rte, cont):
                def do_set(set_rte, val):
                    return set_code(set_rte, cont, val)
                return expr_code(rte, do_set)

            return set_cte, code

        elif isinstance(target, AST.Subscript):
            return gen_Subscript_Store(cte, ast, target, value)
        elif isinstance(target, AST.Tuple):
            return gen_multiple_Assign(cte, ast, target.elts, value)
        else:
            return CT_raise_syntax_error_with_msg(cte, ast, 'Unsupported assignment')
    else:
        # NOTE: Not sure when this can happen
        return CT_raise_syntax_error_with_msg(cte, ast, 'Unknown assignment kind')

def gen_elements_seq(cte, elements_code):
    elements_len = len(elements_code)

    def do_elements_cont(cont):
        i = elements_len - 1
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

            cont = create_code(cont, i, current_element_code)
            i = i - 1
        return cont

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
        vararg = None

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
        kwarg = None

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

def do_stmt_end(cont, ast, nb_steps):
    return lambda rte: stmt_end(Context(rte, cont, ast), nb_steps)

def do_stmt_end_with_message(cont, ast):
    return lambda rte, msg: stmt_end_with_message(Context(rte, cont, ast), msg)

def do_expr_end(cont, ast):
    return lambda rte, val: expr_end(Context(rte, cont, ast), val)

def do_expr_end_with_step(cont, ast, nb_steps):
    return lambda rte, val: expr_end_with_step(Context(rte, cont, ast), val, nb_steps)

def do_expr_end_with_displayed_value(cont, ast, value):
    def reinject_val(val):
        return lambda rte, _: cont(rte, val)

    return lambda rte, val: expr_end(Context(rte, reinject_val(val), ast), value)

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
        return stmt_end(Context(rte, cont, ast), 1)

    return (cte, code)



def gen_while(cte, ast, code1, code2, code3):

    def code(rte, cont):
        def dispatch(rte1, val):
            if om_is(val, om_False):
                return code3(rte1, do_stmt_end(cont, ast, 0))
            else:
                ctrl_env = rte_ctrl_env(rte)
                ctrl_label = RTCtrlLabel(ctrl_env,
                                         lambda rte2: cont(rte2),
                                         lambda rte2: code(rte2, cont))
                new_rte = make_rte_from_new_ctrl_env(rte1, ctrl_label)
                return code2(new_rte, lambda rte2: code(unwind_rte_ctrl_env(rte2), cont))

        def cast_bool(rte, val):
            ctx = Context(rte, dispatch, ast)
            return sem_bool(ctx, val)

        return code1(rte, cast_bool)

    return (cte, code)



def gen_if(cte, ast, code1, code2, code3):

    def code(rte, cont):

        def dispatch(rte, val):
            stmt_end_cont = do_stmt_end(cont, ast, 0)
            if om_is(val, om_False):
                return code3(rte, stmt_end_cont)
            else:
                return code2(rte, stmt_end_cont)

        def cast_bool(rte, val):
            ctx = Context(rte, dispatch, ast)
            return sem_bool(ctx, val)

        return code1(rte, cast_bool)

    return (cte, code)



def gen_assert(cte, ast):
    test = ast.test
    msg = ast.msg

    test_cte, test_code = comp_expr(cte, test)
    msg_cte, msg_code = comp_expr_opt(test_cte, msg)

    if msg_code is None:
        def _throw(rte, cont):
            def do_throw(_):
                return sem_raise(Context(rte, cont, ast), class_AssertionError)
            return stmt_end_breakpoint(Context(rte, do_stmt_end(do_throw, ast, 1), ast))

        # NOTE: reassignment required due to a bug in zp function scoping
        throw_assert = _throw
    else:
        def _throw(rte, cont):
            def set_breakpoint(throw_rte, msg):
                def do_throw(_):
                    return sem_raise(Context(throw_rte, cont, ast), om_exception(class_AssertionError, om_tuple((msg,))))
                return stmt_end_breakpoint(Context(throw_rte, do_stmt_end(do_throw, ast, 1), ast))
            return msg_code(rte, set_breakpoint)
        # NOTE: reassignment required due to a bug in zp function scoping
        throw_assert = _throw

    def make_code(throw_assert):
        def code(rte, cont):
            def do_test(test_rte, test_val):
                def conditional_throw(assert_rte, test_bool):
                    if om_is(test_bool, om_True):
                        stmt_end = do_stmt_end(cont, ast, 0)
                        return stmt_end(assert_rte)
                    else:
                        return throw_assert(assert_rte, cont)
                return sem_bool(Context(test_rte, conditional_throw, test), test_val)
            return test_code(rte, do_test)
        return cte, code

    return make_code(throw_assert)

def gen_var_set(cte, ast, id):
    var_token = get_cte_locals_env_var(cte, id)

    if var_token is None or is_global_var(var_token):
        sem_set = sem_var_set_globals
    elif is_local_var(var_token):
        boxed = get_local_var_is_boxed(var_token)

        if boxed:
            sem_set = sem_var_set_local_boxed
        else:
            sem_set = sem_var_set_local

    else: # case: closure var
        closure_table = get_cte_closure_table(cte)
        closure_pos = dict_get(closure_table, id, None)

        def code(rte, cont, val):
            msg = id + " ← " + om_simple_repr(Context(rte, None, ast), val)
            cont_stmt_end_with_message = do_stmt_end_with_message(cont, ast)
            return sem_var_set_closure(Context(rte, lambda rte: cont_stmt_end_with_message(rte, msg), ast), closure_pos, val)
        return (cte, code)

    def code(rte, cont, val):
        msg = id + " ← " + om_simple_repr(Context(rte, None, ast), val)
        cont_stmt_end_with_message = do_stmt_end_with_message(cont, ast)
        return sem_set(Context(rte, lambda rte: cont_stmt_end_with_message(rte, msg), ast), id, val)
    return (cte, code)


def gen_FunctionDef(cte, ast):
    fn_def_cte, create_function = gen_create_function(cte, ast)
    set_cte, set_fn = gen_var_set(fn_def_cte, ast, ast.name)

    def code(rte, cont):
        def do_set(set_rte, fn):
            return set_fn(set_rte, cont, fn)
        return create_function(rte, do_set)

    return set_cte, code


def gen_create_function(cte, ast):

    def gen_function_freevar_getter(name):
        cte_locals_env = get_cte_locals_env(cte)
        tk = dict_get(cte_locals_env, name, None) # Cannot be None if properly called on a freevar

        if is_local_var(tk):
            def getter(rte):
                locals_= dict_get(rte, 'locals', None)
                return dict_get(locals_, name, None)
            return getter

        elif is_closure_var(tk):

            index = get_closure_var_index(tk)

            def getter(rte):
                current_func = dict_get(rte, 'current_func', None)
                closure_cells = OM_get_function_closure(current_func)
                return closure_cells[index]
            return getter

        else:
            assert False, "Variable does not exist in cte"

    fn_name = om_str(ast.name)

    # Create the closure variable table
    n_freevars = get_ast_property(ast, 'n_freevars', None)
    locals_env = get_ast_property(ast, 'locals_env', None)
    freevars_getter = list_new(n_freevars, None)
    closure_table = make_dict()
    local_vars = []

    for name in dict_keys(locals_env):
        var_token = locals_env[name]
        if is_closure_var(var_token):
            index = get_closure_var_index(var_token)
            freevars_getter[index] = gen_function_freevar_getter(name)
            dict_set(closure_table, name, index)
        elif is_local_var(var_token):
            local_vars.append((name, get_local_var_is_boxed(var_token)))

    def make_closure(rte):
        closure_cells = list_new(n_freevars, None)
        i = 0
        for getter in freevars_getter:
            closure_cells[i] = getter(rte)
            i += 1
        return closure_cells

    ids = make_dict()
    dict_set(ids, "return point", True)

    fn_cte = CTE(ast.name,
                 locals_env,
                 closure_table,
                 cte.lex_env,
                 CTCtrlLabel(None, ids, ast),
                 cte.external_context,
                 cte)

    (body_cte, body_code) = comp_stmt_seq(fn_cte, ast.body)

    # TODO: Once default arguments are implemented this will need to be partially at runtime
    signature = gen_signature(cte, ast)

    safe_for_space = get_cte_safe_for_space(cte)

    if safe_for_space:
        def create_function(rte, cont):
            func = om(class_function)
            OM_set(func, '__name__', fn_name)

            OM_set_function_signature(func, signature)
            OM_set_function_body(func, body_code)
            arity = signature_arity(signature)
            OM_set_function_arity(func, arity)
            OM_set_function_closure(func, make_closure(rte))
            OM_set_function_locals(func, local_vars)
            OM_set_function_var_context(func, locals_env)

            return cont(rte, func)

        return cte, create_function

    else:
        # In non safe-for-space mode, a function saves the whole lexical scope in which it was defined
        def create_function(rte, cont):
            func = om(class_function)
            OM_set(func, '__name__', fn_name)

            OM_set_function_signature(func, signature)
            OM_set_function_body(func, body_code)
            arity = signature_arity(signature)
            OM_set_function_arity(func, arity)
            OM_set_function_closure(func, make_closure(rte))
            OM_set_function_locals(func, local_vars)
            OM_set_function_var_context(func, locals_env)

            current_func = rte_current_func(rte)

            if current_func is absent:
                # top-level definition
                lexical_scope = make_dict()
            else:
                lexical_scope = dict_copy(OM_get_function_lexical_scope(current_func))

                # Add local variables
                locals_ = rte_locals(rte)
                for name in dict_keys(locals_):
                    val = dict_get(locals_, name, None)
                    # in non-safe-for-space mode, all variables should be boxed
                    dict_set(lexical_scope, name, val)

            OM_set_function_lexical_scope(func, lexical_scope)

            return cont(rte, func)


        return cte, create_function


def gen_multiple_Assign(cte, ast, targets, value):
    value_cte, value_code = comp_expr(cte, value)

    for targ in targets:
        if not isinstance(targ, AST.Name):
            return CT_raise_syntax_error_with_msg(cte, ast, "unsupported assignment")

    targets_len = len(targets)
    last_target_index = targets_len - 1

    setters = []
    last_assign_cte = value_cte
    for targ in targets:
        name = targ.id
        last_assign_cte, setter = gen_var_set(last_assign_cte, targ, name)
        setters.append(setter)

    def code(rte, cont):
        def unpack(unpack_rte, iterable):
            def start_assignments(start_assign_rte, seq):
                seq_len = len(seq)
                if targets_len == seq_len:
                    i = last_target_index
                    next_cont = cont
                    while i >= 0:
                        def make_code(i, next_cont):
                            def do_assign(assign_rte):
                                setter_code = setters[i]
                                val = seq[i]
                                return setter_code(assign_rte, next_cont, val)
                            return do_assign
                        next_cont = make_code(i, next_cont)
                        i -= 1
                    return next_cont(start_assign_rte)
                elif targets_len < seq_len:
                    return sem_raise_with_message(Context(start_assign_rte, cont, ast), class_ValueError, "too many values to unpack")
                else:
                    return sem_raise_with_message(Context(start_assign_rte, cont, ast), class_ValueError, "not enough values to unpack")
            return om_unpack_iterable(Context(unpack_rte, start_assignments, ast), iterable)
        return value_code(rte, unpack)
    return cte, code


def gen_var_get(cte, ast, id):
    var_token = get_cte_locals_env_var(cte, id)

    if var_token is None or is_global_var(var_token):
        def code(rte, cont):
            return sem_var_get_global(Context(rte, do_expr_end(cont, ast), ast), id)

        return (cte, code)
    elif is_local_var(var_token):
        boxed = get_local_var_is_boxed(var_token)

        if boxed:
            def code(rte, cont):
                return sem_var_get_local_boxed(Context(rte, do_expr_end(cont, ast), ast), id)

            return (cte, code)
        else:
            def code(rte, cont):
                return sem_var_get_local(Context(rte, do_expr_end(cont, ast), ast), id)

            return (cte, code)

    else: # case: closure var
        closure_table = get_cte_closure_table(cte)
        closure_pos = dict_get(closure_table, id, None)

        def code(rte, cont):
            return sem_var_get_closure(Context(rte, do_expr_end(cont, ast), ast), closure_pos, id)

        return (cte, code)

def gen_delete(cte, ast, expr):
    if isinstance(expr, AST.Name):
        (expr_cte, code) = comp_expr(cte, expr)

        def del_expr(rte, cont):
            return sem_var_del(Context(rte, do_stmt_end(cont, ast, 1), ast), expr.id)

        return (expr_cte, del_expr)
    else:
        return CT_raise_syntax_error_with_msg(cte, ast, "del: only supports var deletion")


def gen_delete_seq(cte, ast, targets):
    expr = targets[0]
    if len(targets) == 1:
        return gen_delete(cte, ast, expr)
    else:
        return CT_raise_syntax_error_with_msg(cte, ast, "del: multiple targets not yet supported.")

def gen_for(cte, ast, target, iterable_expr, body, orelse):

    iterable_cte, iterable_code = comp_expr(cte, iterable_expr)
    set_cte, set_code = gen_var_set(iterable_cte, target, target.id)
    body_cte, body_code = comp_stmt_seq(set_cte, body)
    orelse_cte, orelse_code = comp_stmt_seq(body_cte, orelse)

    def get_iterable(get_iterable_rte, cont):
        def get_iterator(get_iterator_rte, iterable):
            def get_next(get_next_rte, iterator):
                def assign_target(assign_target_rte, nxt_value):
                    if nxt_value is for_loop_end_marker:
                        def do_else(else_rte):
                            return orelse_code(else_rte, cont)
                        stmt_end_cont = do_stmt_end(do_else, ast, 0)
                        return stmt_end_cont(assign_target_rte)
                    else:
                        def run_body(rte):
                            ctrl_env = rte_ctrl_env(rte)
                            ctrl_label = RTCtrlLabel(ctrl_env,
                                                     lambda rte1: cont(rte1),
                                                     lambda rte1: get_next(rte1, iterator))
                            new_rte = make_rte_from_new_ctrl_env(rte, ctrl_label)
                            return body_code(new_rte, lambda rte: get_next(unwind_rte_ctrl_env(rte), iterator))
                        return set_code(assign_target_rte, run_body, nxt_value)
                return sem_next(Context(get_next_rte, assign_target, iterable_expr), iterator, for_loop_end_marker)
            return sem_iter(Context(get_iterator_rte, get_next, iterable_expr), iterable)
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
        return ctrl_env.break_cont(unwind_rte_ctrl_env(rte))
    return unwindBreakContinue(rte, depth, cont)

def unwindContinue(rte, depth):
    def cont(rte):
        ctrl_env = rte_ctrl_env(rte)
        return ctrl_env.continue_cont(unwind_rte_ctrl_env(rte))
    return unwindBreakContinue(rte, depth, cont)

def gen_break(cte, ast):
    depth_ast = CTCtrl_labelLookup(cte, "break point")
    if depth_ast is None:
        return CT_raise_syntax_error_with_msg(cte, ast, "'break' outside loop")
    else:
        def code(rte, _):
            depth = dict_get(depth_ast, 'depth', 0)
            ctx = Context(rte, lambda rte: unwindBreak(rte, depth), ast)
            return stmt_end(ctx, 1)
        return (cte, code)

def gen_continue(cte, ast):
    depth_ast = CTCtrl_labelLookup(cte, "break point")
    if depth_ast is None:
        return CT_raise_syntax_error_with_msg(cte, ast, "'continue' not properly in loop")
    else:
        def code(rte, _):
            depth = dict_get(depth_ast, 'depth', 0)
            ctx = Context(rte, lambda rte: unwindContinue(rte, depth), ast)
            return stmt_end(ctx, 1)
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
        def cast_bool(rte1, val1):
            def dispatch(rte2, cond_val):
                if om_is(cond_val, om_True):
                    return code2(rte2, cont)
                else:
                    return cont(rte2, val1)

            ctx = Context(rte, dispatch, ast)
            return sem_bool(ctx, val1)

        return code1(rte, cast_bool)

    return (cte, code)

def gen_logical_or(cte, ast, code1, code2):
    if debug: print('gen_logical_or')

    def code(rte, cont):
        def cast_bool(rte1, val1):
            def dispatch(rte2, cond_val):
                if om_is(cond_val, om_True):
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
        return CT_raise_syntax_error_with_msg(cte, ast, "unknown boolean operation")
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
        return CT_raise_syntax_error_with_msg(cte, ast, "unimplemented unary operator")

    def code(rte, cont):
        return code1(rte,
                lambda rte1, val1:
                    sem_op(Context(rte1, do_expr_end(cont, ast), ast), val1))

    return (cte, code)


def gen_aug_assign(cte, ast, target, op, value):
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
    elif isinstance(op, AST.LShift):
        sem_op = sem_ILShift
    elif isinstance(op, AST.RShift):
        sem_op = sem_IRShift
    elif isinstance(op, AST.BitAnd):
        sem_op = sem_IAnd
    elif isinstance(op, AST.BitOr):
        sem_op = sem_IOr
    elif isinstance(op, AST.BitXor):
        sem_op = sem_IXor
    elif isinstance(op, AST.Pow):
        sem_op = sem_IPow
    else:
        return CT_raise_syntax_error_with_msg(cte, ast, "Unimplemented assignment operator")

    id_ = target.id

    get_cte, get_target = gen_var_get(cte, target, id_)
    val_cte, val_code = comp_expr(get_cte, ast.value)
    set_cte, set_target = gen_var_set(val_cte, ast, id_)

    def code(rte, cont):
        def get_val(get_rte, target_val):
            def do_sem(val_rte, lhs_val):
                def do_set(set_rte, val):
                    return set_target(set_rte, cont, val)
                return sem_op(Context(val_rte, do_set, ast), target_val, lhs_val)
            return val_code(get_rte, do_sem)
        return get_target(rte, get_val)

    return set_cte, code


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
        sem_op = sem_And
    elif isinstance(op, AST.BitOr):
        sem_op = sem_Or
    elif isinstance(op, AST.BitXor):
        sem_op = sem_Xor
    elif isinstance(op, AST.Pow):
        sem_op = sem_Pow
    else:
        return CT_raise_syntax_error_with_msg(cte, ast, "unimplemented binary operator")

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
    elif isinstance(op, AST.Is):
        return sem_Is
    elif isinstance(op, AST.IsNot):
        return sem_IsNot
    elif isinstance(op, AST.In):
        sem_op = sem_Contains
    else:
        sem_op = None

    return sem_op


def make_Compare_pseudo_node(left, op, right):
    ast = Compare(left, [op], [right])
    ast.lineno = left.lineno
    ast.col_offset = left.col_offset
    ast.end_lineno = right.end_lineno
    ast.end_col_offset = right.end_col_offset

    # Special case which only happens in py.js
    if hasattr(left, 'container'):
        ast.container = left.container

    return ast


def gen_Compare(cte, ast, left, comparators, ops):
    ops_len = len(ops)
    left_cte, left_code = comp_expr(cte, left)

    comparators_code = []
    for expr in comparators:
        left_cte, expr_code = comp_expr(left_cte, expr)
        comparators_code.append(expr_code)

    sem_ops = []
    for op in ops:
        sem_ops.append(comp_Compare_Op(op))

    if len(comparators) > 1:
        pseudo_asts = []
        j = 0
        tmp_left = left
        while j < ops_len:
            tmp_op = ops[j]
            tmp_right = comparators[j]
            pseudo_node = make_Compare_pseudo_node(tmp_left, tmp_op, tmp_right)
            pseudo_asts.append(pseudo_node)
            tmp_left = tmp_right
            j += 1

        def do_chain_cont(end_chain_cont):
            next_cont = end_chain_cont
            init_i = ops_len - 1
            i = init_i

            while i >= 0:
                current_comparator_code = comparators_code[i]
                current_sem_op = sem_ops[i]
                current_pseudo_ast = pseudo_asts[i]

                def create_code(next_cont, current_comparator_code, current_sem_op, current_pseudo_ast, i):
                    def get_right_value(cont_rte, left_val):
                        def exec_comparison(compare_rte, right_val):
                            def check_result(result_rte, result):
                                def branch(branch_rte, bool_result):
                                    if i == init_i or om_is(bool_result, om_False):
                                        expr_end_cont = do_expr_end(end_chain_cont, current_pseudo_ast)
                                        return expr_end_cont(branch_rte, result)
                                    else:
                                        expr_end_cont = do_expr_end_with_displayed_value(next_cont, current_pseudo_ast,
                                                                                         result)
                                        return expr_end_cont(branch_rte, right_val)

                                return sem_bool(make_out_of_ast_context(result_rte, branch), result)

                            return current_sem_op(Context(compare_rte, check_result, current_pseudo_ast), left_val,
                                                  right_val)

                        return current_comparator_code(cont_rte, exec_comparison)

                    return get_right_value

                next_cont = create_code(next_cont, current_comparator_code, current_sem_op, current_pseudo_ast, i)
                i -= 1
            return next_cont

        def start_chain(rte, cont):
            expr_end_cont = do_expr_end(cont, ast)
            chain_cont = do_chain_cont(expr_end_cont)
            return left_code(rte, chain_cont)

        return left_cte, start_chain

    else:
        sem_op = sem_ops[0]
        right_code = comparators_code[0]

        def code(rte, cont):
            def get_left(left_rte, left_val):
                def get_right(right_rte, right_val):
                    expr_end_cont = do_expr_end(cont, ast)
                    return sem_op(Context(right_rte, expr_end_cont, ast), left_val, right_val)
                return right_code(left_rte, get_right)
            return left_code(rte, get_left)
        return left_cte, code


def sem_Is(ctx, val1, val2):
    result = om_is(val1, val2)
    return cont_bool(ctx, result)

def sem_IsNot(ctx, val1, val2):
    result = not om_is(val1, val2)
    return cont_bool(ctx, result)


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

def gen_sem_IOperator(method_name, sem_fall_back, op_name):
    def sem_IOp(ctx, self, other):
        def cont_raise_error(rte, result):
            if om_is(result, om_NotImplemented):
                return sem_raise_with_message(ctx, class_TypeError, "unsupported operand type(s) for " + op_name)
            else:
                return cont_obj(ctx, result)

        def cont_call_fallback(rte, result):
            if om_is(result, om_NotImplemented):
                return sem_fall_back(with_cont(ctx, cont_raise_error), self, other)
            else:
                return cont_obj(ctx, result)

        self_iop = getattribute_from_obj_mro(self, method_name)

        if self_iop is absent:
            return sem_fall_back(ctx, self, other)
        else:
            return om_call(self_iop, with_cont(ctx, cont_call_fallback), [self , other])
    return sem_IOp

sem_IAdd = gen_sem_IOperator("__iadd__", sem_Add, "+=")
sem_ISub = gen_sem_IOperator("__isub__", sem_Sub, "-=")
sem_IMul = gen_sem_IOperator("__imul__", sem_Mult, "*=")
sem_ITrueDiv = gen_sem_IOperator("__itruediv__", sem_TrueDiv, "/=")
sem_IFloorDiv = gen_sem_IOperator("__ifloordiv__",sem_FloorDiv,  "//=")
sem_IPow = gen_sem_IOperator("__ipow__", sem_Pow, "**=")
sem_IMod = gen_sem_IOperator("__imod__", sem_Mod, "%=")
sem_IAnd = gen_sem_IOperator("__iand__", sem_And, "&=")
sem_IOr = gen_sem_IOperator("__ior__", sem_Or, "|=")
sem_IXor = gen_sem_IOperator("__ixor__", sem_Xor, "^=")
sem_ILShift = gen_sem_IOperator("__ilshift__", sem_LShift, "<<=")
sem_IRShift = gen_sem_IOperator("__irshift__", sem_RShift, ">>=")


def sem_Not(ctx, obj):

    def flip(rte, res):
        if om_is(res, om_True):
            return ctx.cont(rte, om_False)
        else:
            return ctx.cont(rte, om_True)

    return sem_bool(with_cont(ctx, flip), obj)

def sem_repr(ctx, val1):
    val1_repr = getattribute_from_obj_mro(val1, '__repr__')

    def check_string(rte, res):
        if om_isinstance(res, class_str):
            return ctx.cont(rte, res)
        else:
            return sem_raise_with_message(ctx, class_TypeError, "__repr__ returned non-string")

    ctx1 = with_cont(ctx, check_string)
    return om_call(val1_repr, ctx1, [val1])

def sem_str(ctx, value):
    value_str = getattribute_from_obj_mro(value, "__str__")

    def check_string(rte, res):
        if om_isinstance(res, class_str):
            return ctx.cont(rte, res)
        else:
            return sem_raise_with_message(ctx, class_TypeError, "__str__ returned non-string")

    next_ctx = with_cont(ctx, check_string)
    return om_call(value_str, next_ctx, (value,))

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
            return ctx.cont(ctx.rte, om_iterator(obj, om_int(int_from_num(0))))
    else:
        return om_call(obj_iter, ctx, (obj,))

def sem_Contains_in_iterator(ctx, target, iterator):
    def get_next(rte, iterator):
        def compare(get_next_rte, get_next_val):
            if get_next_val is for_loop_end_marker:
                return ctx.cont(get_next_rte, om_False)
            else:
                def cont_eq(eq_rte, eq_result):
                    def cont(rte, bool_res):
                        if om_is(bool_res, om_True):
                            return ctx.cont(ctx.rte, om_True)
                        else:
                            return get_next(rte, iterator)
                    return sem_bool(Context(eq_rte, cont, ctx.ast), eq_result)
                return sem_Eq(Context(get_next_rte, cont_eq, ctx.ast), get_next_val, target)
        return sem_next(Context(rte, compare, ctx.ast), iterator, for_loop_end_marker)
    return get_next(ctx.rte, iterator)

def sem_Contains(ctx, target, obj):
    obj_contains = getattribute_from_obj_mro(obj, "__contains__")
    if obj_contains is absent:
        def cont(rte, it):
            return sem_Contains_in_iterator(Context(rte, ctx.cont, ctx.ast), target, it)
        return sem_iter(with_cont(ctx, cont), obj)
    else:
        return om_call(obj_contains, ctx, (obj, target))

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
        def check_result(result_rte, res):
            def check_range(range_rte, len_res):
                res_value = OM_get_boxed_value(res)
                if int_is_nonneg(res_value):
                    return cont_obj(ctx, res)
                else:
                    return sem_raise_with_message(ctx, class_ValueError, "__len__() should return >= 0")
            return sem_index(with_cont(ctx, check_range), res)
        return om_call(obj_len, with_cont(ctx, check_result), (obj,))

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

def sem_maybe_int(ctx, obj):
    obj_int = getattribute_from_obj_mro(obj, '__int__')

    if obj_int is absent:
        return ctx.cont(ctx.rte, absent)
    else:
        def check_int(rte, res):
            if om_isinstance(res, class_int):
                return ctx.cont(rte, res)
            else:
                return sem_raise_with_message(ctx, class_TypeError, "__int__ returned non-int")
        return om_call(obj_int, with_cont(ctx, check_int), [obj])

def sem_int(ctx, obj):
    def check_result(rte, res):
        if res is absent:
            return sem_raise_with_message(ctx, class_TypeError, "object cannot be interpreted as an integer")
        else:
            return cont_obj(ctx, res)
    return sem_maybe_int(with_cont(ctx, check_result), obj)

def sem_maybe_index(ctx, obj):
    obj_int = getattribute_from_obj_mro(obj, '__index__')

    if obj_int is absent:
        return ctx.cont(ctx.rte, absent)
    else:
        def check_int(rte, res):
            if om_isinstance(res, class_int):
                return ctx.cont(rte, res)
            else:
                return sem_raise_with_message(ctx, class_TypeError, "__index__ returned non-int")
        return om_call(obj_int, with_cont(ctx, check_int), [obj])

def sem_index(ctx, obj):
    def check_result(rte, res):
        if res is absent:
            return sem_raise_with_message(ctx, class_TypeError, "object cannot be interpreted as an integer")
        else:
            return cont_obj(ctx, res)
    return sem_maybe_index(with_cont(ctx, check_result), obj)

def sem_maybe_float(ctx, obj):
    obj_float = getattribute_from_obj_mro(obj, '__float__')

    if obj_float is absent:
        return ctx.cont(ctx.rte, absent)
    else:
        def check_float(rte, res):
            if om_isinstance(res, class_float):
                return ctx.cont(rte, res)
            else:
                return sem_raise_with_message(ctx, class_TypeError, "__float__ returned non-float")
        return om_call(obj_float, with_cont(ctx, check_float), [obj])

def sem_float(ctx, obj):
    def check_result(rte, res):
        if res is absent:
            return sem_raise_with_message(ctx, class_TypeError, "object cannot be interpreted as a float")
        else:
            return cont_obj(ctx, res)
    return sem_maybe_float(with_cont(ctx, check_result), obj)

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

def gen_Slice(cte, slice_ast):
    def do_None(rte, cont):
        return cont(rte, om_None)

    lower = slice_ast.lower
    upper = slice_ast.upper
    step = slice_ast.step

    if lower is not None:
        lower_cte, lower_code = comp_expr(cte, lower)
    else:
        lower_cte, lower_code = cte, do_None

    if upper is not None:
        upper_cte, upper_code = comp_expr(lower_cte, upper)
    else:
        upper_cte, upper_code = lower_cte, do_None

    if step is not None:
        step_cte, step_code = comp_expr(upper_cte, step)
    else:
        step_cte, step_code = upper_cte, do_None

    def do_slice(rte, cont):
        def get_lower(lo_rte, lo):
            def get_upper(up_rte, up):
                def get_step(st_rte, st):
                    return cont(st_rte, om_slice(lo, up, st))
                return step_code(up_rte, get_step)
            return upper_code(lo_rte, get_upper)
        return lower_code(rte, get_lower)

    return step_cte, do_slice

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
        return get_obj(rte, do_stmt_end(cont, ast, 1))

    return value_cte, code

def sem_constant(ctx, val):
    return ctx.cont(ctx.rte, val)

def sem_var_set_local(ctx, id, val):
    rte_set_locals(ctx.rte, id, val)
    return cont_no_val(ctx)

def sem_var_set_local_boxed(ctx, id, val):
    rte_set_locals_boxed(ctx.rte, id, val)
    return cont_no_val(ctx)

def sem_var_set_globals(ctx, id, val):
    rte_set_globals(ctx.rte, id, val)
    return cont_no_val(ctx)

def sem_var_set_closure(ctx, pos, val):
    rte_set_closure(ctx.rte, pos, val)
    return cont_no_val(ctx)

def sem_var_get_local(ctx, id):
    value = rte_lookup_locals(ctx.rte, id)

    if value is absent:
        return sem_raise_with_message(ctx, class_UnboundLocalError,
                                      "local variable '" + id + "' referenced before assignment")
    return cont_obj(ctx, value)

def sem_var_get_local_boxed(ctx, id):
    value = rte_lookup_locals_boxed(ctx.rte, id)

    if value is absent:
        return sem_raise_with_message(ctx, class_UnboundLocalError, "local variable '" + id + "' referenced before assignment")
    return cont_obj(ctx, value)


def sem_var_get_closure(ctx, pos, id):
    value = rte_lookup_closure(ctx.rte, pos)

    if value is absent:
        # TODO: recover closure variable name
        return sem_raise_with_message(ctx, class_NameError, "free variable '" + id + "' referenced before assignment in enclosing scope")
    else:
        return cont_obj(ctx, value)

def sem_var_get_global(ctx, id):
    def catch_AttributeError(rte, exn):
        if om_isinstance(exn, class_AttributeError):
            error_msg = "name '" + id + "' is not defined"
            return sem_raise_with_message(Context(rte, ctx.cont, ctx.ast), class_NameError, error_msg)
        else:
            return sem_raise(Context(rte, ctx.cont, ctx.ast), exn)

    value = rte_lookup_globals(ctx.rte, id)

    if value is absent:
        env_builtins = rte_lookup_globals(ctx.rte, '__builtins__')
        return sem_getattribute(with_catch(ctx, catch_AttributeError), [env_builtins, om_str(id)])
    else:
        return cont_obj(ctx, value)

def sem_var_del(ctx, id):
    return sem_raise(ctx, class_NotImplementedError)

def sem_bool(ctx, val):
    __val_bool__ = getattribute_from_obj_mro(val, '__bool__')
    if __val_bool__ is absent:
        def check_len(rte, res):
            if res is absent:
                return cont_obj(ctx, om_True)
            else:
                res_value = OM_get_boxed_value(res)
                return cont_bool(ctx, not int_is_zero(res_value))
        return sem_maybe_len(with_cont(ctx, check_len), val)
    else:
        def check_bool(rte, res):
            if om_is(res, om_True) or om_is(res, om_False):
                return cont_obj(ctx, res)
            else:
                return sem_raise_with_message(ctx, class_TypeError, "__bool__ should return bool")

        return om_call(__val_bool__, with_cont(ctx, check_bool), [val])


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

def gen_ifexpr(cte, ast, test_code, body_code, orelse_code):
    def code(rte, cont):
        expr_end_cont = do_expr_end_with_step(cont, ast, 0)
        def dispatch(rte, val):
            if om_is(val, om_True):
                return body_code(rte, expr_end_cont)
            else:
                return orelse_code(rte, expr_end_cont)

        def cast_bool(rte, val):
            ctx = Context(rte, dispatch, ast)
            return sem_bool(ctx, val)

        return test_code(rte, cast_bool)

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

def om_range_simple_repr(range_, rte):
    start = OM_get_range_start(range_)
    stop = OM_get_range_stop(range_)
    step = OM_get_range_step(range_)

    step_value = OM_get_boxed_value(step)

    if int_eq(step_value, int_from_num(1)):
        args = [start, stop]
    else:
        args = [start, stop, step]

    args_repr = []
    for arg in args:
        repr_ = om_simple_repr(make_out_of_ast_context(rte, None), arg)
        args_repr.append(repr_)

    return 'range(' + ', '.join(args_repr) + ')'


simple_repr_formatters = {
    "NoneType": om_format_NoneType_repr,
    "int": om_format_int_repr,
    "float": om_format_float_repr,
    "bool": om_format_bool_repr,
    "str": om_format_str_repr,
    "tuple": om_tuple_simple_repr,
    "list": om_list_simple_repr,
    "range": om_range_simple_repr,
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
    return return_to_trampoline(ctx.ast, '', 0, False, False, None, error, lambda: None, ctx)

def expr_end(ctx, val):
    return expr_end_with_step(ctx, val, 1)

def expr_end_with_step(ctx, val, nb_steps):
    if om_is(val, om_None):
        return return_to_trampoline(ctx.ast, om_simple_repr(ctx, val), nb_steps, False, False, None, None, lambda: ctx.cont(ctx.rte, val), ctx)
    else:
        return return_to_trampoline(ctx.ast, om_simple_repr(ctx, val), nb_steps, True, False, None, None, lambda: ctx.cont(ctx.rte, val), ctx)

def stmt_end(ctx, nb_steps):
    return return_to_trampoline(ctx.ast, '', nb_steps, False, False, None, None, lambda: ctx.cont(ctx.rte), ctx)

# XXX: Default nb_steps to 1 in stmt_end_with_message to minimise changes
def stmt_end_with_message(ctx, msg):
    return return_to_trampoline(ctx.ast, msg, 1, False, False, None, None, lambda: ctx.cont(ctx.rte), ctx)


def stmt_end_breakpoint(ctx):
    return return_to_trampoline(ctx.ast, '', 0, False, True, None, None, lambda: ctx.cont(ctx.rte), ctx)


def stmt_end_with_sleep(ctx, sleep_time):
    return return_to_trampoline(ctx.ast, '', 0, False, False, sleep_time, None, lambda: ctx.cont(ctx.rte), ctx)


def return_to_trampoline(ast, msg, nb_steps, display_result, breakpoint, sleep_time, error, cont, ctx):
    # return to trampoline with current execution state
    res = make_dict()
    dict_set(res, "ast", ast)
    dict_set(res, "msg", msg)
    dict_set(res, "nb_steps", nb_steps)
    dict_set(res, "display_result", display_result)
    dict_set(res, "breakpoint", breakpoint)
    dict_set(res, "sleep_time", sleep_time)
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

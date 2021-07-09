import ast, copy, itertools, logging, types

import config
import utils


def get_unique_name(name="var", _unique_name_counter=itertools.count()):
    return f"_{name}__{next(_unique_name_counter)}"


# ======================================================================================================================
#  Data model for partially evaluated values
# ======================================================================================================================

# The PPY or ppy prefix means "partial python". Value prefixed with ppy are object from the partial evaluator runtime

class PPYValue:
    def __init__(self, *, origin, context, type=None, **kwargs):
        super().__init__(**kwargs)
        self.origin = origin  # origin of the value in the ast
        self.context = context.copy() if context is not None else None  # copy of the context the value was computed in
        self.type = type

    @classmethod
    def with_type_only(cls, type):
        return cls(origin=None, context=None, type=type)


class PPYContainer:
    def __init__(self, *, items=None, **kwargs):
        super().__init__(**kwargs)
        self._items = items if items is not None else {}  # dict of attributes the container has after its evaluation

    def __getitem__(self, item):
        return self._items[item]

    def __setitem__(self, item, value):
        self._items[item] = value

    def __contains__(self, item):
        sentinel = object()
        return self.get(item, default=sentinel) is not sentinel

    def get(self, item, default=None):
        try:
            return self[item]
        except KeyError:
            return default

    def items(self):
        return self._items.items()


class PPYSingleton(PPYValue):
    def __init__(self, *, name=None, origin=None, context=None, type=None, **kwargs):
        self.name = name
        super().__init__(origin=origin, context=context, type=type, **kwargs)


class PPYFunction(PPYValue):
    pass


class PPYClosure(PPYFunction):
    def __init__(self, *, context, **kwargs):
        super().__init__(context=context, **kwargs)
        self.parent_rte = context


class PPYSemantics(PPYFunction):
    pass


class PPYClass(PPYValue, PPYContainer):
    def __init__(self, *, context, **kwargs):
        super().__init__(context=context, **kwargs)

        # Use Python host types to determine mro
        name = self.origin.name
        klass = type_name_to_python(name)
        mro = klass.mro()

        ppy_mro = []

        for k in mro:
            kname = k.__name__

            if kname == name:
                ppy_mro.append(self)
            else:
                ppy_mro.append(type_name_to_ppy(kname, context.modules))

        self.mro = ppy_mro


class PPYBaseModule(PPYContainer):
    pass


class PPYModule(PPYValue, PPYBaseModule):
    pass


# ======================================================================================================================
#  Runtime Environment for partial evaluation
# ======================================================================================================================

class ReturnKind:
    def __init__(self, kind, info=None, rte=None):
        self.kind = kind
        self.info = info
        self.rte = rte

    @classmethod
    def as_return(cls):
        return cls("return")

    @classmethod
    def as_assign(cls, name, rte):
        return cls("assign", name, rte)

    @classmethod
    def as_expr(cls):
        return cls("expr")

    @property
    def return_(self):
        return self.kind == "return"

    @property
    def assign(self):
        if self.kind == "assign":
            return self.info
        else:
            return False

    @property
    def expr(self):
        return self.kind == "expr"

    def do_return(self, value):
        if self.return_:
            return ast.Return(value)
        elif name := self.assign:
            self.rte[name] = value
            return ast.Assign([ast.Name(name, ast.Load())], value)
        elif self.expr:
            return value
        else:
            raise ValueError("wrong return kind")


class RTE:
    def __init__(self, modules, globals=None, locals=None, closure=None, return_kind=ReturnKind.as_return()):
        self.modules = modules
        self._locals = locals
        self._closure = closure
        self._globals = globals
        self.return_kind = return_kind

    def __getitem__(self, item):
        val = self._locals and self._locals.get(item) \
              or self._closure and self._closure.get(item) \
              or self._globals.get(item)
        if val:
            return val
        else:
            raise KeyError(item)

    def __setitem__(self, item, value):
        if self._locals is not None:
            self._locals[item] = value
        else:
            self._globals[item] = value

    def __contains__(self, item):
        sentinel = object()
        return self.get(item, default=sentinel) is not sentinel

    def get(self, item, default=None):
        try:
            return self[item]
        except KeyError:
            return default

    def copy(self):
        return RTE(self.modules,
                   globals=copy.copy(self._globals),
                   closure=copy.copy(self._closure),
                   locals=copy.copy(self._locals))

    def is_global(self):
        return self._locals is None

    def make_frame(self, closure=None, return_kind=ReturnKind.as_return()):
        return RTE(self.modules,
                   globals=self._globals,
                   locals={},
                   closure=closure,
                   return_kind=return_kind)


# ======================================================================================================================
#  Mock module for __compiler_intrinsics__
# ======================================================================================================================


class PPYIntrinsic:
    all_intrinsics = {}

    def __init__(self, name):
        self.name = name
        PPYIntrinsic.all_intrinsics[name] = self


ppy_intrinsic_absent = PPYIntrinsic("absent")
ppy_intrinsic_sint = PPYIntrinsic("sint")
ppy_intrinsic_bint = PPYIntrinsic("bint")
ppy_intrinsic_class_getattr = PPYIntrinsic("class_getattr")
ppy_intrinsic_define_semantics = PPYIntrinsic("define_semantics")
ppy_intrinsic_builtin = PPYIntrinsic("builtin")
ppy_intrinsic_private = PPYIntrinsic("private")
ppy_intrinsic_alloc = PPYIntrinsic("alloc")
ppy_intrinsic_py_int_from_host = PPYIntrinsic("py_int_from_host")
ppy_intrinsic_py_int_to_host = PPYIntrinsic("py_int_to_host")
ppy_intrinsic_py_float_from_host = PPYIntrinsic("py_float_from_host")
ppy_intrinsic_py_float_to_host = PPYIntrinsic("py_float_to_host")
ppy_intrinsic_py_bool_from_host_bool = PPYIntrinsic("py_bool_from_host_bool")
ppy_intrinsic_py_bool_to_host_bool = PPYIntrinsic("py_bool_to_host_bool")
ppy_intrinsic_py_str_to_host = PPYIntrinsic("py_str_to_host")
ppy_intrinsic_py_str_from_host = PPYIntrinsic("py_str_from_host")
ppy_intrinsic_py_str_len_to_host = PPYIntrinsic("py_str_len_to_host")

# TODO: replace semantics import with semantics
ppy_intrinsic_semantics_truth = PPYIntrinsic("semantics_truth")
ppy_intrinsic_semantics_maybe_to_int = PPYIntrinsic("semantics_maybe_to_int")
ppy_intrinsic_semantics_maybe_to_float = PPYIntrinsic("semantics_maybe_to_float")
ppy_intrinsic_semantics_maybe_index = PPYIntrinsic("semantics_maybe_index")
ppy_intrinsic_semantics_maybe_trunc = PPYIntrinsic("semantics_maybe_trunc")
ppy_intrinsic_semantics_big_index = PPYIntrinsic("semantics_big_index")

# do not make a copy of 'all_intrinsics', semantics are later loaded in intrinsics
ppy__compiler_intrinsics__ = PPYBaseModule(items=PPYIntrinsic.all_intrinsics)


# ======================================================================================================================
#  Evaluation of function specialization
# ======================================================================================================================

def partial_eval_function_call(fn, args, rte, return_kind=ReturnKind.as_return()):
    if isinstance(fn, PPYIntrinsic):
        yield from partial_eval_intrinsic_call(fn, args, rte, return_kind=return_kind)
    else:
        ast_args = fn.origin.args

        if ast_args.kwonlyargs or ast_args.kw_defaults:
            raise NotImplementedError("partial_eval only supports positional arguments")

        fn_args = ast_args.posonlyargs + ast_args.args

        if len(args) > len(fn_args):
            raise TypeError(
                f"partially evaluated function takes {len(fn_args)} context arguments, {len(args)} were given.")
        elif len(args) < len(fn_args):
            raise TypeError(
                f"partially evaluated function missing {len(fn_args) - len(args)} context arguments. Empty contexts must be given explicitly.")

        if isinstance(fn, PPYClosure):
            call_rte = rte.make_frame(closure=fn.parent_rte, return_kind=return_kind)
        else:
            call_rte = rte.make_frame(return_kind=return_kind)

        for fn_arg, callee_arg in zip(fn_args, args):
            call_rte[fn_arg.arg] = callee_arg

        yield from partial_eval_stmts(fn.origin.body, call_rte)


def partial_eval_intrinsic_call(fn, args, rte, return_kind=ReturnKind.as_return()):
    if fn is ppy_intrinsic_class_getattr:
        yield return_kind.do_return(intrinsic_eval_class_getattr_call(args, rte))
    else:
        raise NotImplementedError


# Evaluation of intrinsic calls
def intrinsic_eval_class_getattr_call(args, rte):
    # Assume correct arity
    obj = args[0]
    attr = args[1]

    if isinstance(obj, PPYValue):
        if isinstance(attr, ast.Constant) and isinstance(attr.value, str):
            type_ = rte.modules["builtins"]["int"] if obj.type in (ppy_intrinsic_sint, ppy_intrinsic_bint) else obj.type

            if type_ is None:
                raise NotImplementedError(f"partial_eval_class_getattr_call: could not resolve type")
            else:
                attr_name = attr.value

                for ppy_class in type_.mro:
                    attr = ppy_class.get(attr_name)

                    if attr is not None:
                        return attr

                return ppy_intrinsic_absent
        else:
            raise ValueError("partial_eval_class_getattr_call: second argument must be a string literal")
    else:
        raise NotImplementedError(
            "partial_eval_class_getattr_call: first argument must have been resolved to a ppy object")


# End of intrinsic calls


def partial_eval_stmts(stmts, rte):
    for stmt in stmts:
        yield from partial_eval_stmt(stmt, rte)

        if isinstance(stmt, ast.Return) or isinstance(stmt, ast.Raise):
            break


def partial_eval_stmt(stmt, rte):
    if isinstance(stmt, ast.If):
        yield from partial_eval_if(stmt, rte)
    elif isinstance(stmt, ast.Return):
        yield from partial_eval_return(stmt, rte)
    elif isinstance(stmt, ast.FunctionDef):
        partial_eval_def(stmt, rte)
        yield ast.Pass()  # in the context of behavior we do not consider functions as first class
    elif isinstance(stmt, ast.Assign):
        yield from partial_eval_assign(stmt, rte)
    elif isinstance(stmt, ast.Raise):
        yield ast.Raise(partial_eval_expr(stmt.exc, rte), None)
    else:
        yield stmt


def partial_eval_return(stmt, rte):
    value = stmt.value

    if isinstance(value, ast.Call):
        yield from partial_eval_return_tail_call(value, rte)
    else:
        ppy_expr = partial_eval_expr(value, rte)
        yield rte.return_kind.do_return(ppy_expr)


def partial_eval_expr_call(stmt, rte):
    raise NotImplementedError


def partial_eval_return_tail_call(call, rte):
    func = call.func
    args = [partial_eval_expr(a, rte) for a in call.args]
    if isinstance(func, ast.Name):
        name = func.id
        ppy_func = rte[name]
        yield from partial_eval_function_call(ppy_func, args, rte, return_kind=ReturnKind.as_return())
    else:
        yield ast.Return(ast.Call(func, args, call.keywords))


def partial_eval_assign_call(name, call, rte):
    func = call.func
    args = [partial_eval_expr(a, rte) for a in call.args]
    if isinstance(func, ast.Name):
        func_name = func.id
        ppy_func = rte[func_name]
        yield from partial_eval_function_call(ppy_func, args, rte, return_kind=ReturnKind.as_assign(name, rte))
    else:
        yield ast.Assign([ast.Name(name, ast.Load())], ast.Call(func, args, call.keywords))


def partial_eval_assign(assign, rte):
    if len(assign.targets) == 1 and isinstance(assign.targets[0], ast.Name):
        name = assign.targets[0].id
        value = assign.value
        if isinstance(value, ast.Call):
            yield from partial_eval_assign_call(name, value, rte)
        else:
            ppy_value = partial_eval_expr(value, rte)
            rte[name] = PPYValue(origin=ppy_value, context=rte)
            yield ast.Assign(assign.targets, ppy_value)
    else:
        raise NotImplementedError("Unsupported assignment to multiple targets or non name targets")


def partial_eval_if(stmt, rte):
    test_result = partial_eval_expr(stmt.test, rte)

    if isinstance(test_result, ast.Constant):
        if test_result.value:
            yield from partial_eval_stmts(stmt.body, rte)
        else:
            yield from partial_eval_stmts(stmt.orelse, rte)
    else:
        yield ast.If(test_result,
                     partial_eval_stmts(stmt.body, rte),
                     partial_eval_stmts(stmt.orelse, rte))


def partial_eval_name(name, rte):
    return rte[name.id]


def partial_eval_expr(expr, rte):
    if isinstance(expr, ast.Call):
        return partial_eval_expr_call(expr, rte)
    elif isinstance(expr, ast.Name):
        return partial_eval_name(expr, rte)
    elif isinstance(expr, ast.Compare):
        return partial_eval_compare(expr, rte)
    elif isinstance(expr, ast.BoolOp):
        return partial_eval_bool_op(expr, rte)
    elif isinstance(expr, ast.BinOp):
        return partial_eval_bin_op(expr, rte)
    elif isinstance(expr, ast.UnaryOp):
        return partial_eval_un_op(expr, rte)
    elif isinstance(expr, ast.Attribute):
        raise NotImplementedError
    else:
        return expr


def partial_eval_compare(cmp, rte):
    left = partial_eval_expr(cmp.left, rte)

    if len(cmp.comparators) > 1:
        raise NotImplementedError("partial_eval_compare: chain comparison not supported")
    else:
        op = cmp.ops[0]
        right = partial_eval_expr(cmp.comparators[0], rte)

        if isinstance(op, ast.Is):
            res = partial_eval_is(left, right, rte)
        elif isinstance(op, ast.IsNot):
            res = partial_eval_is_not(left, right, rte)
        elif isinstance(op, ast.Eq):
            res = partial_eval_eq(left, right, rte)
        elif isinstance(op, ast.NotEq):
            res = partial_eval_ne(left, right, rte)
        elif isinstance(op, ast.Lt):
            res = partial_eval_lt(left, right, rte)
        elif isinstance(op, ast.LtE):
            res = partial_eval_le(left, right, rte)
        elif isinstance(op, ast.Gt):
            res = partial_eval_gt(left, right, rte)
        elif isinstance(op, ast.GtE):
            res = partial_eval_ge(left, right, rte)
        else:
            res = None

        if res is None:
            return ast.Compare(left, [op], [right])
        else:
            return res


def partial_eval_is_not(left, right, ctx):
    is_res = partial_eval_is(left, right, ctx)

    if is_res:
        # an evaluation of is should always yield a bool
        if isinstance(is_res, ast.Constant):
            return ast.Constant(not is_res.value)
        else:
            return ast.UnaryOp(ast.Not, is_res)
    else:
        return None


def partial_eval_is(left, right, rte):
    if isinstance(left, ast.Name) and isinstance(right, ast.Name):
        left_var = rte.get(left.id)
        right_var = rte.get(right.id)

        if left_var and right_var:
            left_type = left_var.type
            right_type = right_var.type
            if left_type in (ppy_intrinsic_absent, ppy_NotImplemented) \
               or right_type in (ppy_intrinsic_absent, ppy_NotImplemented):
                # TODO: this assumption can be removed once we have more solid type-checking
                # absent and NotImplemented are singletons which should always be resolvable statically
                # if a type is unknown, we assume it was not absent or NotImplemented
                # this assumption can hold here because absent and NotImplemented values being returned by a semantics
                # or a dunder is never specific to a value, but always to a whole type
                return ast.Constant(left_type == right_type)
            if left_var.type is None is right_var.type and left_var.type != right_var.type:
                return ast.Constant(False)
            if isinstance(left_var.value, ast.Constant) and isinstance(right_var.value, ast.Constant):
                return ast.Constant(left_var.value.value is right_var.value.value)
    # Unresolved
    return None


# ======================================================================================================================
#  Evaluation of module top-level
# ======================================================================================================================

def load_module(name, module, sys_modules):
    rte = RTE(sys_modules)
    this_module = PPYModule(origin=module, context=rte)
    sys_modules[name] = this_module
    rte._globals = this_module

    if name == "builtins":
        # Load some extra builtin objects
        populate_builtins(this_module)

    for stmt in module.body:
        if isinstance(stmt, ast.FunctionDef):
            partial_eval_def(stmt, rte)
        elif isinstance(stmt, ast.ClassDef):
            partial_eval_class(stmt, rte)
        elif isinstance(stmt, (ast.Import, ast.ImportFrom)):
            partial_eval_import(stmt, rte)
        else:
            raise NotImplementedError("PPY: modules can only contain import or class and function definitions")


def partial_eval_def(func_def, rte):
    # TODO: Support closures
    decorators = func_def.decorator_list
    decorators_values = [partial_eval_expr(d, rte) for d in decorators]
    if ppy_intrinsic_define_semantics in decorators_values:
        ppy_func = PPYSemantics(origin=func_def, context=rte)
    elif rte.is_global():
        ppy_func = PPYFunction(origin=func_def, context=rte)
    else:
        ppy_func = PPYClosure(origin=func_def, context=rte)

    if any(not isinstance(d, PPYIntrinsic) for d in decorators_values):
        raise NotImplementedError("PPY: non-intrinsic decorators not supported")

    rte[func_def.name] = ppy_func


def partial_eval_class(class_def, rte):
    this_class = PPYClass(origin=class_def, context=rte)

    for stmt in class_def.body:
        if isinstance(stmt, ast.FunctionDef):
            this_class[stmt.name] = PPYFunction(origin=stmt, context=rte)
        elif isinstance(stmt, ast.Pass):
            pass
        else:
            raise NotImplementedError("PPY: classes can only contain method definitions")

    rte[class_def.name] = this_class


def partial_eval_import(import_stmt, rte):
    if isinstance(import_stmt, ast.ImportFrom):
        ppy_module = rte.modules[import_stmt.module]

        for alias in import_stmt.names:
            obj = ppy_module[alias.name]
            name = alias.asname or alias.name
            rte[name] = obj
    else:
        raise NotImplementedError("import [module]")


# ======================================================================================================================
#  Behavior computation wrappers
# ======================================================================================================================

def convert_expr_to_return_host_bool(expr):
    raise NotImplementedError


def convert_body_to_return_host_bool(body):
    if len(body) == 1:
        stmt = body[0]

        if isinstance(stmt, ast.Return):
            return [ast.Return(convert_expr_to_return_host_bool(stmt.value))]
        elif isinstance(stmt, ast.Raise):
            return body
        else:
            raise NotImplementedError(f"cannot convert body to a return-host-bool version, contains a {type(stmt)}")
    else:
        raise NotImplementedError("cannot convert body to a return-host-bool version due to len != 1")


def type_name_to_ppy(name, ppy_sys_modules):
    if name == "sint":
        return ppy_intrinsic_sint
    elif name == "bint":
        return ppy_intrinsic_bint
    elif name == "unknown":
        return None
    else:
        return ppy_sys_modules["builtins"][name]


def type_name_to_python(name):
    if name == "sint":
        return int
    elif name == "bint":
        return int
    elif name == "function":
        return types.FunctionType
    elif name == "method":
        return types.MethodType
    elif name == "range_iterator":
        return type(iter(range(42)))  # range_iterator
    else:
        return eval(name)


def make_ast_simple_arguments(*args_names, annotations=()):
    return ast.arguments([], [ast.arg(n, t, None) for n, t in zip(args_names, annotations)], None, [], [], None, [])


def compute_single_behavior(behavior_name, module_name, callee_name, types, as_test, ppy_sys_modules):
    module = ppy_sys_modules[module_name]
    callee = module[callee_name]

    rte = RTE(ppy_sys_modules, globals=module)

    if isinstance(callee, PPYClass):
        fn = callee["__new__"]
        args = [PPYValue.with_type_only(callee),
                *(PPYValue.with_type_only(type_name_to_ppy(t, ppy_sys_modules)) for t in types)]
    else:
        fn = callee
        args = [PPYValue.with_type_only(type_name_to_ppy(t, ppy_sys_modules)) for t in types]

    result_body = list(partial_eval_function_call(fn, args, rte))

    if as_test:
        result_body = convert_body_to_return_host_bool(result_body)

    args_names = [a.arg for a in fn.origin.args.args]
    annotations = [None if t == "unknown" else ast.Name(t, ast.Load()) for t in types]

    annotated_arguments = make_ast_simple_arguments(*args_names, annotations=annotations)

    return ast.FunctionDef(behavior_name,
                           annotated_arguments,
                           result_body,
                           [ast.Name("define_behavior", ast.Load())],
                           None,
                           None)


ppy_NotImplemented = PPYSingleton(name="NotImplemented")

def populate_builtins(ppy_builtin):
    ppy_builtin["object"] = PPYClass(context=None, origin=ast.parse("class object: pass").body[0])
    ppy_builtin["NotImplemented"] = ppy_NotImplemented


def compute_behaviors(semantics_file, builtins_file):
    # Builtin modules must be preloaded, there is no dynamic loading
    ppy_sys_modules = PPYContainer(items={"__compiler_intrinsics__": ppy__compiler_intrinsics__})

    # Preload builtins and semantics
    with open(semantics_file, 'r') as f:
        semantics_ast = ast.parse(f.read())

    load_module("semantics", semantics_ast, ppy_sys_modules)

    with open(builtins_file, 'r') as f:
        builtins_ast = ast.parse(f.read())

    load_module("builtins", builtins_ast, ppy_sys_modules)

    # Known intrinsics
    define_behavior = "define_behavior"
    other_intrinsics = "py_int_from_host, py_int_to_host, py_bool_to_host_int, py_float_from_host, " \
                       "py_float_to_host, py_sint_to_host, py_bint_to_host, py_bool_from_host_bool, " \
                       "py_bool_to_host_bool, py_str_from_host, py_str_to_host, py_str_len_to_host, alloc"

    result = f"from __compiler_intrinsics__ import {define_behavior}, {other_intrinsics}\n\n"

    for specializations in config.get_specializations():
        for behavior_name, types in specializations:
            behavior = compute_single_behavior(behavior_name,
                                               specializations.module,
                                               specializations.function,
                                               types,
                                               specializations.as_test,
                                               ppy_sys_modules)
            try:
                ast.fix_missing_locations(behavior)
                result += f"{ast.unparse(behavior)}\n\n"
            except Exception:
                logging.warning(f"ast.unparse failed to generate source for: {behavior.name}")
                raise

    return result


if __name__ == "__main__":
    print(compute_behaviors("out/semantics.py", "out/builtins.py"))

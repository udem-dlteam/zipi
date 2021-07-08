import ast, copy, logging

import config


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


class PPYFunction(PPYValue):
    pass


class PPYSemantics(PPYFunction):
    pass


class PPYClass(PPYValue, PPYContainer):
    pass


class PPYBaseModule(PPYContainer):
    pass


class PPYModule(PPYValue, PPYBaseModule):
    def remove_intrinsics_from_scope(self):
        # intrinsics are compiler directive, they should not be exported from a module's scope
        intrinsic_names = [name for name, value in self.items() if isinstance(value, PPYIntrinsic)]
        for name in intrinsic_names:
            del self._items[name]


# ======================================================================================================================
#  Runtime Environment for partial evaluation
# ======================================================================================================================

class ReturnKind:
    def __init__(self, kind, info=None):
        self.kind = kind
        self.info = info


class RTE:
    def __init__(self, modules, globals=None, locals=None, closure=None, return_kind=ReturnKind("return")):
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

    def make_frame(self, closure=None, return_kind=ReturnKind("return")):
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

def partial_eval_function_call(fn, args, rte):
    ast_args = fn.origin.args

    if ast_args.kwonlyargs or ast_args.kw_defaults:
        raise NotImplementedError("partial_eval only supports positional arguments")

    fn_args = ast_args.posonlyargs + ast_args.args

    if len(args) > len(fn_args):
        raise TypeError(f"partially evaluated function takes {len(fn_args)} context arguments, {len(args)} were given.")
    elif len(args) < len(fn_args):
        raise TypeError(
            f"partially evaluated function missing {len(fn_args) - len(args)} context arguments. Empty contexts must be given explicitly.")

    call_rte = rte.make_frame()

    for fn_arg, callee_arg in zip(fn_args, args):
        call_rte[fn_arg.arg] = callee_arg

    yield from partial_eval_stmts(fn.origin.body, rte)


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
        yield None  # TODO: in the context of behavior we do not consider functions as first class
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

        return_kind = rte.return_kind
        kind = return_kind.kind

        if kind == "return":
            yield ast.Return(ppy_expr)
        elif kind == "assignment":
            name = return_kind.info
            yield ast.Assign(ast.Name(name, ast.Load()), ppy_expr)
        else:
            raise ValueError("Unknown return kind")


def partial_eval_return_tail_call(call, rte):
    raise NotImplementedError


def partial_eval_assign(assign, rte):
    raise NotImplementedError


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
        return partial_eval_call(expr, rte)
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


# ======================================================================================================================
#  Evaluation of module top-level
# ======================================================================================================================

def load_module(name, module, sys_modules):
    rte = RTE(sys_modules)
    this_module = PPYModule(origin=module, context=rte)
    sys_modules[name] = this_module
    rte._globals = this_module

    for stmt in module.body:
        if isinstance(stmt, ast.FunctionDef):
            partial_eval_def(stmt, rte)
        elif isinstance(stmt, ast.ClassDef):
            partial_eval_class(stmt, rte)
        elif isinstance(stmt, (ast.Import, ast.ImportFrom)):
            partial_eval_import(stmt, rte)
        else:
            raise NotImplementedError("PPY: modules can only contain import or class and function definitions")

    this_module.remove_intrinsics_from_scope()


def partial_eval_def(func_def, rte):
    # TODO: Support closures
    decorators = func_def.decorator_list
    decorators_values = [partial_eval_expr(d, rte) for d in decorators]
    if ppy_intrinsic_define_semantics in decorators_values:
        ppy_func = PPYSemantics(origin=func_def, context=rte)
    else:
        ppy_func = PPYFunction(origin=func_def, context=rte)

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

    # TODO: load other modules here

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

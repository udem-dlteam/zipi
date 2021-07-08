import ast, copy


# ======================================================================================================================
#  Data model for partially evaluated values
# ======================================================================================================================

# The PPY or ppy prefix means "partial python". Value prefixed with ppy are object from the partial evaluator runtime

class PPYValue:
    def __init__(self, *, origin, context, **kwargs):
        super().__init__(**kwargs)
        self.origin = origin  # origin of the value in the ast
        self.context = context.copy()  # copy of the context the value was computed in


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


class RTE:
    def __init__(self, modules, globals=None, locals=None, closure=None):
        self._locals = locals
        self._closure = closure
        self._globals = globals

        self.modules = modules

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


# ======================================================================================================================
#  Mock module for __compiler_intrinsics__
# ======================================================================================================================


class PPYIntrinsic:
    all_intrinsics = {}

    def __init__(self, name):
        self.name = name
        PPYIntrinsic.all_intrinsics[name] = self


ppy_intrinsic_absent = PPYIntrinsic("absent")
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

def partial_eval_name(name, rte):
    # Inline only constants
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

# Builtin modules must be preloaded, there is no dynamic loading
ppy_sys_modules = PPYContainer(items={"__compiler_intrinsics__": ppy__compiler_intrinsics__})


def partial_eval_load_module(name, module, sys_modules):
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


def compute_behaviors(semantics_file, builtins_file):
    # Preload builtins and semantics
    with open(semantics_file, 'r') as f:
        semantics_ast = ast.parse(f.read())

    partial_eval_load_module("semantics", semantics_ast, ppy_sys_modules)

    with open(builtins_file, 'r') as f:
        builtins_ast = ast.parse(f.read())

    partial_eval_load_module("builtins", builtins_ast, ppy_sys_modules)



if __name__ == "__main__":
    compute_behaviors("out/semantics.py", "out/builtins.py")

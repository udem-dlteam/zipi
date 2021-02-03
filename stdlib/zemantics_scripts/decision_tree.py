#!/usr/bin/env python3

import argparse, ast, inspect, itertools, logging, operator, sys
from functools import wraps
from pprint import pprint
from types import ModuleType

import templates

import astor.code_gen


# ======================================================================================================================
#   Helpers
# ======================================================================================================================

def get_type_name(obj):
    return type(obj).__name__


def get_current_semantics_context(semantics_register):
    for frame in inspect.stack():
        function_name = frame.function
        if function_name in semantics_register:
            function = frame.frame.f_globals[function_name]
            signature = inspect.signature(function).parameters
            args = tuple(frame.frame.f_locals[name] for name in signature.keys())
            return function_name, args
    return None, None


# ======================================================================================================================
#   Semantics Instructions
# ======================================================================================================================

class Behavior:
    pass


class Procedure(Behavior):
    def __init__(self, semantics, method, semantics_args, method_args):
        self.semantics = semantics
        self.method = method
        self.semantics_args = semantics_args
        self.method_args = method_args

    def __repr__(self):
        method_qualname = self.method.__qualname__
        method_owner = method_qualname.split('.')[0]
        method_name_id = method_qualname.split(".")[1].replace('_', '')

        args_info = [get_type_name(a) + id_ for a, id_ in zip(self.semantics_args, 'XYZW')]
        args_types = '-'.join(args_info)
        return f"procedure:py-{method_owner}-{method_name_id}-{args_types}"

    @property
    def is_reflected_magic_method(self):
        # TODO: slightly hacky, but does the job for now
        method_args = self.method_args
        semantics_args = self.semantics_args

        # reflected method call are detected by the reversal of arguments
        # we must use 'is' because == is True for 1 and 1.0
        # it is okay to use 'is' because arguments come from the 'instances' global list
        # this may not work under other implementations than cPython
        return all(x is y for x, y in zip(method_args, reversed(semantics_args))) \
               and not any(x is y for x, y in zip(method_args, semantics_args))

    @property
    def is_comparison(self):
        return self.semantics in ("eq", "ne", "ge", "gt", "le", "lt")


class Error(Behavior):
    def __init__(self, exc):
        self.exc_type = type(exc)
        self.exc_args = exc.args

    def __repr__(self):
        return f"error:{self.exc_type(self.exc_args)}"

    @property
    def error_message(self):
        return str(self.exc_type(*self.exc_args))


# ======================================================================================================================
#   __compiler_intrinsics__ module
# ======================================================================================================================

def make_compiler_intrinsics_module():
    # Registers for this module
    semantics_register = {}
    decision_tree = {}

    def register_semantics(name, f):
        semantics_register[name] = f
        return f

    # Module attributes
    absent = object()

    def use_static_builtins(f):
        return f

    def use_simple_scoping(f):
        return f

    def define_semantics(f):
        # TODO: in some cases the semantics has a default behavior (ex: eq) undetected by the mock class_getattr
        # TODO: to fix we could decorate all sub-semantics to register their call in case no magic_method succeeded
        # TODO: this will be necessary once we generate behaviors for other types than numbers

        if f.__name__ in target_semantics:
            return register_semantics(f.__name__, f)
        else:
            return f

    def get_own_attr(obj, name):
        return obj.__dict__.get(name, None)

    def class_getattr(instance, name):
        cls = type(instance)

        for super_cls in cls.mro():
            attr = get_own_attr(super_cls, name)

            if attr is not None:

                @wraps(attr)
                def wrapped_method(*args):
                    """
                    Wrapper that registers behaviour of the recovered method
                    """

                    # Gather positional information: in which semantics is this method being called?
                    current_semantics, semantics_args = get_current_semantics_context(semantics_register)

                    # For which types is it being called?
                    decision_tree_branch = decision_tree.setdefault(current_semantics, {})
                    for argument in semantics_args[:-1]:
                        decision_tree_branch = decision_tree_branch.setdefault(get_type_name(argument), {})

                    last_type_name = get_type_name(semantics_args[-1])

                    res = attr(*args)

                    if res is not NotImplemented:
                        decision_tree_branch[last_type_name] = Procedure(current_semantics, attr, semantics_args, args)

                    return res

                return wrapped_method

        return absent

    # Create module
    _all = ["define_semantics", "use_static_builtins", "use_simple_scoping", "class_getattr", "absent"]
    _doc = "A mock version of __compiler_intrinsics__ which registers cPython method calls"

    module = ModuleType("__compiler_intrinsics__")

    module.__all__ = _all
    module.__doc__ = _doc

    for name in _all:
        setattr(module, name, locals()[name])

    return module, semantics_register, decision_tree


# ======================================================================================================================
#   decision tree
# ======================================================================================================================

def copy_type_behavior(decision_branch, source_type, target_type):
    if isinstance(decision_branch, dict):
        for type_name, behavior in decision_branch.items():
            copy_type_behavior(behavior, source_type, target_type)

        source_sub_branch = decision_branch[source_type]
        decision_branch[target_type] = source_sub_branch


def extend_decision_tree_with_specialized_types(decision_tree):
    for semantics, behaviors in decision_tree.items():
        for int_special in int_specialized_types:
            copy_type_behavior(behaviors, 'int', int_special)


def build_decision_tree(filename):
    compiler_intrinsics_module, semantics_register, decision_tree = make_compiler_intrinsics_module()

    with open(filename, 'r') as f:
        content = f.read()
        sys.modules["__compiler_intrinsics__"] = compiler_intrinsics_module

        exec(content, {})

    for name, semantics in semantics_register.items():
        signature = inspect.signature(semantics).parameters

        for left in instances:

            if len(signature) == 1:
                try:
                    semantics(left)
                except TypeError as e:
                    decision_tree.setdefault(name, {})[get_type_name(left)] = Error(e)
            elif len(signature) == 2:
                for right in instances:
                    try:
                        semantics(left, right)
                    except TypeError as e:
                        decision_tree.setdefault(name, {}).setdefault(get_type_name(left), {})[
                            get_type_name(right)] = Error(e)
            else:
                raise NotImplementedError(f"cannot handle semantics with {len(signature)} arguments")

    extend_decision_tree_with_specialized_types(decision_tree)
    return decision_tree


def main_tree(filename):
    pprint(build_decision_tree(filename))


# ======================================================================================================================
#   AST traversal
# ======================================================================================================================

class AstRegister(ast.NodeVisitor):
    def __init__(self, ast_):
        self._register = {}
        self.visit(ast_)

    def __getitem__(self, item):
        return self._register[item]

    def __setitem__(self, item, value):
        self._register[item] = value

    def get(self, item, default=None):
        try:
            return self.__getitem__(item)
        except AttributeError:
            return default


class MethodRegister(AstRegister):
    def __init__(self, ast_, classes):
        super().__init__(ast_)
        self.classes = classes

    def __getitem__(self, item):
        for base_name in self._register['__mro__']:
            base = self.classes[base_name]
            method = base._register.get(item)

            if method is not None:
                return method

        raise AttributeError(item)

    def visit_FunctionDef(self, node):
        self[node.name] = node


class ClassRegister(AstRegister):
    def visit_ClassDef(self, node):
        self[node.name] = MethodRegister(node, self)
        self[node.name]['__mro__'] = (node.name,) + tuple(t.id for t in node.bases)

    def get_by_qualname(self, qualname):
        cls_name, method_name = qualname.split('.')
        method_register = self.get(cls_name)
        return method_register.get(method_name) if method_register else None


class SemanticsRegister(AstRegister):
    def visit_FunctionDef(self, node):
        decorators = node.decorator_list
        if any(isinstance(d, ast.Name) and d.id == 'define_semantics' for d in decorators) and node.name in target_semantics:
            self[node.name] = node

    def iter_binary_semantics(self):
        for name, sem in self._register.items():
            if len(sem.args.args) == 2:
                yield name, sem

    def iter_unary_semantics(self):
        for name, sem in self._register.items():
            if len(sem.args.args) == 1:
                yield name, sem


class AstRenamer(ast.NodeVisitor):
    def __init__(self, table):
        self.table = table

    def visit_Name(self, node):
        node.id = self.table.get(node.id, node.id)


# ======================================================================================================================
#   Partial evaluation
# ======================================================================================================================

# Used by partial evaluator to preserve closure of a FunctionDef
class ClosureDef(ast.FunctionDef):
    def __init__(self, *args, closure=None):
        super().__init__(*args)
        self.closure = closure

    @classmethod
    def from_FunctionDef(cls, fd, ctx):
        cd = cls(*[getattr(fd, attr) for attr in ast.FunctionDef._fields], closure=ctx)
        return cd

    _fields = (
        'name',
        'args',
        'body',
        'decorator_list',
        'returns',
        'type_comment',
        'closure',
    )


class StaticValue(ast.Constant):
    _absent = object()

    def __init__(self, value):
        super().__init__(value)

    @classmethod
    def absent(cls):
        return cls(cls._absent)

    @classmethod
    def NotImplemented(cls):
        return cls(NotImplemented)


class StmtSequence(ast.stmt):
    def __init__(self, body):
        self.body = body

    _fields = (
        'body',
    )



# ======================================================================================================================
#   Partial evaluation
# ======================================================================================================================

class Unknown:
    def __repr__(self):
        return "<unknown>"


_unknown = Unknown()


class VarContext:
    def __init__(self, type=_unknown, value=_unknown):
        self._type = type
        self.value = value

        if isinstance(value, StaticValue):
            if value.value is StaticValue._absent:
                self._type = 'absent'
            elif value.value is NotImplemented:
                self._type = 'NotImplementedType'
            elif value.value in {int, bool, float, str}:
                self._type = "type"

    @property
    def type(self):
        return get_type_alias(self._type)

    @property
    def specialized_type(self):
        return self._type

    def __repr__(self):
        return f"VarContext(type={self.type} ({self.specialized_type}), value={self.value})"


class Context:
    def __init__(self, semantics, classes, closure=None):
        self._locals = {}
        self._closure = closure if closure is not None else {}
        self._globals = {
            'absent': VarContext(value=StaticValue.absent()),
            'NotImplemented': VarContext(value=StaticValue.NotImplemented()),
            'int': VarContext(value=StaticValue(int)),
            'bool': VarContext(value=StaticValue(bool)),
            'float': VarContext(value=StaticValue(float)),
            'str': VarContext(value=StaticValue(str)),
        }

        self.semantics = semantics
        self.classes = classes

    def __getitem__(self, item):
        loc = self._locals.get(item)
        clo = self._closure.get(item)
        glo = self._globals.get(item)

        val = loc or clo or glo
        if val:
            return val
        else:
            raise KeyError(item)

    def __setitem__(self, item, value):
        self._locals[item] = value

    def __contains__(self, item):
        try:
            self[item]
            return True
        except KeyError:
            return False

    def get(self, item, default=None):
        loc = self._locals.get(item)
        clo = self._closure.get(item)
        glo = self._globals.get(item)

        return loc or clo or glo or default

    def new(self):
        return Context(self.semantics, self.classes)

    def from_closure(self, closure):
        return Context(self.semantics, self.classes, closure=closure)


def partial_eval(fn_ast, semantics, classes, *args):
    ast_args = fn_ast.args

    if ast_args.kwonlyargs or ast_args.kw_defaults or ast_args.defaults:
        raise NotImplementedError("partial_eval only supports no-default positional arguments")

    # For now we assume only positional args
    fn_args = ast_args.posonlyargs + ast_args.args

    if len(args) > len(fn_args):
        raise TypeError(f"partially evaluated function takes {len(fn_args)} context arguments, {len(args)} were given.")
    elif len(args) < len(fn_args):
        raise TypeError(
            f"partially evaluated function missing {len(fn_args) - len(args)} context arguments. Empty contexts must be given explicitly.")

    ctx = Context(semantics, classes)

    for ctx_var, arg in zip(args, fn_args):
        ctx[arg.arg] = ctx_var

    body = fn_ast.body
    return partial_eval_body(body, ctx)


def partial_eval_body(body, ctx):
    result = []

    for stmt in partial_eval_stmts(body, ctx):
        result.append(stmt)
        if isinstance(stmt, ast.Return) or isinstance(stmt, ast.Raise):
            break

    return result


def partial_eval_stmts(stmts, ctx):
    for stmt in stmts:
        # filter out None which is a removed statement (assignment which was resolved)
        yield from filter(None, partial_eval_stmt(stmt, ctx))


def partial_eval_set(ctx, name, ast_val):
    if name in ctx:
        raise NotImplementedError(f"partial evaluation does not support re-assignation: {name}")
    elif isinstance(ast_val, ast.FunctionDef):
        ctx[name] = VarContext(type='function', value=ClosureDef.from_FunctionDef(ast_val, ctx))
    else:
        ctx[name] = VarContext(value=ast_val)

def partial_eval_stmt(stmt, ctx):
    if isinstance(stmt, ast.If):
        test_result = partial_eval_expr(stmt.test, ctx)

        if isinstance(test_result, ast.Constant):
            if test_result.value:
                yield from partial_eval_stmts(stmt.body, ctx)
            else:
                yield from partial_eval_stmts(stmt.orelse, ctx)
        else:
            yield ast.If(test_result,
                         partial_eval_body(stmt.body, ctx),
                         partial_eval_body(stmt.orelse, ctx))
    elif isinstance(stmt, ast.Return):
        value = stmt.value
        if isinstance(value, ast.Call):
            yield from partial_eval_return_tail_call(value, ctx)
        elif isinstance(value, ast.Name):
            var = ctx.get(value.id)
            if var:
                if isinstance(var.value, StmtSequence):
                    yield from var.value.body
                elif var.value is not _unknown:
                    yield ast.Return(var.value)
                else:
                    yield ast.Return(ast.Name(value.id))
            else:
                yield ast.Return(partial_eval_expr(value, ctx) if value is not None else value)
        else:
            yield ast.Return(partial_eval_expr(value, ctx) if value is not None else value)
    elif isinstance(stmt, ast.FunctionDef):
        partial_eval_set(ctx, stmt.name, stmt)
        yield None  # TODO: not ok in general, but should be in the case of behaviors where we inline local functions
    elif isinstance(stmt, ast.Assign):
        if len(stmt.targets) == 1 and isinstance(stmt.targets[0], ast.Name):
            expr = partial_eval_expr(stmt.value, ctx)
            partial_eval_set(ctx, stmt.targets[0].id, expr)
            yield None  # TODO: not ok in general, but should be in the case of behaviors
        else:
            raise NotImplementedError("Unsupported assignment to multiple targets or non name targets")
    elif isinstance(stmt, ast.Raise):
        yield ast.Raise(partial_eval_expr(stmt.exc, ctx), None)
    else:
        yield stmt


def partial_eval_expr(expr, ctx):
    if isinstance(expr, ast.Call):
        return partial_eval_call(expr, ctx)
    elif isinstance(expr, ast.Compare):
        return partial_eval_compare(expr, ctx)
    elif isinstance(expr, ast.BoolOp):
        return partial_eval_bool_op(expr, ctx)
    elif isinstance(expr, ast.BinOp):
        return partial_eval_bin_op(expr, ctx)
    elif isinstance(expr, ast.UnaryOp):
        return partial_eval_un_op(expr, ctx)
    elif isinstance(expr, ast.Attribute):
        obj = partial_eval_expr(expr.value, ctx)

        if isinstance(obj, ast.Name):
            var = ctx.get(obj.id)
            if var and isinstance(var.value, StaticValue):
                try:
                    attr = getattr(var.value.value, expr.attr)
                    if isinstance(attr, (int, float, str)):
                        return ast.Constant(attr)
                except AttributeError:
                    pass
        return ast.Attribute(obj, expr.attr, expr.ctx)
    else:
        return expr


def get_operator_from_ast(op):
    return {
        ast.Add: operator.add,
        ast.Sub: operator.sub,
        ast.Mult: operator.mul,
        ast.Div: operator.truediv,
        ast.FloorDiv: operator.floordiv,
    }.get(type(op))


def partial_eval_bin_op(expr, ctx):
    left = partial_eval_expr(expr.left, ctx)
    right = partial_eval_expr(expr.right, ctx)
    op = expr.op
    operator = get_operator_from_ast(op)

    if isinstance(left, ast.Constant) and isinstance(right, ast.Constant) and operator:
        return ast.Constant(operator(left.value, right.value))

    return ast.BinOp(left, op, right)


def partial_eval_un_op(expr, ctx):
    operand = partial_eval_expr(expr.operand, ctx)
    return ast.UnaryOp(expr.op, operand)


def partial_eval_bool_op(expr, ctx):
    op = expr.op
    values = [partial_eval_expr(e, ctx) for e in expr.values]

    evaluated_values = []

    # TODO: this is not exactly correct. For example, 'foo or True' will return foo even if foo is falsy.
    # TODO: this is ok for the current usage of partial evaluation, but could be improved once we have some time
    if isinstance(op, ast.And):
        for val in values:
            if isinstance(val, ast.Constant):
                if not val.value:
                    return val
            else:
                evaluated_values.append(val)

    elif isinstance(op, ast.Or):
        for val in values:
            if isinstance(val, ast.Constant):
                if val.value:
                    return val
            else:
                evaluated_values.append(val)
    else:
        raise NotImplementedError(f"missing partial_eval implementation for {type(op).__name__}")

    if not evaluated_values:
        # All values were evaluated, return the last one
        return val
    elif len(evaluated_values) == 1:
        return evaluated_values[0]
    else:
        return ast.BoolOp(op, evaluated_values)


def partial_eval_call(call, ctx):
    func = partial_eval_expr(call.func, ctx)
    args = [partial_eval_expr(arg, ctx) for arg in call.args]

    if isinstance(func, ast.Name):
        result = partial_eval_static_function_call(func.id, args, call.keywords, ctx)

        if isinstance(result, StmtSequence):
            body = result.body

            if len(body) == 1 and isinstance(body[0], ast.Return):
                return body[0].value
            else:
                return result
        else:
            return result
    else:
        return ast.Call(func, args, call.keywords)


def ast_always_returns(node):
    # TODO: does not cover all forms (missing: With, Try, AsyncFor, AsyncWith)
    if isinstance(node, list):
        return any(ast_always_returns(n) for n in node)
    elif isinstance(node, (ast.Return, ast.Raise)):
        return True
    elif isinstance(node, ast.For):
        return ast_always_returns(node.body) and ast_always_returns(node.orelse)
    elif isinstance(node, ast.If):
        return ast_always_returns(node.body) and ast_always_returns(node.orelse)
    elif isinstance(node, ast.While):
        return ast_always_returns(node.body) and ast_always_returns(node.orelse)
    else:
        return False


def partial_eval_return_tail_call(call, ctx):
    func = partial_eval_expr(call.func, ctx)
    args = [partial_eval_expr(arg, ctx) for arg in call.args]

    if isinstance(func, ast.Name):
        result = partial_eval_static_function_call(func.id, args, call.keywords, ctx)

        if isinstance(result, StmtSequence):
            yield from result.body
            if not ast_always_returns(result.body):
                yield ast.Return(None)
        else:
            yield ast.Return(result)
    else:
        yield ast.Return(ast.Call(func, args, call.keywords))


def partial_eval_compare(cmp, ctx):
    left = partial_eval_expr(cmp.left, ctx)

    if len(cmp.comparators) > 1:
        raise NotImplementedError("partial_eval_compare: chain comparison not supported")
    else:
        op = cmp.ops[0]
        right = partial_eval_expr(cmp.comparators[0], ctx)

        if isinstance(op, ast.Is):
            res = partial_eval_is(left, right, ctx)
        elif isinstance(op, ast.Eq):
            res = partial_eval_eq(left, right, ctx)
        elif isinstance(op, ast.NotEq):
            res = partial_eval_ne(left, right, ctx)
        else:
            res = None

        if res is None:
            return ast.Compare(left, [op], [right])
        else:
            return res


def partial_eval_is(left, right, ctx):
    if isinstance(left, ast.Name) and isinstance(right, ast.Name):
        left_var = ctx.get(left.id)
        right_var = ctx.get(right.id)

        if left_var and right_var:
            left_type = left_var.type
            right_type = right_var.type
            if left_type in ("absent", "NotImplementedType") or right_type in ("absent", "NotImplementedType"):
                # TODO: this assumption can be removed once we have more solid type-checking
                # 'absent' and 'NotImplemented' are singletons which should always be resolved statically
                return ast.Constant(left_type == right_type)
            if left_var.type != _unknown != right_var.type and left_var.type != right_var.type:
                return ast.Constant(False)
            if isinstance(left_var.value, ast.Constant) and isinstance(right_var.value, ast.Constant):
                return ast.Constant(left_var.value.value is right_var.value.value)
            else:
                # Unresolved
                return None
        else:
            # Unresolved
            return None
    else:
        # Unresolved
        return None


def partial_eval_eq(left, right, ctx):
    if isinstance(left, ast.Constant):
        if isinstance(right, ast.Constant):
            return ast.Constant(left.value == right.value)
        else:
            return partial_eval_eq(right, left, ctx)
    elif isinstance(right, ast.Constant):
        if right.value == 0 and isinstance(left, ast.Name):
            left_type = ctx.get(left.id).specialized_type
            if left_type == 'bint':
                return ast.Constant(False)
    return None


def partial_eval_ne(left, right, ctx):
    eq_res = partial_eval_eq(left, right, ctx)
    if isinstance(eq_res, ast.Constant):
        if eq_res.value is True:
            return ast.Constant(False)
        elif eq_res.value is False:
            return ast.Constant(True)
    return None


def partial_eval_static_function_call(func_name, args, keywords, ctx):
    # Assume here that builtins are called with the correct number of arguments
    if func_name == "isinstance":
        instance = args[0]
        type_info = args[1]

        if isinstance(instance, ast.Name) and isinstance(type_info, ast.Name):
            instance_name = instance.id
            type_info_name = type_info.id

            instance_ctx = ctx.get(instance_name)

            if instance_ctx:
                instance_actual_type = instance_ctx.type

                if issubclass(eval(instance_actual_type), eval(type_info_name)):
                    return ast.Constant(True)
                elif instance_actual_type in types:
                    return ast.Constant(False)

    elif func_name == "type":
        instance = args[0]

        if isinstance(instance, ast.Name):
            instance_name = instance.id

            instance_ctx = ctx.get(instance_name)

            if instance_ctx:
                instance_actual_type = instance_ctx.type

                if instance_actual_type is not _unknown:
                    return ast.Name(instance_actual_type, ast.Load())

    elif func_name in ctx:
        return partial_eval_local_function_call(ctx[func_name], args, ctx)
    else:
        return partial_eval_specialize_intrinsic_function(func_name, args, ctx)


def partial_eval_local_function_call(func, args, ctx):
    fn_ast = func.value

    if isinstance(fn_ast, ast.FunctionDef):
        fn_args = fn_ast.args.args
        name_table = {}

        if len(args) == len(fn_args):
            call_ctx = ctx.from_closure(fn_ast.closure) if isinstance(fn_ast, ClosureDef) else ctx.new()

            for fn_arg, arg in zip(fn_args, args):
                if isinstance(arg, ast.Name):
                    arg_name = fn_arg.arg
                    arg_value = ctx[arg.id]
                    name_table[arg_name] = arg.id
                    call_ctx[arg_name] = arg_value
                else:
                    raise NotImplementedError("partial_eval_local_function_call: non-name argument")

            body = fn_ast.body
            result_body = StmtSequence(partial_eval_body(body, call_ctx))
            AstRenamer(name_table).visit(result_body)
            return result_body

        else:
            raise TypeError("partial_eval_local_function_call: incorrect number of arguments")

    else:
        raise ValueError("partial evaluation call to non-function local object")


def partial_eval_specialize_intrinsic_function(func_name, args, ctx):
    # Assume here that builtins are called with the correct number of arguments
    if func_name == "py_int_to_host":
        self = args[0]
        if isinstance(self, ast.Name):
            name = self.id

            name_ctx = ctx.get(name)

            if name_ctx is not None:
                type_ = name_ctx.specialized_type

                if type_ == "sint":
                    return ast.Call(ast.Name("py_sint_to_host"), args, [])
                elif type_ == "bint":
                    return ast.Call(ast.Name("py_bint_to_host"), args, [])
                elif type_ == "bool":
                    return ast.Call(ast.Name("py_bool_to_host_int"), args, [])
                elif issubclass(eval(type_), int):
                    return ast.Call(ast.Name("py_int_to_host"), args, [])
    elif func_name == "class_getattr":
        return partial_eval_class_getattr_call(args, ctx)

    # No specialization
    return ast.Call(ast.Name(func_name), args, [])


def partial_eval_class_getattr_call(args, ctx):
    # Assume correct arity
    name = args[0]
    attr = args[1]

    if isinstance(name, ast.Name):
        if isinstance(attr, ast.Constant) and isinstance(attr.value, str):
            obj = ctx.get(name.id)

            if obj is None:
                raise NameError(f"partial_eval: could not resolve {name.id}")
            elif obj.type is _unknown:
                raise NotImplementedError(f"partial_eval_class_getattr_call: could not resolve type of {name.id}")
            else:
                obj_type = obj.type
                attr_name = attr.value

                cls = ctx.classes[obj_type]
                attr = cls.get(attr_name, StaticValue.absent())

                return attr

        else:
            raise ValueError("partial_eval_class_getattr_call: second argument must be a string literal")
    else:
        raise NotImplementedError("partial_eval_class_getattr_call: first argument must have been resolved to a name")


def convert_expr_to_return_host_bool(expr):
    if isinstance(expr, ast.Call):
        func = expr.func
        if isinstance(func, ast.Name) and func.id == 'py_bool_from_host_bool':
            # assume correct number of argument
            return expr.args[0]
        else:
            raise TypeError(f"cannot convert call to a return-host-bool version due to unknown callee: {func}")
    elif isinstance(expr, ast.Compare):
        return ast.Call(ast.Name('py_bool_to_host_bool'), expr, [])
    else:
        raise TypeError(f"cannot convert expr to a return-host-bool version: {expr}")


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


def get_behavior_name(semantics, types):
    type_signature = '-'.join(t + id_ for t, id_ in zip(types, 'XYZWABCDEF'))
    return f"py-{semantics}-{type_signature}"


def make_ast_raise_with_msg(error_name, msg):
    exc = ast.Call(ast.Name(error_name, ast.Load()), [ast.Constant(msg)], [])
    return ast.Raise(exc, None)


def make_ast_simple_arguments(*args_names, annotations=()):
    return ast.arguments([], [ast.arg(n, t, None) for n, t in itertools.zip_longest(args_names, annotations)], None, [],
                         [], None, [])


def iter_behavior_subtree_type_combinations(tree):
    for tp, subtree in tree.items():
        if isinstance(subtree, Behavior):
            yield [tp]
        else:
            yield from ([tp, *comb] for comb in iter_behavior_subtree_type_combinations(subtree))


def get_subtree_nested_item(tree, chain):
    for x in chain:
        tree = tree[x]
    return tree


def main_behaviors(semantics_file, builtins_file):
    with open(builtins_file, 'r') as f:
        builtins_ast = ast.parse(f.read())

    with open(semantics_file, 'r') as f:
        semantics_ast = ast.parse(f.read())

    class_register = ClassRegister(builtins_ast)
    semantics_register = SemanticsRegister(semantics_ast)

    behaviors = []

    define_behavior = "define_behavior"
    other_intrinsics = "py_int_from_host, py_int_to_host, py_bool_to_host_int, py_float_from_host, " \
                       "py_float_to_host, py_sint_to_host, py_bint_to_host, py_bool_from_host_bool "

    behavior_decorator_list = [ast.Name(f"{define_behavior}")]

    def register_behavior(name, sem, *types):
        args_names = [a.arg for a in sem.args.args]
        annotations = [ast.Name(t) for t in types]

        annotated_arguments = make_ast_simple_arguments(*args_names, annotations=annotations)
        behavior_name = get_behavior_name(name, types)
        behavior_func_name = behavior_name.replace('-', '_')

        result_body = partial_eval(sem, semantics_register, class_register,
                                   *[VarContext(type=t) for t in types])

        behavior_func = ast.FunctionDef(behavior_func_name, annotated_arguments, result_body,
                                        behavior_decorator_list, None, None)

        behaviors.append(behavior_func)

        # For comparisons, we generate a version of the behavior which returns a host bool
        if name in ("eq", "ne", "ge", "gt", "le", "lt"):
            test_behavior_func_name = behavior_name.replace('py-', 'py-test-').replace('-', '_')

            test_body = convert_body_to_return_host_bool(result_body)
            test_behavior_func = ast.FunctionDef(test_behavior_func_name, annotated_arguments, test_body,
                                                 behavior_decorator_list, None, None)
            behaviors.append(test_behavior_func)

    for name, bin_semantics in semantics_register.iter_binary_semantics():
        for left_type in types_without_int:
            for right_type in types_without_int:
                register_behavior(name, bin_semantics, left_type, right_type)

    for name, un_semantics in semantics_register.iter_unary_semantics():
        for type_ in types_without_int:
            register_behavior(name, un_semantics, type_)

    print(f"from __compiler_intrinsics__ import {define_behavior}, {other_intrinsics}\n")

    for b in behaviors:
        try:
            print(astor.code_gen.to_source(b))
        except Exception:
            logging.warning(f"astor failed to generate source for: {b.name}")
            raise


# ======================================================================================================================
#   main
# ======================================================================================================================


def get_type_alias(type_name):
    return "int" if type_name in int_specialized_types else type_name


instances = [1, 1.0, True]
types = [get_type_name(i) for i in instances]
int_specialized_types = ['sint', 'bint']
types += int_specialized_types

# Replace 'int' by 'sint' and 'bint'
types_without_int = [t for t in types if t != 'int']

# Semantics which should be converted to behaviors
target_semantics = [*templates.arithmetic_info, *templates.inplace_arithmetic_info,
                    *templates.comparison_info, *templates.equality_info, *templates.unary_arithmetic_info]

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description="Generate zipi decision tree and behavior functions")

    subparser = parser.add_subparsers(dest='command', required=True)

    # update command
    tree_parser = subparser.add_parser('tree', description="Generate the decision tree only")
    tree_parser.add_argument('semantics_file')

    # save command
    behaviors_parser = subparser.add_parser('behaviors', description="Generate the behaviors")
    behaviors_parser.add_argument('semantics_file')
    behaviors_parser.add_argument('builtins_file')

    args = parser.parse_args()

    command = args.command

    if command == 'tree':
        main_tree(args.semantics_file)
    elif command == 'behaviors':
        main_behaviors(args.semantics_file, args.builtins_file)

#!/usr/bin/env python3

import argparse, ast, inspect, itertools, logging, sys
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


class Procedure:
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


class Error:
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
        for left in instances:
            for right in instances:
                try:
                    semantics(left, right)
                except TypeError as e:
                    decision_tree.setdefault(name, {}).setdefault(get_type_name(left), {})[
                        get_type_name(right)] = Error(e)

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
        return self._register.get(item, default)


class MethodRegister(AstRegister):
    def visit_FunctionDef(self, node):
        self[node.name] = node


class ClassRegister(AstRegister):
    def visit_ClassDef(self, node):
        self[node.name] = MethodRegister(node)

    def get_by_qualname(self, qualname):
        cls_name, method_name = qualname.split('.')
        method_register = self.get(cls_name)
        return method_register.get(method_name) if method_register else None


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

    @property
    def type(self):
        return get_type_alias(self._type)

    @property
    def specialized_type(self):
        return self._type

    def __repr__(self):
        return f"VarContent(type={self.type} ({self.specialized_type}), value={self.value})"


def partial_eval(fn_ast, *args):
    ast_args = fn_ast.args

    if ast_args.kwonlyargs or ast_args.kw_defaults or ast_args.defaults:
        raise ValueError("partial_eval only supports no-default positional arguments")

    # For now we assume only positional args
    fn_args = ast_args.posonlyargs + ast_args.args

    if len(args) > len(fn_args):
        raise TypeError(f"partially evaluated function takes {len(fn_args)} context arguments, {len(args)} were given.")
    elif len(args) < len(fn_args):
        raise TypeError(
            f"partially evaluated function missing {len(fn_args) - len(args)} context arguments. Empty contexts must be given explicitly.")

    ctx = {}

    for ctx_var, arg in zip(args, fn_args):
        ctx[arg.arg] = ctx_var

    body = fn_ast.body
    return partial_eval_body(body, ctx)


def partial_eval_body(body, ctx):
    result = []

    for stmt in partial_eval_stmts(body, ctx):
        result.append(stmt)
        if isinstance(stmt, ast.Return):
            break

    return result


def partial_eval_stmts(stmts, ctx):
    for stmt in stmts:
        yield from partial_eval_stmt(stmt, ctx)


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
        yield ast.Return(partial_eval_expr(value, ctx) if value is not None else value)
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
    else:
        return expr


def partial_eval_bin_op(expr, ctx):
    left = partial_eval_expr(expr.left, ctx)
    right = partial_eval_expr(expr.right, ctx)
    return ast.BinOp(left, expr.op, right)


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
        raise ValueError(f"missing partial_eval implementation for {type(op).__name__}")

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
        return partial_eval_static_function_call(func.id, args, call.keywords, ctx)
    else:
        return ast.Call(func, args, call.keywords)


def partial_eval_compare(cmp, ctx):
    left = partial_eval_expr(cmp.left, ctx)
    comparators = [partial_eval_expr(e, ctx) for e in cmp.comparators]

    evaluated_comparators = []
    evaluated_ops = []

    # Eliminate operators which evaluate to True
    for op, right in zip(cmp.ops, comparators):
        if isinstance(op, ast.Is):
            res = partial_eval_is(left, right, ctx)
            if isinstance(res, ast.Constant):
                if not res.value:
                    return res
                else:
                    evaluated_comparators.append(left)
                    # Eliminate this operation
                    evaluated_ops.append(None)
                    left = right
                    continue

        # Could not evaluate this comparison in this context
        evaluated_comparators.append(left)
        evaluated_ops.append(op)
        left = right

    evaluated_comparators.append(left)

    # Removing an operator in a chain is equivalent to replacing it with 'and'
    # Ex: x is y is y is z => (x is y) and (y is z)
    # We collect those sub-chains to later link them with ast.And
    chained_groups = [[[], []]]
    for i, op in enumerate(evaluated_ops):
        if op is None:
            chained_groups[-1][0].append(evaluated_comparators[i])
            if chained_groups[-1] != [[], []]:
                chained_groups.append([[], []])
        else:
            chained_groups[-1][0].append(evaluated_comparators[i])
            chained_groups[-1][1].append(op)

    chained_groups[-1][0].append(evaluated_comparators[-1])

    chains = [ast.Compare(exprs[0], ops, exprs[1:]) for exprs, ops in chained_groups if ops]

    return ast.Constant(True) if len(chains) == 0 else ast.BoolOp(ast.And(), chains)


def partial_eval_is(left, right, ctx):
    if isinstance(left, ast.Name) and isinstance(right, ast.Name):
        return ast.Constant(left.id == right.id)
    else:
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

    return partial_eval_specialize_intrinsic_function(func_name, args, keywords, ctx)


def partial_eval_specialize_intrinsic_function(func_name, args, keywords, ctx):
    # Assume here that builtins are called with the correct number of arguments
    if func_name == "py_int_to_host_int":
        self = args[0]
        if isinstance(self, ast.Name):
            name = self.id

            name_ctx = ctx.get(name)

            if name_ctx is not None:
                type_ = name_ctx.specialized_type

                if type_ == "sint":
                    return ast.Call(ast.Name("py_sint_to_host_sint"), args, keywords)
                elif type_ == "bint":
                    return ast.Call(ast.Name("py_bint_to_host_bint"), args, keywords)
                elif type_ == "bool":
                    return ast.Call(ast.Name("py_bool_to_host_int"), args, keywords)
                elif issubclass(eval(type_), int):
                    return ast.Call(ast.Name("py_int_to_host_int"), args, keywords)

    # No specialization
    return ast.Call(ast.Name(func_name), args, keywords)


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


def get_binary_behavior_name(semantics, left_type, right_type):
    return f"py-{semantics}-{left_type if left_type else ''}X-{right_type if right_type else ''}Y"


def make_ast_raise_with_msg(error_name, msg):
    exc = ast.Call(ast.Name(error_name, ast.Load()), [ast.Constant(msg)], [])
    return ast.Raise(exc, None)


def make_ast_simple_arguments(*args_names, annotations=()):
    return ast.arguments([], [ast.arg(n, t, None) for n, t in itertools.zip_longest(args_names, annotations)], None, [],
                         [], None, [])


def main_behaviors(semantics_file, builtins_file):
    with open(builtins_file, 'r') as f:
        builtins_ast = ast.parse(f.read())

    decision_tree = build_decision_tree(semantics_file)

    class_register = ClassRegister(builtins_ast)

    behaviors = []

    define_behavior = "define_behavior"
    other_intrinsics = "py_int_from_host_int, py_int_to_host_int, py_bool_to_host_int, py_float_from_host_float, " \
                       "py_float_to_host_float, py_sint_to_host_sint, py_bint_to_host_bint, py_bool_from_host_bool "

    for semantics, subtree in decision_tree.items():
        for left_type in types_without_int:
            for right_type in types_without_int:

                behavior_name = get_binary_behavior_name(semantics, left_type, right_type)
                behavior_func_name = behavior_name.replace('-', '_')
                behavior_decorator_list = [ast.Name(f"{define_behavior}")]

                try:
                    behavior = subtree[left_type][right_type]
                except KeyError:
                    logging.warning(f"unimplemented behavior in decision tree method: {behavior_name}")
                    continue

                if isinstance(behavior, Procedure):
                    method_ast = class_register.get_by_qualname(behavior.method.__qualname__)

                    if method_ast is None:
                        logging.warning(f"unimplemented behavior in magic method: {behavior_name}")
                    else:
                        is_reflected_magic_method = behavior.is_reflected_magic_method
                        is_comparison = behavior.is_comparison

                        if is_reflected_magic_method:
                            # For evaluation
                            args = [VarContext(type=right_type), VarContext(type=left_type)]
                            # For code generation
                            # NOTE: we reverse arguments names because behaviors arguments respect
                            # operands order, not magic_method arguments order
                            args_names = [a.arg for a in method_ast.args.posonlyargs + method_ast.args.args][::-1]
                        else:
                            # For evaluation
                            args = [VarContext(type=left_type), VarContext(type=right_type)]
                            # For code generation
                            args_names = [a.arg for a in method_ast.args.posonlyargs + method_ast.args.args]

                        result_body = partial_eval(method_ast, *args)

                        annotated_arguments = make_ast_simple_arguments(*args_names,
                                                                        annotations=[ast.Name(left_type),
                                                                                     ast.Name(right_type)])

                        behavior_func = ast.FunctionDef(behavior_func_name, annotated_arguments, result_body,
                                                        behavior_decorator_list, method_ast.returns,
                                                        method_ast.type_comment)

                        behaviors.append(behavior_func)

                        # For comparisons, we generate a version of the behavior which returns a host bool
                        if is_comparison:
                            test_behavior_func_name = behavior_name.replace('py-', 'py-test-').replace('-', '_')

                            test_body = convert_body_to_return_host_bool(result_body)
                            test_behavior_func = ast.FunctionDef(test_behavior_func_name, annotated_arguments, test_body,
                                                                 behavior_decorator_list, method_ast.returns,
                                                                 method_ast.type_comment)
                            behaviors.append(test_behavior_func)

                elif isinstance(behavior, Error):
                    # Argument names are unimportant since they are unused in case of Error
                    annotated_arguments = make_ast_simple_arguments("self", "other",
                                                                    annotations=[ast.Name(left_type),
                                                                                 ast.Name(right_type)])
                    body = [make_ast_raise_with_msg("TypeError", behavior.error_message)]

                    behavior_func = ast.FunctionDef(behavior_func_name, annotated_arguments, body,
                                                    behavior_decorator_list, None, None)

                    behaviors.append(behavior_func)

                else:
                    raise TypeError("unknown behavior type")

    print(f"from __compiler_intrinsics__ import {define_behavior}, {other_intrinsics}\n")

    for b in behaviors:
        print(astor.code_gen.to_source(b))


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
                    *templates.comparison_info, *templates.equality_info]

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

#!/usr/bin/env python3

import argparse
import ast as AST

def read_file(path):
    with open(path, 'r') as f:
        content = f.read()
    return content

def parse(source):
    return AST.parse(source)

def dump(ast):
    assert isinstance(ast, AST.Module)
#    print(dict(type(ast)))
#    print(dir(ast._attributes))
#    print(dir(ast._fields))
#    print(AST.dump(ast,True,False))
    print(cvt_mod(ast))

def cvt_seq(cvt, seq):
    return "(" + (" ".join(map(cvt, seq))) + ")"

def cvt_stmt_seq(stmt_seq):
    return cvt_seq(cvt_stmt, stmt_seq)

def cvt_expr_seq(expr_seq):
    return cvt_seq(cvt_expr, expr_seq)

def cvt_expr_seq(expr_seq):
    return cvt_seq(cvt_expr, expr_seq)

def cvt_expr_opt(expr_opt):
    if expr_opt == None:
        return "#f"
    else:
        return cvt_expr(expr_opt)

def cvt_expr_context(ctx):
    if isinstance(ctx, AST.Load):
        return "Load"
    elif isinstance(ctx, AST.Store):
        return "Store"
    elif isinstance(ctx, AST.Del):
        return "Del"
    elif isinstance(ctx, AST.AugLoad):
        return "AugLoad"
    elif isinstance(ctx, AST.Param):
        return "Param"
    else:
        assert False, "cvt_expr_context expected an expr_context AST"

def cvt_string_opt(string_opt):
    if string_opt == None:
        return "#f"
    else:
        return cvt_string(string_opt)

def cvt_string(s):
    return "\"" + str(s) + "\""

def cvt_identifier(identifier):
    return str(identifier)

#def cvt_type_ignore_seq(type_ignore_seq):
#    return "type_ignore_seq"

def cvt_arguments(arguments):
    return ("(" + cvt_arg_seq(arguments.args) +
#            " " + cvt_arg_seq(arguments.posonlyargs) +
            " " + cvt_arg_opt(arguments.vararg) +
            " " + cvt_arg_seq(arguments.kwonlyargs) +
            " " + cvt_expr_seq(arguments.kw_defaults) +
            " " + cvt_arg_opt(arguments.kwarg) +
            " " + cvt_expr_seq(arguments.defaults) +
            ")")

def cvt_arg(arg):
    return ("(" + cvt_identifier(arg.arg) +
            " " + cvt_expr_opt(arg.annotation) +
#            " " + cvt_string_opt(arg.type_comment) +
            ")")

def cvt_arg_seq(arg_seq):
    return cvt_seq(cvt_arg, arg_seq)

def cvt_arg_opt(arg_opt):
    if arg_opt == None:
        return "#f"
    else:
        return cvt_arg(arg_opt)

def cvt_keyword(keyword):
    print(keyword)
    return "keyword"
#    keyword = (identifier? arg, expr value)

def cvt_keyword_seq(keyword_seq):
    return cvt_seq(cvt_keyword, keyword_seq)

def cvt_boolop(op):
    if isinstance(ctx, AST.And):
        return "And"
    elif isinstance(ctx, AST.Or):
        return "Or"
    else:
        assert False, "cvt_boolop expected a boolop AST"

def cvt_operator(op):
    if isinstance(op, AST.Add):
        return "Add"
    elif isinstance(op, AST.Sub):
        return "Sub"
    elif isinstance(op, AST.Mult):
        return "Mult"
    elif isinstance(op, AST.MatMult):
        return "MatMult"
    elif isinstance(op, AST.Div):
        return "Div"
    elif isinstance(op, AST.Mod):
        return "Mod"
    elif isinstance(op, AST.Pow):
        return "Pow"
    elif isinstance(op, AST.LShift):
        return "LShift"
    elif isinstance(op, AST.RShift):
        return "RShift"
    elif isinstance(op, AST.BitOr):
        return "BitOr"
    elif isinstance(op, AST.BitXor):
        return "BitXor"
    elif isinstance(op, AST.BitAnd):
        return "BitAnd"
    elif isinstance(op, AST.FloorDiv):
        return "FloorDiv"
    else:
        assert False, "cvt_operator expected an operator AST"

def cvt_unaryop(op):
    if isinstance(op, AST.Invert):
        return "Invert"
    elif isinstance(op, AST.Not):
        return "Not"
    elif isinstance(op, AST.UAdd):
        return "UAdd"
    elif isinstance(op, AST.USub):
        return "USub"
    else:
        assert False, "cvt_unaryop expected a unaryop AST"

def cvt_cmpop(op):
    if isinstance(op, AST.Eq):
        return "Eq"
    elif isinstance(op, AST.NotEq):
        return "NotEq"
    elif isinstance(op, AST.Lt):
        return "Lt"
    elif isinstance(op, AST.LtE):
        return "LtE"
    elif isinstance(op, AST.Gt):
        return "Gt"
    elif isinstance(op, AST.GtE):
        return "GtE"
    elif isinstance(op, AST.Is):
        return "Is"
    elif isinstance(op, AST.IsNot):
        return "IsNot"
    elif isinstance(op, AST.In):
        return "In"
    elif isinstance(op, AST.NotIn):
        return "NotIn"
    else:
        assert False, "cvt_cmpop expected a cmpop AST"

def cvt_cmpop_seq(ops):
    return cvt_seq(cvt_cmpop, ops)

def cvt_mod(ast):
    if isinstance(ast, AST.Module):
        # Module(stmt* body, type_ignore *type_ignores)
        return ("(Module" +
                " " + cvt_stmt_seq(ast.body) +
#                " " + cvt_type_ignore_seq(ast.type_ignores) +
                ")")
    elif isinstance(ast, AST.Interactive):
        # Interactive(stmt* body)
        return ("(Interactive" +
                " " + cvt_stmt_seq(ast.body) +
                ")")
    elif isinstance(ast, AST.Expression):
        # Expression(expr body)
        return ("(Expression" +
                " " + cvt_expr(ast.body) +
                ")")
    elif isinstance(ast, AST.Function):
        # FunctionType(expr* argtypes, expr returns)
        return ("(Function" +
                " " + cvt_expr_seq(ast.argtypes) +
                " " + cvt_expr(ast.returns) +
                ")")
#    elif isinstance(ast, AST.Suite):
#        # not really an actual node but useful in Jython's typesystem.
#        # Suite(stmt* body)
#        return ("(Suite" +
#                " " + cvt_stmt_seq(ast.body) +
#                ")")
    else:
        assert False, "cvt_mod expected a module AST"

def cvt_stmt(ast):
    if isinstance(ast, AST.FunctionDef):
        # FunctionDef(identifier name, arguments args,
        #             stmt* body, expr* decorator_list, expr? returns,
        #             string? type_comment)
        return ("(FunctionDef" +
                " " + cvt_identifier(ast.name) +
                " " + cvt_arguments(ast.args) +
                " " + cvt_stmt_seq(ast.body) +
                " " + cvt_expr_seq(ast.decorator_list) +
                " " + cvt_expr_opt(ast.returns) +
#                " " + cvt_string_opt(ast.type_comment) +
                ")")
    elif isinstance(ast, AST.AsyncFunctionDef):
        # AsyncFunctionDef(identifier name, arguments args,
        #                  stmt* body, expr* decorator_list, expr? returns,
        #                  string? type_comment)
        TODO
        return ("(AsyncFunctionDef" +
                " " + cvt_stmt_seq(ast.body) +
                ")")
    elif isinstance(ast, AST.ClassDef):
        # ClassDef(identifier name,
        #          expr* bases,
        #          keyword* keywords,
        #          stmt* body,
        #          expr* decorator_list)
        TODO
        return ("(ClassDef" +
                " " + cvt_stmt_seq(ast.body) +
                ")")
    elif isinstance(ast, AST.Return):
        # Return(expr? value)
        return ("(Return" +
                " " + cvt_expr_opt(ast.value) +
                ")")
    elif isinstance(ast, AST.Delete):
        # Delete(expr* targets)
        return ("(Delete" +
                " " + cvt_expr_seq(ast.targets) +
                ")")
    elif isinstance(ast, AST.Assign):
        # Assign(expr* targets, expr value, string? type_comment)
        return ("(Assign" +
                " " + cvt_expr_seq(ast.targets) +
                " " + cvt_expr(ast.value) +
                " " + cvt_string_opt(ast.type_comment) +
                ")")
    elif isinstance(ast, AST.AugAssign):
        # AugAssign(expr target, operator op, expr value)
        return ("(AugAssign" +
                " " + cvt_expr(ast.target) +
                " " + cvt_operator(ast.op) +
                " " + cvt_expr(ast.value) +
                ")")
    elif isinstance(ast, AST.AnnAssign):
        # 'simple' indicates that we annotate simple name without parens
        # AnnAssign(expr target, expr annotation, expr? value, int simple)
        return ("(AnnAssign" +
                " " + cvt_expr(ast.target) +
                " " + cvt_expr(ast.annotation) +
                " " + cvt_expr_opt(ast.value) +
                " " + cvt_int(ast.simple) +
                ")")
    elif isinstance(ast, AST.For):
        # use 'orelse' because else is a keyword in target languages
        # For(expr target, expr iter, stmt* body, stmt* orelse, string? type_comment)
        return ("(For" +
                " " + cvt_expr(ast.target) +
                " " + cvt_expr(ast.iter) +
                " " + cvt_stmt_seq(ast.body) +
                " " + cvt_stmt_seq(ast.orelse) +
                " " + cvt_string_opt(ast.type_comment) +
                ")")
    elif isinstance(ast, AST.AsyncFor):
        # AsyncFor(expr target, expr iter, stmt* body, stmt* orelse, string? type_comment)
        return ("(AsyncFor" +
                " " + cvt_expr(ast.target) +
                " " + cvt_expr(ast.iter) +
                " " + cvt_stmt_seq(ast.body) +
                " " + cvt_stmt_seq(ast.orelse) +
                " " + cvt_string_opt(ast.type_comment) +
                ")")
    elif isinstance(ast, AST.While):
        # While(expr test, stmt* body, stmt* orelse)
        return ("(While" +
                " " + cvt_expr(ast.test) +
                " " + cvt_stmt_seq(ast.body) +
                " " + cvt_stmt_seq(ast.orelse) +
                ")")
    elif isinstance(ast, AST.If):
        # If(expr test, stmt* body, stmt* orelse)
        return ("(If" +
                " " + cvt_expr(ast.test) +
                " " + cvt_stmt_seq(ast.body) +
                " " + cvt_stmt_seq(ast.orelse) +
                ")")
    elif isinstance(ast, AST.With):
        # With(withitem* items, stmt* body, string? type_comment)
        return ("(With" +
                " " + cvt_withitem_seq(ast.items) +
                " " + cvt_stmt_seq(ast.body) +
                " " + cvt_string_opt(ast.type_comment) +
                ")")
    elif isinstance(ast, AST.AsyncWith):
        # AsyncWith(withitem* items, stmt* body, string? type_comment)
        return ("(AsyncWith" +
                " " + cvt_stmt_seq(ast.body) +
                " " + cvt_string_opt(ast.type_comment) +
                ")")
    elif isinstance(ast, AST.Raise):
        # Raise(expr? exc, expr? cause)
        return ("(Raise" +
                " " + cvt_expr_opt(ast.exc) +
                " " + cvt_expr_opt(ast.cause) +
                ")")
    elif isinstance(ast, AST.Try):
        # Try(stmt* body, excepthandler* handlers, stmt* orelse, stmt* finalbody)
        return ("(Try" +
                " " + cvt_stmt_seq(ast.body) +
                " " + cvt_excepthandler_seq(ast.handlers) +
                " " + cvt_stmt_seq(ast.orelse) +
                " " + cvt_stmt_seq(ast.finalbody) +
                ")")
    elif isinstance(ast, AST.Assert):
        # Assert(expr test, expr? msg)
        return ("(Assert" +
                " " + cvt_expr(ast.test) +
                " " + cvt_expr_opt(ast.msg) +
                ")")
    elif isinstance(ast, AST.Import):
        # Import(alias* names)
        return ("(Import" +
                " " + cvt_alias_seq(ast.names) +
                ")")
    elif isinstance(ast, AST.ImportFrom):
        # ImportFrom(identifier? module, alias* names, int? level)
        return ("(ImportFrom" +
                " " + cvt_identifier_opt(ast.module) +
                " " + cvt_alias_seq(ast.names) +
                " " + cvt_int_opt(ast.level) +
                ")")
    elif isinstance(ast, AST.Global):
        # Global(identifier* names)
        return ("(Global" +
                " " + cvt_identifier_seq(ast.names) +
                ")")
    elif isinstance(ast, AST.Nonlocal):
        # Nonlocal(identifier* names)
        return ("(Nonlocal" +
                " " + cvt_identifier_seq(ast.names) +
                ")")
    elif isinstance(ast, AST.Expr):
        # Expr(expr value)
        return ("(Expr" +
                " " + cvt_expr(ast.value) +
                ")")
    elif isinstance(ast, AST.Pass):
        # Pass
        return ("(Pass" +
                ")")
    elif isinstance(ast, AST.Break):
        # Break
        return ("(Break" +
                ")")
    elif isinstance(ast, AST.Continue):
        # Continue
        return ("(Continue" +
                ")")
    else:
        assert False, "cvt_stmt expected a statement AST"

def cvt_expr(ast):
    if isinstance(ast, AST.BoolOp):
        # BoolOp() can use left & right?
        # BoolOp(boolop op, expr* values)
        return ("(BoolOp" +
                " " + cvt_boolop(ast.op) +
                " " + cvt_expr_seq(ast.values) +
                ")")
#    elif isinstance(ast, AST.NamedExpr):
#        # NamedExpr(expr target, expr value)
#        return ("(NamedExpr " +
#                " " + cvt_expr(ast.target) +
#                " " + cvt_expr(ast.value) +
#                ")")
    elif isinstance(ast, AST.BinOp):
        # BinOp(expr left, operator op, expr right)
        return ("(BinOp" +
                " " + cvt_expr(ast.left) +
                " " + cvt_operator(ast.op) +
                " " + cvt_expr(ast.right) +
                ")")
    elif isinstance(ast, AST.UnaryOp):
        # UnaryOp(unaryop op, expr operand)
        return ("(UnaryOp" +
                " " + cvt_unaryop(ast.op) +
                " " + cvt_expr(ast.operand) +
                ")")
    elif isinstance(ast, AST.Lambda):
        # Lambda(arguments args, expr body)
        return ("(Lambda" +
                " " + cvt_arguments(ast.args) +
                " " + cvt_expr(ast.body) +
                ")")
    elif isinstance(ast, AST.IfExp):
        # IfExp(expr test, expr body, expr orelse)
        return ("(IfExp" +
                " " + cvt_expr(ast.test) +
                " " + cvt_expr(ast.body) +
                " " + cvt_expr(ast.orelse) +
                ")")
    elif isinstance(ast, AST.Dict):
        # Dict(expr* keys, expr* values)
        return ("(Dict" +
                " " + cvt_expr_seq(ast.keys) +
                " " + cvt_expr_seq(ast.values) +
                ")")
    elif isinstance(ast, AST.Set):
        # Set(expr* elts)
        return ("(Set" +
                " " + cvt_expr_seq(ast.elts) +
                ")")
    elif isinstance(ast, AST.ListComp):
        # ListComp(expr elt, comprehension* generators)
        return ("(ListComp" +
                " " + cvt_expr(ast.elt) +
                " " + cvt_comprehension_seq(ast.generators) +
                ")")
    elif isinstance(ast, AST.SetComp):
        # SetComp(expr elt, comprehension* generators)
        return ("(SetComp" +
                " " + cvt_expr(ast.elt) +
                " " + cvt_comprehension_seq(ast.generators) +
                ")")
    elif isinstance(ast, AST.DictComp):
        # DictComp(expr key, expr value, comprehension* generators)
        return ("(DictComp" +
                " " + cvt_expr(ast.key) +
                " " + cvt_expr(ast.value) +
                " " + cvt_comprehension_seq(ast.generators) +
                ")")
    elif isinstance(ast, AST.GeneratorExp):
        # GeneratorExp(expr elt, comprehension* generators)
        return ("(GeneratorExp" +
                " " + cvt_expr(ast.elt) +
                " " + cvt_comprehension_seq(ast.generators) +
                ")")
    elif isinstance(ast, AST.Await):
        # the grammar constrains where yield expressions can occur
        # Await(expr value)
        return ("(Await" +
                " " + cvt_expr(ast.value) +
                ")")
    elif isinstance(ast, AST.Yield):
        # Yield(expr? value)
        return ("(Yield" +
                " " + cvt_expr_opt(ast.value) +
                ")")
    elif isinstance(ast, AST.YieldFrom):
        # YieldFrom(expr value)
        return ("(YieldFrom" +
                " " + cvt_expr(ast.value) +
                ")")
    elif isinstance(ast, AST.Compare):
        # need sequences for compare to distinguish between
        # x < 4 < 3 and (x < 4) < 3
        # Compare(expr left, cmpop* ops, expr* comparators)
        return ("(Compare" +
                " " + cvt_expr(ast.left) +
                " " + cvt_cmpop_seq(ast.ops) +
                " " + cvt_expr_seq(ast.comparators) +
                ")")
    elif isinstance(ast, AST.Call):
        # Call(expr func, expr* args, keyword* keywords)
        return ("(Call" +
                " " + cvt_expr(ast.func) +
                " " + cvt_expr_seq(ast.args) +
                " " + cvt_keyword_seq(ast.keywords) +
                ")")
    elif isinstance(ast, AST.FormattedValue):
        # FormattedValue(expr value, int? conversion, expr? format_spec)
        return ("(FormattedValue" +
                " " + cvt_expr(ast.value) +
                " " + cvt_int_opt(ast.conversion) +
                " " + cvt_expr_opt(ast.format_spec) +
                ")")
    elif isinstance(ast, AST.JoinedStr):
        # JoinedStr(expr* values)
        return ("(JoinedStr" +
                " " + cvt_expr_seq(ast.values) +
                ")")
    elif isinstance(ast, AST.Constant):
        # Constant(constant value, string? kind)
        return ("(Constant" +
                " " + cvt_constant(ast.value) +
                " " + cvt_string_opt(ast.kind) +
                ")")
    elif isinstance(ast, AST.Attribute):
        # the following expression can appear in assignment context
        # Attribute(expr value, identifier attr, expr_context ctx)
        return ("(Attribute" +
                " " + cvt_expr(ast.value) +
                " " + cvt_identifier(ast.attr) +
                " " + cvt_expr_context(ast.ctx) +
                ")")
    elif isinstance(ast, AST.Subscript):
        # Subscript(expr value, slice slice, expr_context ctx)
        return ("(Subscript" +
                " " + cvt_expr(ast.value) +
                " " + cvt_slice(ast.slice) +
                " " + cvt_expr_context(ast.ctx) +
                ")")
    elif isinstance(ast, AST.Starred):
        # Starred(expr value, expr_context ctx)
        return ("(Starred" +
                " " + cvt_expr(ast.value) +
                " " + cvt_expr_context(ast.ctx) +
                ")")
    elif isinstance(ast, AST.Name):
        # Name(identifier id, expr_context ctx)
        return ("(Name" +
                " " + cvt_identifier(ast.id) +
                " " + cvt_expr_context(ast.ctx) +
                ")")
    elif isinstance(ast, AST.List):
        # List(expr* elts, expr_context ctx)
        return ("(List" +
                " " + cvt_expr_seq(ast.elts) +
                " " + cvt_expr_context(ast.ctx) +
                ")")
    elif isinstance(ast, AST.Tuple):
        # Tuple(expr* elts, expr_context ctx)
        return ("(Tuple" +
                " " + cvt_expr_seq(ast.elts) +
                " " + cvt_expr_context(ast.ctx) +
                ")")
    elif isinstance(ast, AST.Num):
        return ("(Num" +
                " " + cvt_string(ast.n) +
                ")")
    elif isinstance(ast, AST.Str):
        return ("(Str" +
                " " + cvt_string(ast.s) +
                ")")
    elif isinstance(ast, AST.NameConstant):
        return ("(NameConstant" +
                " " + cvt_string(ast.value) +
                ")")
    else:
        print(ast)
        print(dir(ast))
        assert False, "cvt_expr expected an expression AST"



"""

    expr_context = Load | Store | Del | AugLoad | AugStore | Param

    slice = Slice(expr? lower, expr? upper, expr? step)
        # ExtSlice(slice* dims)
        # Index(expr value)

    boolop = And | Or

    operator = Add | Sub | Mult | MatMult | Div | Mod | Pow | LShift
                 | RShift | BitOr | BitXor | BitAnd | FloorDiv

    unaryop = Invert | Not | UAdd | USub

    cmpop = Eq | NotEq | Lt | LtE | Gt | GtE | Is | IsNot | In | NotIn

    comprehension = (expr target, expr iter, expr* ifs, int is_async)

    excepthandler = ExceptHandler(expr? type, identifier? name, stmt* body)
                    attributes (int lineno, int col_offset, int? end_lineno, int? end_col_offset)

    arguments = (arg* args, arg* posonlyargs, arg? vararg, arg* kwonlyargs,
                 expr* kw_defaults, arg? kwarg, expr* defaults)

    arg = (identifier arg, expr? annotation, string? type_comment)
           attributes (int lineno, int col_offset, int? end_lineno, int? end_col_offset)

    -- keyword arguments supplied to call (NULL identifier for **kwargs)
    keyword = (identifier? arg, expr value)

    -- import name with optional 'as' alias.
    alias = (identifier name, identifier? asname)

    withitem = (expr context_expr, expr? optional_vars)

    type_ignore = TypeIgnore(int lineno, string tag)
"""


def scmast(path):
    source = read_file(path)
#    print(source)
    dump(parse(source))

def main():
    parse = argparse.ArgumentParser(description="scmast")
    parse.add_argument("file", help="source file")
    args = parse.parse_args()
    scmast(args.file)

main()

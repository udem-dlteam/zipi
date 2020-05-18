import argparse
import re
from common import *

parser = argparse.ArgumentParser(description='CLI to zp bootstrap compiler.')
parser.add_argument('-f', '--file',  metavar='FILE', type=str, nargs=1,
                    help='file to compile')
parser.add_argument('-t', '--target',  metavar='TARGET', type=str, nargs=1,
                    help='target language')

cli_args = parser.parse_args()


# Import backend
from zp_javascript import JavaScript


def parse_node(node):
    if isinstance(node, Assign):
        return parse_Assign(node)
    elif isinstance(node, Name):
        return parse_Name(node)
    elif isinstance(node, Num):
        return parse_Num(node)
    elif isinstance(node, Str):
        return parse_Str(node)
    elif isinstance(node, FunctionDef):
        return parse_FunctionDef(node)
    elif isinstance(node, arguments):
        return parse_arguments(node)
    elif isinstance(node, arg):
        return parse_arg(node)
    elif isinstance(node, Return):
        return parse_Return(node)
    elif isinstance(node, If):
        return parse_If(node)
    elif isinstance(node, Compare):
        return parse_Compare(node)
    elif isinstance(node, NameConstant):
        return parse_NameConstant(node)
    elif isinstance(node, BoolOp):
        return parse_BoolOp(node)
    elif isinstance(node, And):
        return parse_And(node)
    elif isinstance(node, Or):
        return parse_Or(node)
    elif isinstance(node, Gt):
        return parse_Gt(node)
    elif isinstance(node, GtE):
        return parse_GtE(node)
    elif isinstance(node, Lt):
        return parse_Lt(node)
    elif isinstance(node, LtE):
        return parse_LtE(node)
    elif isinstance(node, Eq):
        return parse_Eq(node)
    elif isinstance(node, NotEq):
        return parse_NotEq(node)
    elif isinstance(node, BinOp):
        return parse_BinOp(node)
    elif isinstance(node, Call):
        return parse_Call(node)
    elif isinstance(node, Add):
        return parse_Add(node)
    elif isinstance(node, Sub):
        return parse_Sub(node)
    elif isinstance(node, Expr):
        return parse_Expr(node)
    elif isinstance(node, Attribute):
        return parse_Attribute(node)
    elif isinstance(node, Bytes):
        return parse_Bytes(node)
    elif isinstance(node, Subscript):
        return parse_Subscript(node)
    elif isinstance(node, Index):
        return parse_Index(node)
    elif isinstance(node, Is):
        return parse_Is(node)
    elif isinstance(node, For):
        return parse_For(node)
    elif isinstance(node, Slice):
        return parse_Slice(node)
    elif isinstance(node, ClassDef):
        return parse_ClassDef(node)
    elif isinstance(node, List):
        return parse_List(node)
    elif isinstance(node, IfExp):
        return parse_IfExp(node)
    elif isinstance(node, Raise):
        return parse_Raise(node)
    elif isinstance(node, AugAssign):
        return parse_AugAssign(node)
    elif isinstance(node, Dict):
        return parse_Dict(node)
    elif isinstance(node, Global):
        return parse_Global(node)
    elif isinstance(node, Mult):
        return parse_Mult(node)
    elif isinstance(node, While):
        return parse_While(node)
    elif isinstance(node, Break):
        return parse_Break(node)
    elif isinstance(node, Continue):
        return parse_Continue(node)
    elif isinstance(node, FloorDiv):
        return parse_FloorDiv(node)
    elif isinstance(node, BitAnd):
        return parse_BitAnd(node)
    elif isinstance(node, Pass):
        return parse_Pass(node)


# Set up backend
javascript = JavaScript(parse_node)

# Empty default
backend = object()


def parse_Pass(node):
    return backend.parse_Pass(node)


def parse_BitAnd(node):
    return backend.parse_BitAnd(node)


def parse_FloorDiv(node):
    return backend.parse_FloorDiv(node)


def parse_While(node):
    return backend.parse_While(node)


def parse_Global(node):
    return ''


def parse_Raise(node):
    return backend.parse_Raise(node)


def parse_Assign(node):
    return backend.parse_Assign(node)


def parse_AugAssign(node):
    return backend.parse_AugAssign(node)


def parse_Attribute(node):
    return backend.parse_Attribute(node)


def parse_Subscript(node):
    return backend.parse_Subscript(node)


def parse_Index(node):
    return parse_node(node.value)


def parse_Is(node):
    return backend.parse_Is(node)


def parse_If(node):
    return backend.parse_If(node)


def parse_IfExp(node):
    return backend.parse_IfExp(node)


def parse_BinOp(node):
    return backend.parse_BinOp(node)


def parse_Call(node):
    return backend.parse_Call(node)


def parse_Expr(node):
    return backend.parse_Expr(node)


def parse_For(node):
    return backend.parse_For(node)


def parse_Add(node):
    return backend.parse_Add(node)


def parse_Sub(node):
    return backend.parse_Sub(node)


def parse_Mult(node):
    return backend.parse_Mult(node)


def parse_Gt(node):
    return backend.parse_Gt(node)


def parse_GtE(node):
    return backend.parse_GtE(node)


def parse_Lt(node):
    return backend.parse_Lt(node)


def parse_LtE(node):
    return backend.parse_LtE(node)


def parse_Eq(node):
    return backend.parse_Eq(node)


def parse_NotEq(node):
    return backend.parse_NotEq(node)


def parse_Compare(node):
    return backend.parse_Compare(node)


def parse_BoolOp(node):
    return backend.parse_BoolOp(node)


def parse_Or(node):
    return backend.parse_Or(node)


def parse_And(node):
    return backend.parse_And(node)


def parse_Break(node):
    return backend.parse_Break(node)


def parse_Continue(node):
    return backend.parse_Continue(node)


def parse_NameConstant(node):
    val = node.value
    if val == True:
        return 'true'
    elif val == False:
        return 'false'
    else:
        return str(node.value)


def parse_Num(node):
    return str(node.n)


def parse_Name(node):
    return node.id


def parse_Str(node):
    # TODO: Fix string encoding issues, maybe handling per backend.
    return '"' + node.s.encode('unicode-escape').decode().replace('"', '\\"') + '"'

def parse_Bytes(node):
    return '"' + node.s.decode('utf-8').encode('unicode-escape').decode().replace('"', '\\"') + '"'


def parse_Slice(node):
    return backend.parse_Slice(node)

def parse_FunctionDef(node):
    return backend.parse_FunctionDef(node)


def parse_ClassDef(node):
    return backend.parse_ClassDef(node)


def parse_List(node):
    return backend.parse_List(node)


def parse_Dict(node):
    return backend.parse_Dict(node)


def parse_arguments(node):
    return backend.parse_arguments(node)


def parse_arg(node):
    return backend.parse_arg(node)


def parse_Return(node):
    return backend.parse_Return(node)


def parse_file(f):
    with open(f, 'r') as _f:
        source = _f.read()
    return backend.py_parse(source)


def compile_file(input_file, _backend):
    if input_file[-3:] != '.py':
        raise Exception

    # Hacky...
    global backend
    backend = _backend

    target_code = parse_file(input_file)
    output_file = input_file[:-3] + backend.ext

    if _backend.name == 'JavaScript':
        target_code = re.sub(r'(;)\1+', r'\1', target_code)

    with open(output_file, 'w') as f:
        print(target_code, file=f)

    print(f"{input_file} compiled successfully to {output_file}.")


if cli_args.target[0] == 'javascript':
    compile_file(cli_args.file[0], javascript)
else:
    raise Exception

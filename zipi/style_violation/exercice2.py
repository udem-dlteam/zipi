from zipi.style_violation import *
from zipi._runtime import *

# Tests

def ex2_variable_style(ast):
    id_ = ast.id
    if len(id_) < 3:
        return False
    else:
        return True

def ex2_maybe_long_expr(ast):
    if isinstance(ast, AST.UnaryOp):
        return ex2_maybe_long_expr(ast.operand)
    else:
        return isinstance(ast, AST.BinOp)

def ex2_is_long_expr(ast):
    if isinstance(ast, AST.UnaryOp):
        return ex2_is_long_expr(ast.operand)
    elif isinstance(ast, AST.BinOp):
        return ex2_maybe_long_expr(ast.left) and ex2_maybe_long_expr(ast.right)
    else:
        return False


def ex2_stringify_op(ast):
    if isinstance(ast, AST.Add):
        return '+'
    elif isinstance(ast, AST.Sub):
        return '-'
    elif isinstance(ast, AST.Mult):
        return '*'
    elif isinstance(ast, AST.Div):
        return '/'
    elif isinstance(ast, AST.FloorDiv):
        return '//'
    elif isinstance(ast, AST.Mod):
        return '%'
    elif isinstance(ast, AST.LShift):
        return '<<'
    elif isinstance(ast, AST.RShift):
        return '>>'
    elif isinstance(ast, AST.BitAnd):
        return '&'
    elif isinstance(ast, AST.BitOr):
        return '|'
    elif isinstance(ast, AST.BitXor):
        return '^'
    elif isinstance(ast, AST.Pow):
        return '**'
    elif isinstance(ast, AST.MatMult):
        return '@'
    elif isinstance(ast, AST.USub):
        return '-'
    elif isinstance(ast, AST.UAdd):
        return ''
    else:
        return "?"


def ex2_stringify_expr(ast):
    if isinstance(ast, AST.UnaryOp):
        return ex2_stringify_op(ast.op) + ex2_stringify_expr(ast.operand)
    elif isinstance(ast, AST.BinOp):
        return "(" + ex2_stringify_expr(ast.left) + ex2_stringify_op(ast.op) + ex2_stringify_expr(ast.right) + ")"
    elif isinstance(ast, AST.Constant):
        return str(ast.value)
    elif isinstance(ast, AST.Name):
        return ast.id
    else:
        return "(?)"


def ex2_no_duplicate_expr(ast, state):
    if ex2_is_long_expr(ast):
        ast_repr = ex2_stringify_expr(ast)

        seen = dict_get(state, ast_repr, False)
        dict_set(state, ast_repr, True)

        return not seen
    else:
        return True


ex2_rules = define_rules(
    [code_startswith([
        statement_is_assignment("first statement must be an assignment")]),
        code_endswith([
            statement_is_call_to("print", "last statement must be a call to print")]),
        all_satisfy(select(is_Name()), satisfies_condition(ex2_variable_style, "variables format")),
        all_satisfy(select(is_arithmetic_expression()),
                    satisfies_global_condition(ex2_no_duplicate_expr, make_dict, "No duplicate expressions"))
    ]
)
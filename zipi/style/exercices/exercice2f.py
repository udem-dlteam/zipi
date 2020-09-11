from zipi.style import *
from zipi._runtime import *

# Tests

def ex2_variable_style(ast):
    id_ = ast.id
    id_len = len(id_)
    if id_len < 3:
        return False
    else:
        first_code = ord(id_[0])
        if first_code < 97 and first_code > 122:
            return False
        else:
            i = 1
            while i < id_len:
                code = ord(id_[i])

                if code < 65 or code > 90 and code < 97 or  code > 122:
                    return False

                i += 1
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
        return ex2_maybe_long_expr(ast.left) or ex2_maybe_long_expr(ast.right)
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

def is_a_number(x):
    return isinstance(x, int) or isinstance(x, float)

def ex2_get_binop(ast):

    def check_inputs_are_number(fn):
        return lambda x, y, env: fn(x, y) if is_a_number(x) and is_a_number(y) else exec_error(env)

    if isinstance(ast, AST.Add):
        return check_inputs_are_number(lambda x, y: x + y)
    elif isinstance(ast, AST.Sub):
        return check_inputs_are_number(lambda x, y: x - y)
    elif isinstance(ast, AST.Mult):
        return check_inputs_are_number(lambda x, y: x * y)
    elif isinstance(ast, AST.Div):
        return check_inputs_are_number(lambda x, y: x / y)
    elif isinstance(ast, AST.FloorDiv):
        return check_inputs_are_number(lambda x, y: x // y)
    elif isinstance(ast, AST.Mod):
        return check_inputs_are_number(lambda x, y: x % y)
    elif isinstance(ast, AST.Pow):
        return check_inputs_are_number(lambda x, y: x ** y)
    else:
        return None

def ex2_get_unaryop(ast):
    def check_input_is_float(fn):
        return lambda x, env: fn(x) if is_a_number(x) else exec_error(env)

    if isinstance(ast, AST.UAdd):
        return check_input_is_float(lambda x: x)
    elif isinstance(ast, AST.USub):
        return check_input_is_float(lambda x: -x)
    else:
        return None

NONE_OBJECT = ["NONE_OBJECT"]
ERROR = ["ERROR"]

def is_NONE_OBJECT(obj):
    return isinstance(obj, list) and len(obj) == 1 and obj[0] == "NONE_OBJECT"

def is_ERROR(obj):
    return isinstance(obj, list) and len(obj) == 1 and obj[0] == "ERROR"

def exec_error(env):
    dict_set(env, '@error', True)
    return ERROR

def exec_expression(expr, env):
    if isinstance(expr, AST.Constant):
        value = expr.value

        if int_instance(value):
            return int_to_num(value)
        elif float_instance(value):
            return float_to_num(value)
        else:
            return exec_error(env)

    elif isinstance(expr, AST.BinOp):
        left = exec_expression(expr.left, env)
        right = exec_expression(expr.right, env)
        op = ex2_get_binop(expr.op)
        if is_ERROR(left) or is_ERROR(right) or is_ERROR(op):
            return ERROR
        else:
            return op(left, right, env)

    elif isinstance(expr, AST.UnaryOp):
        operand = exec_expression(expr.operand, env)
        op = ex2_get_unaryop(expr.op)
        if is_ERROR(operand) or is_ERROR(op):
            return ERROR
        else:
            return op(operand, env)
    elif isinstance(expr, AST.Name):
        id_ = expr.id
        id_value = dict_get(env, id_, None)
        if id_value is None:
            return exec_error(env)
        else:
            return id_value

    elif isinstance(expr, AST.Call):
        fn = expr.func
        if isinstance(fn, AST.Name) and fn.id == "print":
            env_output = dict_get(env, '@output', None)
            output = []
            for arg in expr.args:
                arg_value = exec_expression(arg, env)
                if is_ERROR(arg_value):
                    return ERROR
                else:
                    output.append(arg_value)

            for item in output:
                env_output.append(item)

            return NONE_OBJECT
        else:
            return exec_error(env)
    else:
        return exec_error(env)


def exec_statement(stmt, env):

    if isinstance(stmt, AST.Assign) and len(stmt.targets) == 1 and isinstance(stmt.targets[0], AST.Name):
        id_ = stmt.targets[0].id
        expr = stmt.value
        expr_value = exec_expression(expr, env)

        if is_ERROR(expr_value):
            return ERROR
        else:
            dict_set(env, id_, expr_value)
            return None
    elif isinstance(stmt, AST.Expr):
        return exec_expression(stmt.value, env)
    else:
        return exec_error(env)

def output_is_correct(ast):
    def make_constant(val, kind):
        return Constant(val, kind)

    def result_is_correct(principal, duration, interest, result):
        if isinstance(result, float) or isinstance(result, int):
            expected = principal * ((1 + interest / (12 * 100)) ** duration * interest / (12 * 100)) / (
                        (1 + interest / (12 * 100)) ** duration - 1)

            diff = result - expected
            abs_diff = diff if diff >= 0 else -diff

            return abs_diff / expected < 1e-9
        else:
            return False


    def test(principal, duration, interest):
        env = make_dict()
        dict_set(env, '@output', [])
        dict_set(env, '@error', False)

        body = ast.body

        p_assignation_targets = body[0].targets
        n_assignation_targets = body[1].targets
        i_assignation_targets = body[2].targets

        test_p_assignation = Assign(p_assignation_targets, make_constant(principal, None), [])
        test_n_assignation = Assign(n_assignation_targets, make_constant(duration, None), [])
        test_i_assignation = Assign(i_assignation_targets, make_constant(interest, None), [])

        test_body = [test_p_assignation, test_n_assignation, test_i_assignation]

        j = 3
        body_len = len(body)

        while j < body_len:
            test_body.append(body[j])
            j += 1

        for stmt in test_body:
            exec_statement(stmt, env)
            if dict_get(env, '@error', False):
                return False

        output = dict_get(env, '@output', [])

        if len(output) == 1:
            test_result = output[0]
            if result_is_correct(principal, duration, interest, test_result):
                return True
            else:
                return False
        else:
            return False

    principal_sample = [100, 150, 500, 5000, 25000, 123456, 234567, 1000000, 2005000]
    duration_sample = [1, 2, 3, 5, 10, 15, 24, 50, 100, 120, 150, 199, 250, 300, 360, 720, 12000]
    interest_sample = [0.1, 0.5, 0.8, 1.0, 1.2, 2.0, 2.5, 3.0, 3.5, 4.5, 6.5, 7.5, 8.5, 10.0, 15.0, 25.0]

    # NOTE: zp does not support nested for loops
    index_p = 0
    while index_p < len(principal_sample):
        index_d = 0
        while index_d < len(duration_sample):
            index_i = 0
            while index_i < len(interest_sample):
                if not test(principal_sample[index_p], duration_sample[index_d], interest_sample[index_i]):
                    return False
                index_i += 1
            index_d += 1
        index_p += 1
    return True

# Binds 'make_dict' in this scope for usage in JS quiz
make_dict = make_dict

ex2f_rules = define_rules(
    [code_startswith([
        statement_is_assignment("Les trois premières expressions doivent être des affectations"),
        statement_is_assignment("Les trois premières expressions doivent être des affectations"),
        statement_is_assignment("Les trois premières expressions doivent être des affectations")]),
        code_endswith([
            statement_is_call_to("print", "La dernière expression doit être une appel à 'print'")]),
        all_satisfy(select(is_Name()),
                    satisfies_condition(ex2_variable_style, "Chaque variable doit être composée uniquement de lettres, comporter au moins trois caractères et commencer par une lettre minuscule")),
        all_satisfy(select(is_arithmetic_expression()),
                    satisfies_global_condition(ex2_no_duplicate_expr, make_dict, "Cette expression arithmétique a déjà été calculée")),
        if_no_error(
            module_statisfies(satisfies_condition(output_is_correct, "Résultat incorrect")))
    ]
)
from zipi.zast._zast import *

import zipi.zast._zast as AST
import zipi.zast as zast
AST.parse = zast.parse

from zipi._runtime import *


# ======================================================================================================================
# Rules object
# ======================================================================================================================

def init_rules():
    """Initialize an empty set of rules"""
    return []


def add_rules(rules, new_rule):
    """Add a rule to an already existing set of rules"""
    rules.append(new_rule)


def define_rules(rules_list):
    """Initialize a new set of rules with the given rules"""
    rules = init_rules()

    for item in rules_list:
        add_rules(rules, item)

    return rules


def apply_rules(rules, ast):
    """Apply a set of rules to the ast, returning all broken rules as a pair (ast node, error message)"""
    errors = []
    for rule in rules:
        rule(ast, errors)



    return errors


# ======================================================================================================================
# Constraints on AST
# ======================================================================================================================


# Due to zp import mecanism, sentinel object are sometimes duplicated and need to be identified by structure
NO_STATEMENT = ["NO_STATEMENT"]
IS_STATEFUL_PREDICATE = ["IS_STATEFUL_PREDICATE"]

def is_NOT_STATEMENT(obj):
    return isinstance(obj, list) and len(obj) == 1 and obj[0] == "NO_STATEMENT"

def is_IS_STATEFUL_PREDICATE(obj):
    return isinstance(obj, list) and len(obj) == 1 and obj[0] == "IS_STATEFUL_PREDICATE"


# Helpers

def __register_error(errors, location, new_error):
    errors.append((location, new_error))


def __register_many_error(errors, new_errors):
    for e in new_errors:
        errors.append(e)


def __is_variable_with_name(ast, name):
    return isinstance(ast, AST.Name) and ast.id == name


def __predicate_requires_init(pred):
    if isinstance(pred, tuple) and is_IS_STATEFUL_PREDICATE(pred[0]):
        return True
    else:
        return False


def __init_predicate(pred):
    if __predicate_requires_init(pred):
        return pred[1]()
    else:
        return pred


def __make_stateful_predicate(pred):
    return (IS_STATEFUL_PREDICATE, pred)


# Conditions on statment

def statement_is(ast_type, error_msg):
    """Assert that a statement is of a given type"""

    def test(ast, errors):
        if isinstance(ast, ast_type):
            return True
        else:
            __register_error(errors, ast, error_msg)
            return False

    return test


def statement_is_assignment(error_msg):
    """Assert that a statement is an assignment"""

    def test(ast, errors):
        if isinstance(ast, AST.Assign):
            return True
        else:
            __register_error(errors, ast, error_msg)
            return False

    return test


def statement_is_assignment_to(name, error_msg):
    """Assert that a statement is an assignment which assigns to a given name"""

    def test(ast, errors):
        if isinstance(ast, AST.Assign):
            for t in ast.targets:
                if __is_variable_with_name(t, name):
                    return True

        __register_error(errors, ast, error_msg)
        return False

    return test


def statement_is_call_to(fn_name, error_msg):
    """Assert that a statement is a call to a specific function name"""

    def test(ast, errors):
        if isinstance(ast, AST.Expr):
            expr_value = ast.value
            if isinstance(expr_value, AST.Call) and __is_variable_with_name(expr_value.func, fn_name):
                return True
            else:
                __register_error(errors, ast, error_msg)
                return False
        else:
            __register_error(errors, ast, error_msg)
            return False

    return test


def statement_exists(error_msg):
    """Assert that a statement exists, this can be used to check the code contains a minimum number of statements"""

    def test(ast, errors):
        if is_NOT_STATEMENT(ast):
            __register_error(errors, ast, error_msg)
            return False
        else:
            return True

    return test


def satisfies_condition(predicate, error_msg):
    """Assert that an AST node satisfies a custom condition"""

    def test(ast, errors):
        if predicate(ast):
            return True
        else:
            __register_error(errors, ast, error_msg)
            return False

    return test


def satisfies_global_condition(stateful_predicate, state_init, error_msg):
    """
    Assert that an AST node satisfies a custom condition
    This method also allows the predicate to mutate and keep track of a global state
    """

    def test_init():
        state = state_init()
        def test(ast, errors):
            if stateful_predicate(ast, state):
                return True
            else:
                __register_error(errors, ast, error_msg)
                return False

        return test
    return __make_stateful_predicate(test_init)


# Conditions on code

def code_startswith(predicates_seq):
    """Assert that the module's code starts with a sequence of statements which each obey a given rule"""

    def test(module, errors):
        body = module.body

        body_len = len(body)
        predicates_len = len(predicates_seq)
        i = 0

        any_error = False

        while i < predicates_len:
            pred = predicates_seq[i]
            res = pred(body[i] if i < body_len else NO_STATEMENT, errors)
            any_error = any_error or not res
            i += 1

        return any_error

    return test


def code_endswith(predicates_seq):
    """Assert that the module's code ends with a sequence of statements which each obey a given rule"""

    def test(module, errors):
        body = module.body

        body_len = len(body)
        predicates_len = len(predicates_seq)
        predicate_i = predicates_len - 1
        body_i = body_len - 1

        any_error = False

        while predicate_i >= 0:
            pred = predicates_seq[predicate_i]
            statement = body[body_i] if body_i >= 0 else NO_STATEMENT
            res = pred(statement, errors)
            any_error = any_error or not res
            predicate_i -= 1
            body_i -= 1

        return any_error

    return test

def if_no_error(test):
    """Execute a test only no errors occured yet"""

    def conditional_test(ast, errors):
        if len(errors) > 0:
            return False
        else:
            return test(ast, errors)

    return conditional_test


# Conditions on set of node

def all_satisfy(selector, predicate):
    """Assert that all nodes walked on by selector satisfy the given predicate"""

    def test(module, errors):
        return selector(module, __init_predicate(predicate), errors)

    return test


def module_statisfies(predicate):
    """
    Assert that the whole module satisfies the given predicate
    Allows running a custom predicate on the whole code
    """

    def test(module, errors):
        return predicate(module, errors)

    return test

# Walkers

def select(select_predicate):
    """Walks on all nodes which satisfy 'select_predicate'"""

    def selector(ast, predicate, errors):
        if not hasattr(ast, '_fields'):  # Hack to check: 'not isinstance(ast, AST.AST)' with zp
            return True
        if select_predicate(ast):
            any_error = not predicate(ast, errors)
        else:
            any_error = False

        fields = ast._fields
        for attr in fields:
            child = getattr(ast, attr)

            if child is None:
                pass
            elif isinstance(child, list):
                for elt in child:
                    any_error = not selector(elt, predicate, errors) or any_error
            else:
                any_error = not selector(child, predicate, errors) or any_error
        return any_error

    return selector


# Selector conditions

def is_kind(ast_type):
    """Selector predicates which selects only nodes of a given type"""
    return lambda ast: isinstance(ast, ast_type)

def is_Name():
    return lambda ast: isinstance(ast, AST.Name)


def is_one_of_kinds(ast_types):
    """Selector predicates which selects only nodes of a given type"""

    def test(ast):
        for t in ast_types:
            if isinstance(ast, t):
                return True
        return False

    return test

def is_arithmetic_expression():
    return lambda ast: isinstance(ast, AST.BinOp) or isinstance(ast, AST.UnaryOp)


# Miscellaneous

empty_rules = define_rules([])

# Parse source and return error locations

def default_compilation_error(start_line0,
                         start_column0,
                         end_line0,
                         end_column0, error_kind, msg):
    return lambda rte, __: runtime_print(error_kind + " at line " + str(end_line0) + ": " + msg, rte)

def get_style_violations(rules, source, compilationError):
    ast = AST.parse(source, '<unknown>', 'exec', False)

    error_messages = apply_rules(rules, ast)

    if len(error_messages) == 0:
        return False
    else:
        error_pos, msg = error_messages[0]

        # If the error happens due to a missing statement, the flag NO_STATEMENT is returned
        # Or happens on the whole Module
        # Then we need to manually set a location
        if is_NOT_STATEMENT(error_pos) or isinstance(error_pos, AST.Module):
            body = ast.body

            if len(body) == 0:
                virtual_error_lineno = 0
                virtual_error_end_lineno = 0
                virtual_error_col_offset = 0
                virtual_error_end_col_offset = 0
            else:
                first_stmt = body[0]
                last_stmt = body[len(body)-1]
                virtual_error_lineno = first_stmt.lineno
                virtual_error_end_lineno = last_stmt.end_lineno
                virtual_error_col_offset = first_stmt.col_offset
                virtual_error_end_col_offset = last_stmt.end_col_offset
        else:
            virtual_error_lineno = error_pos.lineno
            virtual_error_end_lineno = error_pos.end_lineno
            virtual_error_col_offset = error_pos.col_offset
            virtual_error_end_col_offset = error_pos.end_col_offset

        compilationError(virtual_error_lineno,
                         virtual_error_col_offset,
                         virtual_error_end_lineno,
                         virtual_error_end_col_offset,
                         "StyleError",
                         msg)

        return True

"""
This module allows to define style constraint on the AST and to enforce it usage
"""

import zipi.zast._zast as AST
import zipi.zast as zast

AST.parse = zast.parse

from pprint import pprint as print


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

NO_STATEMENT = None


# Helpers

def __register_error(errors, new_error):
    errors.append(new_error)


def __register_many_error(errors, new_errors):
    for e in new_errors:
        errors.append(e)


def __is_variable_with_name(ast, name):
    return isinstance(ast, AST.Name) and ast.id == name

# Conditions on statment

def statement_is(ast_type, error_msg):
    """Assert that a statement is of a given type"""

    def test(ast, errors):
        if isinstance(ast, ast_type):
            return True
        else:
            __register_error(errors, (ast, error_msg))
            return False

    return test


def statement_is_assignment(error_msg):
    """Assert that a statement is an assignment"""
    return statement_is(AST.Assign, error_msg)


def statement_is_assignment_to(name, error_msg):
    """Assert that a statement is an assignment which assigns to a given name"""

    def test(ast, errors):
        if isinstance(ast, AST.Assign):
            for t in ast.targets:
                if __is_variable_with_name(t, name):
                    return True

        __register_error(errors, (ast, error_msg))
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
                __register_error(errors, (ast, error_msg))
                return False
        else:
            __register_error(errors, (ast, error_msg))
            return False

    return test


def statement_exists(error_msg):
    """Assert that a statement exists, this can be used to check the code contains a minimum number of statements"""

    def test(ast, errors):
        if ast is NO_STATEMENT:
            __register_error(errors, (ast, error_msg))
            return False
        else:
            return True

    return test

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

# Conditions on set of node

def all_satisfy(selector, predicate):
    def test(module, errors):
        return selector(module, predicate, errors)
    return test

# Walkers

def select(select_predicate):
    def selector(ast, predicate, errors):
        if not isinstance(ast, AST.AST):
            return True
        if select_predicate(ast):
            any_error = predicate(ast, errors)
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
    return lambda ast: isinstance(ast, ast_type)




# Tests

def is_variable_with_length_3(ast, errors):
    if isinstance(ast.ctx, AST.Store):
        id_ = ast.id
        if len(id_) < 3:
            __register_error(errors, (ast, "Variable names must contain at least three characters"))
            return False
        else:
            return True
    else:
        return True

rules = define_rules(
    [code_startswith([
        statement_is_assignment("first statement must be an assignment")]),
    code_endswith([
        statement_is_call_to("print", "last statement must be a call to print")]),
    all_satisfy(select(is_kind(AST.Name)), is_variable_with_length_3)
    ]
)

a = AST.parse("""
y=2
xx=5
ghj=5
""")

print(apply_rules(rules, a))

"""
This module allows to define style constraint on the AST and to enforce it usage
"""

import zipi.zast._zast as AST
import zipi.zast as zast
AST.parse = zast.parse

# ======================================================================================================================
# Rules object
# ======================================================================================================================

def init_rules():
    return []

def add_rules(rules, new_rule):
    rules.append(new_rule)

def define_rules(rules_list):
    rules = init_rules()

    for item in rules_list:
        add_rules(rules, item)

    return rules

# ======================================================================================================================
# Constraints on AST
# ======================================================================================================================

def statement_is(ast_type, error_msg):
    def test(ast, errors):
        if isinstance(ast, ast_type):
            return True
        else:
            errors.append((ast, error_msg))
            return False

    return test

def code_startswith(predicates_seq):
    def test(module, errors):
        body = module.body

        body_len = len(body)
        predicates_len = len(predicates_seq)
        i = 0

        any_error = False

        while i < predicates_len:
            pred = predicates_seq[i]
            res = pred(body[i] if i < body_len else None, errors)
            any_error = any_error or not res
            i += 1

        return any_error
    return test


a = AST.parse("1+1\n1")

test = code_startswith([statement_is(AST.Assign, "first three statement must be assignations")])

l = []
test(a, l)
print(l)
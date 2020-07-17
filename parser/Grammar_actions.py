# File: Grammar_actions.py

{
"prelude":
"from _zast import *\n\
"



,"file_input: stmts ENDMARKER.":
   ["return Module(stmts1,[])"]



,"stmts: .(NEWLINE | stmt)*":
   ["asts = []",""]
,"stmts: (NEWLINE | stmt.)*":
   ["asts.append(stmt1)"]
,"stmts: (NEWLINE | stmt)*.":
   ["return asts"]


,"stmt: simple_stmt.":
   ["return simple_stmt1"]

,"stmt: compound_stmt.":
   ["return compound_stmt1"]


,"simple_stmt: small_stmt NEWLINE.":
   ["return small_stmt1"]


,"small_stmt: expr_stmt.":
   ["return expr_stmt1"]

,"small_stmt: del_stmt.":
   ["return del_stmt1"]

,"small_stmt: pass_stmt.":
   ["return pass_stmt1"]

,"small_stmt: flow_stmt.":
   ["return flow_stmt1"]

,"small_stmt: import_stmt.":
   ["return import_stmt1"]

,"small_stmt: global_stmt.":
   ["return global_stmt1"]

,"small_stmt: nonlocal_stmt.":
   ["return nonlocal_stmt1"]

,"small_stmt: assert_stmt.":
   ["return assert_stmt1"]


,"expr_stmt: .test":
   ["lineno = get_lineno(ts); col_offset = get_col_offset(ts)"]
,"expr_stmt: test.":
   ["ast = Expr(test1)\n"
    "return set_start_end(ts, lineno, col_offset, ast)"]


,"expr_stmt: .testlist_star_expr (annassign | augassign (yield_expr|testlist) | [('=' (yield_expr|testlist_star_expr))+ [TYPE_COMMENT]] )":
   ["lineno = get_lineno(ts); col_offset = get_col_offset(ts)"]
,"expr_stmt: testlist_star_expr. (annassign | augassign (yield_expr|testlist) | [('=' (yield_expr|testlist_star_expr))+ [TYPE_COMMENT]] )":
   ["targets = [testlist_star_expr1]\n"
    "type_comment = None"]
,"expr_stmt: testlist_star_expr (annassign | augassign (yield_expr|testlist) | [('=' (yield_expr|testlist_star_expr))+. [TYPE_COMMENT]] )":
   ["ast = Assign(targets, testlist_star_expr2, type_comment)\n"
    "for i in range(len(targets)):\n"
    "    t = targets[i]\n"
    "    t.ctx = Store()\n"
    "    if isinstance(t, Tuple):\n"
    "        for j in range(len(t.elts)):\n"
    "            t.elts[j].ctx = Store()\n"
    "return set_start_end(ts, lineno, col_offset, ast)"]
,"expr_stmt: testlist_star_expr (annassign | augassign (yield_expr|testlist) | [('=' (yield_expr|testlist_star_expr))+ [TYPE_COMMENT]]. )":
   ["ast = Expr(testlist_star_expr1)\n"
    "return set_start_end(ts, lineno, col_offset, ast)"]


,"star_expr: .'*' expr":
   ["lineno = get_lineno(ts); col_offset = get_col_offset(ts)"]
,"star_expr: '*' expr.":
   ["ast = Starred(expr1, Load())\n"
    "return set_start_end(ts, lineno, col_offset, ast)"]


,"del_stmt: .'del' exprlist":
   ["lineno = get_lineno(ts); col_offset = get_col_offset(ts)"]
,"del_stmt: 'del' exprlist.":
   ["ast = Delete(exprlist1)\n"
    "for i in range(len(exprlist1)):\n"
    "    exprlist1[i].ctx = Del()\n"
    "return set_start_end(ts, lineno, col_offset, ast)"]


,"pass_stmt: .'pass'":
   ["ast = set_start_end_1token(ts, Pass())"]
,"pass_stmt: 'pass'.":
   ["return ast"]


,"flow_stmt: break_stmt.":
   ["return break_stmt1"]

,"flow_stmt: continue_stmt.":
   ["return continue_stmt1"]

,"flow_stmt: return_stmt.":
   ["return return_stmt1"]

,"flow_stmt: raise_stmt.":
   ["return raise_stmt1"]

,"flow_stmt: yield_stmt.":
   ["return yield_stmt1"]


,"break_stmt: .'break'":
   ["ast = set_start_end_1token(ts, Break())"]
,"break_stmt: 'break'.":
   ["return ast"]


,"continue_stmt: .'continue'":
   ["ast = set_start_end_1token(ts, Continue())"]
,"continue_stmt: 'continue'.":
   ["return ast"]


,"return_stmt: .'return' [testlist_star_expr]":
   ["lineno = get_lineno(ts); col_offset = get_col_offset(ts)\n"
    "value = None"]
,"return_stmt: 'return' [testlist_star_expr.]":
   ["value = testlist_star_expr1\n"]
,"return_stmt: 'return' [testlist_star_expr].":
   ["ast = Return(value)\n"
    "return set_start_end(ts, lineno, col_offset, ast)"]


,"yield_stmt: .yield_expr":
   ["lineno = get_lineno(ts); col_offset = get_col_offset(ts)"]
,"yield_stmt: yield_expr.":
   ["ast = Expr(yield_expr1)\n"
    "return set_start_end(ts, lineno, col_offset, ast)"]

,"yield_expr: .'yield' [yield_arg]":
   ["lineno = get_lineno(ts); col_offset = get_col_offset(ts)"]
,"yield_expr: 'yield' [yield_arg.]":
   ["return yield_arg1"]
,"yield_expr: 'yield' [yield_arg].":
   ["ast = Yield(None)\n"
    "return set_start_end(ts, lineno, col_offset, ast)"]


,"augassign: '+='.":   ["return Add()"]

,"augassign: '-='.":   ["return Sub()"]

,"augassign: '*='.":   ["return Mult()"]

,"augassign: '@='.":   ["return MatMult()"]

,"augassign: '/='.":   ["return Div()"]

,"augassign: '%='.":   ["return Mod()"]

,"augassign: '&='.":   ["return BitAnd()"]

,"augassign: '|='.":   ["return BitOr()"]

,"augassign: '^='.":   ["return BitXor()"]

,"augassign: '<<='.":  ["return LShift()"]

,"augassign: '>>='.":  ["return RShift()"]

,"augassign: '**='.":  ["return Pow()"]

,"augassign: '//='.":  ["return FloorDiv()"]


,"raise_stmt: .'raise' [test ['from' test]]":
   ["lineno = get_lineno(ts); col_offset = get_col_offset(ts)\n"
    "exc = None\n"
    "cause = None"]
,"raise_stmt: 'raise' [test. ['from' test]]":
   ["exc = test1"]
,"raise_stmt: 'raise' [test ['from' test.]]":
   ["cause = test2"]
,"raise_stmt: 'raise' [test ['from' test]].":
   ["ast = Raise(exc, cause)\n"
    "return set_start_end(ts, lineno, col_offset, ast)"]


,"test: .or_test ['if' or_test 'else' test]":
   ["lineno = get_lineno(ts); col_offset = get_col_offset(ts)"]
,"test: or_test ['if' or_test 'else' test.]":
   ["ast = IfExp(or_test2, or_test1, test1)\n"
    "return set_start_end(ts, lineno, col_offset, ast)"]
,"test: or_test ['if' or_test 'else' test].":
   ["return or_test1"]


,"test: lambdef.":
   ["return lambdef1"]


,"lambdef: .'lambda' [varargslist] ':' test":
   ["lineno = get_lineno(ts); col_offset = get_col_offset(ts)\n"
    "args = None"]
,"lambdef: 'lambda' [varargslist.] ':' test":
   ["args = varargslist1"]
,"lambdef: 'lambda' [varargslist] ':' test.":
   ["if args is None:\n"
    "    args = arguments([], [], None, [], [], None, [])\n"
    "ast = Lambda(args, test1)\n"
    "return set_start_end(ts, lineno, col_offset, ast)"]


,"or_test: .and_test ('or' and_test)*":
   ["lineno = get_lineno(ts); col_offset = get_col_offset(ts)"]
,"or_test: and_test. ('or' and_test)*":
   ["asts = [and_test1]"]
,"or_test: and_test ('or' and_test.)*":
   ["asts.append(and_test2)"]
,"or_test: and_test ('or' and_test)*.":
   ["if len(asts) == 1:\n"
    "    return asts[0]\n"
    "else:\n"
    "    ast = BoolOp(Or(), asts)\n"
    "    return set_start_end(ts, lineno, col_offset, ast)"]


,"and_test: .not_test ('and' not_test)*":
   ["lineno = get_lineno(ts); col_offset = get_col_offset(ts)"]
,"and_test: not_test. ('and' not_test)*":
   ["asts = [not_test1]"]
,"and_test: not_test ('and' not_test.)*":
   ["asts.append(not_test2)"]
,"and_test: not_test ('and' not_test)*.":
   ["if len(asts) == 1:\n"
    "    return asts[0]\n"
    "else:\n"
    "    ast = BoolOp(And(), asts)\n"
    "    return set_start_end(ts, lineno, col_offset, ast)"]


,"not_test: .'not' not_test":
   ["lineno = get_lineno(ts); col_offset = get_col_offset(ts)"]
,"not_test: 'not' not_test.":
   ["ast = UnaryOp(Not(), not_test1)\n"
    "return set_start_end(ts, lineno, col_offset, ast)"]


,"not_test: comparison.":
   ["return comparison1"]


,"comparison: .expr (comp_op expr)*":
   ["lineno = get_lineno(ts); col_offset = get_col_offset(ts)"]
,"comparison: expr. (comp_op expr)*":
   ["ops = []\n"
    "comparators = []"]
,"comparison: expr (comp_op expr.)*":
   ["ops.append(comp_op1)\n"
    "comparators.append(expr2)"]
,"comparison: expr (comp_op expr)*.":
   ["if len(ops) == 0:\n"
    "    return expr1\n"
    "else:\n"
    "    ast = Compare(expr1, ops, comparators)\n"
    "    return set_start_end(ts, lineno, col_offset, ast)"]


,"comp_op: '<'.":   ["return Lt()"]

,"comp_op: '>'.":   ["return Gt()"]

,"comp_op: '=='.":  ["return Eq()"]

,"comp_op: '>='.":  ["return GtE()"]

,"comp_op: '<='.":  ["return LtE()"]


,"expr: .xor_expr ('|' xor_expr)*":
   ["lineno = get_lineno(ts); col_offset = get_col_offset(ts)"]
,"expr: xor_expr. ('|' xor_expr)*":
   ["ast = xor_expr1"]
,"expr: xor_expr ('|' xor_expr.)*":
   ["ast = BinOp(ast, BitOr(), xor_expr2)\n"
    "set_start_end(ts, lineno, col_offset, ast)"]
,"expr: xor_expr ('|' xor_expr)*.":
   ["return ast"]


,"xor_expr: .and_expr ('^' and_expr)*":
   ["lineno = get_lineno(ts); col_offset = get_col_offset(ts)"]
,"xor_expr: and_expr. ('^' and_expr)*":
   ["ast = and_expr1"]
,"xor_expr: and_expr ('^' and_expr.)*":
   ["ast = BinOp(ast, BitXor(), and_expr2)\n"
    "set_start_end(ts, lineno, col_offset, ast)"]
,"xor_expr: and_expr ('^' and_expr)*.":
   ["return ast"]


,"and_expr: .shift_expr ('&' shift_expr)*":
   ["lineno = get_lineno(ts); col_offset = get_col_offset(ts)"]
,"and_expr: shift_expr. ('&' shift_expr)*":
   ["ast = shift_expr1"]
,"and_expr: shift_expr ('&' shift_expr.)*":
   ["ast = BinOp(ast, BitAnd(), shift_expr2)\n"
    "set_start_end(ts, lineno, col_offset, ast)"]
,"and_expr: shift_expr ('&' shift_expr)*.":
   ["return ast"]


,"shift_expr: .arith_expr (('<<'|'>>') arith_expr)*":
   ["lineno = get_lineno(ts); col_offset = get_col_offset(ts)"]
,"shift_expr: arith_expr. (('<<'|'>>') arith_expr)*":
   ["ast = arith_expr1"]
,"shift_expr: arith_expr (.('<<'|'>>') arith_expr)*":
   ["if ts.token == LEFTSHIFT:\n"
    "    op = LShift()\n"
    "else:\n"
    "    op = RShift()"]
,"shift_expr: arith_expr (('<<'|'>>') arith_expr.)*":
   ["ast = BinOp(ast, op, arith_expr2)\n"
    "set_start_end(ts, lineno, col_offset, ast)"]
,"shift_expr: arith_expr (('<<'|'>>') arith_expr)*.":
   ["return ast"]


,"arith_expr: .term (('+'|'-') term)*":
   ["lineno = get_lineno(ts); col_offset = get_col_offset(ts)"]
,"arith_expr: term. (('+'|'-') term)*":
   ["ast = term1"]
,"arith_expr: term (.('+'|'-') term)*":
   ["if ts.token == PLUS:\n"
    "    op = Add()\n"
    "else:\n"
    "    op = Sub()"]
,"arith_expr: term (('+'|'-') term.)*":
   ["ast = BinOp(ast, op, term2)\n"
    "set_start_end(ts, lineno, col_offset, ast)"]
,"arith_expr: term (('+'|'-') term)*.":
   ["return ast"]


,"term: .factor (('*'|'@'|'/'|'%'|'//') factor)*":
   ["lineno = get_lineno(ts); col_offset = get_col_offset(ts)"]
,"term: factor. (('*'|'@'|'/'|'%'|'//') factor)*":
   ["ast = factor1"]
,"term: factor (.('*'|'@'|'/'|'%'|'//') factor)*":
   ["if ts.token == STAR:\n"
    "    op = Mult()\n"
    "elif ts.token == SLASH:\n"
    "    op = Div()\n"
    "elif ts.token == AT:\n"
    "    op = MatMult()\n"
    "elif ts.token == DOUBLESLASH:\n"
    "    op = FloorDiv()\n"
    "else:\n"
    "    op = Mod()"]
,"term: factor (('*'|'@'|'/'|'%'|'//') factor.)*":
   ["ast = BinOp(ast, op, factor2)\n"
    "set_start_end(ts, lineno, col_offset, ast)"]
,"term: factor (('*'|'@'|'/'|'%'|'//') factor)*.":
   ["return ast"]


,"factor: .('+'|'-'|'~') factor":
   ["lineno = get_lineno(ts); col_offset = get_col_offset(ts)\n"
    "if ts.token == PLUS:\n"
    "    op = UAdd()\n"
    "elif ts.token == MINUS:\n"
    "    op = USub()\n"
    "else:\n"
    "    op = Invert()"]
,"factor: ('+'|'-'|'~') factor.":
   ["ast = UnaryOp(op, factor1)\n"
    "return set_start_end(ts, lineno, col_offset, ast)"]


,"factor: power.":
   ["return power1"]


,"power: .atom_expr ['**' factor]":
   ["lineno = get_lineno(ts); col_offset = get_col_offset(ts)"]
,"power: atom_expr ['**' factor.]":
   ["ast = BinOp(atom_expr1, Pow(), factor1)\n"
    "return set_start_end(ts, lineno, col_offset, ast)"]
,"power: atom_expr ['**' factor].":
   ["return atom_expr1"]


,"atom_expr: .[AWAIT] atom trailer*":
   ["lineno = get_lineno(ts); col_offset = get_col_offset(ts)\n"
    "has_await = False"
   ]
,"atom_expr: [.AWAIT] atom trailer*":
   ["has_await = True"]
,"atom_expr: [AWAIT] atom. trailer*":
   ["ast = atom1"]
,"atom_expr: [AWAIT] atom trailer.*":
   ["ast = trailer1"]
,"atom_expr: [AWAIT] atom trailer*.":
   ["if has_await:\n"
    "    ast = Await(ast)\n"
    "    set_start_end(ts, lineno, col_offset, ast)\n"
    "return ast"]


,"yield_arg": ",lineno,col_offset"


,"yield_arg: 'from' test.":
   ["ast = YieldFrom(test1)\n"
    "return set_start_end(ts, lineno, col_offset, ast)"]

,"yield_arg: testlist_star_expr.":
   ["ast = Yield(testlist_star_expr1)\n"
    "return set_start_end(ts, lineno, col_offset, ast)"]


,"testlist_star_expr: .(test|star_expr) (',' (test|star_expr))* [',']":
   ["lineno = get_lineno(ts); col_offset = get_col_offset(ts)"]
,"testlist_star_expr: (test.|star_expr) (',' (test|star_expr))* [',']":
   ["test_or_star_expr1 = test1"]
,"testlist_star_expr: (test|star_expr.) (',' (test|star_expr))* [',']":
   ["test_or_star_expr1 = star_expr1"]
,"testlist_star_expr: (test|star_expr) .(',' (test|star_expr))* [',']":
   ["tests = [test_or_star_expr1]\n"
    "force_tuple = False",
    ""]
,"testlist_star_expr: (test|star_expr) (',' (test.|star_expr))* [',']":
   ["tests.append(test2)"]
,"testlist_star_expr: (test|star_expr) (',' (test|star_expr.))* [',']":
   ["tests.append(star_expr2)"]
,"testlist_star_expr: (test|star_expr) (',' (test|star_expr))* [','.]":
   ["force_tuple = True"]
,"testlist_star_expr: (test|star_expr) (',' (test|star_expr))* [','].":
   ["if len(tests) == 1 and not force_tuple:\n"
    "    return test_or_star_expr1\n"
    "else:\n"
    "    ast = Tuple(tests, Load())\n"
    "    return set_start_end(ts, lineno, col_offset, ast)"]


,"exprlist: (expr.|star_expr) (',' (expr|star_expr))* [',']":
   ["expr_or_star_expr1 = expr1"]
,"exprlist: (expr|star_expr.) (',' (expr|star_expr))* [',']":
   ["expr_or_star_expr1 = star_expr1"]
,"exprlist: (expr|star_expr) .(',' (expr|star_expr))* [',']":
   ["exprs = [expr_or_star_expr1]",""]
,"exprlist: (expr|star_expr) (',' (expr.|star_expr))* [',']":
   ["expr_or_star_expr2 = expr2"]
,"exprlist: (expr|star_expr) (',' (expr|star_expr.))* [',']":
   ["expr_or_star_expr2 = star_expr2"]
,"exprlist: (expr|star_expr) (',' (expr|star_expr).)* [',']":
   ["exprs.append(expr_or_star_expr2)"]
,"exprlist: (expr|star_expr) (',' (expr|star_expr))* [','].":
   ["return exprs"]


,"subscriptlist: .subscript (',' subscript)* [',']":
   ["lineno = get_lineno(ts); col_offset = get_col_offset(ts)"]
,"subscriptlist: subscript. (',' subscript)* [',']":
   ["subscripts = [subscript1]\n"
    "force_tuple = False"]
,"subscriptlist: subscript (',' subscript.)* [',']":
   ["subscripts.append(subscript2)"]
,"subscriptlist: subscript (',' subscript)* [','.]":
   ["force_tuple = True"]
,"subscriptlist: subscript (',' subscript)* [','].":
   ["if len(subscripts) == 1 and not force_tuple:\n"
    "    return subscript1\n"
    "else:\n"
    "    ast = Tuple(subscripts, Load())\n"
    "    return set_start_end(ts, lineno, col_offset, ast)"]


,"trailer": ",lineno,col_offset,ast"

,"trailer: '('. [arglist] ')'":
   ["arglist1 = []"]
,"trailer: '(' [arglist]. ')'":
   ["ast = Call(ast, arglist1, [])"]
,"trailer: '(' [arglist] ')'.":
   ["return set_start_end(ts, lineno, col_offset, ast)"]

,"trailer: '[' subscriptlist. ']'":
   ["ast = Subscript(ast, Index(subscriptlist1), Load())"]
,"trailer: '[' subscriptlist ']'.":
   ["return set_start_end(ts, lineno, col_offset, ast)"]

,"trailer: '.' .NAME":
   ["ast = Attribute(ast, token(ts), Load())"]
,"trailer: '.' NAME.":
   ["return set_start_end(ts, lineno, col_offset, ast)"]


,"atom: '(' [yield_expr.|testlist_comp] ')'":
   ["ast = yield_expr1"]
,"atom: '(' [yield_expr|testlist_comp.] ')'":
   ["ast = testlist_comp1"]
,"atom: '(' [yield_expr|testlist_comp] ')'.":
   ["return ast"]

,"atom: .'[' [testlist_comp] ']'":
   ["lineno = get_lineno(ts); col_offset = get_col_offset(ts)"]
,"atom: '[' [testlist_comp.] ']'":
   [""]
,"atom: '[' [testlist_comp] ']'.":
   [""]

,"atom: .'{' [dictorsetmaker] '}'":
   ["lineno = get_lineno(ts); col_offset = get_col_offset(ts)"]
,"atom: '{' [dictorsetmaker.] '}'":
   [""]
,"atom: '{' [dictorsetmaker] '}'.":
   [""]


,"atom: .NAME":     ["ast = set_start_end_1token(ts, Name(token(ts), Load()))"]
,"atom: NAME.":     ["return ast"]


,"atom: .NUMBER":   ["ast = set_start_end_1token(ts, Constant(int(token(ts)), None))"]
,"atom: NUMBER.":   ["return ast"]


,"atom: .STRING+":  ["lineno = get_lineno(ts); col_offset = get_col_offset(ts)\n"
                     "end_lineno = 0\n"
                     "end_col_offset = 0\n"
                     "value = ''",
                     "end_lineno = get_end_lineno(ts)\n"
                     "end_col_offset = get_end_col_offset(ts)\n"
                     "value += token(ts)[1:-1] # FIXME! and add SyntaxError: cannot mix bytes and nonbytes literals"]
,"atom: STRING+.":  ["ast = Constant(value, None)\n"
                     "ast.lineno = lineno\n"
                     "ast.col_offset = col_offset\n"
                     "ast.end_lineno = end_lineno\n"
                     "ast.end_col_offset = end_col_offset\n"
                     "return ast"]


,"atom: .'...'":    ["ast = set_start_end_1token(ts, Constant(..., None))"]
,"atom: '...'.":    ["return ast"]


,"atom: .'None'":   ["ast = set_start_end_1token(ts, Constant(None, None))"]
,"atom: 'None'.":   ["return ast"]


,"atom: .'True'":   ["ast = set_start_end_1token(ts, Constant(True, None))"]
,"atom: 'True'.":   ["return ast"]


,"atom: .'False'":  ["ast = set_start_end_1token(ts, Constant(False, None))"]
,"atom: 'False'.":  ["return ast"]


,"testlist_comp: test.":
   ["return test1"]


,"argument: test.":
   ["return test1"]


,"arglist: argument. (',' argument)* [',']":
   ["arguments = [argument1]"]
,"arglist: argument (',' argument.)* [',']":
   ["arguments.append(argument2)"]
,"arglist: argument (',' argument)* [','].":
   ["return arguments"]


,"subscript: test.":
   ["return test1"]

}

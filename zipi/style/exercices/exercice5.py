from zipi.style import *
from zipi._runtime import *

def ctrl_char_hook(ts, pos):
    lineno = ts.line_num
    style_error = dict_get(ts.context, 'styleError', None)
    style_error(lineno, pos - 1, lineno, pos,
                "N’utilisez pas de caractère de contrôle, tel que le TAB, dans vos programmes")

def eol_hook(ts, pos, comment_start):
    line_len = pos - ts.line_start
    lineno = ts.line_num
    style_error = dict_get(ts.context, 'styleError', None)

    if line_len >= 80:
        style_error(lineno, 0, lineno, line_len, "N'écrivez pas de lignes de plus de 80 caractères")

ex5_linter = make_dict()
dict_set(ex5_linter, 'eol_reached', eol_hook)
dict_set(ex5_linter, 'ctrl_char', ctrl_char_hook)

ex5_rules = define_rules(
    [enable_linting([
        ["NO_CTRL_CHAR", "N’utilisez pas de caractère de contrôle, tel que le TAB, dans vos programmes"],
        ["LINE_LENGTH", "N'écrivez pas de lignes de plus de 80 caractères"]
    ]),
    any_satisfies(select(is_FunctionDef_with_name("distanceVolOiseauUnitaire")),
                   statement_exists("La fonction 'distanceVolOiseauUnitaire' n'est pas définie")),
    any_satisfies(select(is_FunctionDef_with_name("distanceVolOiseau")),
                  statement_exists("La fonction 'distanceVolOiseau' n'est pas définie")),
    any_satisfies(select(is_FunctionDef_with_name("distanceVolOiseauTerre")),
                  statement_exists("La fonction 'distanceVolOiseauTerre' n'est pas définie")),
    any_satisfies(select(is_FunctionDef_with_name("testVolOiseau")),
                  statement_exists("La fonction 'testVolOiseau' n'est pas définie")),
    code_endswith([
        statement_is_call_to(
            "testVolOiseau",
            "Le programme doit se terminer par un appel à 'testVolOiseau' suivi de trois appels à 'print'"),
        statement_is_call_to("print", "Les trois derniers énoncés doivent être des appels à 'print'"),
        statement_is_call_to("print", "Les trois derniers énoncés doivent être des appels à 'print'"),
        statement_is_call_to("print", "Les trois derniers énoncés doivent être des appels à 'print'")
    ])
    ]
)
"""
ex5_rules = define_rules(
    [any_satisfies(is_FunctionDef_with_name("distanceVolOiseauUnitaire"),
                   statement_exists("La fonction 'distanceVolOiseauUnitaire' n'est pas définie")),
    any_satisfies(is_FunctionDef_with_name("distanceVolOiseau"),
                  statement_exists("La fonction 'distanceVolOiseau' n'est pas définie")),
    any_satisfies(is_FunctionDef_with_name("distanceVolOiseauTerre"),
                  statement_exists("La fonction 'distanceVolOiseauTerre' n'est pas définie")),
    any_satisfies(is_FunctionDef_with_name("testVolOiseau"),
                  statement_exists("La fonction 'testVolOiseau' n'est pas définie")),
    code_endswith([
        statement_is_call_to(
            "testVolOiseau",
            "Le programme doit se terminer par un appel à 'testVolOiseau' suivi de trois appels à 'print'"),
        statement_is_call_to("print", "Les trois dernières expressions doivent être des appels à 'print'"),
        statement_is_call_to("print", "Les trois dernières expressions doivent être des appels à 'print'"),
        statement_is_call_to("print", "Les trois dernières expressions doivent être des appels à 'print'")
    ])

    ]
)
"""
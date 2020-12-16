import argparse

import templates

def init_int_class():
    int_methods = ""

    for semantics, method_name in templates.operations.items():
        inplace_method_name = f"i{method_name}"

        symbol = templates.symbols_no_inplace[semantics]

        if method_name in templates.division_operations:
            error_message = templates.int_division_by_zero_error_messages[method_name]

            int_methods += templates.int_division_method_template.format(method_name=method_name, op=symbol,
                                                                         error_message=error_message)
            int_methods += templates.int_reflected_division_method_template.format(method_name=method_name, op=symbol,
                                                                                   error_message=error_message)
            int_methods += templates.int_division_method_template.format(method_name=inplace_method_name,
                                                                                   op=symbol,
                                                                                   error_message=error_message)
        else:
            int_methods += templates.int_binary_method_template.format(method_name=method_name, op=symbol)
            int_methods += templates.int_reflected_binary_method_template.format(method_name=method_name, op=symbol)
            int_methods += templates.int_binary_method_template.format(method_name=inplace_method_name,
                                                                       op=symbol)


    return templates.class_int_template.format(structure_name="PyObjectInt", methods=int_methods)


def main_init(path):
    builtins = templates.builtins_template.format(definitions=init_int_class())

    with open(path, 'x') as f:
        f.write(builtins)



if __name__ == '__main__':
    parser = argparse.ArgumentParser(description="Manage Python builtins file")
    subparser = parser.add_subparsers(dest='command', required=True)

    # init command
    init_parser = subparser.add_parser('init', description="Initialize a semantics file from templates")
    init_parser.add_argument('path')

    args = parser.parse_args()

    command = args.command

    if command == 'init':
        path = args.path
        main_init(path)
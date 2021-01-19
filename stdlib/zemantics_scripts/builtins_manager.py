import argparse

import templates


def init_number_class(*, class_template, method_info, shift_method_info, division_method_info,
                      binary_method_template, reflected_binary_method_template, inplace_binary_method_template,
                      shift_method_template, reflected_shift_method_template, inplace_shift_method_template,
                      division_method_template, reflected_division_method_template, inplace_division_method_template):
    int_methods = ""

    for semantics, data in method_info.items():
        int_methods += binary_method_template.format(**data)
        int_methods += reflected_binary_method_template.format(**data)
        int_methods += inplace_binary_method_template.format(**data)

    for semantics, data in shift_method_info.items():
        int_methods += shift_method_template.format(**data)
        int_methods += reflected_shift_method_template.format(**data)
        int_methods += inplace_shift_method_template.format(**data)

    for semantics, data in division_method_info.items():
        int_methods += division_method_template.format(**data)
        int_methods += reflected_division_method_template.format(**data)
        int_methods += inplace_division_method_template.format(**data)

    return class_template.format(methods=int_methods)


def main_init(path):
    int_class = init_number_class(class_template=templates.class_int_template,
                                  method_info=templates.int_method_info,
                                  shift_method_info=templates.int_shift_method_info,
                                  division_method_info=templates.int_division_method_info,
                                  binary_method_template=templates.int_binary_method_template,
                                  reflected_binary_method_template=templates.int_reflected_binary_method_template,
                                  inplace_binary_method_template=templates.int_inplace_binary_method_template,
                                  shift_method_template=templates.int_shift_method_template,
                                  reflected_shift_method_template=templates.int_reflected_shift_method_template,
                                  inplace_shift_method_template=templates.int_inplace_shift_method_template,
                                  division_method_template=templates.int_division_method_template,
                                  reflected_division_method_template=templates.int_reflected_division_method_template,
                                  inplace_division_method_template=templates.int_inplace_division_method_template)

    bool_class = init_number_class(class_template=templates.class_bool_template,
                                   method_info=templates.bool_method_info,
                                   shift_method_info={},
                                   division_method_info={},
                                   binary_method_template=templates.bool_binary_method_template,
                                   reflected_binary_method_template=templates.bool_reflected_binary_method_template,
                                   inplace_binary_method_template="",
                                   shift_method_template="",
                                   reflected_shift_method_template="",
                                   inplace_shift_method_template="",
                                   division_method_template="",
                                   reflected_division_method_template="",
                                   inplace_division_method_template="")

    float_class = init_number_class(class_template=templates.class_float_template,
                                    method_info=templates.float_method_info,
                                    shift_method_info={},
                                    division_method_info=templates.float_division_method_info,
                                    binary_method_template=templates.float_binary_method_template,
                                    reflected_binary_method_template=templates.float_reflected_binary_method_template,
                                    inplace_binary_method_template=templates.float_inplace_binary_method_template,
                                    shift_method_template="",
                                    reflected_shift_method_template="",
                                    inplace_shift_method_template="",
                                    division_method_template=templates.float_division_method_template,
                                    reflected_division_method_template=templates.float_reflected_division_method_template,
                                    inplace_division_method_template=templates.float_inplace_division_method_template)

    definitions = "\n\n".join([int_class, bool_class, float_class])

    builtins = templates.builtins_template.format(definitions=definitions)

    with open(path, 'w') as f:
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

import argparse

INDENT = 0

def push(obj, l, depth):
    while depth:
        l = l[-1]
        depth -= 1

    if isinstance(obj, str):
        l.extend(obj.split())
    else:
        l.append(obj)

def parse_sexp(s):
    groups = []
    depth = 0
    current = ''

    try:
        for char in s:
            if char == '(':
                push(current, groups, depth)
                push([], groups, depth)
                current = ''
                depth += 1
            elif char == ')':
                push(current, groups, depth)
                current = ''
                depth -= 1
            else:
                current += char
    except IndexError:
        raise ValueError('Parentheses mismatch')

    if depth > 0:
        raise ValueError('Parentheses mismatch')
    else:
        push(current, groups, 0)
        return groups


def iter_forms(sexp, forms):
    if isinstance(sexp, list) and sexp:
        if sexp[0] in forms:
            yield sexp
        for el in sexp:
            yield from iter_forms(el, forms)


def parse_exports(filenames, format_table):
    result = []

    for filename in filenames:
        with open(filename, 'r') as f:
            content = f.read()
            sexp = parse_sexp(content)
            for match in iter_forms(sexp, ['define', 'define-macro']):
                form = match[0]
                formatter = format_table[form]
                result.append(formatter(match[1:]))

    return result


def list_to_str_sexp(exp):
    return exp if isinstance(exp, str) else '(' + ' '.join(map(list_to_str_sexp, exp)) + ')'


def main_bigloo(template_file, source_files, placeholder):
    format_table = {
        'define-macro': lambda args: list_to_str_sexp(['macro', *args[0]]),
        'define': lambda args: list_to_str_sexp(args[0])}

    with open(template_file, 'r') as f:
        exports = f'\n{" "*INDENT}'.join(parse_exports(source_files, format_table))
        content = f.read().replace(placeholder, exports)

    content += '\n(start-registering-constants)\n'

    for filename in source_files:
        with open(filename, 'r') as f:
            content += f.read()

    content += '\n(end-registering-constants)\n'

    return content


def main_gambit(template_file, source_files, placeholder):
    format_table = {
        'define-macro': lambda args: args[0][0],
        'define': lambda args: args[0][0]}

    with open(template_file, 'r') as f:
        exports = f'\n{" "*INDENT}'.join(parse_exports(source_files, format_table))
        return f.read().replace(placeholder, exports)

if __name__ == '__main__':
    parser = argparse.ArgumentParser()

    parser.add_argument('-b', '--backend', choices=['gambit', 'bigloo'], required=True, dest='backend')
    parser.add_argument('-t', '--template', required=True, dest='template')
    parser.add_argument('-s', '--sources', nargs='+', required=True, dest='sources')
    parser.add_argument('-p', '--placeholder', required=True, dest='placeholder')
    parser.add_argument('-i', '--indent', type=int, default=INDENT, dest='indent')

    args = parser.parse_args()

    INDENT = args.indent

    if args.backend == 'gambit':
        print(main_gambit(args.template, args.sources, args.placeholder))
    elif args.backend == 'bigloo':
        print(main_bigloo(args.template, args.sources, args.placeholder))
    else:
        raise ValueError(f"unknown backend: {args.backend}")

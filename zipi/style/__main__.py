import sys
import argparse

from zipi.style import get_style_violations
from zipi.style.exercice2 import ex2_rules

from zipi._runtime import *

def default_compilation_error(start_line0,
                         start_column0,
                         end_line0,
                         end_column0, error_kind, msg):
    return lambda rte, __: runtime_print(error_kind + " at line " + str(end_line0) + ": " + msg, rte)

def main():
    parse = argparse.ArgumentParser(description='style')
    parse.add_argument('file', help='source file')
    args = parse.parse_args()
    with open(args.file, 'r') as f:
        source = f.read()

    code = get_style_violations(ex2_rules, source, default_compilation_error)
    if code is not None:
        code(None, None)

if __name__ == '__main__':
    main()
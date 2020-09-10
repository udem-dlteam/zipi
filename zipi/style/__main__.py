import sys
import argparse

from zipi.style import get_style_violations
from zipi.style.exercices.exercice2f import ex2f_rules

from zipi._runtime import *

def throw_default_compilation_error(start_line0,
                         start_column0,
                         end_line0,
                         end_column0, error_kind, msg):
    return runtime_print(error_kind + " at line " + str(end_line0) + ": " + msg, None)

def main():
    parse = argparse.ArgumentParser(description='style')
    parse.add_argument('file', help='source file')
    args = parse.parse_args()
    with open(args.file, 'r') as f:
        source = f.read()

    return get_style_violations(ex2f_rules, source, throw_default_compilation_error)

if __name__ == '__main__':
    main()
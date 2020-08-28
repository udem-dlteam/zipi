import sys
import argparse

from zipi.pyinterp import interp_file


def main():
    parse = argparse.ArgumentParser(description='interp_file')
    parse.add_argument('file', help='source file')
    parse.add_argument('--trace', action="store_true", default=False, help='print the trace of the execution of the program')
    args = parse.parse_args()
    options = {}
    options["trace"] = args.trace
    interp_file(args.file, options)

if __name__ == '__main__':
    main()

#!/usr/bin/env python3

import os
import sys

import argparse

dirname = os.path.dirname(__file__)
sys.path.append(os.path.join(dirname, '../parser'))

from pyinterp import interp_file


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

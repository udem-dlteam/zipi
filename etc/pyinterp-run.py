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
    parse.add_argument('--no-trace', action="store_true", default=False, help='if set, the interpreter will not print any trace of its execution (only python prints will be displayed)')
    args = parse.parse_args()
    interp_file(args.file, not args.no_trace)

if __name__ == '__main__':
    main()

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
    args = parse.parse_args()
    interp_file(args.file)

if __name__ == '__main__':
    main()

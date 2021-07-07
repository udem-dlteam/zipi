import argparse
from .compute_behaviors import build_semantics

parser = argparse.ArgumentParser(description="Generate zipi decision tree and behavior functions")
parser.add_argument('semantics')
parser.add_argument('builtins')
parser.add_argument('-path', default=None)
parser.add_argument('--int-maxsize', dest='int_maxsize', type=int, default=-1)

args = parser.parse_args()
semantics_file = args.semantics
builtins_file = args.builtins
path = args.path
int_maxsize = args.int_maxsize

if int_maxsize != -1:
    INT_MAXSIZE = int_maxsize

if path:
    with open(path, 'w') as f:
        f.write(build_semantics(semantics_file, builtins_file))
else:
    print(build_semantics(semantics_file, builtins_file))
import argparse
import ast
import re
from colorama import Fore, init
from pathlib import Path
from zp_javascript import Transformer as JS

parser = argparse.ArgumentParser(description="CLI to zp bootstrap compiler.")
parser.add_argument(
    "-f", "--file", metavar="FILE", type=str, nargs=1, help="file to compile"
)
parser.add_argument(
    "-d", "--debug", action="store_true", help="add debug information (default False)"
)
cli_args = parser.parse_args()

# DEBUG = False

init()


def _debug(node, msg):
    if cli_args.debug:
        try:
            print(f"{Fore.RED}DEBUG: {Fore.GREEN}{node.lineno}{Fore.RESET} | {msg}")
        except Exception:
            print(f"{Fore.RED}DEBUG:{Fore.RESET} {msg}")


def transform(node, _ast=""):
    _debug(node, f"{Fore.MAGENTA}transform{Fore.RESET}")
    _debug(node, f"\tnode: {node}")

    if isinstance(node, ast.AST):
        result = transform_node(node)
        try:
            _ast += result
        except Exception as e:
            print(f"\n\nin transform(transform_node)")
            print(f"\tnode: {node}")
            print(f"\tnode type: {type(node)}")
            print(f"\t_ast: {_ast}")
            print(f"\t_ast type: {type(_ast)}")
            print(f"\tresult: {result}")
            print(f"\tresult type: {type(result)}\n\n")
            raise e
    elif isinstance(node, tuple) or isinstance(node, list):
        result = transform_seq(node)
        try:
            _ast += result
        except Exception as e:
            print(f"\n\nin transform (transform_seq)\t{node}\t{_ast}\t{result}")
            print(f"\ttype: {type(result)}\n\n")
            raise e
    else:
        # catch all
        return to_string(node)

    return _ast


def transform_seq(_list, _ast=""):
    _debug(_list, f"{Fore.MAGENTA}transform_seq{Fore.RESET}")
    _debug(_list, f"\tsequence: {_list}")
    for node in _list:
        _ast += transform(node)
    return _ast


def transform_node(node, _ast=""):
    kind = node.__class__.__name__
    transformer = getattr(backend, kind)
    result = transformer(node)

    _debug(node, f"{Fore.MAGENTA}transform_node{Fore.RESET}")
    _debug(node, f"\tnode: {node}")
    _debug(node, f"\tkind: {kind}")
    _debug(node, f"\ttransformer: {transformer}")
    _debug(
        node,
        f"\tresult: {Fore.YELLOW}{result}{Fore.RESET} (type: {Fore.CYAN}{type(result)}{Fore.RESET}))",
    )

    try:
        _ast += result
    except Exception as e:
        print(f"\n\ntransform_node\t{node}\t{_ast}\t{kind}\t{result}")
        print(f"\ttype: {type(result)}\n\n")
        raise e
    return _ast


def to_string(node):
    return '"' + str(node).encode("unicode-escape").decode().replace('"', '\\"') + '"'


backend = JS(transform)  # Current default


def compile_file(input_file):
    if input_file[-3:] != ".py":
        raise Exception

    with open(input_file, "r") as f:
        source = f.read()

    backend.rootdir = str(Path(input_file).parent)

    target_code = transform(ast.parse(source))
    output_file = input_file[:-3] + backend.ext

    target_code = re.sub(r"(;)\1+", r"\1", target_code)
    target_code = '"use strict"; ' + target_code

    with open(output_file, "w") as f:
        print(target_code, file=f)

    print(f"{input_file} compiled successfully to {output_file}.")


if __name__ == "__main__":
    compile_file(cli_args.file[0])

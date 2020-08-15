import argparse
import ast
import re
import os
from colorama import Fore, init
from pathlib import Path
from zp_javascript import Transformer as JS

parser = argparse.ArgumentParser(description="CLI to zp bootstrap compiler.")
parser.add_argument(
    "-f", "--file", metavar="FILE", type=str, nargs=1, help="file to compile"
)
parser.add_argument(
    "-o", "--output", metavar="OUTPUT", type=str, nargs=1, help="output file"
)
parser.add_argument(
    "-n", "--node", action="store_true", help="export as node module (default False)"
)
parser.add_argument(
    "-b",
    "--browser",
    action="store_true",
    help="export as browser module (default True)",
    default=True,
)
parser.add_argument(
    "-es6",
    "--es6-classes",
    action="store_true",
    help="compile to ES6 classes (default False)",
)
parser.add_argument(
    "-d", "--debug", action="store_true", help="add debug information (default False)"
)
parser.add_argument(
    "-t", "--tests", action="store_true", help="include extended runtime for tests (default False)"
)
cli_args = parser.parse_args()

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


backend = JS(transform, es6_classes=cli_args.es6_classes)


def compile_file(input_file):
    if input_file[-3:] != ".py":
        raise Exception

    if cli_args.output:
        output_file = cli_args.output[0]
    else:
        output_file = input_file[:-3] + backend.ext

    with open(input_file, "r") as f:
        source = f.read()

    backend.rootdir = str(Path(input_file).parent)

    _ast = ast.parse(source)
    target_code = transform(_ast)

    # Runtime
    runtime = """
String.prototype.lstrip = function () { return this.replace(/^\s+/g, ''); };
function isEmpty(obj) {
    if (obj === absent) { return true; } else { return false; }
};
function make_dict() { return {}; };
function dict_get(d, key, _default) {
    if (Object.prototype.hasOwnProperty.call(d, key)) {
    return d[key];
    } else {
    return _default;
    }
    };
function dict_set(d, key, value) {
    d[key] = value;
    };
function gui_wait_for_click(ast, msg, continue_execution) {
    console.log('at '+ast.lineno+'.'+(ast.col_offset+1)+'-'+ast.end_lineno+'.'+(ast.end_col_offset+1)+msg)
    return continue_execution
    };
function py_tokenset() {
    return Array.prototype.slice.call(arguments, py_tokenset.length);
    };
function dict_has(d, a) {
    if (Object.prototype.hasOwnProperty.call(d, a)) {
    return true;
    } else {
    return false;
    }
    };
function print_stdout(obj) {
    console.log("PRINTING TO STDOUT");
    console.log(obj);
    };
    """

    if cli_args.tests:
        with open("num.js", "r") as f:
            runtime += " " + f.read()

    # Modules
    if cli_args.node or cli_args.browser:
        module = f"var {Path(input_file).name[:-3]} = (function () {{ {runtime} "
    else:
        module = "{runtime} "

    ids = [backend.get_identifier(n) for n in _ast.body]
    ids = [i for i in ids if i is not None]
    if len(ids) > 0:
        exports = "return {"
        for id in ids[:-1]:
            exports += f"{id}:{id},"
        exports += f"{ids[-1]}:{ids[-1]} }}"
    else:
        exports = ""

    # Build the target code
    target_code = module + target_code
    target_code = re.sub(r"(;)\1+", r"\1", target_code)
    target_code = '"use strict"; ' + target_code

    # Finish modules
    if cli_args.node or cli_args.browser:
        target_code += f"{exports} }})();"

    if cli_args.node:
        target_code += f"module.exports = {Path(input_file).name[:-3]};"

    with open(output_file, "w") as f:
        print(target_code, file=f)

    print(f"{input_file} compiled successfully to {output_file}.")


if __name__ == "__main__":
    compile_file(cli_args.file[0])

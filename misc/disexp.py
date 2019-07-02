#!/usr/bin/env python3

import py_compile
import argparse
import marshal
import dis

def main():
  parse = argparse.ArgumentParser(description="disexp")
  parse.add_argument("file", help="source file")
  parse.add_argument("--verbose", "-v", action="store_true", help="verbose")

  args = parse.parse_args()
  
  co = parse_file(py_compile.compile(args.file), args)
  dco(co, "")

def dco(co, margin):
  """for i in dir(co):
    print(i, ": ", getattr(co, i))
  """

#  print(dis.code_info(co))
  print(margin,"(function \""
        + co.co_name
        + "\"",dcorep(co.co_varnames[0:co.co_argcount]))
  margin2 = margin + "  "
  for i in dis.get_instructions(co):
    if type(i.argval) == code_type:
      print(margin2, "(" + i.opname, i.offset)
      dco(i.argval, margin2 + "  ")
      print(margin2, ")")
    elif i.arg == None:
      print(margin2, "(" + i.opname, str(i.offset) + ")")
    else:
      print(margin2, "(" + i.opname, i.offset, i.arg, dcorep(i.argval) + ")")
  print(margin, ")")

def dcorep(v):
  if type(v) == str:
    return "\"" + v + "\""
  elif type(v) == tuple:
    i = "("
    for e in v:
      i += dcorep(e) + " "
    return i + ")"
  else:
    return str(v)
  
code_type = type(main.__code__)

# Parse a python bytecode file and return the CodeObject
def parse_file(filename, args):
    bytecode_file = open(filename, "rb")

    # The header of a bytecode file is 16 bytes long
    magic = bytecode_file.read(4)
    bit_field = bytecode_file.read(4)
    timestamp = bytecode_file.read(4)
    misc = bytecode_file.read(4)

    return parse_code_object(bytecode_file, args)


# Parse a CodeObject from an already opened file
def parse_code_object(file, args):
    # Then we found the marshaled code object
    body = file.read()
    co = marshal.loads(body)

    if args.verbose:
        print(dis.dis(co))

    file.close()
    return co

def fib(n):
  if n > 10:
    print( "gee")
  else:
    print("bar")
  return 42

main()  

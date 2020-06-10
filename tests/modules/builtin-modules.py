s = __import__("sys")

print(type(s.modules) is dict)
print("sys" in s.modules)

print(type(s.path) is list)

import sys as hello

print(type(hello.modules) is dict)
print("sys" in hello.modules)

print(type(hello.path) is list)

import sys

print(type(sys.modules) is dict)
print("sys" in sys.modules)

print(type(sys.path) is list)

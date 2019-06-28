print ("in import2")

import mod2

def f():
    import mod2 as m
    print(m.x)

print(mod2.x)
mod2.x = 34
print(mod2.x)
mod2.x = 35

f()

import submodules.mod3

import sys

print(sys.modules["mod2"])
print(sys.modules["submodules.mod3"])

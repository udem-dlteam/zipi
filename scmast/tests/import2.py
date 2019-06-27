print ("in import2")

import mod2

def f():
    import mod2 as m
    print(m.x)

print("ICI.....")    
print(mod2.x)
mod2.x = 34
print(mod2.x)
mod2.x = 35

f()

import submodules.mod3

print("sm.1")
print(submodules)
print("sm.2")

import sys

print(sys.modules["mod2"])
print(sys.modules["submodules.mod3"])

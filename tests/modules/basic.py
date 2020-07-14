import sys
sys.path.append(sys.path[0] + "/modules")

import package1.subpackage

print(package1.x)
print(package1.subpackage.y)

import package1.module

print(package1.module.z)

import package1.subpackage.module as foo

print(foo.x)



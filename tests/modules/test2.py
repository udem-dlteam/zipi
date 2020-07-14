import sys
sys.path.append(sys.path[0] + "/modules")

import package1.subpackage as foo
print(foo.y)

import package1
print(package1.subpackage.y)

print(package1.x)
import package1.hithere
print(package1.hithere.hithere)


import sys
sys.path.append(sys.path[0] + "/modules")

import package1.subpackage
print(package1.__path__)
from package1.subpackage import y
print(y)
print(package1.subpackage.y)
from package1 import x
print(x)

import package1.hithere



import package1

try:
    package1.subpackage1
except AttributeError:
    print("attributeerror")

from package1 import subpackage1

package1.subpackage1

print(subpackage1.y)



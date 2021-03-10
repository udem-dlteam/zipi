import package1

import package1.subpackage

from package1 import module

print(package1.__name__)
print(package1.__package__)
print(package1.subpackage.__name__)
print(package1.subpackage.__package__)
print(module.__name__)
print(module.__package__)

from package1 import subpackage1

print(subpackage1.__name__)
print(subpackage1.__package__)

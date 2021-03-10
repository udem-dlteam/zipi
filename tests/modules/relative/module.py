print("in module")
from . import module1

print(module1.__package__)
print(module1.__name__)



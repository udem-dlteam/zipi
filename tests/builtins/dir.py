import sys

print(dir(sys) == sorted(sys.__dir__()))
print(dir(object) == sorted(object.__dir__(object)))
print(dir(int) == sorted(type.__dir__(int)))
print(dir(1) == sorted((1).__dir__()))

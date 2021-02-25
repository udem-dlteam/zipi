import sys

print(dir(sys) == sorted(sys.__dir__()))
print(sorted(type.__dir__(type)) == sorted(object.__dir__(type)))
print(dir(int) == sorted(type.__dir__(int)))
print(dir(1) == sorted((1).__dir__()))

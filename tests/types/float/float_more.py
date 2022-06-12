# repr

print(0.1)
print(0.1.__repr__())
print(0.0.__repr__())

# abs

print(abs(-1.))
print(abs(1.2))
print(abs(0.0))
print(abs(-0.))
print(abs(-7568978657476787909.0))

print(0.0.__abs__())
print(-1.2.__abs__())

# bool

print(bool(0.))
print(bool(1.))
print(bool(0.00000000001))
print(bool(182482083.0))
print(bool(-01282930.0))

print((0.).__bool__())
print((1.).__bool__())
print((0.00000000001).__bool__())
print((182482083.0).__bool__())
print((-01282930.0).__bool__())

# float

print(float(1.2))
print(float(0.1))
print(0.1.__float__())

print(float(0))
print(float(0.0))

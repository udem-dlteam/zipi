# Shifts and powers whose results cross the fixnum limit (2**60 - 1 with
# 61-bit fixnums), with constant operands (folded by the compiler) and
# with operands only known at run time

# constants
print(1 << 59, 1 << 60, 1 << 61, 1 << 62, 1 << 63, 1 << 64, 1 << 70)
print(-1 << 60, -1 << 61, 1073741823 << 31, -1073741823 << 31)
print((1 << 62) >> 61, (1 << 70) >> 69, 1 >> 64, -1 >> 64, -5 >> 100)
print(2 ** 59, 2 ** 60, 2 ** 61, 2 ** 62, 2 ** 63, 2 ** 64, 2 ** 70)
print(3 ** 38, 3 ** 39, 3 ** 40, (-3) ** 39, (-3) ** 40, 7 ** 0, 0 ** 0)

def lsh(a, b):
    return a << b

def rsh(a, b):
    return a >> b

def power(a, b):
    return a ** b

# operands known at run time only
for n in [0, 1, 29, 30, 31, 32, 58, 59, 60, 61, 62, 63, 64, 65, 70, 100]:
    print(n, lsh(1, n), lsh(-1, n), lsh(3, n), lsh(1073741823, n),
          rsh(lsh(1, n), n), rsh(1, n), rsh(-1, n), rsh(-5, n))

for b in [-3, -2, 2, 3, 10]:
    for n in [0, 1, 37, 38, 39, 40, 59, 60, 61, 62, 63, 64, 70]:
        print(b, n, power(b, n))

# local integer variables
x = 1073741823
n = 31
print(x << n, -x << n, x ** 2, (x + 1) ** 2, (x + 1) << 30)
y = 2
for k in range(58, 66):
    print(k, y ** k, 1 << k, (y ** k) >> k)

# truthiness (2**64 overflows to 0 with fixnum arithmetic)
for k in [60, 61, 64]:
    if 2 ** k:
        print("true", k)
    if 1 << k:
        print("true", k)
    if power(2, k):
        print("true", k)

# augmented assignments
z = 1
z <<= 64
print(z)
z >>= 63
print(z)
w = 2
w **= 64
print(w)

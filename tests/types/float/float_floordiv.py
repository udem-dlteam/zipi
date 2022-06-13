# floordiv

print(1 // 2)
print(1 // 2.)
print(1. // 2)
print(1. // 2.)

print(-1 // 2.)
print(-1. // 2)
print(-1. // 2.)

print(1 // -2.)
print(1. // -2)
print(1. // -2.)

print(-1 // -2.)
print(-1. // -2)
print(-1. // -2.)

print(3.5 // 0.5)
print(-3.5 // 0.5)
print(3.5 // -0.5)
print(-3.5 // -0.5)

# print(3.5 // 0.5) # removed because zipi has better precision than cPython in this case



x = 1; y = 2; print(x // y)
x = 1; y = 2.; print(x // y)
x = 1.; y = 2; print(x // y)
x = 1.; y = 2.; print(x // y)

x = -1; y = 2.; print(x // y)
x = -1.; y = 2; print(x // y)
x = -1.; y = 2.; print(x // y)

x = 1; y = -2.; print(x // y)
x = 1.; y = -2; print(x // y)
x = 1.; y = -2.; print(x // y)

x = -1; y = -2.; print(x // y)
x = -1.; y = -2; print(x // y)
x = -1.; y = -2.; print(x // y)

x = 3.5; y = 0.5; print(x // y)
x = -3.5; y = 0.5; print(x // y)
x = 3.5; y = -0.5; print(x // y)
x = -3.5; y = -0.5; print(x // y)

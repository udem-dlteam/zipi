import time

def fib(n):
    if n<2:
        return n
    else:
        return fib(n-1) + fib(n-2)

start = time.time()
result = fib(30)
end = time.time()

print("fib(30) =", result)
print("time =", end-start)

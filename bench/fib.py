import time

def fib(n):
    if n<2:
        return n
    else:
        return fib(n-1) + fib(n-2)

start = time.time()
result = fib(35)
end = time.time()

print("fib(30) =", result)
print("time =", end-start)

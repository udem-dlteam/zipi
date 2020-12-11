# Compute nth fibonacci number using double recursion

import time

n = 33

def fib(n):
    if n<2:
        return n
    else:
        return fib(n-1) + fib(n-2)

bench_time = time.time()
result = fib(n)
bench_time = time.time() - bench_time
print(bench_time, 'seconds for', 'fib(', n, ') =', result)

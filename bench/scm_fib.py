# Compute nth fibonacci number using double recursion

import time

n = 35

def fib(n):
    if n<2:
        return n
    else:
        return fib(n-1) + fib(n-2)

result = fib(20) - 6765 # dry run

bench_time = time.time()
result = result + fib(n)
bench_time = time.time() - bench_time
print(str(bench_time) + ' seconds: fib(' + str(n) + ') = ' + str(result))

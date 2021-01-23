# micro_global_inc.py
# Auto-generated
from __compiler_intrinsics__ import inline_host_code
import time

bench_iterations = 700000
bench_duplications = 40

def bench_exec():
    global g
    bench_counter = bench_iterations
    while bench_counter > 0:
        bench_counter -= 1
        g=0
        inline_host_code('(inline-c-code "/*BEGIN-BENCH-FIRST-STMT*/")')
        g+=1
        inline_host_code('(inline-c-code "/*END-BENCH-FIRST-STMT*/")')
        g+=1
        g+=1
        g+=1
        g+=1
        g+=1
        g+=1
        g+=1
        g+=1
        g+=1
        g+=1
        g+=1
        g+=1
        g+=1
        g+=1
        g+=1
        g+=1
        g+=1
        g+=1
        g+=1
        g+=1
        g+=1
        g+=1
        g+=1
        g+=1
        g+=1
        g+=1
        g+=1
        g+=1
        g+=1
        g+=1
        g+=1
        g+=1
        g+=1
        g+=1
        g+=1
        g+=1
        g+=1
        g+=1
        g+=1
    

bench_time = time.time()
bench_exec()
bench_time = time.time() - bench_time
print(str(bench_time) + ' seconds for ' + str(bench_iterations*bench_duplications) + ' executions of: ' + 'g+=1')



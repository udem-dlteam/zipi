# micro_var_int_sub_1.py
# Auto-generated
from __compiler_intrinsics__ import inline_host_code
import time

bench_iterations = 1300000
bench_duplications = 30

def bench_exec():
    x=1
    bench_counter = bench_iterations
    while bench_counter > 0:
        bench_counter -= 1
        
        inline_host_code('(inline-c-code "/*BEGIN-BENCH-FIRST-STMT*/")')
        x=x-1
        inline_host_code('(inline-c-code "/*END-BENCH-FIRST-STMT*/")')
        x=x-1
        x=x-1
        x=x-1
        x=x-1
        x=x-1
        x=x-1
        x=x-1
        x=x-1
        x=x-1
        x=x-1
        x=x-1
        x=x-1
        x=x-1
        x=x-1
        x=x-1
        x=x-1
        x=x-1
        x=x-1
        x=x-1
        x=x-1
        x=x-1
        x=x-1
        x=x-1
        x=x-1
        x=x-1
        x=x-1
        x=x-1
        x=x-1
        x=x-1
    

bench_time = time.time()
bench_exec()
bench_time = time.time() - bench_time
print(str(bench_time) + ' seconds for ' + str(bench_iterations*bench_duplications) + ' executions of: ' + 'x=x-1')



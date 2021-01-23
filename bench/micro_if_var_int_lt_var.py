# micro_if_var_int_lt_var.py
# Auto-generated
from __compiler_intrinsics__ import inline_host_code
import time

bench_iterations = 1600000
bench_duplications = 30

def bench_exec():
    x=1;y=2
    bench_counter = bench_iterations
    while bench_counter > 0:
        bench_counter -= 1
        
        inline_host_code('(inline-c-code "/*BEGIN-BENCH-FIRST-STMT*/")')
        if x<y:x=0
        inline_host_code('(inline-c-code "/*END-BENCH-FIRST-STMT*/")')
        if x<y:x=0
        if x<y:x=0
        if x<y:x=0
        if x<y:x=0
        if x<y:x=0
        if x<y:x=0
        if x<y:x=0
        if x<y:x=0
        if x<y:x=0
        if x<y:x=0
        if x<y:x=0
        if x<y:x=0
        if x<y:x=0
        if x<y:x=0
        if x<y:x=0
        if x<y:x=0
        if x<y:x=0
        if x<y:x=0
        if x<y:x=0
        if x<y:x=0
        if x<y:x=0
        if x<y:x=0
        if x<y:x=0
        if x<y:x=0
        if x<y:x=0
        if x<y:x=0
        if x<y:x=0
        if x<y:x=0
        if x<y:x=0
    

bench_time = time.time()
bench_exec()
bench_time = time.time() - bench_time
print(str(bench_time) + ' seconds for ' + str(bench_iterations*bench_duplications) + ' executions of: ' + 'if x<y:x=0')



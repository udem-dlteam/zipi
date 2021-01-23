# micro_global_write2.py
# Auto-generated
from __compiler_intrinsics__ import inline_host_code
import time

bench_iterations = 2000000
bench_duplications = 20

def bench_exec():
    global g;x=0
    bench_counter = bench_iterations
    while bench_counter > 0:
        bench_counter -= 1
        g1=0;g2=0
        inline_host_code('(inline-c-code "/*BEGIN-BENCH-FIRST-STMT*/")')
        g1=x;g2=x
        inline_host_code('(inline-c-code "/*END-BENCH-FIRST-STMT*/")')
        g1=x;g2=x
        g1=x;g2=x
        g1=x;g2=x
        g1=x;g2=x
        g1=x;g2=x
        g1=x;g2=x
        g1=x;g2=x
        g1=x;g2=x
        g1=x;g2=x
        g1=x;g2=x
        g1=x;g2=x
        g1=x;g2=x
        g1=x;g2=x
        g1=x;g2=x
        g1=x;g2=x
        g1=x;g2=x
        g1=x;g2=x
        g1=x;g2=x
        g1=x;g2=x
    

bench_time = time.time()
bench_exec()
bench_time = time.time() - bench_time
print(str(bench_time) + ' seconds for ' + str(bench_iterations*bench_duplications) + ' executions of: ' + 'g1=x;g2=x')



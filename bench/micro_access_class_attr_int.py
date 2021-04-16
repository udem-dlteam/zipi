# micro_access_class_attr_int.py
# Auto-generated

import time

bench_iterations = 700000
bench_duplications = 30

def bench_exec():
    class A: x=1
    a=A()
    bench_counter = bench_iterations
    while bench_counter > 0:
        bench_counter -= 1
        
        a.x
        a.x
        a.x
        a.x
        a.x
        a.x
        a.x
        a.x
        a.x
        a.x
        a.x
        a.x
        a.x
        a.x
        a.x
        a.x
        a.x
        a.x
        a.x
        a.x
        a.x
        a.x
        a.x
        a.x
        a.x
        a.x
        a.x
        a.x
        a.x
        a.x
    

bench_time = time.time()
bench_exec()
bench_time = time.time() - bench_time
print(str(bench_time) + ' seconds for ' + str(bench_iterations*bench_duplications) + ' executions of: ' + 'a.x')



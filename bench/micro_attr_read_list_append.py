# micro_attr_read_list_append.py
# Auto-generated

import time

bench_iterations = 1300000
bench_duplications = 30

def bench_exec():
    m=list
    bench_counter = bench_iterations
    while bench_counter > 0:
        bench_counter -= 1
        
        x=m.append
        x=m.append
        x=m.append
        x=m.append
        x=m.append
        x=m.append
        x=m.append
        x=m.append
        x=m.append
        x=m.append
        x=m.append
        x=m.append
        x=m.append
        x=m.append
        x=m.append
        x=m.append
        x=m.append
        x=m.append
        x=m.append
        x=m.append
        x=m.append
        x=m.append
        x=m.append
        x=m.append
        x=m.append
        x=m.append
        x=m.append
        x=m.append
        x=m.append
        x=m.append
    

bench_time = time.time()
bench_exec()
bench_time = time.time() - bench_time
print(str(bench_time) + ' seconds for ' + str(bench_iterations*bench_duplications) + ' executions of: ' + 'x=m.append')



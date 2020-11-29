# micro_var_str_add_var.py
# Auto-generated

import time

bench_iterations = 700000
bench_duplications = 30

def bench_exec():
    str1="a";str2="b"
    bench_counter = bench_iterations
    while bench_counter > 0:
        bench_counter -= 1
        
        x=str1+str2
        x=str1+str2
        x=str1+str2
        x=str1+str2
        x=str1+str2
        x=str1+str2
        x=str1+str2
        x=str1+str2
        x=str1+str2
        x=str1+str2
        x=str1+str2
        x=str1+str2
        x=str1+str2
        x=str1+str2
        x=str1+str2
        x=str1+str2
        x=str1+str2
        x=str1+str2
        x=str1+str2
        x=str1+str2
        x=str1+str2
        x=str1+str2
        x=str1+str2
        x=str1+str2
        x=str1+str2
        x=str1+str2
        x=str1+str2
        x=str1+str2
        x=str1+str2
        x=str1+str2
    

bench_time = time.time()
bench_exec()
bench_time = time.time() - bench_time
print(bench_time, 'seconds for', bench_iterations*bench_duplications, 'executions of:', 'x=str1+str2')

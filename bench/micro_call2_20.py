# micro_call2_20.py
# Auto-generated

import time

bench_iterations = 100000
bench_duplications = 1

def bench_exec():
    def dec1(a,b): return a-1
    def dec2(a,b): return a-1
    def dec3(a,b): return a-1
    def dec4(a,b): return a-1
    def dec5(a,b): return a-1
    def call(x,dec):
        while x>0:x=dec(x,x)
    bench_counter = bench_iterations
    while bench_counter > 0:
        bench_counter -= 1
        n=20
        call(n,dec1);call(n,dec2);call(n,dec3);call(n,dec4);call(n,dec5);
    

bench_time = time.time()
bench_exec()
bench_time = time.time() - bench_time
print(str(bench_time) + ' seconds for ' + str(bench_iterations*bench_duplications) + ' executions of: ' + 'call(n,dec1);call(n,dec2);call(n,dec3);call(n,dec4);call(n,dec5);')



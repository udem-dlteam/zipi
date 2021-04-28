import time

bench_iterations = 1

class Argparser():
    def add_argument(*args, **kwargs):
        pass


class Runner():
    def __init__(self):
        self.metadata = {}
        self.argparser = Argparser()

    def bench_func(self, name, func, *args):
        bench_time = time.time()
        bench_count = bench_iterations
        print("starting...")
        while bench_count > 0:
            bench_count -= 1
            func(*args)

        bench_time = time.time() - bench_time
        print(str(bench_time) + ' seconds for ' + str(bench_iterations) + ' executions of: ' + name)

    def bench_time_func(self, name, func, *args):
        self.bench_func(name, func, *args)





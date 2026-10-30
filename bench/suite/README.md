# zipi benchmarks
Performance benchmarks developed for the Zipi compiler.

This suite was imported from the `udem-dlteam/zipi-benchmarks`
repository and is now maintained as part of Zipi. From the `bench` directory
of Zipi, use `make run`, `make compare-to-cpython`, etc. (see `bench/makefile`).

Quick usage instructions, from this directory:

    ./configure              # required before any of the following commands
    ./list                   # get a list of the benchmark names
    ./info scm/fib SOURCE    # get source code of a benchmark given its name
    ./run --system python3   # run all the benchmarks with a given system
    ./run --system python3 scm/fib       # run specific benchmark(s)
    ./run --system pypy3 --filter ^scm/  # run all scm/* benchmarks

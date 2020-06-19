# zipi
A fast Python implementation.


## How to run

To compile with Zipi for Gambit

```
# First make sure to have followed those steps
export PATH=/usr/local/Gambit/bin:$PATH
export ZIPIROOT=/home/[username]/udem-dlteam/zipi
./configure
make

# You can then compile and run a script with
zipi/zpc/run-zipi.scm somepythonfile.py
```

To compile with Bigloo, you will first need to install Zipi

```
./configure --bigloo-only
jmake && sudo make install
```

Once done, you can compile and run with the following commands

```
zpc.bigloo somepythonfile.py -o output.scm
bigloo -L /usr/local/lib/zipi/0.0.1 -rpath /usr/local/lib/zipi/0.0.1 output.scm
./a.out
```

You can also use the `./compile-and-run somepythonfile.py` to test a Python script with Zipi both on Bigloo and Gambit.

## Tests

To run all tests

```
make test
```

To run a specific test or tests matching a given pattern

```
python zipi/tests/run.py --pattern=[regex-pattern]
```

The `regex-pattern` must obey Python `re` syntax. 

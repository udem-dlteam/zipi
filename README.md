# zipi
A fast Python implementation.


## How to run

To compile with Zipi for Gambit

```
# First make sure to follow those steps
export PATH=/usr/local/Gambit/bin:$PATH
# For development:
export ZIPIROOT=/home/[username]/udem-dlteam/zipi
export GAMBOPT=~~zipicache=~/.zipicache,~~zipidir=$ZIPIROOT,search=~~zipidir/..
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

## Debug procedures

Here are some useful debugging procedures that can be used in the Gambit REPL

### `(debug-class-name-get obj)`

Returns the Scheme string of the class of the Python object `obj`

### `(debug-value-get obj)`

Returns the Scheme value of the Python object `obj`

### `(debug-ref obj . values)`

This procedure helps navigating inside a py-object. It's a more intuitive procedure than `debug-get` as the numbers in `values` directly correlate to the values inside the HClasses. This way, we can get the value of an object by doing `(debug-ref obj 1)` and the class name by doing `(debug-ref obj 0 4 1)` (`**class**`, `__name__`, `**value**`)  

### `(debug-get obj . values)`

Calls `(##vector-ref obj x)` with all values in `values` one after the other. Useful when trying to navigate a Py-Object

### `(debug-get-list obj values)`

Same as `debug-get`, but `values` is a list 

### `(debug-catch thunk)`

Executes `thunk` and prints the name of the Python exception, if one is thrown

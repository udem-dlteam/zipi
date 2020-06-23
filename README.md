# zipi
A fast Python implementation.


## How to run

To compile with Zipi for Gambit

```
# First make sure to follow those steps
export PATH=/usr/local/Gambit/bin:$PATH
export ZIPIROOT=/home/[username]/udem-dlteam/zipi
# For development:
export GAMBOPT=search=~/udem-dlteam
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

## Debug functions

Here are some usefull debug functions that can be used in gambit repl

`class-please obj`

Returns the class of the `obj` python object

`class-name-please obj`

Returns the scheme string of the python object `obj`

`value-please obj`

Returns the scheme value of the python object `obj`

`what-am-i? obj . values`

This function helps the navigation inside a py-object. Its a more intuitive function then debug-get as the numbers in `values` directly correlate to the values inside the HClasses. This way, we can get the value of an object by doing `(what-am-i? obj 1)` and the class name by doing `(what-am-i? obj 0 4 1)` (`**class**`, `__name__`, `**value**`)  

`debug-get obj . values`

Calls `##vector-ref obj x` with all values in `values` one after the other. Usefull when trying to navigate a Py-Object

`debug-get-list obj values`

Same as debug-get, but `values` is a list 

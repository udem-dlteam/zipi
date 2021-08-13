# zipi
A fast Python implementation.


## Versions

  * Bigloo: branch `4.4a`, commit `2cfd676b56a08a2d1f4f03e85159c2a1f3bddf85`
  * Gambit:


## How to run

To compile with Zipi for Gambit

```
./configure --gambit-only
make
make test # recommended
sudo make install

# You can then compile and run a script with
zipi somepythonfile.py
```

To compile with Bigloo, you will first need to install Zipi

```
./configure --bigloo-only
jmake && sudo make install
```

Once done, you can compile and run with the following commands

```
zpc.bigloo somepythonfile.py
```

Alternatively, this can be split as:

```
zpc.bigloo somepythonfile.py -s -o output.scm
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

## CI

Here is some information about self-hosted runner. On the Gambit server, all files concerning the runner are located inside the `/Users/Shared/zipi` folder. There are three subfolders : 
- `dependencies` : this folder is used as dependency folder when configuring zipi (see --dependencies-dir option of `./configure`)
- `bigloo-*` : this folder contains the installation of bigloo. Should be moved to the dependencies soon...
- `action-runner` : this folder contains all the info about the github self-hosted runner. 

Here are some usefull commands (need sudo): 
Start the runner service : `sudo launchctl start /Users/oestolel/Library/LaunchAgents/actions.runner.udem-dlteam-zipi.gambit.plist`
Stop the runner service : `sudo launchctl stop /Users/oestolel/Library/LaunchAgents/actions.runner.udem-dlteam-zipi.gambit.plist`

Note the `./svc.sh` in `action-runner` command to setup the service doesnt work for some reason. This is why we use sudo and the plist directly. Note that the plist file must have well-defined permissions to be used with `sudo` and `launchctl`. See github documentation on self-hosted runner for more info

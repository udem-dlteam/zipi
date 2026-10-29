# zipi
A fast Python implementation.


## Requirements

Zipi needs Gambit, Bigloo and CPython 3.9. The versions known to work are
pinned at the top of the `Makefile`:

  * Gambit: `GAMBIT_VERSION` (GitHub release tag of `gambit/gambit`)
  * Bigloo: `BIGLOO_VERSION` (GitHub release tag of `manuel-serrano/bigloo`)
  * CPython: `PYTHON_VERSION` (GitHub release tag of `python/cpython`)

`make compilers` (or `make gambit`, `make bigloo`, `make python`) builds them
from their GitHub releases and installs them in `dependencies/`. Building
Bigloo from its git repository requires an installed Bigloo: by default the
Bigloo source release `BIGLOO_BOOT_VERSION` is downloaded (checksum verified),
built and used for that, or you can point `BIGLOO_BOOT_BINDIR` to the `bin`
directory of an existing Bigloo installation. The usual C build tools are
needed, as well as the GMP and libunistring development files (e.g.,
`apt install build-essential libgmp-dev libunistring-dev libssl-dev
libsqlite3-dev libpcre2-dev`).

## How to build

```
make compilers   # optional, ./configure runs it for missing dependencies
./configure
make
make test        # recommended
make install     # optional, installs in --prefix (default /usr/local)

# You can then compile and run a script with
bin/zipi somepythonfile.py
```

`./configure --gambit-only` or `./configure --bigloo-only` restrict Zipi to
one backend (the default is both, with Gambit as the default backend of
`bin/zipi`, use `--default=bigloo` to change it).

### Using local installations of the compilers

The compilers and the Python interpreter can be selected with the `GSI`,
`GSC`, `BIGLOO` and `PYTHON` variables, either when configuring or when
building (the latter reconfigures Zipi with these tools):

```
./configure GSI=gsi GSC=gsc BIGLOO=bigloo PYTHON=python3.9
make

# or, equivalently, on an already configured tree
make GSI=gsi GSC=gsc BIGLOO=bigloo PYTHON=python3.9
```

The values can be commands found in the `PATH` or absolute paths. When only
one of `GSI` and `GSC` is given, the other one is looked up in the same
directory. These variables can also be set in the environment of `./configure`.

### Choosing the backend

`bin/zipi` uses the default backend; the other one can be selected with
`-X gambit` or `-X bigloo`, or by running `bin/zipi.gambit` or
`bin/zipi.bigloo` directly:

```
bin/zipi -X bigloo somepythonfile.py
```

## Benchmarks

The benchmark suite is in `bench/suite` (it used to be the separate
`zipi-benchmarks` repository). `make bench`, `make bench-gambit` and
`make bench-bigloo` run every benchmark once and fail if one of them crashes.
From the `bench` directory:

```
make run                          # run all benchmarks with bin/zipi
make run filter=^scm/             # run a subset
make run system=python3           # run with another system
make check                        # run every benchmark once, fail on crash
make compare-to-cpython           # compare bin/zipi to CPython
```

## Tests

To run all tests

```
make test          # with bin/zipi (the default backend)
make test-gambit   # with the Gambit backend
make test-bigloo   # with the Bigloo backend
```

Tests are compared to the output of the CPython used to build Zipi. The tests
listed in `tests/expected-failures.txt`, as well as those of `tests/wishlist`,
are known to fail: they are run and reported as `XFAIL` but do not make the
test suite fail (a `XPASS` reports one that now passes).

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

Note the `./svc.sh` in `action-runner` command to setup the service doesnt work for some reason. This is why we use sudo and the plist directly. Note that the plist file must have well-defined permissions to be used with `sudo` and `launchctl`. For more information on self-hosted runner, see github documentation for more info

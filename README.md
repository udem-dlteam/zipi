# zipi
A fast Python implementation.


## How to run

To compile with Zipi for Gambit

```
# Add Gambit to your PATH
export PATH=/usr/local/Gambit/bin:$PATH

# Compile with py19 for Gambit
zipi/etc/py19 -t gambit somepythonfile.py > output.scm

# Run the output file with Gambit
gsi zipi/pyc/ output.scm
```

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

# zipi
A fast Python implementation.


## How to run

To compile with Zipi for Gambit

```
# Add Zipi to your PATH
export PATH=/usr/local/Gambit/bin:$PATH

# Compile with py19 for Gambit
zipi/etc/py19 -t gambit somepythonfile.py > output.scm

# Run the output file with Gambit
gsi zipi/pyc/ output.scm
```

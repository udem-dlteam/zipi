# zp

## Instructions

```
usage: zp.py [-h] [-f FILE] [-o OUTPUT] [-n] [-b] [-d]

CLI to zp bootstrap compiler.

optional arguments:
  -h, --help            show this help message and exit
  -f FILE, --file FILE  file to compile
  -o OUTPUT, --output OUTPUT
                        output file
  -n, --node            export as node module (default False)
  -b, --browser         export as browser module (default True)
  -d, --debug           add debug information (default False)
```

## Make

The `Makefile` assumes that you have already built the parser in `../../parser`.

Run `make` to build a browser module version of `zast.py` in `test/`. You can
then open `test/index.html` and use `zast` in the console.

Tests require `node`. Run `make parse_test` to run the parser through
`../../parser/test1.py`.

TMPDIR = ./_tmpdir
PYTHON38 = ../../venv/bin/python
ZP_DEBUG =

_tmpdir:
	mkdir -p $(TMPDIR)

.PHONY: _zparse.py
_zparse.py: zipi-venv
	@echo "Make parser..."
	@cd ../../zipi/zast && $(MAKE)

.PHONY: zipi-venv
zipi-venv:
	@echo "Setting up zipi venv..."
	@cd ../.. && $(MAKE) venv

copy_files: _tmpdir zipi-venv
	@echo "Copying files..."
	cp zp_unit_tests.py $(TMPDIR)/
	cp _unit_tests.py $(TMPDIR)/

pyinterp: copy_files zipi-venv
	$(PYTHON38) zp.py -f ../../zipi/pyinterp/__init__.py $(ZP_DEBUG) -o $(TMPDIR)/pyinterp.js
	$(PYTHON38) zp.py -f ../../zipi/pyinterp/__init__.py $(ZP_DEBUG) -t -o $(TMPDIR)/pyinterp_browser.js
	$(PYTHON38) zp.py -f ../../zipi/pyinterp.py $(ZP_DEBUG) -n -t -o $(TMPDIR)/pyinterp_node.js
	cp $(TMPDIR)/pyinterp_browser.js test/pyinterp/

tests: copy_files pyinterp_tests zipi-venv
	$(PYTHON38) zp.py -f $(TMPDIR)/zp_unit_tests.py $(ZP_DEBUG) -n -t -o $(TMPDIR)/zp_unit_tests.js
	@echo "\nRunning Python unit tests...\n"
	$(PYTHON38) $(TMPDIR)/zp_unit_tests.py >$(TMPDIR)/PY_TESTS
	@echo "Python unit test results:\n"
	@cat "$(TMPDIR)/PY_TESTS" | tail -n5
	@echo "\nRunning JS unit tests...\n"
	node -e "var t = require('./$(TMPDIR)/zp_unit_tests.js'); t.run_tests();" >$(TMPDIR)/JS_TESTS
	@echo "JS unit test results:\n"
	@cat "$(TMPDIR)/JS_TESTS" | tail -n5
	diff -s $(TMPDIR)/PY_TESTS $(TMPDIR)/JS_TESTS
	rm -f $(TMPDIR)/PY_TESTS $(TMPDIR)/JS_TESTS $(TMPDIR)/zp_unit_tests.js

.PHONY: pyinterp_tests zipi-venv
pyinterp_tests:
	cd ../tests_pyinterp && $(MAKE) tests

clean:
	rm -vf ./test/zast_browser.js ./test/zast_node.js ./test/zast_browser_es6.js \
	./test/zast_node_es6.js ./test/pyinterp/pyinterp_node.js \
	./test/pyinterp/pyinterp_browser.js
	rm -vrf $(TMPDIR)/*
	rmdir $(TMPDIR)

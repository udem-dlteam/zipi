# Relative to 'must_pass' and 'wishlist'
PYTHON38 = ../../../../venv/bin/python

all: tests zp-tests

# Compare CPython and pyinterp.py results
tests:
	@echo "Comparing CPython and pyinterp.py results..."
	-cd must_pass && $(PYTHON38) ../run.py --zipi "$(PYTHON38) ../../pyinterp-run.py " >../PYINTERP_TESTS_ESSENTIAL 2>&1
	-cd wishlist && $(PYTHON38) ../run.py --zipi "$(PYTHON38) ../../pyinterp-run.py " >../PYINTERP_TESTS_WISHLIST 2>&1
	@echo "Pyinterp unit test results:"
	@echo ""
	@echo "===== ESSENTIAL TESTS ======"
	@cat "PYINTERP_TESTS_ESSENTIAL" | tail -n2
	@echo ""
	@echo "===== WiSH LIST ====="
	@cat "PYINTERP_TESTS_WISHLIST" | tail -n2
	@echo ""
	rm -f PYINTERP_TESTS_ESSENTIAL
	rm -f PYINTERP_TESTS_WISHLIST

# Run these tests from the zp makefile:

# Compare pyinterp.py and pyinterp.js traces
zp-trace-tests:
	@echo "Comparing pyinterp.py and pyinterp.js traces..."
	-cd must_pass && $(PYTHON38) ../run.py --cpython "$(PYTHON38) ../../pyinterp-run.py --trace " --zipi "node ../../../../etc/zp/zp_trace.js " >../PYINTERP_TESTS_ESSENTIAL 2>&1
	-cd wishlist && $(PYTHON38) ../run.py --cpython "$(PYTHON38) ../../pyinterp-run.py --trace " --zipi "node ../../../../etc/zp/zp_trace.js " >../PYINTERP_TESTS_WISHLIST 2>&1
	@echo "Pyinterp unit test results:"
	@echo ""
	@echo "===== ESSENTIAL TESTS ======"
	@cat "PYINTERP_TESTS_ESSENTIAL" | tail -n2
	@echo ""
	@echo "===== WiSH LIST ====="
	@cat "PYINTERP_TESTS_WISHLIST" | tail -n2
	@echo ""
	rm -f PYINTERP_TESTS_ESSENTIAL
	rm -f PYINTERP_TESTS_WISHLIST

# Compare CPython and pyinterp.js results
zp-no-trace-tests:
	@echo "Comparing CPython and pyinterp.js results..."
	-cd must_pass && $(PYTHON38) ../run.py --zipi "node ../../../../etc/zp/zp_no_trace.js " >../PYINTERPJS_TESTS_ESSENTIAL 2>&1
	-cd wishlist && $(PYTHON38) ../run.py --zipi "node ../../../../etc/zp/zp_no_trace.js " >../PYINTERPJS_TESTS_WISHLIST 2>&1
	@echo "Test results:"
	@echo ""
	@echo "===== ESSENTIAL TESTS ======"
	@cat "PYINTERPJS_TESTS_ESSENTIAL" | tail -n2
	@echo ""
	@echo "===== WiSH LIST ====="
	@cat "PYINTERPJS_TESTS_WISHLIST" | tail -n2
	@echo ""
	rm -f PYINTERPJS_TESTS_ESSENTIAL
	rm -f PYINTERPJS_TESTS_WISHLIST

zp-tests: zp-trace-tests zp-no-trace-tests

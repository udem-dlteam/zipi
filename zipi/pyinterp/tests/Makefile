# Relative to 'must_pass' and 'wishlist'
PYTHON38 = ../../../../venv/bin/python
TAIL = | tail -n2

all: tests zp-tests venv store_results

.PHONY: venv
venv:
	@cd ../../../ && $(MAKE) venv

store_results:
	@mv TEST_RESULTS OLD_TEST_RESULTS
	@echo "Comparing CPython and pyinterp.py results..." >> TEST_RESULTS
	@cat CPYTHON_PYINTERPPY_ESSENTIAL | tail -n 2 >> TEST_RESULTS
	@cat CPYTHON_PYINTERPPY_WISHLIST | tail -n 2 >> TEST_RESULTS
	rm -f CPYTHON_PYINTERPPY_ESSENTIAL
	rm -f CPYTHON_PYINTERPPY_WISHLIST
	@echo "Comparing pyinterp.py and pyinterp.js traces..." >> TEST_RESULTS
	@cat PYINTERPPY_PYINTERPJS_ESSENTIAL | tail -n 2 >> TEST_RESULTS
	@cat PYINTERPPY_PYINTERPJS_WISHLIST | tail -n 2 >> TEST_RESULTS
	rm -f PYINTERPPY_PYINTERPJS_ESSENTIAL
	rm -f PYINTERPPY_PYINTERPJS_WISHLIST
	@echo "Comparing CPython and pyinterp.js results..." >> TEST_RESULTS
	@cat CPYTHON_PYINTERPJS_ESSENTIAL | tail -n 2 >> TEST_RESULTS
	@cat CPYTHON_PYINTERPJS_WISHLIST | tail -n 2 >> TEST_RESULTS
	rm -f CPYTHON_PYINTERPJS_ESSENTIAL
	rm -f CPYTHON_PYINTERPJS_WISHLIST
	diff TEST_RESULTS OLD_TEST_RESULTS

# Compare CPython and pyinterp.py results
tests: venv
	@echo "Comparing CPython and pyinterp.py results..."
	-cd must_pass && $(PYTHON38) ../run.py --zipi "$(PYTHON38) -m zipi.pyinterp " >../CPYTHON_PYINTERPPY_ESSENTIAL 2>&1
	-cd wishlist && $(PYTHON38) ../run.py --zipi "$(PYTHON38) -m zipi.pyinterp " >../CPYTHON_PYINTERPPY_WISHLIST 2>&1
	@echo "Pyinterp unit test results:"
	@echo ""
	@echo "===== ESSENTIAL TESTS ======"
	@cat "CPYTHON_PYINTERPPY_ESSENTIAL" $(TAIL)
	@echo ""
	@echo "===== WiSH LIST ====="
	@cat "CPYTHON_PYINTERPPY_WISHLIST" $(TAIL)
	@echo ""

# Run these tests from the zp makefile:

# Compare pyinterp.py and pyinterp.js traces
zp-trace-tests: venv
	@echo "Comparing pyinterp.py and pyinterp.js traces..."
	-cd must_pass && $(PYTHON38) ../run.py --cpython "$(PYTHON38) -m zipi.pyinterp --trace " --zipi "node ../../../../etc/zp/zp_trace.js " >../PYINTERPPY_PYINTERPJS_ESSENTIAL 2>&1
	-cd wishlist && $(PYTHON38) ../run.py --cpython "$(PYTHON38) -m zipi.pyinterp --trace " --zipi "node ../../../../etc/zp/zp_trace.js " >../PYINTERPPY_PYINTERPJS_WISHLIST 2>&1
	@echo "Pyinterp unit test results:"
	@echo ""
	@echo "===== ESSENTIAL TESTS ======"
	@cat "PYINTERPPY_PYINTERPJS_ESSENTIAL" $(TAIL)
	@echo ""
	@echo "===== WiSH LIST ====="
	@cat "PYINTERPPY_PYINTERPJS_WISHLIST" $(TAIL)
	@echo ""

# Compare CPython and pyinterp.js results
zp-no-trace-tests: venv
	@echo "Comparing CPython and pyinterp.js results..."
	-cd must_pass && $(PYTHON38) ../run.py --zipi "node ../../../../etc/zp/zp_no_trace.js " >../CPYTHON_PYINTERPJS_ESSENTIAL 2>&1
	-cd wishlist && $(PYTHON38) ../run.py --zipi "node ../../../../etc/zp/zp_no_trace.js " >../CPYTHON_PYINTERPJS_WISHLIST 2>&1
	@echo "Test results:"
	@echo ""
	@echo "===== ESSENTIAL TESTS ======"
	@cat "CPYTHON_PYINTERPJS_ESSENTIAL" $(TAIL)
	@echo ""
	@echo "===== WiSH LIST ====="
	@cat "CPYTHON_PYINTERPJS_WISHLIST" $(TAIL)
	@echo ""

zp-tests: zp-trace-tests zp-no-trace-tests venv

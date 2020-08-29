# Relative to 'must_pass' and 'wishlist'
PYTHON38 = ../../../../venv/bin/python
TAIL = | tail -n2

all: tests zp-tests venv

.PHONY: venv
venv:
	@cd ../../../ && $(MAKE) venv

# Compare CPython and pyinterp.py results
tests: venv
	@echo "Comparing CPython and pyinterp.py results... (CPYTHON_PYINTERPPY)"
	rm -f CPYTHON_PYINTERPPY_ESSENTIAL
	rm -f CPYTHON_PYINTERPPY_WISHLIST
	-cd must_pass && $(PYTHON38) ../run.py --zipi "$(PYTHON38) -m zipi.pyinterp " >../CPYTHON_PYINTERPPY_ESSENTIAL
	-cd wishlist && $(PYTHON38) ../run.py --zipi "$(PYTHON38) -m zipi.pyinterp " >../CPYTHON_PYINTERPPY_WISHLIST
	@echo "Test results:"
	@echo ""
	@echo "===== ESSENTIAL TESTS ======"
	@cat "CPYTHON_PYINTERPPY_ESSENTIAL" $(TAIL)
	@echo ""
	@echo "===== WISH LIST ====="
	@cat "CPYTHON_PYINTERPPY_WISHLIST" $(TAIL)
	@echo ""

# Run these tests from the zp makefile:

# Compare pyinterp.py and pyinterp.js traces
zp-trace-tests: venv
	@echo "Comparing pyinterp.py and pyinterp.js traces... (PYINTERPPY_PYINTERPJS)"
	rm -f PYINTERPPY_PYINTERPJS_ESSENTIAL
	rm -f PYINTERPPY_PYINTERPJS_WISHLIST
	rm -f PYINTERPPY_PYINTERPJS_ESSENTIAL_NO_BIGINT
	rm -f PYINTERPPY_PYINTERPJS_WISHLIST_NO_BIGINT
	-cd must_pass && $(PYTHON38) ../run.py --cpython "$(PYTHON38) -m zipi.pyinterp --trace " --zipi "node ../../../../etc/zp/zp_trace.js " >../PYINTERPPY_PYINTERPJS_ESSENTIAL
	-cd wishlist && $(PYTHON38) ../run.py --cpython "$(PYTHON38) -m zipi.pyinterp --trace " --zipi "node ../../../../etc/zp/zp_trace.js " >../PYINTERPPY_PYINTERPJS_WISHLIST
	@echo "Test results:"
	@echo ""
	@echo "===== ESSENTIAL TESTS ======"
	@cat "PYINTERPPY_PYINTERPJS_ESSENTIAL" $(TAIL)
	@echo ""
	@echo "===== WISH LIST ====="
	@cat "PYINTERPPY_PYINTERPJS_WISHLIST" $(TAIL)
	@echo ""
	-cd must_pass && $(PYTHON38) ../run.py --cpython "$(PYTHON38) -m zipi.pyinterp --trace " --zipi "node ../../../../etc/zp/zp_trace.js -nb " >../PYINTERPPY_PYINTERPJS_ESSENTIAL_NO_BIGINT
	-cd wishlist && $(PYTHON38) ../run.py --cpython "$(PYTHON38) -m zipi.pyinterp --trace " --zipi "node ../../../../etc/zp/zp_trace.js -nb " >../PYINTERPPY_PYINTERPJS_WISHLIST_NO_BIGINT
	@echo "Test results (disabled BigInt support):"
	@echo ""
	@echo "===== ESSENTIAL TESTS ======"
	@cat "PYINTERPPY_PYINTERPJS_ESSENTIAL_NO_BIGINT" $(TAIL)
	@echo ""
	@echo "===== WISH LIST ====="
	@cat "PYINTERPPY_PYINTERPJS_WISHLIST_NO_BIGINT" $(TAIL)
	@echo ""

# Compare CPython and pyinterp.js results
zp-no-trace-tests: venv
	@echo "Comparing CPython and pyinterp.js results... (CPYTHON_PYINTERPJS)"
	rm -f CPYTHON_PYINTERPJS_ESSENTIAL
	rm -f CPYTHON_PYINTERPJS_WISHLIST
	rm -f CPYTHON_PYINTERPJS_ESSENTIAL_NO_BIGINT
	rm -f CPYTHON_PYINTERPJS_WISHLIST_NO_BIGINT
	-cd must_pass && $(PYTHON38) ../run.py --zipi "node ../../../../etc/zp/zp_no_trace.js " >../CPYTHON_PYINTERPJS_ESSENTIAL
	-cd wishlist && $(PYTHON38) ../run.py --zipi "node ../../../../etc/zp/zp_no_trace.js " >../CPYTHON_PYINTERPJS_WISHLIST
	@echo "Test results:"
	@echo ""
	@echo "===== ESSENTIAL TESTS ======"
	@cat "CPYTHON_PYINTERPJS_ESSENTIAL" $(TAIL)
	@echo ""
	@echo "===== WISH LIST ====="
	@cat "CPYTHON_PYINTERPJS_WISHLIST" $(TAIL)
	@echo ""
	-cd must_pass && $(PYTHON38) ../run.py --zipi "node ../../../../etc/zp/zp_no_trace.js -nb " >../CPYTHON_PYINTERPJS_ESSENTIAL_NO_BIGINT
	-cd wishlist && $(PYTHON38) ../run.py --zipi "node ../../../../etc/zp/zp_no_trace.js -nb " >../CPYTHON_PYINTERPJS_WISHLIST_NO_BIGINT
	@echo "Test results (disabled BigInt support):"
	@echo ""
	@echo "===== ESSENTIAL TESTS ======"
	@cat "CPYTHON_PYINTERPJS_ESSENTIAL_NO_BIGINT" $(TAIL)
	@echo ""
	@echo "===== WISH LIST ====="
	@cat "CPYTHON_PYINTERPJS_WISHLIST_NO_BIGINT" $(TAIL)
	@echo ""

zp-tests: zp-trace-tests zp-no-trace-tests venv

PYTHON38 = python3

tests:
	@echo "Running pyinterp tests..."
	-cd must_pass && $(PYTHON38) run.py --zipi "python ../pyinterp-run.py " >../PYINTERP_TESTS_ESSENTIAL 2>&1
	-cd whishlist && $(PYTHON38) run.py --zipi "python ../pyinterp-run.py " >../PYINTERP_TESTS_WHISHLIST 2>&1
	@echo "Pyinterp unit test results:"
	@echo ""
	@echo "===== ESSENTIAL TESTS ======"
	@cat "PYINTERP_TESTS_ESSENTIAL" | tail -n2
	@echo ""
	@echo "===== WHISH LIST ====="
	@cat "PYINTERP_TESTS_WHISHLIST" | tail -n2
	@echo ""
	rm -f PYINTERP_TESTS


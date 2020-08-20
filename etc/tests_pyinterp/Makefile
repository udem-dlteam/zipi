PYTHON38 = python3

tests:
	@echo "\nRunning pyinterp tests...\n"
	-$(PYTHON38) run.py --zipi "python ../pyinterp-run.py " >PYINTERP_TESTS 2>&1
	@echo "Pyinterp unit test results:\n"
	@cat "PYINTERP_TESTS" | tail -n2
	@echo "\n"
	rm -f PYINTERP_TESTS


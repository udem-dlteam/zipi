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

pyinterp: _tmpdir zipi-venv _zparse.py
	$(PYTHON38) zp.py -f ../../zipi/pyinterp/__init__.py $(ZP_DEBUG) -e pyinterp -o $(TMPDIR)/pyinterp.js
	$(PYTHON38) zp.py -f ../../zipi/pyinterp/__init__.py $(ZP_DEBUG) -e pyinterp -t -o $(TMPDIR)/pyinterp_browser.js
	$(PYTHON38) zp.py -f ../../zipi/pyinterp/__init__.py $(ZP_DEBUG) -e pyinterp -n -t -o $(TMPDIR)/pyinterp_node.js
	cp $(TMPDIR)/pyinterp_browser.js test/pyinterp/

tests: pyinterp
	cd ../../zipi/pyinterp/tests && $(MAKE)

clean:
	rm -vf ./test/zast_browser.js ./test/zast_node.js ./test/zast_browser_es6.js \
	./test/zast_node_es6.js ./test/pyinterp/pyinterp_node.js \
	./test/pyinterp/pyinterp_browser.js
	rm -vrf $(TMPDIR)/*
	rmdir $(TMPDIR)

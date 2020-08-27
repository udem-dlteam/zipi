TMPDIR = ./_tmpdir
PYTHON38 = python3
ZP_DEBUG =

_tmpdir:
	mkdir -p $(TMPDIR)

.PHONY: ../../parser/_zparse.py
../../parser/_zparse.py:
	@echo "Make parser..."
	@cd ../../parser && $(MAKE)

copy_files: _tmpdir ../pyinterp.py ../../parser/_zast.py ../../parser/ztokenizer.py ../../parser/ztoken.py ../../parser/zast.py ../../parser/zpgen.py ../../parser/_zparse.py ../../parser/_runtime.py zp_unit_tests.py _unit_tests.py
	@echo "Copying files..."
	cp zp_unit_tests.py $(TMPDIR)/
	cp _unit_tests.py $(TMPDIR)/
	cp ../pyinterp.py $(TMPDIR)/
	cp ../../parser/zast.py $(TMPDIR)/
	cp ../../parser/_zast.py $(TMPDIR)/
	cp ../../parser/ztokenizer.py $(TMPDIR)/
	cp ../../parser/ztoken.py $(TMPDIR)/
	cp ../../parser/_zparse.py $(TMPDIR)/
	cp ../../parser/_runtime.py $(TMPDIR)/

pyinterp: copy_files
	$(PYTHON38) zp.py -f $(TMPDIR)/pyinterp.py $(ZP_DEBUG) -o $(TMPDIR)/pyinterp.js
	$(PYTHON38) zp.py -f $(TMPDIR)/pyinterp.py $(ZP_DEBUG) -t -o $(TMPDIR)/pyinterp_browser.js
	$(PYTHON38) zp.py -f $(TMPDIR)/pyinterp.py $(ZP_DEBUG) -n -t -o $(TMPDIR)/pyinterp_node.js
	cp $(TMPDIR)/pyinterp_browser.js test/pyinterp/

tests: pyinterp
	cd ../tests_pyinterp && $(MAKE)

clean:
	rm -vf ./test/zast_browser.js ./test/zast_node.js ./test/zast_browser_es6.js \
	./test/zast_node_es6.js ./test/pyinterp/pyinterp_node.js \
	./test/pyinterp/pyinterp_browser.js
	rm -vrf $(TMPDIR)/*
	rmdir $(TMPDIR)

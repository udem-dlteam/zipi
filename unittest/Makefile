

-include ../etc/Makefile.zipiconfig
test_folder = "../zipitestlib/test"

cpython:
	git clone https://github.com/python/cpython.git \
		--depth 1 \
		--filter blob:none \
		--sparse;\
	cd cpython && \
	git sparse-checkout init --cone && \
	git sparse-checkout set Lib/test

clean:
	rm -rf cpython
	rm -rf $(test_folder)

install: cpython
	cp -r test ../zipitestlib
	cp -n -r cpython/Lib/test ../zipitestlib/

unittest: install
	python run-test.py $(test_folder)/test_*.py -c -zipi "../bin/zipi.gambit" -zpc "../bin/zipi.zpc"

unittest-fast: install
	python run-test.py $(test_folder)/test_int.py $(test_folder)/test_bool.py -c -zipi "../bin/zipi.gambit" -zpc "../bin/zipi.zpc"

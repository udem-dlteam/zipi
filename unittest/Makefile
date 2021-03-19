

-include ../etc/Makefile.zipiconfig

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
	rm -rf ../zipitestlib/test

install: cpython
	cp -r test ../zipitestlib
	cp -n -r cpython/Lib/test ../zipitestlib/

unittest: install
	python run-test.py ../zipitestlib/test/test_*.py

unittest-fast: install
	python run-test.py ../zipitestlib/test/{test_int.py,test_bool.py}

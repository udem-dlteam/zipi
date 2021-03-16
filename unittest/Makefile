

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

install: cpython
	cp -n -r cpython/Lib/test ../zipitestlib/test

unittest: install
	python run-test.py ../zipitestlib/test/test_*.py

include ../etc/Makefile.zipiconfig

all: micro

gen-micro:
	scripts/gen_micro_bench.py

micro:
	#rm -rf "/Users/feeley/.zipicache/cache@zipi_0_0_1/Users/feeley/python/zipi/bench"
	@for bench in micro_*.py; do \
	  ./compare-zipi-cpython $$bench $(ZIPISYSTEMS); \
	done

micro-gambit:
	@for bench in micro_*.py; do \
	  ./compare-zipi-cpython $$bench gambit; \
	done

micro-bigloo:
	@for bench in micro_*.py; do \
	  ./compare-zipi-cpython $$bench bigloo; \
	done

list:
	@for bench in micro_*.py; do \
          echo $$bench; \
	done

realclean:
	rm micro_*.py

clean:

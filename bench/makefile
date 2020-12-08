include ../etc/Makefile.zipiconfig

all: micro

gen-micro:
	scripts/gen_micro_bench.py

micro:
	@for bench in micro_*.py; do \
	  ./compare-zipi-cpython $$bench $(ZIPISYSTEMS); \
	done

micro-gambit:
	../bin/zipi.gambit -X reset
	@for bench in micro_*.py; do \
	  ./compare-zipi-cpython $$bench gambit; \
	done

micro-bigloo:
	@for bench in micro_*.py; do \
	  ./compare-zipi-cpython $$bench bigloo; \
	done

micro-pypy:
	@for bench in micro_*.py; do \
	  ./compare-zipi-cpython $$bench pypy; \
	done

.PHONY: profile

profile:
	../bin/zipi.gambit -X reset
	@for bench in *.py; do \
	  ./profile-zipi $$bench $(ZIPISYSTEMS); \
	done

profile-gambit:
	../bin/zipi.gambit -X reset
	@for bench in *.py; do \
	  ./profile-zipi $$bench gambit; \
	done

profile-bigloo:
	@for bench in *.py; do \
	  ./profile-zipi $$bench bigloo; \
	done

list:
	@for bench in micro_*.py; do \
          echo $$bench; \
	done

realclean:
	rm micro_*.py

clean:


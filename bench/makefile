include ../etc/Makefile.zipiconfig

all: micro

gen-micro:
	scripts/gen_micro_bench.py

micro:
	@echo "system   cpython2  cpython3 (higher than 1x means faster than cpython2/3)"
	@for bench in micro_*.py; do \
	  ./compare-to-cpython $$bench $(ZIPISYSTEMS); \
	done

micro-gambit:
	../bin/zipi.gambit -X reset
	@echo "system   cpython2  cpython3 (higher than 1x means faster than cpython2/3)"
	@for bench in micro_*.py; do \
	  ./compare-to-cpython $$bench gambit; \
	done

micro-bigloo:
	@echo "system   cpython2  cpython3 (higher than 1x means faster than cpython2/3)"
	@for bench in micro_*.py; do \
	  ./compare-to-cpython $$bench bigloo; \
	done

micro-pypy:
	@echo "system   cpython2  cpython3 (higher than 1x means faster than cpython2/3)"
	@for bench in micro_*.py; do \
	  ./compare-to-cpython $$bench pypy; \
	done

scm:
	@echo "system   cpython2  cpython3 (higher than 1x means faster than cpython2/3)"
	@for bench in scm_*.py; do \
	  ./compare-to-cpython $$bench $(ZIPISYSTEMS); \
	done

scm-gambit:
	../bin/zipi.gambit -X reset
	@echo "system   cpython2  cpython3 (higher than 1x means faster than cpython2/3)"
	@for bench in scm_*.py; do \
	  ./compare-to-cpython $$bench gambit; \
	done

scm-bigloo:
	@echo "system   cpython2  cpython3 (higher than 1x means faster than cpython2/3)"
	@for bench in scm_*.py; do \
	  ./compare-to-cpython $$bench bigloo; \
	done

scm-pypy:
	@echo "system   cpython2  cpython3 (higher than 1x means faster than cpython2/3)"
	@for bench in scm_*.py; do \
	  ./compare-to-cpython $$bench pypy; \
	done

.PHONY: profile

profile:
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


include ../etc/Makefile.zipiconfig

.PHONY: configure run check compare-to-cpython scm-compare-to-cpython \
  micro-compare-to-cpython compare clean

# The benchmark suite lives in the "suite" directory (it used to be the
# separate udem-dlteam/zipi-benchmarks repository).
SUITE = suite

system ?= $(BUILDBINDIR)/zipi
systems ?= $(BUILDPYTHON) $(BUILDBINDIR)/zipi
filter ?=

configure: $(SUITE)/run

$(SUITE)/run: $(SUITE)/run.in $(SUITE)/configure $(SUITE)/benchmarks/micro/_gen_micro_bench.py
	cd $(SUITE); PYTHON=$(BUILDPYTHON) bash ./configure

run: configure
	@cd $(SUITE); ./run --system $(system) --filter "$(filter)"

# Run every benchmark (matching filter) once and fail if any of them crashes
check: configure
	@cd $(SUITE); ./run --system $(system) --max-repeat 1 --filter "$(filter)" \
	  | sed -e 's/^+!CSVLINE!+,//' | tee .check.out
	@if grep -q ',CRASHED$$' $(SUITE)/.check.out; then \
	  echo "*** benchmarks crashed:"; grep ',CRASHED$$' $(SUITE)/.check.out; \
	  rm -f $(SUITE)/.check.out; exit 1; \
	else \
	  echo "*** all benchmarks ran successfully"; rm -f $(SUITE)/.check.out; \
	fi

compare-to-cpython: configure
	@$(BUILDPYTHON) compare.py --systems $(BUILDPYTHON) $(BUILDBINDIR)/zipi --filter "$(filter)"

scm-compare-to-cpython: configure
	@$(BUILDPYTHON) compare.py --systems $(BUILDPYTHON) $(BUILDBINDIR)/zipi --filter scm

micro-compare-to-cpython: configure
	@$(BUILDPYTHON) compare.py --systems $(BUILDPYTHON) $(BUILDBINDIR)/zipi --filter micro

compare: configure
	@$(BUILDPYTHON) compare.py --systems $(systems) --filter "$(filter)"

clean:
	if [ -f $(SUITE)/makefile ]; then $(MAKE) -C $(SUITE) distclean; fi

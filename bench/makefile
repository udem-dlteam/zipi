include ../etc/Makefile.zipiconfig

.PHONE: build update run

system ?= $(BUILDBINDIR)/zipi

zipi-benchmarks:
	git clone git@github.com:udem-dlteam/zipi-benchmarks.git
	cd zipi-benchmarks; ./configure

update: zipi-benchmarks
	cd zipi-benchmarks; ./update

run: zipi-benchmarks
	@cd zipi-benchmarks; ./run --system $(system) --filter $(filter)

compare-to-cpython: zipi-benchmarks
	@$(BUILDPYTHON) compare.py --systems $(BUILDPYTHON) $(BUILDDIR)/bin/zipi --filter $(filter)

scm-compare-to-cpython: zipi-benchmarks
	@$(BUILDPYTHON) compare.py --systems $(BUILDPYTHON) $(BUILDDIR)/bin/zipi --filter scm

micro-compare-to-cpython: zipi-benchmarks
	@$(BUILDPYTHON) compare.py --systems $(BUILDPYTHON) $(BUILDDIR)/bin/zipi --filter micro

compare: zipi-benchmarks
	@$(BUILDPYTHON) compare.py --systems $(systems) --filter $(filter)

make clean:
	rm -rf zipi-benchmarks

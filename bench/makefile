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

compare: zipi-benchmarks
	@$(BUILDPYTHON) compare.py --systems $(systems) --filter $(filter)

make clean:
	rm -rf zipi-benchmarks

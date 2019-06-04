BIGLOO = bigloo
BFLAGS = -g # -Obench
AFILE = bglafile
GAMBIT = gsc

SOURCES = evalpy/evalpy

.SUFFIXES:
.SUFFIXES: .scm .bgl .o

astpy.bigloo: .afile
	mkdir -p o/bigloo
	$(MAKE) astpy COMPILER=$(BIGLOO) LINKER="$(BIGLOO) $(BFLAGS)" \
           OBJECTS=$(SOURCES:%=o/bigloo/%.o)

astpy: $(OBJECTS)
	$(LINKER) $(LFLAGS) astpy.bgl $(OBJECTS) -o astpy


.PHONY: clean

.afile:
	$(AFILE) -o .afile $(SOURCES:%=%.bgl)

clean:
	rm -f .afile
	rm -rf o
	rm -f aspy

o/bigloo/%.o: %.bgl %.scm
	mkdir -p $(@D)
	$(COMPILER) $(BFLAGS) -c $+ -o $@

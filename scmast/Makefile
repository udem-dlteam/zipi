BIGLOO = bigloo
BFLAGS = -g # -Obench
AFILE = bglafile
GAMBIT = gsc

SOURCES = ast/ast sexp/sexp symbol/symbol return/return beval/beval \
  hclass/hclass object/object

.SUFFIXES:
.SUFFIXES: .scm .bgl .sch .o

astpy.bigloo: .afile ast/types.sch hclass/hclass.sch object/object.sch
	mkdir -p o/bigloo
	$(MAKE) astpy COMPILER=$(BIGLOO) LINKER="$(BIGLOO) $(BFLAGS)" \
           OBJECTS="$(SOURCES:%=o/bigloo/%.o)"

astpy: $(OBJECTS)
	$(LINKER) $(LFLAGS) astpy.bgl $(OBJECTS) -o astpy


.PHONY: clean clenall

.afile:
	$(AFILE) -o .afile $(SOURCES:%=%.bgl)

clean:
	rm -rf o
	rm -f astpy
	rm -f astpy.o

cleanall: clean
	rm -f .afile
	rm -f ast/types.sch

o/bigloo/%.o: %.bgl %.scm
	mkdir -p $(@D)
	$(COMPILER) $(BFLAGS) -c $+ -o $@

ast/types.sch: ast/ast.bgl
	$(BIGLOO) -classgen $< -o $@

%.sch: %.bgl
	$(BIGLOO) -classgen $< -o $@

BIGLOO = bigloo
BFLAGS = -g # -Obench
AFILE = bglafile
GAMBIT = gsc

SOURCES = main/main ast/ast sexp/sexp symbol/symbol return/return \
  beval/beval hclass/hclass object/object dump/dump locals/locals \
  break/break scheme/scheme \
  javascript/javascript

.SUFFIXES:
.SUFFIXES: .scm .bgl .sch .o

pyc.bigloo: .afile ast/types.sch hclass/hclass.sch object/object.sch
	mkdir -p o/bigloo
	$(MAKE) pyc COMPILER=$(BIGLOO) LINKER="$(BIGLOO) -w $(BFLAGS)" \
           OBJECTS="$(SOURCES:%=o/bigloo/%.o)"

pyc: $(OBJECTS)
	$(LINKER) $(LFLAGS) $(OBJECTS) -o pyc


.PHONY: clean clenall

.afile:
	$(AFILE) -o .afile $(SOURCES:%=%.bgl)

clean:
	rm -rf o
	rm -f pyc
	rm -f pyc.o

cleanall: clean
	rm -f .afile
	rm -f ast/types.sch
	rm -f ast/new.sch

o/bigloo/%.o: %.bgl %.scm
	mkdir -p $(@D)
	$(COMPILER) $(BFLAGS) -c $+ -o $@

ast/types.sch: ast/ast.bgl
	$(BIGLOO) -classgen $< -o $@

ast/new.sch: ast/ast.bgl
	$(BIGLOO) -i etc/mkastnew.scm $< > $@

%.sch: %.bgl
	$(BIGLOO) -classgen $< -o $@

main/main.scm: ast/new.sch

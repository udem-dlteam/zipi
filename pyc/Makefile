#*=====================================================================*/
#*    serrano/prgm/project/zipi/zpc/Makefile                           */
#*    -------------------------------------------------------------    */
#*    Author      :  Manuel Serrano                                    */
#*    Creation    :  Mon Jul  1 13:14:30 2019                          */
#*    Last change :  Mon Jul  1 13:16:01 2019 (serrano)                */
#*    Copyright   :  2019 Marc Feeley & Manuel Serrano                 */
#*    -------------------------------------------------------------    */
#*    The makefile to build the ZPC compiler                           */
#*=====================================================================*/

.phony: do bigloo gambit

do: $(ZIPISYSTEMS)

bigloo:
	$(MAKE) -f Makfile.bigloo

gambit:
	$(MAKE) -f Makfile.gambit


BIGLOO = bigloo
BFLAGS = -g # -Obench
AFILE = bglafile
GAMBIT = gsc

SOURCES = main/main ast/ast sexp/sexp symbol/symbol return/return \
  beval/beval dump/dump locals/locals \
  break/break generator/generator cps/cps scheme/scheme \
  javascript/javascript \
  hclass/hclass object/object iterator/iterator import/import

.SUFFIXES:
.SUFFIXES: .scm .bgl .sch .o

pyc.bigloo: .afile ast/types.sch ast/new.sch \
  hclass/hclass.sch object/object.sch \
  iterator/iterator.sch 
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
	touch $@ && $(BIGLOO) -classgen $< -o $@

main/main.scm: ast/new.sch

#*=====================================================================*/
#*    serrano/prgm/project/zipi/pyc/Makefile                           */
#*    -------------------------------------------------------------    */
#*    Author      :  Manuel Serrano                                    */
#*    Creation    :  Mon Jul  1 13:14:30 2019                          */
#*    Last change :  Tue Jul  2 11:49:18 2019 (serrano)                */
#*    Copyright   :  2019 Marc Feeley & Manuel Serrano                 */
#*    -------------------------------------------------------------    */
#*    The makefile to build the PYC compiler library                   */
#*=====================================================================*/
.PHONY: do bigloo gambit install

do: build

#*---------------------------------------------------------------------*/
#*    Standard Zipi configuration                                      */
#*---------------------------------------------------------------------*/
-include ../etc/Makefile.zipiconfig

#*---------------------------------------------------------------------*/
#*    common objects                                                   */
#*---------------------------------------------------------------------*/
OBJECTS_COMMON = ast compile sexp symbol return dump locals break \
  generator cps scheme javascript

#*---------------------------------------------------------------------*/
#*    Common entry points                                              */
#*---------------------------------------------------------------------*/
build: $(ZIPISYSTEMS:%=do.%)
install: $(ZIPISYSTEMS:%=install.%)

-include Makefile.bigloo
-include Makefile.gambit

#*---------------------------------------------------------------------*/
#*    common cleanup                                                   */
#*---------------------------------------------------------------------*/
.PHONY: clean cleanall

clean: $(ZIPISYSTEMS:%=clean.%)

cleanall: clean
	rm -f types.sch
	rm -f new.sch

#*---------------------------------------------------------------------*/
#*    common targets and dependencies                                  */
#*---------------------------------------------------------------------*/
types.sch: ast.bgl
	$(BIGLOO) -classgen $< -o $@

new.sch: ast.bgl
	$(BIGLOO) -i $(BUILDETCDIR)/mkastnew.scm $< > $@

%.sch: %.bgl
	touch $@ && $(BIGLOO) -classgen $< -o $@

compile.scm: new.sch types.sch


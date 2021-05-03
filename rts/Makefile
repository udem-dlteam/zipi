#*=====================================================================*/
#*    serrano/prgm/project/zipi/rts/Makefile                           */
#*    -------------------------------------------------------------    */
#*    Author      :  Manuel Serrano                                    */
#*    Creation    :  Mon Jul  1 13:14:30 2019                          */
#*    Last change :  Sun May  2 14:27:32 2021 (serrano)                */
#*    Copyright   :  2019-21 Marc Feeley & Manuel Serrano              */
#*    -------------------------------------------------------------    */
#*    The makefile to build the ZIPI runtime system                    */
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
OBJECTS_COMMON = rts configure

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

distclean: clean
	rm -f rts.sch

cleanall: distclean

#*---------------------------------------------------------------------*/
#*    common targets and dependencies                                  */
#*---------------------------------------------------------------------*/
rts.sch: behaviors.sch zemantics.sch
o/rts.o: rts.sch

%.sch: %.bgl .afile
	touch $@ && $(BIGLOO) -srfi classgen -classgen $< -o $@ || (rm -f $@; exit 1)

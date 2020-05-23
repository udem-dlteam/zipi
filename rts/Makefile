#*=====================================================================*/
#*    serrano/prgm/project/zipi/rts/Makefile                           */
#*    -------------------------------------------------------------    */
#*    Author      :  Manuel Serrano                                    */
#*    Creation    :  Mon Jul  1 13:14:30 2019                          */
#*    Last change :  Sat May 23 08:45:53 2020 (serrano)                */
#*    Copyright   :  2019-20 Marc Feeley & Manuel Serrano              */
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
OBJECTS_COMMON = hclass object import iterator configure

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
	rm -f object.sch
	rm -f hclass.sch

cleanall: distclean

#*---------------------------------------------------------------------*/
#*    common targets and dependencies                                  */
#*---------------------------------------------------------------------*/
o/object.o: object.sch

%.sch: %.bgl .afile
	touch $@ && $(BIGLOO) -classgen $< -o $@

.afile: hclass.sch

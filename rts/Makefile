#*=====================================================================*/
#*    serrano/prgm/project/zipi/rts/Makefile                           */
#*    -------------------------------------------------------------    */
#*    Author      :  Manuel Serrano                                    */
#*    Creation    :  Mon Jul  1 13:14:30 2019                          */
#*    Last change :  Tue Jul  2 11:39:51 2019 (serrano)                */
#*    Copyright   :  2019 Marc Feeley & Manuel Serrano                 */
#*    -------------------------------------------------------------    */
#*    The makefile to build the PYC compiler library                   */
#*=====================================================================*/
.PHONY: do bigloo gambit install

do: build
install: install-library

#*---------------------------------------------------------------------*/
#*    Standard Zipi configuration                                      */
#*---------------------------------------------------------------------*/
-include ../etc/Makefile.zipiconfig

#*---------------------------------------------------------------------*/
#*    common objects                                                   */
#*---------------------------------------------------------------------*/
OBJECTS_COMMON = hclass object import iterator

#*---------------------------------------------------------------------*/
#*    Common entry points                                              */
#*---------------------------------------------------------------------*/
build: $(ZIPISYSTEMS:%=do.%)

-include Makefile.bigloo
-include Makefile.gambit

#*---------------------------------------------------------------------*/
#*    common cleanup                                                   */
#*---------------------------------------------------------------------*/
.PHONY: clean cleanall

clean: $(ZIPISYSTEMS:%=clean.%)

cleanall: clean
	rm -f object.sch
	rm -f hclass.sch

#*---------------------------------------------------------------------*/
#*    common targets and dependencies                                  */
#*---------------------------------------------------------------------*/
o/object.o: object.sch

%.sch: %.bgl
	touch $@ && $(BIGLOO) -classgen $< -o $@


#*=====================================================================*/
#*    serrano/prgm/project/zipi/zipi/zipi/Makefile                     */
#*    -------------------------------------------------------------    */
#*    Author      :  Manuel Serrano                                    */
#*    Creation    :  Mon Jul  1 13:14:30 2019                          */
#*    Last change :  Thu Aug 12 09:45:09 2021 (serrano)                */
#*    Copyright   :  2019-21 Marc Feeley & Manuel Serrano              */
#*    -------------------------------------------------------------    */
#*    The makefile to build the zip launcher                           */
#*=====================================================================*/
.PHONY: do bigloo gambit install

do: build

#*---------------------------------------------------------------------*/
#*    Standard Zipi configuration                                      */
#*---------------------------------------------------------------------*/
-include ../etc/Makefile.zipiconfig

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

cleanall: distclean

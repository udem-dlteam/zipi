#*=====================================================================*/
#*    serrano/prgm/project/zipi/Makefile                               */
#*    -------------------------------------------------------------    */
#*    Author      :  Marc Feeley & Manuel Serrano                      */
#*    Creation    :  Sat Feb 19 12:25:16 2000                          */
#*    Last change :  Mon Jul  1 13:17:02 2019 (serrano)                */
#*    Copyright   :  2019 Marc Feeley & Manuel Serrano                 */
#*    -------------------------------------------------------------    */
#*    The Makefile to build Zipi.                                      */
#*=====================================================================*/
.PHONY: do

do: build

#*---------------------------------------------------------------------*/
#*    Standard Bigloo configuration                                    */
#*---------------------------------------------------------------------*/
-include etc/Makefile.zipiconfig

#*---------------------------------------------------------------------*/
#*    build                                                            */
#*---------------------------------------------------------------------*/
.PHONY: bindir libdir lib bin clean distclean cleanall

build: bindir libdir lib bin

bindir:
	mkdir -p bin

libdir:
	mkdir -p lib

bin: bindir
	$(MAKE) -C zpc

lib: libdir
	$(MAKE) -C rts

#*---------------------------------------------------------------------*/
#*    clean                                                            */
#*---------------------------------------------------------------------*/
clean:
	$(MAKE) -C zpc clean
	$(MAKE) -C rts clean

distclean: clean
	$(MAKE) -C zpc distclean
	$(MAKE) -C rts distclean
	rm -rf bin lib
	rm -f etc/Makefile.zipiconfig

clenall: distclean

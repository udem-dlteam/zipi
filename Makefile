#*=====================================================================*/
#*    serrano/prgm/project/zipi/Makefile                               */
#*    -------------------------------------------------------------    */
#*    Author      :  Marc Feeley & Manuel Serrano                      */
#*    Creation    :  Sat Feb 19 12:25:16 2000                          */
#*    Last change :  Tue Jul  2 11:46:25 2019 (serrano)                */
#*    Copyright   :  2019 Marc Feeley & Manuel Serrano                 */
#*    -------------------------------------------------------------    */
#*    The Makefile to build Zipi.                                      */
#*=====================================================================*/
.PHONY: do mkdir

do: build

#*---------------------------------------------------------------------*/
#*    Standard Bigloo configuration                                    */
#*---------------------------------------------------------------------*/
-include etc/Makefile.zipiconfig

#*---------------------------------------------------------------------*/
#*    build                                                            */
#*---------------------------------------------------------------------*/
.PHONY: bindir libdir lib pyc rts bin clean distclean cleanall

build: pyc zpc rts bin

bindir:
	mkdir -p bin

libdir:
	mkdir -p lib

bin: bindir
	$(MAKE) -C zpc

pyc: libdir
	$(MAKE) -C pyc

rts: libdir zpc
	$(MAKE) -C rts

zpc: pyc
	$(MAKE) -C zpc

#*---------------------------------------------------------------------*/
#*    install                                                          */
#*---------------------------------------------------------------------*/
install: zipi-dirs
	$(MAKE) -C pyc install
	$(MAKE) -C zpc install
	$(MAKE) -C rts install

zipi-dirs:
	if [ ! -d $(DESTDIR)$(ZIPIBINDIR) ]; then \
          $(MAKE) mkdir DIR=$(DESTDIR)$(ZIPIBINDIR); \
        fi
	if [ ! -d $(DESTDIR)$(ZIPILIBDIR) ]; then \
          $(MAKE) mkdir DIR=$(DESTDIR)$(ZIPILIBDIR); \
        fi
	if [ ! -d $(DESTDIR)$(ZIPIETCDIR) ]; then \
	  $(MAKE) mkdir DIR=$(DESTDIR)$(ZIPIETCDIR); \
        fi
	if [ ! -d $(DESTDIR)$(ZIPILIBDIR)/zipi ]; then \
	  $(MAKE) mkdir DIR=$(DESTDIR)$(ZIPILIBDIR)/zipi; \
        fi
	if [ ! -d $(DESTDIR)$(ZIPILIBDIR)/$(ZIPIFILDIR) ]; then \
	  $(MAKE) mkdir DIR=$(DESTDIR)$(ZIPILIBDIR)/$(ZIPIFILDIR); \
        fi


#*---------------------------------------------------------------------*/
#*    clean                                                            */
#*---------------------------------------------------------------------*/
clean:
	$(MAKE) -C pyc clean
	$(MAKE) -C zpc clean
	$(MAKE) -C rts clean

distclean: clean
	$(MAKE) -C pyc distclean
	$(MAKE) -C zpc distclean
	$(MAKE) -C rts distclean
	rm -rf bin lib
	rm -f etc/Makefile.zipiconfig

clenall: distclean

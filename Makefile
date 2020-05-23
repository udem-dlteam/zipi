#*=====================================================================*/
#*    serrano/prgm/project/zipi/Makefile                               */
#*    -------------------------------------------------------------    */
#*    Author      :  Marc Feeley & Manuel Serrano                      */
#*    Creation    :  Sat Feb 19 12:25:16 2000                          */
#*    Last change :  Sat May 23 09:05:31 2020 (serrano)                */
#*    Copyright   :  2019-20 Marc Feeley & Manuel Serrano              */
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
.PHONY: build clean distclean cleanall

build:
	mkdir -p bin
	mkdir -p lib
	$(MAKE) -C pyc
	$(MAKE) -C zpc
	$(MAKE) -C rts

#*---------------------------------------------------------------------*/
#*    install                                                          */
#*---------------------------------------------------------------------*/
install: zipi-dirs
	$(MAKE) -C pyc install
	$(MAKE) -C zpc install
	$(MAKE) -C rts install
	$(MAKE) -C etc install
	$(MAKE) install.systems

install.systems: $(ZIPISYSTEMS:%=install.system.%)

-include etc/Makefile.bigloo
-include etc/Makefile.gambit

zipi-dirs:
	if [ ! -d $(DESTDIR)$(ZIPIBINDIR) ]; then \
          mkdir -p $(DESTDIR)$(ZIPIBINDIR) && chmod $(MODDIR) $(DESTDIR)$(ZIPIBINDIR); \
        fi
	if [ ! -d $(DESTDIR)$(ZIPILIBDIR) ]; then \
          mkdir -p $(DESTDIR)$(ZIPILIBDIR) && chmod $(MODDIR) $(DESTDIR)$(ZIPILIBDIR); \
        fi
	if [ ! -d $(DESTDIR)$(ZIPIETCDIR) ]; then \
	  mkdir -p $(DESTDIR)$(ZIPIETCDIR) && chmod $(MODDIR) $(DESTDIR)$(ZIPIETCDIR); \
        fi
	if [ ! -d $(DESTDIR)$(ZIPILIBDIR)/zipi ]; then \
	  mkdir -p $(DESTDIR)$(ZIPILIBDIR)/zipi && chmod $(MODDIR) $(DESTDIR)$(ZIPILIBDIR)/zipi; \
        fi
	if [ ! -d $(DESTDIR)$(ZIPILIBDIR)/$(ZIPIFILDIR) ]; then \
	  mkdir -p $(DESTDIR)$(ZIPILIBDIR)/$(ZIPIFILDIR) && chmod $(MODDIR) $(DESTDIR)$(ZIPILIBDIR)/$(ZIPIFILDIR); \
        fi


#*---------------------------------------------------------------------*/
#*    clean                                                            */
#*---------------------------------------------------------------------*/
clean:
	$(MAKE) -C pyc clean
	$(MAKE) -C zpc clean
	$(MAKE) -C rts clean
	$(MAKE) -C stdlib clean

distclean: clean
	$(MAKE) -C pyc distclean
	$(MAKE) -C zpc distclean
	$(MAKE) -C rts distclean
	$(MAKE) -C stdlib distclean
	rm -rf bin lib
	rm -f etc/Makefile.zipiconfig

cleanall: distclean

test:
	@cd tests; python run.py

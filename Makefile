#*=====================================================================*/
#*    serrano/prgm/project/zipi/Makefile                               */
#*    -------------------------------------------------------------    */
#*    Author      :  Marc Feeley & Manuel Serrano                      */
#*    Creation    :  Sat Feb 19 12:25:16 2000                          */
#*    Last change :  Sat May 23 09:05:31 2020 (serrano)                */
#*    Copyright   :  2019-21 Marc Feeley & Manuel Serrano              */
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
#*    cPython venv                                                     */
#*---------------------------------------------------------------------*/

venv:
	virtualenv --python=$(BUILDPYTHON) venv
	. ./venv/bin/activate; pip install -r requirements.txt

#*---------------------------------------------------------------------*/
#*    build                                                            */
#*---------------------------------------------------------------------*/
.PHONY: build clean distclean cleanall

build: venv
	mkdir -p bin
	mkdir -p lib
	$(MAKE) -C pyc
	$(MAKE) -C zpc
	$(MAKE) -C stdlib
	$(MAKE) -C rts
	rm -rf ./bin/pysexp.py; ln -s ../etc/pysexp.py ./bin/pysexp.py
	chmod u+x ./etc/pysexp.py

#*---------------------------------------------------------------------*/
#*    install                                                          */
#*---------------------------------------------------------------------*/
install: zipi-dirs
	$(MAKE) -C pyc install
	$(MAKE) -C zpc install
	$(MAKE) -C rts install
	$(MAKE) install.systems

install.systems: $(ZIPISYSTEMS:%=install.system.%)
	$(INSTALL) bin/pysexp.py $(DESTDIR)$(ZIPIBINDIR) \
            && chmod $(MODEXE) $(DESTDIR)/$(ZIPIBINDIR)/pysexp.py

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
	rm -rf lib
	rm -f etc/Makefile.zipiconfig
	rm -rf venv

cleanall: distclean

test:
	@cd tests; $(BUILDPYTHON) run.py

unittest:
	@cd unittest; make unittest

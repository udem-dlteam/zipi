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
#*    build                                                            */
#*---------------------------------------------------------------------*/
.PHONY: build clean distclean cleanall

build:
	mkdir -p bin
	mkdir -p lib
	$(MAKE) -C pyc
	$(MAKE) -C zpc
	$(MAKE) -C stdlib
	$(MAKE) -C rts

#*---------------------------------------------------------------------*/
#*    install                                                          */
#*---------------------------------------------------------------------*/
uninstall:
	rm -r $(ZIPIROOT)

reinstall: uninstall
	$(MAKE) install-unsafe

install:
ifeq ($(shell test -e $(ZIPIROOT); echo $$?),0)
	$(error zipi already installed at $(ZIPIROOT), use make reinstall to overwrite it)
endif
	$(MAKE) install-unsafe;

install-unsafe: zipi-dirs install-bin $(ZIPISYSTEMS:%=install.%)
	$(MAKE) -C pyc install
	$(MAKE) -C zpc install
	$(MAKE) -C rts install
	$(MAKE) install.systems
	ln -sf $(ZIPIBINDIR)/zipi $(ZIPIPREFIX)/bin/zipi
	ln -sf $(ZIPIBINDIR)/zipi $(ZIPIPREFIX)/bin/zipi-$(PYTHONVERSION)

install-bin: zipi-dirs
	for file in zipi zipi.gambit zipi-compile-and-run.gambit zipi.bigloo zpc zpc.gambit pysexp_script.py; \
		do \
		cat $(BUILDBINDIR)/$$file.in \
			| sed -e "s|@RELEASE@|$(ZIPIRELEASE)|g" \
						-e "s|@DEFAULT_SCHEME_SYSTEM@|$(DEFAULT_SCHEME_SYSTEM)|g" \
						-e "s|@DATE@|$(ZIPIDATE)|g" \
						-e "s|@BRANCH@|$(ZIPIBRANCH)|g" \
						-e "s|@VERSION@|$(ZIPIVERSION)|g" \
						-e "s|@PYTHONVERSION@|$(PYTHONVERSION)|g" \
						-e "s|@SYSTEMS@|$(ZIPISYSTEMS)|g" \
						-e "s|@ZIPIBIN@|$(ZIPIBINDIR)|g" \
						-e "s|@ZIPIETC@|$(ZIPIETCDIR)|g" \
						-e "s|@ZIPIRTS@|$(ZIPIRTSDIR)|g" \
						-e "s|@BIGLOO@|$(BIGLOO)|g" \
						-e "s|@GAMBIT@|$(GAMBIT)|g" \
						-e "s|@GAMBITROOT@|$(GAMBITROOT)|g" \
						-e "s|@PYTHON@|$(PYTHON)|g" \
						-e "s|@ZIPICACHE@|$(ZIPICACHE)|g" \
						-e "s|@ZIPIROOT@|$(ZIPIROOT)|g" \
			> $(ZIPIBINDIR)/$$file; \
		chmod +x $(ZIPIBINDIR)/$$file; \
		done;
	rm -rf $(ZIPIBINDIR)/pysexp
	cp -r $(BUILDBINDIR)/pysexp $(ZIPIBINDIR)/pysexp
	rm -rf $(ZIPIDEPDIR)
	cp -r $(BUILDDEPDIR) $(ZIPIDEPDIR)

install.systems: $(ZIPISYSTEMS:%=install.system.%)

-include etc/Makefile.bigloo
-include etc/Makefile.gambit

zipi-dirs:
	mkdir -p $(ZIPIPREFIX)/bin
	mkdir -p $(ZIPIPREFIX)/lib
	if [ ! -d $(ZIPIBINDIR) ]; then \
    mkdir -p $(ZIPIBINDIR) && chmod $(MODDIR) $(ZIPIBINDIR); \
  fi
	if [ ! -d $(ZIPILIBDIR) ]; then \
    mkdir -p $(ZIPILIBDIR) && chmod $(MODDIR) $(ZIPILIBDIR); \
  fi
	if [ ! -d $(ZIPIETCDIR) ]; then \
	  mkdir -p $(ZIPIETCDIR) && chmod $(MODDIR) $(ZIPIETCDIR); \
  fi
	if [ ! -d $(ZIPIZPCDIR) ]; then \
	  mkdir -p $(ZIPIZPCDIR) && chmod $(MODDIR) $(ZIPIZPCDIR); \
  fi
	if [ ! -d $(ZIPILIBDIR)/zipi ]; then \
	  mkdir -p $(ZIPILIBDIR)/zipi && chmod $(MODDIR) $(ZIPILIBDIR)/zipi; \
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
	rm -f bin/pysexp_script.py
	rm -rf bin/pysexp

clean-dependencies:
	rm -rf dependencies

cleanall: distclean

test:
	@cd tests; $(BUILDPYTHON) run.py

unittest:
	@cd unittest; make unittest

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
	chmod u+x ./etc/pysexp_script.py

#*---------------------------------------------------------------------*/
#*    install                                                          */
#*---------------------------------------------------------------------*/
install: zipi-dirs install-bin
	$(MAKE) -C pyc install
	$(MAKE) -C zpc install
	$(MAKE) -C rts install
	$(MAKE) install.systems
	ln -sf $(ZIPIBINDIR)/zipi /usr/local/bin/zipi
	ln -sf $(ZIPIBINDIR)/zipi /usr/local/bin/zipi-$(PYTHONVERSION)

install-bin: zipi-dirs
	for file in zipi zipi.gambit zipi.gambit.sh zipi.bigloo zpc zpc.gambit; \
		do \
		cat $(BUILDBINDIR)/$$file.in \
			| sed -e "s|@RELEASE@|$(ZIPIRELEASE)|" \
						-e "s|@DEFAULT_SCHEME_SYSTEM@|$(DEFAULT_SCHEME_SYSTEM)|" \
						-e "s|@DATE@|$(ZIPIDATE)|" \
						-e "s|@BRANCH@|$(ZIPIBRANCH)|" \
						-e "s|@VERSION@|$(ZIPIVERSION)|" \
						-e "s|@SYSTEMS@|$(ZIPISYSTEMS)|" \
						-e "s|@ZIPIBIN@|$(ZIPIBINDIR)|" \
						-e "s|@ZIPIETC@|$(ZIPIETCDIR)|" \
						-e "s|@ZIPIRTS@|$(ZIPIRTSDIR)|" \
						-e "s|@BIGLOO@|$(BIGLOO)|" \
						-e "s|@GAMBIT@|$(GAMBIT)|" \
						-e "s|@ZIPICACHE@|$(ZIPICACHE)|" \
						-e "s|@ZIPIROOT@|$(ZIPIROOT)|g" \
			> $(ZIPIBINDIR)/$$file; \
		chmod +x $(ZIPIBINDIR)/$$file; \
		done

install.systems: $(ZIPISYSTEMS:%=install.system.%)
	$(INSTALL) bin/pysexp_script.py $(ZIPIBINDIR) \
            && chmod $(MODEXE) $(ZIPIBINDIR)/pysexp_script.py

-include etc/Makefile.bigloo
-include etc/Makefile.gambit

zipi-dirs:
	if [ ! -d $(ZIPIBINDIR) ]; then \
          mkdir -p $(ZIPIBINDIR) && chmod $(MODDIR) $(ZIPIBINDIR); \
        fi
	if [ ! -d $(ZIPILIBDIR) ]; then \
          mkdir -p $(ZIPILIBDIR) && chmod $(MODDIR) $(ZIPILIBDIR); \
        fi
	if [ ! -d $(ZIPIETCDIR) ]; then \
	  mkdir -p $(ZIPIETCDIR) && chmod $(MODDIR) $(ZIPIETCDIR); \
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
	rm -rf venv
	rm -f bin/pysexp_script.py

cleanall: distclean

test:
	@cd tests; $(BUILDPYTHON) run.py

unittest:
	@cd unittest; make unittest

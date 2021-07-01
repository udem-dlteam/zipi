.PHONY: do bigloo gambit install update-semPy

do: build

#*---------------------------------------------------------------------*/
#*    Standard Zipi configuration                                      */
#*---------------------------------------------------------------------*/
-include ../etc/Makefile.zipiconfig

#*---------------------------------------------------------------------*/
#*    Semantics generation                                             */
#*---------------------------------------------------------------------*/
update-semPy:
	cd semPy; $(MAKE) clean; $(MAKE) PYTHON3=$(BUILDPYTHON)

builtins.py: update-semPy
	cp semPy/out/builtins.py builtins.py

zemantics.py: update-semPy
	cp semPy/out/semantics.py zemantics.py

behaviors.py: update-semPy
	cp semPy/out/behaviors.py behaviors.py

#*---------------------------------------------------------------------*/
#*    Common entry points                                              */
#*---------------------------------------------------------------------*/
build: builtins.py zemantics.py behaviors.py $(ZIPISYSTEMS:%=do.%)
install: $(ZIPISYSTEMS:%=install.%)
	rm -rf $(ZIPISTDLIBDIR)/libs
	cp -r $(BUILDSTDLIBDIR)/libs $(ZIPISTDLIBDIR)/libs
	chmod -R a+rx,u+rx $(ZIPISTDLIBDIR)/libs

-include Makefile.bigloo
-include Makefile.gambit

clean: $(ZIPISYSTEMS:%=clean.%)
distclean: $(ZIPISYSTEMS:%=distclean.%)
	rm -f behaviors.py behaviors.scm zemantics.py zemantics.scm builtins.py

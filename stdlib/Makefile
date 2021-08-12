.PHONY: do bigloo gambit install update-semPy

do: build

#*---------------------------------------------------------------------*/
#*    Standard Zipi configuration                                      */
#*---------------------------------------------------------------------*/
-include ../etc/Makefile.zipiconfig

#*---------------------------------------------------------------------*/
#*    Semantics generation                                             */
#*---------------------------------------------------------------------*/
#* update-semPy:                                                       */
#* 	cd semPy; $(MAKE) clean; $(MAKE) PYTHON3=$(BUILDPYTHON)        */

#* builtins.py: semPy/out/builtins.py                                  */
#* 	cp semPy/out/builtins.py builtins.py                           */
#*                                                                     */
#* zemantics.py: semPy/out/semantics.py                                */
#* 	cp semPy/out/semantics.py zemantics.py                         */
#*                                                                     */
#* behaviors.py: semPy/out/behaviors.py                                */
#* 	cp semPy/out/behaviors.py behaviors.py                         */

builtins.py: semPy/semPy/code_generation/__main__.py semPy/semPy/code_generation/templates.py
	(cd semPy; $(BUILDPYTHON) -m semPy.code_generation builtins -o ../builtins.py)

zemantics.py: semPy/semPy/code_generation/__main__.py semPy/semPy/code_generation/templates.py
	(cd semPy; $(BUILDPYTHON) -m semPy.code_generation semantics -o ../zemantics.py)

behaviors.py: builtins.py zemantics.py
	(cd semPy; cp ../zemantics.py out/semantics.py; $(BUILDPYTHON) -m semPy out/semantics.py ../builtins.py -o ../behaviors.py; rm out/semantics.py)

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
	rm -f behaviors.py behaviors.scm zemantics.py zemantics.scm builtins.py
distclean: $(ZIPISYSTEMS:%=distclean.%)
	rm -f behaviors.py behaviors.scm zemantics.py zemantics.scm builtins.py

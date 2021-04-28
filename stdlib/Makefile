.PHONY: do bigloo gambit install

do: build

#*---------------------------------------------------------------------*/
#*    Standard Zipi configuration                                      */
#*---------------------------------------------------------------------*/
-include ../etc/Makefile.zipiconfig

#*---------------------------------------------------------------------*/
#*    Semantics generation                                             */
#*---------------------------------------------------------------------*/

builtins.py:
	cd  zemantics_scripts; \
	$(BUILDPYTHON) builtins_manager.py init ../builtins.py

zemantics.py:
	cd  zemantics_scripts; \
	$(BUILDPYTHON) semantics_manager.py init ../zemantics.py

behavior.py: builtins.py zemantics.py
	cd  zemantics_scripts; \
	$(BUILDPYTHON) decision_tree.py behaviors ../zemantics.py ../builtins.py > ../behaviors.py

#*---------------------------------------------------------------------*/
#*    Common entry points                                              */
#*---------------------------------------------------------------------*/
build: behavior.py $(ZIPISYSTEMS:%=do.%)
install: $(ZIPISYSTEMS:%=install.%)

-include Makefile.bigloo
-include Makefile.gambit

clean: $(ZIPISYSTEMS:%=clean.%)
distclean: $(ZIPISYSTEMS:%=distclean.%)
	rm -f behaviors.py behaviors.scm zemantics.py zemantics.scm builtins.py

.PHONY: do bigloo gambit install

do: build

#*---------------------------------------------------------------------*/
#*    Standard Zipi configuration                                      */
#*---------------------------------------------------------------------*/
-include ../etc/Makefile.zipiconfig

#*---------------------------------------------------------------------*/
#*    Semantics generation                                             */
#*---------------------------------------------------------------------*/

numbers_builtins.py:
	. ../venv/bin/activate; \
	cd  zemantics_scripts; \
	python builtins_manager.py init ../numbers_builtins.py

zemantics.py:
	. ../venv/bin/activate; \
	cd  zemantics_scripts; \
	python semantics_manager.py init ../zemantics.py

behavior.py: numbers_builtins.py zemantics.py
	. ../venv/bin/activate; \
	cd  zemantics_scripts; \
	python decision_tree.py behaviors ../zemantics.py ../numbers_builtins.py > ../behaviors.py

#*---------------------------------------------------------------------*/
#*    Common entry points                                              */
#*---------------------------------------------------------------------*/
build: behavior.py $(ZIPISYSTEMS:%=do.%)
install: $(ZIPISYSTEMS:%=install.%)

-include Makefile.bigloo
-include Makefile.gambit

clean: $(ZIPISYSTEMS:%=clean.%)
distclean: $(ZIPISYSTEMS:%=distclean.%)

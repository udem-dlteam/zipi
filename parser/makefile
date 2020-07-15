# command to run python 3.8
PYTHON38=python3
#PYTHON38=/usr/local/Cellar/python@3.8/3.8.3/bin/python3.8


all: _zparse.py


check: test1


test1 test2 test3 test4 test5: _zparse.py
	@echo "------------------------------------------------------ $@"
	$(PYTHON38) zast.py $@.py > z.out
	$(PYTHON38) parse38.py $@.py > p38.out
	@if diff -U 5 z.out p38.out ; then \
	  echo "*** ASTs are the same"; \
	else \
	  echo "*** ERROR -- ASTs are different"; \
	fi


_zparse.py: Grammar.py Grammar_actions.py zpgen.py
	$(PYTHON38) -m zpgen Grammar.py > _zparse.py

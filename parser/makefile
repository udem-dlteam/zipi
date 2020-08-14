# command to run python 3.8
PYTHON38=python3
#PYTHON38=/usr/local/Cellar/python@3.8/3.8.3/bin/python3.8


all: _zparse.py


check: test1


test1 test2 test3 test4 test5 test6: _zparse.py
	@echo "------------------------------------------------------ $@"
	$(PYTHON38) zast.py $@.py > z.out
	$(PYTHON38) parse38.py $@.py > p38.out
	@if diff -U 5 z.out p38.out ; then \
	  echo "*** ASTs are the same"; \
	else \
	  echo "*** ERROR -- ASTs are different"; \
	fi


fuzz: _zparse.py
	@n=0; \
	while :; do \
	  : || echo "*******************************************************"; \
	  n=$$(expr $$n + 1); if test "$$(expr $$n % 100)" == "0"; then echo "*** $$n"; fi; \
	  $(PYTHON38) -m zpgen -fuzzer Grammar.py > sample.py; \
	  : || cat sample.py; \
	  if $(PYTHON38) parse38.py sample.py > p38.out 2>&1; then \
	    : || echo "*** NO SYNTAX ERRORS REPORTED BY CPYTHON ***"; \
	    if $(PYTHON38) zast.py sample.py > z.out; then \
	      : || echo "*** NO SYNTAX ERRORS REPORTED BY ZAST ***"; \
	      if diff -U 5 z.out p38.out > z.diff ; then \
	        : || echo "*** ASTs are the same"; \
	      else \
	        : || echo "*** ERROR -- zast produced an incorrect AST s on the program:"; \
	        : || echo "------------------------------------------------------"; \
	        : || cat sample.py; \
	        : || echo "------------------------------------------------------"; \
	        : || cat z.diff; \
	        : || exit; \
	      fi; \
	    else \
	      echo "*** ERROR -- zast crashed on the program:"; \
	      echo "------------------------------------------------------"; \
	      cat sample.py; \
	      echo "------------------------------------------------------"; \
	      exit; \
	    fi; \
	  else \
	    : || echo "*** SYNTAX ERRORS FOR:"; \
	    : || echo "------------------------------------------------------"; \
	    : || cat sample.py; \
	    : || echo "------------------------------------------------------"; \
	    : || cat p38.out; \
	    : || exit; \
	  fi; \
	done

_zparse.py: Grammar.py Grammar_actions.py zpgen.py
	$(PYTHON38) -m zpgen Grammar.py > _zparse.py

all: micro

gen-micro:
	scripts/gen_micro_bench.py

micro:
	#rm -rf "/Users/feeley/.zipicache/cache@zipi_0_0_1/Users/feeley/python/zipi/bench"
	@for bench in micro_*.py; do \
	  zipi_time=`../zpc/run-zipi --compile $$bench | sed -e "s/ .*//g"`; \
	  cpython_output=`python3 $$bench`; \
	  cpython_time=`echo "$$cpython_output" | sed -e "s/ .*//g"`; \
	  code=`echo "$$cpython_output" | sed -e "s/^.*: //"`; \
	  python3 -c "a=$$cpython_time;b=$$zipi_time;code='$$code';speedup=a/b;print(f'{speedup:.2f}x on {code:s}')"; \
	done

realclean:
	rm micro_*.py

clean:

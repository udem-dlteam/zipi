generate-test:
	cd _gen_test && python generate.ppy

tests: generate-test
	python run.py --zipi "python ../pyinterp-run.py "

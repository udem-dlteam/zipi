test/zast_browser.js: ../../parser/zast.py
	python3 zp.py -f ../../parser/zast.py -o test/zast_browser.js

test/zast_node.js: ../../parser/zast.py
	python3 zp.py -f ../../parser/zast.py -n -o test/zast_node.js

parse_test: test/zast_node.js
	node < ./test/parse_test.js

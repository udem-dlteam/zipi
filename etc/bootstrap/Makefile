test/zast_browser.js: ../../parser/zast.py
	python3 zp.py -f ../../parser/zast.py -o test/zast_browser.js

test/zast_node.js: ../../parser/zast.py
	python3 zp.py -f ../../parser/zast.py -n -o test/zast_node.js

test/zast_node_es6.js:
	python3 zp.py -f ../../parser/zast.py -n -es6 -o test/zast_node_es6.js

test/zast_browser_es6.js:
	python3 zp.py -f ../../parser/zast.py -b -es6 -o test/zast_browser_es6.js

test_builds: test/zast_browser.js test/zast_node.js test/zast_browser_es6.js test/zast_node_es6.js

test_node: ./test/zast_node.js ./test/zast_node_es6.js
	node < ./test/parse_test.js &&
	node < ./test/parse_test_es6.js

clean:
	rm ./test/zast_browser.js ./test/zast_node.js ./test/zast_browser_es6.js ./test/zast_node_es6.js

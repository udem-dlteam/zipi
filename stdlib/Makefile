builtins:
	/home/olivier/udem-dlteam/zipi/etc/py19 -t gambit --no-main -d /home/olivier/udem-dlteam/zipi/ /home/olivier/udem-dlteam/zipi/stdlib/builtins.py > /home/olivier/udem-dlteam/zipi/stdlib/builtins.scm
	# Temporary way for the builtins' scope to use pre-bootstrap py-make-simple-global
	sed -i -- 's/py-make-global/py-make-base-global/g' /home/olivier/udem-dlteam/zipi/stdlib/builtins.scm

DOCKERCOMPOSE 	?= $(shell which docker-compose)
GIT							?= $(shell which git)
XDGOPEN					?= $(shell which xdg-open)
PYTHON 					?= $(shell which python)
NAVIGATOR 			?= $(if $(PYTHON),$(PYTHON) -m webbrowser,$(XDGOPEN))
USERID					?= $(shell id -u):$(shell id -g)
REMOVE					?= $(shell which rm)
MAKEDIR					?= $(shell mkdir)

setup:
	$(MAKEDIR) moodle/moodledata
	$(REMOVE) -f moodle/public/config.php
	$(GIT) submodule update --init --recursive
	CURRENT_UID=$(USERID) $(DOCKERCOMPOSE) build
run:
	$(NAVIGATOR) http://127.0.0.1:80
	CURRENT_UID=$(USERID) $(DOCKERCOMPOSE) up
down:
	$(DOCKERCOMPOSE) down
cache:
	$(DOCKERCOMPOSE) exec varnish varnishtop
reload:
	$(DOCKERCOMPOSE) restart varnish
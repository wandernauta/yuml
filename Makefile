PYTHON?=/usr/bin/env python

all:
	cat test.yuml | $(PYTHON) ./yuml -v -o /tmp/test1.png
	$(PYTHON) ./yuml --scale 200 -t class -s nofunky -v -i test.yuml -o /tmp/test2.png

.PHONY: all

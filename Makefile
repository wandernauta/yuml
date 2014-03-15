PYTHON?=/usr/bin/env python

all:
	$(PYTHON) ./yuml --scale 200 -t class -s nofunky -v -i test.yuml -o /tmp/yumltest.png

.PHONY: all

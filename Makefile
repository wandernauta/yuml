PYTHON?=/usr/bin/env python

all:
	$(PYTHON) ./yuml -v -i test.yuml -o /tmp/yumltest.png

.PHONY: all

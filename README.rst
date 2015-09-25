====
yuml
====

.. image:: https://travis-ci.org/wandernauta/yuml.png?branch=master

This is an unofficial command line client for the `yUML <http://yuml.me>`_ web
app. Use it to draw class diagrams, activity diagrams and usecase diagrams
from the command line, integrate yUML into your documentation workflow or what
have you.

``yuml`` (the tool) supports all the styles and formats that yUML (the service)
does, so you can take your pick between *scruffy* (the default), *nofunky* and
*plain* for the styles and *png*, *pdf*, *svg* or *jpg* for the format.

Have fun.

Options
-------

Only the -o option is required.

-i       Read yuml from ``FILE`` instead of stdin  
-o       Store output in ``FILE``  
-f       Use specified format (one of ``png``, ``pdf``, ``svg``, or ``jpg``)  
-t       Use this diagram type (one of ``class``, ``activity``, or ``usecase``)  
-s       Use this diagram style (one of ``scruffy``, ``nofunky``, ``plain``)
--dir    Lay out elements in this direction (one of ``LR``, ``RL``, ``TD``)
--scale  Scale output to percentage  
-v       Print some debug info

Example
-------

    echo "[This]-[That]" | ./yuml -s nofunky -o diagram.png

Installation
------------

To install ``yuml``, try:

    sudo pip install https://github.com/wandernauta/yuml/zipball/master
    
...or the equivalent for your system.

License
-------

``yuml`` is distributed under the terms of the ISC license. See the COPYING.rst 
file for more details.

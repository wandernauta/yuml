#!/usr/bin/python
# -*- coding: utf-8 -*-

"""
This is an unofficial command line client for the yUML <http://yuml.me> web
app. Use it to draw class diagrams, activity diagrams and usecase diagrams
from the command line, integrate yUML into your documentation workflow or what
have you.

Copyright (c) 2012, 2013, 2014 Wander Nauta.
yuml is distributed under the terms of the ISC license.

***

Permission to use, copy, modify, and/or distribute this software for any
purpose with or without fee is hereby granted, provided that the above
copyright notice and this permission notice appear in all copies.

The software is provided "as is" and the author disclaims all warranties with
regard to this software including all implied warranties of merchantability and
fitness. In no event shall the author be liable for any special, direct,
indirect, or consequential damages or any damages whatsoever resulting from
loss of use, data or profits, whether in an action of contract, negligence or
other tortious action, arising out of or in connection with the use or
performance of this software.
"""

from optparse import OptionParser

import codecs
import os
import sys
import time

# <monkey>
# We try to be compatible with both Python 2 and 3 here.
if sys.version_info >= (3, 0):
    # noinspection PyUnresolvedReferences, PyCompatibility
    from urllib.request import urlopen, Request, HTTPError
    # noinspection PyUnresolvedReferences, PyCompatibility
    from urllib.parse import urlencode
else:
    # noinspection PyUnresolvedReferences, PyCompatibility
    from urllib import urlencode
    # noinspection PyUnresolvedReferences, PyCompatibility
    from urllib2 import urlopen, Request, HTTPError
# </monkey>


class YumlRequest(object):
    """Represents a single request to the yUML web service."""
    opts = None
    body = ""
    out = None

    API_BASE = "http://yuml.me/diagram"

    def log(self, msg):
        """
        Optionally log an informative message.

        @param msg: The message to log.
        """
        if self.opts.v:
            print("[yuml] %s" % msg)

    def loadbody(self):
        """Load the yUML text from stdin or a file."""
        infile = self.opts.infile
        self.log('Reading from %s' % ('stdin' if infile == '-' else infile))

        if infile == '-':
            self.body = sys.stdin.readlines()
        elif os.path.exists(infile):
            lines = codecs.open(infile, 'r', 'utf-8').readlines()
            self.body = [x.strip() for x in lines if x.strip()]
        else:
            raise IOError("File %s not found" % infile)

        self.log('Done reading.')

    def prepout(self):
        """Open the output file."""
        if self.opts.outfile:
            self.out = open(self.opts.outfile, 'wb')
        else:
            print("Usage: yuml [-i FILE] -o FILE")
            sys.exit(1)

    def run(self):
        """Execute the request."""
        start = time.time()

        if not self.out:
            self.prepout()

        if not self.body:
            self.loadbody()

        opts = self.opts.style

        if self.opts.scale:
            opts += ";scale:" + str(self.opts.scale)

        if self.opts.dir:
            opts += ";dir:" + str(self.opts.dir)

        url = "%s/%s/%s/" % (self.API_BASE, opts, self.opts.type)

        dsl_text = (', '.join(self.body) + '.' + self.opts.fmt)
        data = {'dsl_text':  dsl_text.encode('utf-8')}

        values = urlencode(data).encode('utf-8')

        headers = {
            'User-Agent': 'wandernauta/yuml v0.1',
            'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'
        }

        self.log('Data: %s' % values)
        self.log('Requesting %s' % url)

        try:
            req = Request(url, values, headers)
            img_name = urlopen(req).read().decode('utf-8')

            self.log('Got image name %s' % img_name)

            img_arr = img_name.partition('.')
            img_url = url + img_arr[0] + '.' + self.opts.fmt

            self.log('Requesting %s' % img_url)

            req = Request(img_url, None, headers)
            response = urlopen(req).read()
        except HTTPError as exception:
            if exception.code == 500:
                self.log("Service returned 500: probably malformed input.")
                sys.exit(1)
            else:
                raise

        self.out.write(response)
        self.log('Done after %f seconds' % (time.time() - start))


def main():
    """Entry point for the command-line tool."""

    parser = OptionParser(usage="%prog [-i FILE] -o FILE", version="%prog 0.1")

    parser.add_option("-i", "--in", dest="infile", metavar="FILE", default="-",
                      help="read yuml from FILE instead of stdin")
    parser.add_option("-o", "--out", dest="outfile", metavar="FILE",
                      help="store output in FILE")

    parser.add_option("-f", "--format", dest="fmt", metavar="FMT",
                      choices=['png', 'pdf', 'jpg', 'svg'],
                      help="use format FMT")
    parser.add_option("-t", "--type", dest="type", metavar="TYPE",
                      choices=['class', 'activity', 'usecase'],
                      help="draw a TYPE diagram")
    parser.add_option("-s", "--style", dest="style", metavar="STY",
                      choices=['scruffy', 'nofunky', 'plain'],
                      help="use style STY")

    parser.add_option("--scale", dest="scale", metavar="PERCENT", type="int",
                      help="scale output to percentage")
    parser.add_option("--dir", dest="dir", choices=['LR', 'RL', 'TD'],
                      help="direction of the diagram LR RL TD")

    parser.add_option("-v", "--verbose", dest="v", action="store_true",
                      help="print some debug info")

    parser.set_defaults(v=False, fmt="png", type="class", style="scruffy")

    (options, _) = parser.parse_args()

    request = YumlRequest()
    request.opts = options
    request.run()

if __name__ == "__main__":
    main()

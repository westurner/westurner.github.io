#!/usr/bin/env python
# -*- coding: utf-8 -*-
from __future__ import print_function
"""
striptableofcontents
"""

import codecs

class LinesRemovedError(ValueError):
    pass


def striptableofcontents(input, output,
                         startmarker=".. <extratoc>\n",
                         endmarker=".. </extratoc>\n"):
    """strip an extra table of contents and ``.. contents::`` directive
    between ``.. <extratoc>`` and ``.. </extratoc>`` markers
    and write

    Arguments:
        filename (str): file path

    Keyword Arguments:
        startmarker (str): marker to remove lines starting at (inclusive)
        endmarker (str): marker to remove lines ending at (inclusive)

    Returns:
        str: ...

    Raises:
        OSError: if a filesystem access error occurs
        ValueError: if the markers are not found
        LinesRemovedError: if n_to_remove != n_removed
    """
    with codecs.open(input, 'r') as f:
        lines = f.readlines()
    start = lines.index(startmarker)
    end = lines.index(endmarker)
    with codecs.open(output, 'w') as f:
        _linesbefore = lines[:start]
        f.writelines(_linesbefore)
        _linesafter = lines[end+1:]
        f.writelines(_linesafter)
    n_to_remove = (end - start) + 1
    n_removed = len(lines) - (len(_linesbefore) + len(_linesafter))
    if n_removed != n_to_remove:
        raise LinesRemovedError("n_removed != n_to_remove (%r != %r)" %
                        (n_removed, n_to_remove))


import unittest


class Test_striptableofcontents(unittest.TestCase):

    def setUp(self):
        import os.path
        self.conf = dict(
            input=os.path.join('..', 'pages', 'resume.rst'),
            output='resume_stripped.rst')

    def test_striptableofcontents(self):
        import subprocess
        input, output = self.conf['input'], self.conf['output']
        striptableofcontents(input, output)
        cmd = ('diff', '-Naur', input, output)
        retcode = subprocess.call(cmd)
        assert retcode == 1

    def tearDown(self):
        import os
        os.remove(self.conf['output'])


def main(argv=None):
    """
    Main function

    Keyword Arguments:
        argv (list): commandline arguments (e.g. sys.argv[1:])
    Returns:
        int:
    """
    import logging
    import optparse

    prs = optparse.OptionParser(usage="%prog -i <input.rst> -o <output.rst>")

    prs.add_option('-i', '--input',
                   dest='input',
                   action='store',
                   help='input .rst filename')
    prs.add_option('-o', '--output',
                   dest='output',
                   action='store',
                   help='output .rst filename')

    prs.add_option('-v', '--verbose',
                   dest='verbose',
                   action='store_true',)
    prs.add_option('-q', '--quiet',
                   dest='quiet',
                   action='store_true',)
    prs.add_option('-t', '--test',
                   dest='run_tests',
                   action='store_true',)

    argv = list(argv) if argv else []
    (opts, args) = prs.parse_args(args=argv)
    loglevel = logging.INFO
    if opts.verbose:
        loglevel = logging.DEBUG
    elif opts.quiet:
        loglevel = logging.ERROR
    logging.basicConfig(level=loglevel)
    log = logging.getLogger()
    log.debug('argv: %r', argv)
    log.debug('opts: %r', opts)
    log.debug('args: %r', args)

    if opts.run_tests:
        import sys
        sys.argv = [sys.argv[0]] + args
        import unittest
        return unittest.main()

    if not opts.input:
        prs.error("You must specify -i/--input")
    if not opts.output:
        prs.error("You must specify -o/--output")

    EX_OK = 0
    output = striptableofcontents(opts.input, opts.output)
    output
    return EX_OK


if __name__ == "__main__":
    import sys
    sys.exit(main(argv=sys.argv[1:]))

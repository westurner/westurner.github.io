#!/usr/bin/env python
# encoding: utf-8
from __future__ import print_function
"""
google_plus_profile_links
"""


import urllib
import urllib2
import bs4
import os.path
import logging
log = logging.getLogger()

def _repr(_str):
    if isinstance(_str, basestring):
        return '"%s"' % repr(_str)[1:-1]
    else:
        raise TypeError(_str)


def icon_url_to_local_path(img, icon_path):
    sitename = urllib.splitquery(img['src'])[-1].split('&')[0][7:]
    filename = '%s.png' % sitename
    filepath = os.path.join(icon_path, filename)
    imgurl = 'https:%s' % img['src']
    return sitename, filename, filepath, imgurl


def get_accounts_from_google_plus(google_plus_url, icon_path=''):
    r = urllib2.urlopen(google_plus_url)
    html = r.read()
    bs = bs4.BeautifulSoup(html)
    #about = bs.find('div',{'class':'Ee g5a vna Yjb'})
    about = bs.find('div', {'class': 'wna fa-TCa Ala'})
    accounts = about.findAll('li')
    for a in accounts:
        img = a.findNext('img')
        link = a.findNext('a')
        log.debug( (img['src'], link['href'], link['title']) )
        yield img, link, icon_url_to_local_path(img, icon_path)


def download_service_icons(iterable, icon_path=''):
    for img, link, (sitename, filename, filepath, imgurl) in iterable:
        resp = urllib2.urlopen(imgurl)
        log.debug('downloading: %r' % imgurl)
        with open(filepath, 'w+') as f:
            f.write(resp.read())
        log.debug('downloaded to: %r' % filepath)


def google_plus_profile_links(iterable, icon_path=''):
    """
    mainfunc
    """
    yield '<div class="widget">'
    yield '<ul id="accounts">'
    for img, link, (sitename, filename, filepath, imgurl) in iterable:
        yield '<li>'
        yield '<a href=%s title=%s rel="me" target="_blank">' % (
            _repr(link['href']),
            _repr(link['title']))
        yield '<img src=%s alt=%s></img>' % (
            _repr('/' + filepath),
            _repr(sitename))
        yield '</a>'
        yield '</li>'
    yield '</ul>'
    yield '</div>'


import unittest
class Test_google_plus_profile_links(unittest.TestCase):
    def test_google_plus_profile_links(self):
        pass


def main():
    import optparse
    import logging

    prs = optparse.OptionParser(usage="./%prog : args")

    prs.add_option('-d', '--download-icons',
                    dest='download_icons',
                    action='store_true')

    prs.add_option('-v', '--verbose',
                    dest='verbose',
                    action='store_true',)
    prs.add_option('-q', '--quiet',
                    dest='quiet',
                    action='store_true',)
    prs.add_option('-t', '--test',
                    dest='run_tests',
                    action='store_true',)

    (opts, args) = prs.parse_args()

    if not opts.quiet:
        logging.basicConfig()

        if opts.verbose:
            logging.getLogger().setLevel(logging.DEBUG)

    if opts.run_tests:
        import sys
        sys.argv = [sys.argv[0]] + args
        import unittest
        exit(unittest.main())

    ICON_PATH = '_static/service_icons/'
    account_url = 'https://plus.google.com/+WesTurner1/about'

    accounts = get_accounts_from_google_plus(account_url, icon_path=ICON_PATH)
    accounts = list(accounts)

    if opts.download_icons:
        download_service_icons(accounts, icon_path=ICON_PATH)

    for l in google_plus_profile_links(accounts, icon_path=ICON_PATH):
        print(l)


if __name__ == "__main__":
    main()


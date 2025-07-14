#!/usr/bin/env python
# encoding: utf-8
from __future__ import print_function
"""
google_plus_profile_links
"""


import urllib
import urllib.parse
import urllib.request
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
    sitename = urllib.parse.urlsplit(img['src'])[-1].split('&')[0][7:]
    filename = '%s.png' % sitename
    filepath = os.path.join(icon_path, filename)
    imgurl = 'https:%s' % img['src']
    return sitename, filename, filepath, imgurl


def get_accounts_from_google_plus(google_plus_url, icon_path=''):
    r = urllib.request.urlopen(google_plus_url)
    html = r.read()
    bs = bs4.BeautifulSoup(html, features='lxml')
    #about = bs.find('div',{'class':'Ee g5a vna Yjb'})
    about = bs.find('div', {'class': 'wna fa-TCa Ala'})
    if not about:
        raise ValueError("about not found")
    accounts = about.findAll('li')
    for a in accounts:
        img = a.findNext('img')
        link = a.findNext('a')
        log.debug( (img['src'], link['href'], link['title']) )
        yield img, link, icon_url_to_local_path(img, icon_path)


def download_service_icons(iterable, icon_path=''):
    for img, link, (sitename, filename, filepath, imgurl) in iterable:
        resp = urllib.request.urlopen(imgurl)
        log.debug('downloading: %r' % imgurl)
        with open(filepath, 'w+') as f:
            f.write(resp.read())
        log.debug('downloaded to: %r' % filepath)


def build_data_uri(path, mimetype):
    encoded = urllib.quote(open(path, "rb").read().encode("base64"))
    return "data:{};base64,{}".format(mimetype, encoded)


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
        yield '<img src=%s alt=%s width="16" height="16"></img>' % (
            _repr(build_data_uri(filepath, "image/png")),
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
    
    prs.add_option("--data-uri", dest='do_data_uri', nargs=2, help="path_to.ico image/png")

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

    if opts.do_data_uri:
        import urllib.parse
        import base64
        def build_data_uri(path, mimetype):
            with open(path, "rb") as image_file:
                image_bytes = image_file.read()
                encoded = urllib.parse.quote(base64.b64encode(image_bytes).decode("ascii"))
            return "data:{};base64,{}".format(mimetype, encoded)
        print(build_data_uri(opts.do_data_uri[0], opts.do_data_uri[1]))
    else:
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


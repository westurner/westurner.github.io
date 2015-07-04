Documentation
=============


This weekend, I managed to get a fixed navigation bar configured
with the `Bootstrap affix JS <http://getbootstrap.com/javascript/#affix>`__
and a fair amount of CSS iteration
for Sphinx (with the excellent `sphinxjp.themes.basicstrap`_)
and have been merging the new styles into various
sets of docs that I've been working on:

* Concepts: https://wrdrd.com/docs/

  * Open Source:
    https://wrdrd.com/docs/consulting/open-source
  * Small Business Consulting:
    https://wrdrd.com/docs/consulting/small-business
  * Web Development:
    https://wrdrd.com/docs/consulting/web-development
  * Software Development:
    https://wrdrd.com/docs/consulting/software-development
  * Computer Engineering:
    https://wrdrd.com/docs/consulting/computer-engineering
  * Information Systems:
    https://wrdrd.com/docs/consulting/information-systems
  * Data Science:
    https://wrdrd.com/docs/consulting/data-science
  * Knowledge Engineering:
    https://wrdrd.com/docs/consulting/knowledge-engineering
  * Entrepreneurship:
    https://wrdrd.com/docs/consulting/entrepreneurship
  * Education Technology:
    https://wrdrd.com/docs/consulting/education-technology
  * Art & Design:
    https://wrdrd.com/docs/consulting/art-design
  * Team Building:
    https://wrdrd.com/docs/consulting/team-building
  * Collaboration Plan:
    https://wrdrd.com/docs/consulting/collaboration-plan
  * `Tools`:
    https://wrdrd.com/docs/tools/

* `Tools`: https://westurner.org/tools/
* Dotfiles: https://westurner.org/dotfiles/

  * Usage: https://westurner.org/dotfiles/usage

    * Bash Usage: https://westurner.org/dotfiles/usage/#bash
    * Vim Usage: https://westurner.org/dotfiles/usage/#vim
    * i3wm Usage: https://westurner.org/dotfiles/usage/#i3wm

  * Venv: https://westurner.org/dotfiles/venv
  * Usrlog: https://westurner.org/dotfiles/usrlog
  * `Tools`: https://westurner.org/dotfiles/tools/

* Infrastructure: https://westurner.org/provis/
* Open Government: https://westurner.org/opengov/
* Learning: https://westurner.org/self-directed-learning/
* Resume: https://westurner.org/resume/html/resume
* Wiki: https://westurner.org/wiki/

  * Workflow: https://westurner.org/wiki/workflow
  * Projects: https://westurner.org/wiki/projects
  * Contributions: https://westurner.org/wiki/contributions

.. _sphinxjp.themes.basicstrap: https://github.com/tell-k/sphinxjp.themes.basicstrap
.. _WRD R&D Documentation: https://wrdrd.com/docs/


Update: 2015-07-03
********************

* [X] DOC: 2015/03/02/documentation.rst: Update inlined
  `WRD R&D Documentation`_ Table of Contents
* [x] UBY: show current location in navbar toctree (#6)

  `gh:westurner/wiki#6`

  https://github.com/westurner/wiki/issues/6

  * [o] [UBY] show the currently ``#manually-selected`` link in the navbar
    when the fixed navbar is scrolled beyond the viewport
    (i.e. when showing the complete table of contents in the
    *full width sidebar navbar*).

    * [x] Assert ``#anchor`` exists as a `DOM`_ element
      with an ``id="anchor"`` property.
    * [o] Find and style each link to ``#anchor`` (``href="#anchor"``):

      * [X] *mobile header navbar*:

        + [X] UBY: **Bold** and add an **arrow** ⬅
          next to the heading,
          in place of the ¶ sphinx heading selector link.

      * [X] *full width sidebar navbar*:

        + [X] UBY: **Bold** and add an **arrow** ⬅
          next to the heading,
          in place of the ¶ sphinx heading selector link.

        + [X] UBY: If the *full width sidebar navbar* is on the screen;
          and there's a link in the table of contents
          to the given ``#anchor``;
          and that link is not displayed,
          **scroll** the sidebar navbar
          so that the given navbar link is displayed
          (with a few at the top, for context).

          .. code:: javascript

              ## pseudo-JS
              sidebar = $('#sidebar');
              link =  $(sidebar).find('a[href=<#anchor>]');
              if !(jquery.isonscreen.js(sidebar, link)) {
                  jquery.scrollTo(sidebar, link);
              }

.. _DOM: https://wrdrd.com/docs/consulting/web-development#term-dom


* [ ] Learn `Bootstrap`_ `ScrollSpy`_
  because it's already bundled with the bootstrap JS
  in `sphinxjp.themes.basicstrap`_.

  | Docs: http://getbootstrap.com/javascript/#scrollspy
  | Source: https://github.com/twbs/bootstrap/blob/master/js/scrollspy.js
  | JS: https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js
  | JS: https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.5/js/bootstrap.min.js
  | CDNJS: https://cdnjs.com/libraries/twitter-bootstrap

  * ScrollSpy overwrites the currently ``#manually-selected`` link on scroll.
  * ScrollSpy synchronizes all page scroll action with navbar current link
    indication.
  * [ ] ScrollSpy does not work w/ a fixed navbar
    because ``#anchors`` are hidden
    (and otherwise remain scrolled out of the vieport
    without something like isonscreen and scrollTo (ENH?,TST)

.. _Bootstrap: https://github.com/twbs/bootstrap
.. _ScrollSpy: http://getbootstrap.com/javascript/#scrollspy

* [ ] Learn `ReadTheDocs`_ in order to `WriteTheDocs`_:

  * The default ReadTheDocs theme is sphinx_rtd_theme.

    | Source: git https://github.com/snide/sphinx_rtd_theme
    | PyPI: https://pypi.python.org/pypi/sphinx_rtd_theme
    | Docs: https://read-the-docs.readthedocs.org/en/latest/theme.html

  * Sphinx themes are configured in a ``conf.py`` file.
    From http://stackoverflow.com/a/25007833 (CC-BY-SA 3.0):

    .. code:: python

        # on_rtd is whether we are on readthedocs.org
        import os
        on_rtd = os.environ.get('READTHEDOCS', None) == 'True'

        if not on_rtd:  # only import and set the theme if we're building docs locally
            import sphinx_rtd_theme
            html_theme = 'sphinx_rtd_theme'
            html_theme_path = [sphinx_rtd_theme.get_html_theme_path()]

        # otherwise, readthedocs.org uses their theme by default, so no need to specify it


  * From casual inspection,
    ReadTheDocs rtd_theme takes a different approach:

    + ReadTheDocs rtd_theme does support scrolling the left navbar
      independently from the document;
    + ReadTheDocs rtd_theme scrolls the navbar and the document;
    + The ReadTheDocs rtd_theme navbar displays
      a document-expanded
      but otherwise collapsed
      table of contents.


.. _ReadTheDocs: https://read-the-docs.readthedocs.org/en/latest/
.. _WriteTheDocs: http://www.writethedocs.org/
.. _WriteTheDocs 2015 videos: https://www.youtube.com/playlist?list=PLkQw3GZ0bq1JvhaLqfBqRFuaY108QmJDK

.. author:: default
.. categories:: none
.. tags:: DOC, documentation, UBY, usability,
   ENH, enhancement, sphinx, bootstrap, affordances
.. comments::

Hello World!
============

.. code-block:: python

   from __future__ import print_function

   def hello_world():
       return "Hello World!"

   if __name__ == "__main__":
       print(hello_world())


**Updated: 2013-12-15**

New blog! I thought best to accentuate "Hello World" with an exclamation
point. [#f1]_

This Blog
----------
This blog is created from `reStructuredText
<https://en.wikipedia.org/wiki/reStructuredText>`_
`sources hosted by GitHub <https://github.com/westurner/westurner.github.io>`_
which are processed by `Tinkerer <http://www.tinkerer.me/>`_
(`source <https://github.com/vladris/tinkerer>`_),
which extends `Sphinx <https://sphinx-doc.org/>`_
(`source <https://bitbucket.org/birkenfeld/sphinx>`_,
`wikipedia
<https://en.wikipedia.org/wiki/Sphinx_(documentation_generator)>`_).

Syntax Highlighting
++++++++++++++++++++
Code syntax highlighting --
`pygments-style-jellywrd
<https://github.com/westurner/pygments-style-jellywrd>`_ --
is adapted from
`jellybeans.vim <https://github.com/nanotech/jellybeans.vim>`_
and a
`PatchColors function
<https://github.com/westurner/dotvim/blob/d9acce/vimrc#L426>`_
in my
`dotvim <https://github.com/westurner/dotvim>`_
`Vim <http://vim.org/>`_
(`source <https://vim.googlecode.com/hg/>`_,
`wikipedia <https://en.wikipedia.org/wiki/Vim_(text_editor)>`_)
configuration
with a
`Python <http://python.org>`_
(`source <http://hg.python.org/cpython>`_,
`wikipedia <https://en.wikipedia.org/wiki/Python_(programming_language)>`_)
script called
`vim2vim
<https://github.com/westurner/vim2vim/blob/master/vim2vim/vim2vim.py>`_,
which generates the requisite
`Pygments <http://pygments.org/>`_
(`source <https://bitbucket.org/birkenfeld/pygments-main>`_)
style.



.. [#f1] TIL that "Hello World" originated from
   `The C Programming Language
   <https://en.wikipedia.org/wiki/The_C_Programming_Language_(book)>`_
   by Kernighan and Ritchie (1978) [#f2]_

.. [#f2] https://en.wikipedia.org/wiki/Hello_world_program#History

.. author:: default
.. categories:: python
.. tags:: python
.. comments::

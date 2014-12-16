Literate Configuration
========================
**Problem**: configuration files which specify keyboard shortcuts
can be difficult to grep through. It's not always easy
*to get a simple commented list of configured keyboard shortcuts*.

**Solution**: Approach configuration documentation
like `literate programming`_:
"literate configuration".

1. Markup headings with two or more ``#`` signs.
2. Markup comment lines with a ``#`` prefix and at least two spaces.


**Example**

Take an abbreviated excerpt from the `i3wm`_
`.i3/config`_ that I cleaned up this morning::

   #### i3 config file (v4)
   ### Notes
   #  #  Default location: ~/.i3/config
   #  #  List the commented command shortcuts with::
   #  #     cat ~/.i3/config | egrep '(^(\s+)?##+ |^(\s+)?#  )'
   #...
   ## Change volume
   #  <XF86AudioRaiseVolume>   -- volume up
   bindsym XF86AudioRaiseVolume exec --no-startup-id $volume_up
   #  <XF86AudioLowerVolume>   -- volume down
   bindsym XF86AudioLowerVolume exec --no-startup-id $volume_down

   ## Start, stop, and reset xflux
   #  <alt> [         -- start xflux
   bindsym $mod+bracketleft    exec --no-startup-id $xflux_start
   #  <alt> ]         -- stop xflux
   bindsym $mod+bracketright   exec --no-startup-id $xflux_stop
   #  <alt><shift> ]  -- reset gamma to 1.0
   bindsym $mod+Shift+bracketright  exec --no-startup-id $xflux_reset

   ## Resize Mode
   #  <alt> r      -- enter resize mode
   bindsym $mod+r  mode "resize"

   mode "resize" {
       ## Grow and shrink windows
       # These bindings trigger as soon as you enter the resize mode
       # ...
       # back to normal: Enter or Escape
       #  <enter>  -- exit resize mode
       bindsym Return      mode "default"
       #  <esc>    -- exit resize mode
       bindsym Escape      mode "default"
   }


Run it through extended `grep`_
with a simple conditional regular expression:

.. code-block:: bash

   cat ~/.i3/config | egrep '(^(\s+)?##+ |^(\s+)?#  )'

   
Peruse the output for that one excellent keyboard shortcut::

   #### i3 config file (v4)
   ### Notes
   #  #  Default location: ~/.i3/config
   #  #  List the commented command shortcuts with::
   #  #     cat ~/.i3/config | egrep '(^(\s+)?##+ |^(\s+)?#  )'
   ## Change volume
   #  <XF86AudioRaiseVolume>   -- volume up
   #  <XF86AudioLowerVolume>   -- volume down
   ## Start, stop, and reset xflux
   #  <alt> [         -- start xflux
   #  <alt> ]         -- stop xflux
   #  <alt><shift> ]  -- reset gamma to 1.0
   ## Resize Mode
   #  <alt> r      -- enter resize mode
       ## Grow and shrink windows
       #  <enter>  -- exit resize mode
       #  <esc>    -- exit resize mode 


Add the ``-n`` switch to `grep`_ to display the source line numbers
of the relevant configuration file documentation.

The `docco`_ homepage lists quite a few more heavyweight approaches to
generating documentation from comment strings embedded in various languages
(such as Markdown in a shell script).


I've added documentation with this pattern to my `dotfiles`_:

* `bashrc`_
  (`bashrc docs`_)
* `vimrc`_
  (`vimrc docs`_)
* `.i3/config`_
  (`.i3/config docs`_)
* and the `provis Makefile`_ (`provis Makefile docs`_)

This simple pattern saves time when looking up `my keyboard shortcuts`_.


EDIT: 2014-12-16: Updated links to https://westurner.github.io/dotfiles/

.. _literate programming: https://en.wikipedia.org/wiki/Literate_programming#Contrast_with_documentation_generation
.. _i3wm: https://en.wikipedia.org/wiki/I3_(window_manager)
.. _grep: https://en.wikipedia.org/wiki/Grep
.. _docco: https://jashkenas.github.io/docco

.. _dotfiles: https://github.com/westurner/dotfiles
.. _bashrc: https://github.com/westurner/dotfiles/tree/master/etc/bash
.. _bashrc docs: http://westurner.github.io/dotfiles/usage.html#bash   
.. _vimrc: https://github.com/westurner/dotvim/blob/master/vimrc
.. _vimrc docs: http://westurner.github.io/dotfiles/usage.html#vim
.. _`.i3/config`: https://github.com/westurner/dotfiles/blob/master/etc/.i3/config   
.. _`.i3/config docs`: http://westurner.github.io/dotfiles/usage.html#i3wm   
.. _provis makefile: https://github.com/westurner/provis/blob/8ee46bed/Makefile#L83
.. _provis makefile docs: https://provis.readthedocs.org/en/latest/usage.html#Makefile

.. _my keyboard shortcuts: http://westurner.github.io/dotfiles/usage.html#dotfiles-makefile   

.. author:: default
.. categories:: none
.. tags:: docs, literateprogramming, bash, vim, i3wm, keyboardshortcuts
.. comments::

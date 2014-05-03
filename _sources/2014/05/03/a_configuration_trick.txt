A configuration trick
=====================
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
`i3 config`_ that I cleaned up this morning::

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

A similar pattern has worked well in my `vimrc`_ for a few years.

I've also added this to the `Provis Makefile`_,
which I currently just include into the 
`Provis Documentation`_.

This simple pattern saves time when looking up custom keyboard shortcuts.


.. _literate programming: https://en.wikipedia.org/wiki/Literate_programming#Contrast_with_documentation_generation
.. _i3wm: https://en.wikipedia.org/wiki/I3_(window_manager)
.. _grep: https://en.wikipedia.org/wiki/Grep
.. _i3 config: https://github.com/westurner/dotfiles/blob/043037f9ac81a5d6f10d1ac3ce628910e57da774/etc/.i3/config 
.. _docco: https://jashkenas.github.io/docco/
.. _vimrc: https://github.com/westurner/dotvim/commit/e78c59ba048087422806c1c1e668be667f949260#diff-076d61938d25fd036d6436c94d8778faR123 
.. _provis makefile: https://github.com/westurner/provis/blob/8ee46bed3110b581a42a77199e2c6708f5165683/Makefile#L83
.. _provis documentation: https://provis.readthedocs.org/en/latest/

.. author:: default
.. categories:: none
.. tags:: bash, documentation, literateprogramming
.. comments::

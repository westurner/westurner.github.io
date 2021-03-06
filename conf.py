# -*- coding: utf-8 -*-

import tinkerer
import tinkerer.paths

# **************************************************************
# TODO: Edit the lines below
# **************************************************************

# Change this to the name of your blog
project = 'Wes Turner'

# Change this to the tagline of your blog
tagline = '@westurner'

# Change this to the description of your blog
description = 'A code blog'

# Change this to your name
author = 'Wes Turner'

# Change this to your copyright string
copyright = '2020 %s' % author

# Change this to your blog root URL (required for RSS feed)
website = 'https://westurner.github.io/'

# **************************************************************
# More tweaks you can do
# **************************************************************

# Add your Disqus shortname to enable comments powered by Disqus
disqus_shortname = None

# Change your favicon (new favicon goes in _static directory)
html_favicon = ''

# Pick another Tinkerer theme or use your own
html_theme = "flat5000"

# Theme-specific options, see docs
html_theme_options = { }

# Link to RSS service like FeedBurner if any, otherwise feed is
# linked directly
rss_service = None

# Generate full posts for RSS feed even when using "read more"
rss_generate_full_posts = True

# Number of blog posts per page
posts_per_page = 10

# Character use to replace non-alphanumeric characters in slug
slug_word_separator = '-'

# **************************************************************
# Edit lines below to further customize Sphinx build
# **************************************************************

# Add other Sphinx extensions here
extensions = [
    'tinkerer.ext.blog',
    'tinkerer.ext.disqus',
    'withgithub',
    'myst_nb',
]

# Add other template paths here
templates_path = ['_templates']

# Add other static paths here
html_static_path = ['_static', tinkerer.paths.static]

# Add other theme paths here
html_theme_path = ['_themes', tinkerer.paths.themes]

# Add file patterns to exclude from build
exclude_patterns = ["drafts/*", "_templates/*"]

# Add templates to be rendered in sidebar here
html_sidebars = {
    "**": [
        "recent.html",
        "searchbox.html",
        "tags.html",
        "accounts.html",
    ]
}

# **************************************************************
# Do not modify below lines as the values are required by
# Tinkerer to play nice with Sphinx
# **************************************************************

source_suffix = tinkerer.source_suffix
master_doc = tinkerer.master_doc
version = tinkerer.__version__
release = tinkerer.__version__
html_title = project
html_use_index = False
html_show_sourcelink = True
html_add_permalinks = True

# Suffix for generated links to HTML files.
# The default is whatever html_file_suffix is set to;
# it can be set differently (e.g. to support different web server setups).
html_link_suffix = ''

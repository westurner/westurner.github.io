
## westurner.org Makefile
# https://westurner.org/

.PHONY: default \
	all \
	build \
	accounts \
	serve open view \
	push \
	push-source \
	resume \
	resume-web \
	resume-print \
	resume-commit \
	install \
	autocompile.py \
	auto-html \
	fix-links \
	setup_texlive_ubuntu \
	setup_texlive_osx \
	setup_texlive_yum \
	setup_texlive_dnf \
	upgrade_lifestream_js

ifeq ($(__IS_MAC),true)
BROWSER="open"
SEDOPTS=-i '' -e
else
BROWSER="web"
SEDOPTS=-i
endif

default: build

all:
	$(MAKE) fix-links
	#$(MAKE) resume
	$(MAKE) build
	$(MAKE) push
	$(MAKE) push-source
	##
	## NOTE:
	## To update resume renderings, run:
	## $ make resume all (resume-web, resume-print, resume-commit)

build:
	# Generate static HTML in ./blog/html
	tinker --build

docs: build
	# alias of 'build'

STATIC:="./_static"
LOCALJS="$(STATIC)/js/local.js"

localjs:
	# Concatenate javascript files into $(LOCALJS)
	echo '' > $(LOCALJS)
	cat $(STATIC)/js/ga.js >> $(LOCALJS)
	cat $(STATIC)/js/newtab.js >> $(LOCALJS)

accounts:
	# Regenerate ./_templates/accounts.html
	python ./get_accounts.py -d > ./_templates/accounts.html
	git add _static/service_icons/*
	git add _templates/accounts.html
	git status
	# Note, to commit these changes, run:
	#  git commit -m ./_static/service_icons ./_templates/accounts.html

serve:
	# Serve ./blog/html with python 2 SimpleHTTPServer
	(cd ./blog/html; \
	python -m SimpleHTTPServer 18282)

serve-pgs:
	# Serve ./blog/html with pgs
	(cd ./blog/html; pgs -p . -P 18282)

GIT_WWW_BRANCH="master"  # gh-pages
serve-gh-pages:
	# Serve the ${GIT_WWW_BRANCH} of this repository
	pgs -g . -r ${GIT_WWW_BRANCH} -P 18283

open:
	# Open a browser to locally served website
	$(BROWSER) http://localhost:18282/ &
	$(BROWSER) http://localhost:18283/ &

view:
	# Serve and open a browser to the website
	$(MAKE) serve & $(MAKE) open

gh-pages:
	# Overwrite ${GIT_WWW_BRANCH} with contents from ./blog/html
	# add a .nojekyll file for gh-pages (-n)
	# add a commit message with the source hash (TODO: indicate status w/ **)
	# **and** git push to origin ${GIT_WWW_BRANCH}
	git status
	ghp-import \
		-n \
		-b ${GIT_WWW_BRANCH} \
		-m "RLS: gh-pages: :books: $(shell git rev-parse --short HEAD) '$(shell git describe --all)'" \
		-r origin \
		-p \
		./blog/html
	GIT_PAGER="less -R | cat" git log -n6 master
	@echo ''

push:
	# Git push to origin/source
	git status
	git push origin source

pull:
	# Git pull from origin/source
	git status
	git pull origin source

resume:
	# Regenerate resume for web and for print
	$(MAKE) resume-web
	$(MAKE) resume-print

resume-web:
	# Regenerate resume for web (HTML)
	$(MAKE) -C resume forweb
	$(MAKE) resume-commit

resume-print:
	# Regenerate resume for print (PDF, ...)
	$(MAKE) -C resume forprint
	$(MAKE) resume-commit

resume-commit:
	# Commit resume build outputs in ./_copy/resume
	git add ./_copy/resume && \
		git commit ./_copy/resume -m "RLS: :boat: resume"


install:
	# Install requirements
	pip install -r requirements.txt

autocompile.py:
	# Install pyinotify and get autocompile.py
	pip install pyinotify
	wget https://raw.github.com/seb-m/pyinotify/master/python2/examples/autocompile.py

auto-html: autocompile.py
	# Run "make build" when source files change (TODO: livereload)
	python ./autocompile.py . \
		'.rst,Makefile,conf.py,theme.conf,.css_t,pygments.css' \
		"make build"

GRIN_EXCLUDE='Makefile,.pyc,.pyo,.so,.o,.a,.tgz,.tar.gz,.un~,.zip,~,.bak, \
.png,.jpg,.gif,.bmp,.tif,.tiff,.pyd,.dll,.exe,.obj,.lib'
fix-links:
	# Project-global URL transforms
	grin 'westurner.org' -l -e $(GRIN_EXCLUDE) | \
		xargs -I % sed $(SEDOPTS) \
			's/westurner.github.com/westurner.org/g' %
	grin 'http://westurner.github' -l -e $(GRIN_EXCLUDE) | \
		xargs -I % sed $(SEDOPTS) \
			's,http://westurner.github,https://westurner.github,g' %
	grin 'http://en.wikipedia.org' -l -e $(GRIN_EXCLUDE) | \
		xargs -I % sed $(SEDOPTS) \
			's,http://en.wikipedia.org,https://en.wikipedia.org,g' %


setup_texlive_ubuntu:
	# Install sphinx latex/PDF build requirements w/ Ubuntu 12.04
	# NOTE: This is over 1GB of LaTeX
	latex_build_deps_ubuntu:
	sudo apt-get install -y \
		texlive-latex-base \
		texlive-latex-extra \
		texlive-latex-recommended \
		texlive-fonts-recommended
	# texlive-fonts-extra

setup_texlive_yum:
	sudo yum install -y texlive-collection-latexextra \
		texlive-collection-fontsextra

setup_texlive_dnf:
	# Install sphinx latex/PDF build requirements w/ Fedora 22
	# NOTE: This is over 800MB of LaTeX
	#sudo dnf install -y libxml2-devel libxslt-devel  # lxml build
	#pip install -r ./requirements.txt
	sudo dnf install -y texlive-collection-latexextra \
		texlive-collection-fontsextra

setup_texlive_osx:
	# Install sphinx latex/PDF build requirements w/ OSX
	# MacPorts
	# sudo port install texlive texlive-latex-extra
	#
	# Pkg
	# open https://www.tug.org/mactex/
	# wget 'https://www.tug.org/mactex/MacTeX.pkg.torrent'
	## 'http://mirror.ctan.org/systems/mac/mactex/MacTeX.pkg'
	#
	#

upgrade_lifestream_js:
	# Get, add/overwrite, and commit the latest jquery.lifestream.js
	# from upstream
	git status
	wget 'https://raw.githubusercontent.com/christianv/jquery-lifestream/master/jquery.lifestream.min.js' \
		-O ./_static/js/jquery.lifestream.min.js
	wget 'https://raw.githubusercontent.com/christianv/jquery-lifestream/master/jquery.lifestream.js' \
		-O ./_static/js/jquery.lifestream.js
	git status
	git diff
	git add ./_static/js/jquery.lifestream.*
	git commit ./_static/js/jquery.lifestream.* \
		-m "BLD: Update jquery.lifestream.js"


pygments_remove_background_color:
	sed -i 's/background-color: #040404 //' _themes/flat5000/static/pygments.css

pygments_set_highlight_background_color:
	sed -i 's/.highlight  { background: #040404/.highlight  { background: #101010/g' _themes/flat5000/static/pygments.css


## westurner.github.io Makefile
# https://westurner.github.io/

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
	upgrade_lifestream_js

ifeq ($(__IS_MAC),true)
BROWSER="open"
SEDOPTS=-i '' -e
else
BROWSER="x-www-browser"
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
	# Building HTML
	tinker --build

STATIC:="./_static"
LOCALJS="$(STATIC)/js/local.js"

localjs:
	echo '' > $(LOCALJS)
	cat $(STATIC)/js/ga.js >> $(LOCALJS)
	cat $(STATIC)/js/newtab.js >> $(LOCALJS)

accounts:
	python ./get_accounts.py -d > ./_templates/accounts.html
	git add _static/service_icons/*
	git add _templates/accounts.html
	#git commit

serve:
	eval "python -m SimpleHTTPServer 18282 &"; PID=$$! ; echo "PID=$$PID"

open:
	$(BROWSER) http://localhost:18282/ &

view:
	$(MAKE) serve & $(MAKE) open

gh-pages:
	git status
	ghp-import -n -b master \
		-m 'RLS: `tinker --build` (`make build`)' \
		-r origin \
		-p ./blog/html/

push:
	git status
	git push origin source

resume:
	$(MAKE) resume-web
	$(MAKE) resume-print

resume-web:
	cd resume && \
		make forweb
	$(MAKE) resume-commit

resume-print:
	cd resume && \
		make forprint
	$(MAKE) resume-commit

resume-commit:
	git add ./_copy/resume && \
		git commit -m "Added updated resume build outputs"


install:
	pip install -r requirements.txt

autocompile.py:
	pip install pyinotify
	wget https://raw.github.com/seb-m/pyinotify/master/python2/examples/autocompile.py

auto-html: autocompile.py
	python ./autocompile.py . \
		'.rst,Makefile,conf.py,theme.conf,.css_t,pygments.css' \
		"make build"

GRIN_EXCLUDE='Makefile,.pyc,.pyo,.so,.o,.a,.tgz,.tar.gz,.un~,.zip,~,.bak, \
.png,.jpg,.gif,.bmp,.tif,.tiff,.pyd,.dll,.exe,.obj,.lib'
fix-links:
	grin 'westurner.github.io' -l -e $(GRIN_EXCLUDE) | \
		xargs -I % sed $(SEDOPTS) \
			's/westurner.github.com/westurner.github.io/g' %
	grin 'http://westurner.github' -l -e $(GRIN_EXCLUDE) | \
		xargs -I % sed $(SEDOPTS) \
			's,http://westurner.github,https://westurner.github,g' %
	grin 'http://en.wikipedia.org' -l -e $(GRIN_EXCLUDE) | \
		xargs -I % sed $(SEDOPTS) \
			's,http://en.wikipedia.org,https://en.wikipedia.org,g' %


setup_texlive_ubuntu:
	latex_build_deps_ubuntu:
	sudo apt-get install -y \
		texlive-latex-base \
		texlive-latex-extra \
		texlive-latex-recommended \
		texlive-fonts-recommended
	# texlive-fonts-extra

setup_texlive_osx:
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

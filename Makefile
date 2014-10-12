

.PHONY: default all build \
	accounts \
	serve open view \
	push \
	push_source \
	resume \
	resume_commit \
	install \
	auto_setup \
	auto_html

default: build


all:
	$(MAKE) build
	$(MAKE) push
	$(MAKE) push-source
	##
	## NOTE:
	## To update resume renderings, run:
	## $ make resume all (resume-web, resume-print, resume-commit)

build:
	tinker --build

accounts:
	python ./get_accounts.py -d > ./_themes/flat5000/accounts.html
	git add _static/service_icons/*
	git add _themes/flat5000/accounts.html
	#git commit

serve:
	python -m SimpleHTTPServer 18282

open:
	open http://localhost:18282/

view:
	$(MAKE) serve & $(MAKE) open

push:
	git status
	ghp-import -n -b master -m 'Added output from `tinker --build` (`make build`)' -r origin -p ./blog/html/

push-source:
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
	git add ./_copy/resume
	git commit -m "Added updated resume build outputs"


install:
	pip install -r requirements.txt

auto-setup:
	pip install pyinotify
	wget https://raw.github.com/seb-m/pyinotify/master/python2/examples/autocompile.py

auto-html: html_preview
	python ./autocompile.py . '.rst,Makefile,conf.py,theme.conf' "make html"

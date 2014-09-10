


default: build


all:
	$(MAKE) resume_commit
	$(MAKE) build
	$(MAKE) push
	$(MAKE) push_source

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
	ghp-import -n -b master -m 'Added output from `tinker --build` (`make build`)' -r origin -p ./blog/html/

push_source:
	git push origin source

.PHONY: resume
resume:
	cd resume && \
		make forweb

resume_commit: resume
	git add ./_copy/resume
	git commit -m "Added updated resume build outputs"


install:
	pip install -r requirements.txt

auto_setup:
	pip install pyinotify
	wget https://raw.github.com/seb-m/pyinotify/master/python2/examples/autocompile.py

auto_html: html_preview
	python ./autocompile.py . '.rst,Makefile,conf.py,theme.conf' "make html"

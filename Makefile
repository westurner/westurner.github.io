build:
	tinker --build

serve:
	python -m SimpleHTTPServer

push:
	git push origin master

default: build

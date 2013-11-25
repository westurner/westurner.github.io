build:
	tinker --build

serve:
	python -m SimpleHTTPServer

push:
	ghp-import -n -b master -m 'Added output from `tinker --build` (`make build`)' -r origin -p ./blog/html/

default: build

build:
	tinker --build

accounts:
	python ./get_accounts.py -d > ./_themes/flat5000/accounts.html

serve:
	python -m SimpleHTTPServer

push:
	ghp-import -n -b master -m 'Added output from `tinker --build` (`make build`)' -r origin -p ./blog/html/

default: build

build:
	tinker --build

accounts:
	python ./get_accounts.py -d > ./_themes/flat5000/accounts.html
	git add _static/service_icons/*
	git add _themes/flat5000/accounts.html
	git commit

serve:
	python -m SimpleHTTPServer 18282

view:
	x-www-browser http://localhost:18282/

push:
	ghp-import -n -b master -m 'Added output from `tinker --build` (`make build`)' -r origin -p ./blog/html/

default: build

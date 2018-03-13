CWD = $(shell pwd)
SOURCEDIR=docs
BUILDDIR=build
SPHINXOPTS=
SPHINXPROJ=readthedocs-styles
STYLE=orange

.PHONY: build
build: env clean style html man latexpdf
	@echo ::: BUILD :::

.PHONY: serve
serve: env clean style html
	@cd $(SOURCEDIR)/$(BUILDDIR)/html && $(CWD)/env/bin/python3 -m http.server

.PHONY: style
style: $(SOURCEDIR)/_static
	@echo ::: STYLE :::
$(SOURCEDIR)/_static:
	@cp -r $(STYLE)/_static $(SOURCEDIR)/_static

.PHONY: clean
clean:
	-@rm -rf $(SOURCEDIR)/_static $(SOURCEDIR)/build > /dev/null || true
	@echo ::: CLEAN :::

.PHONY: help
help:
	@$(SPHINXBUILD) -M help $(SOURCEDIR) $(BUILDDIR) $(SPHINXOPTS) $(O)

env:
	@virtualenv env
	@env/bin/pip3 install -r requirements.txt
	@echo ::: ENV :::

.PHONY: freeze
freeze:
	@env/bin/pip3 freeze > requirements.txt
	@echo ::: FREEZE :::

.PHONY: Makefile
%: Makefile
	@cd $(SOURCEDIR) && $(CWD)/env/bin/sphinx-build -M $@ ./ $(BUILDDIR) $(SPHINXOPTS) $(O)
	@echo ::: $@ ::: | tr '[:lower:]' '[:upper:]'

all: install test

install:
	sage -pip install --upgrade --no-index -v .

develop:
	sage -pip install --upgrade --no-index -e .

test: 
	sage -tp --force-lib sage_sample/*.py sage_sample/*.pyx

coverage:
	sage -coverage sage_sample/*

doc:
	cd docs && sage -sh -c "make html"

doc-pdf:
	cd docs && sage -sh -c "make latexpdf"

dist:
	sage -python setup.py sdist

register: dist
	VERSION=`cat VERSION`; sage -sh -c "twine register dist/sage_sample-$$VERSION.tar.gz"

upload: dist
	VERSION=`cat VERSION`; sage -sh -c "twine upload dist/sage_sample-$$VERSION.tar.gz"

clean: clean-doc

clean-doc:
	cd docs && sage -sh -c "make clean"

.PHONY: all install develop test coverage clean clean-doc doc doc-pdf dist register upload

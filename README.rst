===================
Sage Sample Package
===================

This package is designed as as simple `SageMath <http://www.sagemath.org>`_ package 
example to serve as a good practice reference for package developers. We follow 
python recommendations and adapt them to the SageMath community. You can find more 
advanced documentation on python package creation on 
`How To Package Your Python Code <https://packaging.python.org/>`_.


Installation
------------

Local install from source
^^^^^^^^^^^^^^^^^^^^^^^^^

Download the source from the github and run this command from the repo root::

    $ sage  -pip install --upgrade --no-index -v .

Equivalently, you can use the ``Makefile`` install command::

    $ make install

Install from PyPI
^^^^^^^^^^^^^^^^^^

TODO: distribute on PyPI.

Usage
-----

Once the package is installed, you can use it on Sage with::

    sage: from sage_sample import answer_to_ultimate_question
    sage: answer_to_ultimate_question()
    42

Setup
------

All packaging setup is done through the ``setup.py``. To create your own package
follow the strcuture of the file and change the parameters accordingly.

Source code
-----------

All source code is stored in the folder ``sage_sample`` using the same name as the
package. This is not mandatory but highly recommended for clarity. All source folder 
must contain a ``__init__.py`` file with needed includes.

Tests
-----

Define your tests as doctest in your source code following SageMath good practice.
Examples of documentation and tests are given in this package.
Once the package is installed, you can use the SageMath test system configured in
``setup.py`` to run the tests::

    $ sage setup.py test

Or for short::

    $ make test

Documentation
-------------

You can use the Sage ``Sphinx`` installation to generate the documentation of the
package::

    $ cd docs
    $ sage -sh -c "make html"

Or for short::

    $ make doc

For this to work on your own package, make sure you follow the same structure as 
we do here.

 * Create a ``docs`` folder containing the exact same ``Makefile`` and a ``source``
   folder.
 * Copy and paste the ``docs/source/conf.py`` file from this package and update
   the few project specific variables at the beginning of the file.
 * Create an ``index.rst`` file as well as a ``<module name>.rst`` file for each
   module you want on the documentation. 

Travis CI integration
---------------------

Scripts that run ``make test`` on various SageMath versions on the
Travis CI system are included.
https://docs.travis-ci.com/user/for-beginners explains how to enable
automatic Travis CI builds for your GitHub-hosted project.

The scripts download and install binary releases (7.1-7.4) from a
SageMath mirror.  Edit ``.travis-install.sh`` if some optional or
experimental SageMath packages need to be installed prior to running
your package.  Edit ``.travis.yml`` to change the list of SageMath
versions used.


===================
Sage Sample Package
===================

This package is designed as a simple `SageMath <http://www.sagemath.org>`_ package
example to serve as a good practice reference for package developers. We follow
python recommendations and adapt them to the SageMath community. You can find more
advanced documentation on python package creation on
`How To Package Your Python Code <https://packaging.python.org/>`_.


Installation
------------

Local install from source
^^^^^^^^^^^^^^^^^^^^^^^^^

Download the source from the git repository::

    $ git clone https://github.com/nthiery/sage_sample.git

Change to the root directory and run::

    $ sage -pip install --upgrade --no-index -v .

For convenience this package contains a [makefile](makefile) with this
and other often used commands. Should you wish too, you can use the
shorthand:

    $ make install

Install from PyPI
^^^^^^^^^^^^^^^^^^

TODO: distribute on PyPI.

Usage
-----

Once the package is installed, you can use it in Sage with::

    sage: from sage_sample import answer_to_ultimate_question
    sage: answer_to_ultimate_question()
    42

Setup
------

All packaging setup is done through ``setup.py``. To create your own package
follow the strcuture of the file and change the parameters accordingly.

Source code
-----------

All source code is stored in the folder ``sage_sample`` using the same name as the
package. This is not mandatory but highly recommended for clarity. All source folder
must contain a ``__init__.py`` file with needed includes.

Tests
-----

This package is configured for tests written in the documentation
strings, also known as ``doctests``. For examples, see this
[source file](sage_sample/ultimate_question.py). See also
[SageMath's coding conventions and best practices document](http://doc.sagemath.org/html/en/developer/coding_basics.html#writing-testable-examples).
With additional configuration, it would be possible to include unit
tests as well.

Once the package is installed, one can use the SageMath test system
configured in ``setup.py`` to run the tests::

    $ sage setup.py test

This is just calling ``sage -t`` with appropriate flags.

Shorthand:

    $ make test

Documentation
-------------

The documentation of the package can be generated using Sage's
``Sphinx`` installation::

    $ cd docs
    $ sage -sh -c "make html"

Shorthand:

    $ make doc

For this to work on your own package, make sure you follow the same
structure as we do here:

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

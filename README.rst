===================
Sage Sample Package
===================

This package is designed as a simple `SageMath <http://www.sagemath.org>`_ package
example to serve as a good practice reference for package developers. We follow
python recommendations and adapt them to the SageMath community. You can find more
advanced documentation on python package creation on
`How To Package Your Python Code <https://packaging.python.org/>`_.

This is still a work in progress. Once this example will have
stabilized, the plan is to make a
`cookie cutter <https://cookiecutter.readthedocs.io/en/latest/>`_
template out of it.

Installation
------------

Local install from source
^^^^^^^^^^^^^^^^^^^^^^^^^

Download the source from the git repository::

    $ git clone https://github.com/sagemath/sage_sample.git

Change to the root directory and run::

    $ sage -pip install --upgrade --no-index -v .

For convenience this package contains a [makefile](makefile) with this
and other often used commands. Should you wish too, you can use the
shorthand::

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

Shorthand::

    $ make test

Documentation
-------------

The documentation of the package can be generated using Sage's
``Sphinx`` installation::

    $ cd docs
    $ sage -sh -c "make html"

Shorthand::

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

.. image:: https://travis-ci.org/sagemath/sage_sample.svg?branch=master
    :target: https://travis-ci.org/sagemath/sage_sample

Scripts that run ``make test`` on various SageMath versions on the
Travis CI system are included.
https://docs.travis-ci.com/user/for-beginners explains how to enable
automatic Travis CI builds for your GitHub-hosted project.

The scripts download and install binary releases (7.1-7.4) from a
SageMath mirror.  Edit ``.travis-install.sh`` if some optional or
experimental SageMath packages need to be installed prior to running
your package.  Edit ``.travis.yml`` to change the list of SageMath
versions used.

Automatically deploying documentation to GitHub pages using Travis CI
---------------------------------------------------------------------

* First do the steps described above to enable Travis CI integration
  of your GitHub-hosted project.
  
* If you don't already have GitHub pages for your project: Create and
  checkout a branch empty branch ``gh-pages`` in your repository.
  Then commit it and push it to GitHub. This is done in a new clone
  because we will delete it after we pushed everything to github.

    git clone --single-branch --depth 1 https://github.com/USER/PROJECT.git tmp_dir
    cd tmp_dir
    git checkout --orphan gh-pages
    git rm -rf .
    git commit -m --allow-empty "Initial commit"
    git push -u origin gh-pages
    cd ..

   
* (Back in your working copy:) Generate a new ssh key pair with an
  empty passphrase::

    ssh-keygen -t dsa -f .travis_ci_gh_pages_deploy_key

* Add the public ssh key (contents of the file
  ``.travis_ci_gh_pages_deploy_key.pub``) to your GitHub repository
  as a deploy key on http://github.com (Settings/Deploy keys/Add deploy key).
  Title: Key for deploying documentation to GitHub pages.
  Check Allow write access.

* Install the Travis CI command-line client from
  https://github.com/travis-ci/travis.rb::

    gem install travis

  One might need to add the ``--user-install`` option to gem if one doesn't have
  write acces to the system wide gem repository. If one does this be sure to also
  add the place where travis is installed to your path. This should be something
  like ``$HOME/.gem/ruby/2.0.0/bin``

  
* Log in to Travis CI using your GitHub credentials::

    travis login
  
* Encrypt the private ssh key, add the decryption keys
  as secure environment variables to Travis CI, and
  add code to ``.travis.yml`` to decrypt it::

    travis encrypt-file .travis_ci_gh_pages_deploy_key --add before_deploy

* inspect the ``.travis.yml`` file. The ``before_deploy`` section should look
  something like this::

    before_deploy:
    - travis_scripts/get-key.sh
    - openssl aes-256-cbc -K $encrypted_0fe3b59c4233_key -iv $encrypted_0fe3b59c4233_iv -in .travis_ci_gh_pages_deploy_key.enc -out .travis_ci_gh_pages_deploy_key -d

  if there are more then one openssl command, remove all but the last one.

* Add the encrypted ssh key to the ``tmp_dir`` repository in a new branch called ``deploy_key``::

    cd tmp_dir
    git checkout --orphan deploy_key
    git add .travis_ci_gh_pages_deploy_key.enc
    git commit -m "Added Travis GitHub pages deploy key"
    git push origin deploy_key

* we can now savely remove the repository in tmp_dir::

    cd ..
    rm -rf tmp_dir

* Optionally, edit ``.travis.yml`` to adjust variables ``DEPLOY_DOC_...``

* Commit all changes to GitHub.  The Travis CI build should then run
  automatically and deploy it::

    git add .travis.yml
    git commit -m "Deploy built documentation to GitHub"
    git push

* The deployed documentation will be available at:
  https://USER.github.io/PROJECT/
  This can be customized by changing ``DEPLOY_DOC_TO_DIRECTORY=/``
  to another directory in ``.travis.yml``
  For example, setting ``DEPLOY_DOC_TO_DIRECTORY=doc/html`` will make
  the deployed documentation available at:
  https://USER.github.io/PROJECT/doc/html/

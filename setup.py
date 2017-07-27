## -*- encoding: utf-8 -*-
import os
import sys
import re
import urllib2
from setuptools import setup
from codecs import open # To open the README file with proper encoding
from setuptools.command.test import test as TestCommand # for tests
from distutils.command import build as build_module

# Obtain the different Sage versions
def get_all_version_names(mirror_url, idx = None, distribution = 'Ubuntu_14.04-x86_64'):
    if idx is None:
        idx = 0
    else:
        idx = int(idx)
    site = urllib2.urlopen(mirror_url).read()
    ans = re.findall('(sage-([0-9]*(?:\.[0-9]*)*)-%s.tar.bz2)'%distribution, site)
    all_version_names = []
    for fname, ver in ans:
        if fname not in all_version_names:
            all_version_names.append(fname)
    return all_version_names[idx]

# Get information from separate files (README, VERSION)
def readfile(filename):
    with open(filename,  encoding='utf-8') as f:
        return f.read()

# Check the right Sage version
class build(build_module.build):
    def run(self):
        from sagemath.check_version import check_version
        check_version(sage_required_version)
        build_module.build.run(self)

# For the tests
class SageTest(TestCommand):
    def run_tests(self):
        errno = os.system("sage -t --force-lib sage_sample sage_sample/*.pyx")
        if errno != 0:
            sys.exit(1)

if __name__ == "__main__":

    # The next block is needed if there are cython files
    from setuptools import Extension
    from Cython.Build import cythonize
    import Cython.Compiler.Options
    from sage.env import sage_include_directories


    # Cython modules
    ext_modules = [
             Extension('sage_sample.one_cython_file',
             sources = [os.path.join('sage_sample','one_cython_file.pyx')],
             include_dirs=sage_include_directories())
    ]

    # Specify the required Sage version
    sage_required_version = '>=7.5'

    setup(
        name = "sage_sample",
        version = readfile("VERSION"), # the VERSION file is shared with the documentation
        description='An example of a basic sage package',
        long_description = readfile("README.rst"), # get the long description from the README
        url='https://github.com/sagemath/sage_sample',
        author='Matthias Koeppe, Sébastien Labbé, Viviane Pons, Nicolas M. Thiéry, ... with inspiration from many',
        author_email='viviane.pons@lri.fr', # choose a main contact email
        license='GPLv2+', # This should be consistent with the LICENCE file
        classifiers=[
          # How mature is this project? Common values are
          #   3 - Alpha
          #   4 - Beta
          #   5 - Production/Stable
          'Development Status :: 4 - Beta',
          'Intended Audience :: Science/Research',
          'Topic :: Software Development :: Build Tools',
          'Topic :: Scientific/Engineering :: Mathematics',
          'License :: OSI Approved :: GNU General Public License v2 or later (GPLv2+)',
          'Programming Language :: Python :: 2.7',
        ], # classifiers list: https://pypi.python.org/pypi?%3Aaction=list_classifiers
        keywords = "SageMath packaging",
        install_requires = ['sagemath'], # This ensures that Sage is installed
        packages = ['sage_sample'],
        ext_modules = cythonize(ext_modules), # This line is only needed if there are cython files present
        include_package_data = True,
        cmdclass = {'build': build, 'test': SageTest} # adding a special setup command for tests
    )

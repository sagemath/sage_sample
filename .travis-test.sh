#! /bin/sh
# Copying and distribution of this file, with or without modification,
# are permitted in any medium without royalty provided the copyright
# notice and this notice are preserved.  This file is offered as-is,
# without any warranty.
set -e
$HOME/SageMath/sage -pip install --upgrade --no-index -v .
$HOME/SageMath/sage setup.py test
(cd docs && $HOME/SageMath/sage -sh -c "make html")
$HOME/SageMath/sage -pip uninstall .

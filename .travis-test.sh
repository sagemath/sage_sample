#! /bin/sh
set -e

$HOME/SageMath/sage -pip install --upgrade -v -i https://pypi.python.org/pypi sagemath
$HOME/SageMath/sage -pip install --upgrade --no-index -v .
$HOME/SageMath/sage setup.py test
(cd docs && $HOME/SageMath/sage -sh -c "make html")
$HOME/SageMath/sage -pip uninstall .

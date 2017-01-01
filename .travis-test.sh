#! /bin/sh
set -e
make install SAGE="$HOME/SageMath/sage"
make test SAGE="$HOME/SageMath/sage"
make doc SAGE="$HOME/SageMath/sage"
make uninstall SAGE="$HOME/SageMath/sage"

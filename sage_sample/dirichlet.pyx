# -*- coding: utf-8 -*-
r"""
Dirichlet Diophantine approximation

EXAMPLES::

    sage: from sage_sample import dirichlet
    sage: dirichlet(pi, 10)
    7

AUTHORS:

- Sébastien Labbé, November 23, 2016, Sage Days 79, Jerusalem
"""
#*****************************************************************************
#       Copyright (C) 2016 Sebastien Labbe <slabqc@gmail.com>
#
#  Distributed under the terms of the GNU General Public License (GPL)
#  as published by the Free Software Foundation; either version 2 of
#  the License, or (at your option) any later version.
#                  http://www.gnu.org/licenses/
#*****************************************************************************
from libc.math cimport floor

include "cysignals/signals.pxi"   # ctrl-c interrupt block support
include "cysignals/memory.pxi"

def dirichlet(alpha, Q):
    r"""
    Return a diophantine approximation p/q to real number alpha following
    Dirichlet Theorem (1842).

    .. NOTES::

        This function is slow compared to using continued fractions.
        It tests all of the possible values of q.

    INPUT:

    - `alpha` -- real number
    - `Q` -- real number > 1

    OUTPUT:

    - a tuple of integers (p,q) such that `|\alpha q-p|<1/Q`.

    EXAMPLES::

        sage: from sage_sample import dirichlet
        sage: dirichlet(pi, 10)
        7
        sage: dirichlet(pi, 100)
        7
        sage: dirichlet(pi, 200)
        113
        sage: dirichlet(pi, 1000)
        113
        sage: dirichlet(pi, 35000) # long (1.38s)
        33102
    """
    if not Q > 1:
        raise ValueError("argument Q(={}) must be > 1".format(Q))
    cdef double Qinv = 1. / Q
    cdef double one_minus_Qinv = 1 - Qinv
    cdef double a
    cdef long q
    for q in range(1, Q):
        sig_check() # Check for Keyboard interupt
        a = q*alpha
        a = a - floor(a) 
        if a <= Qinv or one_minus_Qinv <= a:
            return q



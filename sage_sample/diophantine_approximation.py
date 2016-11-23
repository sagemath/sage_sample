# -*- coding: utf-8 -*-
r"""
Diophantine approximation

EXAMPLES::

    sage: from sage_sample import diophantine_approx
    sage: diophantine_approx(pi, 10)
    (22, 7)

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

# Use `import_statements` command to know how to import each sage commands::
#
#     sage: import_statements('round')
#     from sage.misc.functional import round

from sage.functions.other import frac
from sage.misc.functional import round

def diophantine_approx(alpha, Q):
    r"""
    Return a diophantine approximation p/q to real number alpha following
    Dirichlet Theorem (1842).

    .. NOTES::

        This function is very slow compared to using continued fractions.
        It tests all of the possible values of q.

    INPUT:

    - `alpha` -- real number
    - `Q` -- real number > 1

    OUTPUT:

    - a tuple of integers (p,q) such that `|\alpha q-p|<1/Q`.

    EXAMPLES::

        sage: from sage_sample import diophantine_approx
        sage: diophantine_approx(pi, 10)
        (22, 7)
        sage: diophantine_approx(pi, 100)
        (22, 7)
        sage: diophantine_approx(pi, 200)
        (355, 113)
        sage: diophantine_approx(pi, 1000)
        (355, 113)
        sage: diophantine_approx(pi, 35000) # not tested, code is very slow
    """
    for q in range(1, Q):
        if frac(alpha*q) <= 1./Q or 1-1./Q <= frac(alpha*q):
            p = round(alpha*q)
            return (p,q)



from __future__ import print_function, division
import os
import sys

# Try to import useful modules but fail silently if they aren't there.
try:
    import numpy as np
    try:
        import pandas as pd
    except ImportError:
        pass

    try:
        import matplotlib as mpl
        import matplotlib.pyplot as pp

        # Try to activate TkAgg backend, but roll back on failure.
        targets = ('Qt4Agg', 'TkAgg')
        default = mpl.get_backend()
        for t in targets:
            try:
                pp.switch_backend(t)
                f = pp.figure()
                del f
                break
            except:
                pp.switch_backend(default)
            finally:
                del t
        else:
            print('Couldn\'t set interactive backend for Matplotlib.')
        del default
    except ImportError:
        pass
except ImportError:
    pass

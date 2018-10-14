from __future__ import print_function, division
import os
import sys

try:
    from IPython.terminal import interactiveshell
    from IPython.paths import locate_profile

    sys.path.insert(1, locate_profile())
    from _solarized import SolarizedStyle, overrides

    def get_style_by_name(name, original=interactiveshell.get_style_by_name):
        return SolarizedStyle if name == 'solarized' else original(name)
    interactiveshell.get_style_by_name = get_style_by_name

    c.TerminalInteractiveShell.highlighting_style = 'solarized'
    c.TerminalInteractiveShell.highlighting_style_overrides = overrides
except ImportError:
    pass

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
                print('Using {} backend.'.format(t))
                break
            except:
                pp.switch_backend(default)
            finally:
                del t
        del default
    except ImportError:
        pass
except ImportError:
    pass

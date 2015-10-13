import rlcompleter
import readline
import os
import sys
readline.parse_and_bind("tab: complete")

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
        default = mpl.get_backend()
        target = 'TkAgg'
        try:
            pp.switch_backend(target)
            f = pp.figure()
            del f
        except:
            pp.switch_backend(default)
        finally:
            del target, default
    except ImportError:
        pass
except ImportError:
    pass

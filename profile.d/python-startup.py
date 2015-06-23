import rlcompleter
import readline
import os
import sys
readline.parse_and_bind("tab: complete")

# Try to import useful modules but fail silently if they aren't there.
try:
    import numpy as np
    import matplotlib as mpl
    import matplotlib.pyplot as plt

    default = mpl.get_backend()
    target = 'TkAgg'
    try:
        plt.switch_backend(target)
        f = plt.figure()
        del f
    except:
        plt.switch_backend(default)
except ImportError:
    pass

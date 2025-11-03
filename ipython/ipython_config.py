import sys

from IPython.paths import locate_profile

sys.path.insert(1, locate_profile())

from IPython.utils.PyColorize import theme_table

from _solarized import solarized_theme

theme_table["solarized"] = solarized_theme
c.TerminalInteractiveShell.colors = "solarized"

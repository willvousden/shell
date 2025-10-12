import sys

from IPython.terminal import interactiveshell
from IPython.paths import locate_profile

sys.path.insert(1, locate_profile())
from _solarized import SolarizedStyle, overrides


def get_style_by_name(name, original=interactiveshell.get_style_by_name):
    return SolarizedStyle if name == "solarized" else original(name)


interactiveshell.get_style_by_name = get_style_by_name

c.TerminalInteractiveShell.highlighting_style = "solarized"
c.TerminalInteractiveShell.highlighting_style_overrides = overrides

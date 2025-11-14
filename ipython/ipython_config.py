import sys

from IPython.paths import locate_profile

sys.path.insert(1, locate_profile())

from IPython.utils.PyColorize import theme_table

from _solarized import solarized_theme, TRACEBACK_HIGHLIGHT

theme_table["solarized"] = solarized_theme
c.TerminalInteractiveShell.colors = "solarized"  # noqa: F821

try:
    from IPython.core.ultratb import VerboseTB

    VerboseTB.tb_highlight = TRACEBACK_HIGHLIGHT
except Exception:
    print(
        "Error patching background color for tracebacks, they'll be the ugly default instead"
    )

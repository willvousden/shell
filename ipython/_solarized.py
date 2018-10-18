# -*- coding: utf-8 -*-

try:
    from prompt_toolkit.output.vt100 import _256_colors
except ImportError:
    from prompt_toolkit.terminal.vt100_output import _256_colors
from pygments.style import Style
from pygments.token import (Keyword, Name, Comment, String, Error, Text,
                            Number, Operator, Literal, Token)

colours = {
    'base03'  : '#002b36', # brblack
    'base02'  : '#073642', # black
    'base01'  : '#586e75', # brgreen
    'base00'  : '#657b83', # bryellow
    'base0'   : '#839496', # brblue
    'base1'   : '#93a1a1', # brcyan
    'base2'   : '#eee8d5', # white
    'base3'   : '#fdf6e3', # brwhite
    'yellow'  : '#b58900', # yellow
    'orange'  : '#cb4b16', # brred
    'red'     : '#dc322f', # red
    'magenta' : '#d33682', # magenta
    'violet'  : '#6c71c4', # brmagenta
    'blue'    : '#268bd2', # blue
    'cyan'    : '#2aa198', # cyan
    'green'   : '#859900' # green
}

# I have no idea where these numbers come from.  Something to do with this:
# https://github.com/jonathanslenders/python-prompt-toolkit/issues/355
codes = {
    'red': 1,
    'green':  2,
    'yellow':  3,
    'blue':  4,
    'magenta':  5,
    'cyan':  6,
    'base03':  8,
    'orange':  9,
    'base01':  10,
    'base00':  11, # ???
    'base0':  12,
    'purple':  13,
    'base1':  14,
    'base02':  0,
    'base3':  15,
    'base2':  7,
}

colours = {n: c for n, c in colours.items() if n in codes}
for i, (n, c) in enumerate(colours.items()):
    r, g, b = int(c[1:3], 16), int(c[3:5], 16), int(c[5:], 16)
    _256_colors[r, g, b] = codes[n]

# See http://pygments.org/docs/tokens/ for a description of the different
# pygments tokens.
class SolarizedStyle(Style):
    background_color = colours['base03']
    highlight_color = colours['base00']
    default_style = colours['base0']

    styles = {
        Text: colours['base0'],
        Error: colours['red'],
        Comment: colours['base01'],
        Keyword: colours['green'],
        Keyword.Constant: colours['green'],
        Keyword.Namespace: colours['orange'],
        Name.Builtin: colours['blue'],
        Name.Function: colours['blue'],
        Name.Class: colours['blue'],
        Name.Decorator: colours['blue'],
        Name.Exception: colours['blue'],
        Number: colours['cyan'],
        Operator: colours['green'],
        Operator.Word: colours['green'],
        Literal: colours['cyan'],
        String: colours['cyan']
    }


# See https://github.com/jonathanslenders/python-prompt-toolkit/blob/master/prompt_toolkit/styles/defaults.py
# for a description of prompt_toolkit related pseudo-tokens.
overrides = {
    Token.Prompt: colours['green'],
    Token.PromptNum: colours['base0'],
    Token.OutPrompt: colours['base01'],
    Token.OutPromptNum: colours['base0'],
}

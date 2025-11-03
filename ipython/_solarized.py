from prompt_toolkit.output.vt100 import _256_colors
from pygments.token import Token
from IPython.utils.PyColorize import Theme

solarized_colours = {
    "base03": "#002b36",
    "base02": "#073642",
    "base01": "#586e75",
    "base00": "#657b83",
    "base0": "#839496",
    "base1": "#93a1a1",
    "base2": "#eee8d5",
    "base3": "#fdf6e3",
    "yellow": "#b58900",
    "orange": "#cb4b16",
    "red": "#dc322f",
    "magenta": "#d33682",
    "violet": "#6c71c4",
    "blue": "#268bd2",
    "cyan": "#2aa198",
    "green": "#859900",
}

solarized_mapping = {
    "base03": "brblack",
    "base02": "black",
    "base01": "brgreen",
    "base00": "bryellow",
    "base0": "brblue",
    "base1": "brcyan",
    "base2": "white",
    "base3": "brwhite",
    "yellow": "yellow",
    "orange": "brred",
    "red": "red",
    "magenta": "magenta",
    "violet": "brmagenta",
    "blue": "blue",
    "cyan": "cyan",
    "green": "green",
}

ansi_numbers = {
    "black": 0,
    "red": 1,
    "green": 2,
    "yellow": 3,
    "blue": 4,
    "magenta": 5,
    "cyan": 6,
    "white": 7,
    "brblack": 8,
    "brred": 9,
    "brgreen": 10,
    "bryellow": 11,
    "brblue": 12,
    "brmagenta": 13,
    "brcyan": 14,
    "brwhite": 15,
}


# Token reference:
# * Regular tokens: http://pygments.org/docs/tokens/ for a description of the different
# * Prompt pseudo-tokens: https://github.com/jonathanslenders/python-prompt-toolkit/blob/master/prompt_toolkit/styles/defaults.py

# Here we use the hex colour code.
solarized_theme = Theme(
    "solarized",
    "default",
    {
        Token.Text: solarized_colours["base0"],
        Token.Error: solarized_colours["red"],
        Token.Comment: solarized_colours["base01"],
        Token.Keyword: solarized_colours["green"],
        Token.Keyword.Constant: solarized_colours["green"],
        Token.Keyword.Namespace: solarized_colours["orange"],
        Token.Name.Builtin: solarized_colours["blue"],
        Token.Name.Function: solarized_colours["blue"],
        Token.Name.Class: solarized_colours["blue"],
        Token.Name.Decorator: solarized_colours["blue"],
        Token.Name.Exception: solarized_colours["blue"],
        Token.Number: solarized_colours["cyan"],
        Token.Operator: solarized_colours["green"],
        Token.Operator.Word: solarized_colours["green"],
        Token.Literal: solarized_colours["cyan"],
        Token.String: solarized_colours["cyan"],
        Token.Prompt: solarized_colours["green"],
        Token.PromptNum: solarized_colours["base0"],
        Token.OutPrompt: solarized_colours["base01"],
        Token.OutPromptNum: solarized_colours["base0"],
    },
)

# Here we use override the specific hex colour codes referenced above to use the terminal colours.
for solarized_name, ansi_name in solarized_mapping.items():
    hex = solarized_colours[solarized_name]
    number = ansi_numbers[ansi_name]
    r, g, b = int(hex[1:3], 16), int(hex[3:5], 16), int(hex[5:], 16)
    _256_colors[r, g, b] = number

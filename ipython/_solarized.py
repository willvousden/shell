from IPython.utils.PyColorize import Theme
from pygments.token import Token

# Token reference:
# * Regular tokens: http://pygments.org/docs/tokens/ for a description of the different
# * Prompt pseudo-tokens: https://github.com/jonathanslenders/python-prompt-toolkit/blob/main/src/prompt_toolkit/styles/defaults.py

# Map from Solarized name to the corresponding terminal colour name understood by Pygments:
# https://github.com/pygments/pygments/blob/0328cfaf1d953b3a0c7eb0ec0efd363deb2f9d51/pygments/style.py#L13-L33

BASE03 = "ansibrightblack"
BASE02 = "ansiblack"
BASE01 = "ansibrightgreen"
BASE00 = "ansibrightyellow"
BASE0 = "ansibrightblue"
BASE1 = "ansibrightcyan"
BASE2 = "ansigray"
BASE3 = "ansiwhite"
YELLOW = "ansiyellow"
ORANGE = "ansibrightred"
RED = "ansired"
MAGENTA = "ansimagenta"
VIOLET = "ansibrightmagenta"
BLUE = "ansiblue"
CYAN = "ansicyan"
GREEN = "ansigreen"

solarized_theme = Theme(
    "solarized",
    "default",
    {
        # Language syntax
        Token.Text: BASE0,
        Token.Error: RED,
        Token.Comment: BASE01,
        Token.Keyword: f"noinherit {GREEN}",
        Token.Keyword.Constant: GREEN,
        Token.Keyword.Namespace: f"noinherit {MAGENTA}",
        Token.Name.Namespace: f"noinherit {GREEN}",
        Token.Name.Builtin: BLUE,
        Token.Name.Function: BLUE,
        Token.Name.Class: f"noinherit {BLUE}",
        Token.Name.Decorator: BLUE,
        Token.Name.Exception: BLUE,
        Token.Number: CYAN,
        Token.Operator: GREEN,
        Token.Operator.Word: GREEN,
        Token.Literal: CYAN,
        Token.String: CYAN,
        # Prompt stuff
        Token.Prompt: GREEN,
        Token.PromptNum: BASE0,
        Token.OutPrompt: BASE01,
        Token.OutPromptNum: BASE0,
        Token.ExcName: RED,
        Token.Topline: RED,
        Token.FilenameEm: GREEN,
        Token.Filename: VIOLET,
    },
)

TRACEBACK_HIGHLIGHT = f"bg:{YELLOW} {BASE2}"

# My shell environment

All my shell environment stuff. Use/abuse as you like.

## Setup

On macOS, remember to edit `/etc/profile` to prevent `path_helper` from ruining our day:

```sh
if [ -z "$PROFILE_SOURCED" ]; then
    # path_helper stuff
fi
```

See [this GitHub
page](https://gist.github.com/Linerre/f11ad4a6a934dcf01ee8415c9457e7b2#what-is-it-).

## Solarized

The terminal should be configured such that its dark mode ANSI colours match the standard Solarized
ANSI colour mapping. That means that `base0{0,1,2,3}` are dark and `base{0,1,2,3}` are light.

The light mode ANSI colours should be identical, but with the base colours swapped (e.g., `base01`
becomes `base1` and vice versa).

### iTerm2 setup

The `Solarized.itermcolors` file contains the correct colours under the `(Light)` and `(Dark)`, but
iTerm2 doesn't seem to provide a way to load these properly, so it's easiest just to set them
manually from the sRGB hex codes in `etc/solarized_test.py` (and then use that script to check that
everything comes out right).

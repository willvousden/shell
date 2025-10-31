My shell environment
====================

All my shell environment stuff. Use/abuse as you like.

Setup
-----

On macOS, remember to edit `/etc/profile` to prevent `path_helper` from ruining our day:

```sh
if [ -z "$PROFILE_SOURCED" ]; then
    # path_helper stuff
fi
```

See [this GitHub
page](https://gist.github.com/Linerre/f11ad4a6a934dcf01ee8415c9457e7b2#what-is-it-).

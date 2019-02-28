My shell environment
====================

All my shell environment stuff. Use/abuse as you like.

Setup
-----

On macOS, remember to edit `/etc/profile` to prevent `path_helper` from ruining our day:

    if [ -z "$PROFILE_SOURCED" ]; then
        # path_helper stuff
    fi

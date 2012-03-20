#!/bin/bash

if [[ ! -x $(which unix2dos) ]] && [[ -x $(which perl) ]]; then
    function dos2unix {
        __patternify 's/\r$//' $1 $2
    }
fi

if [[ ! -x $(which unix2dos) ]] && [[ -x $(which perl) ]]; then
    function unix2dos {
        __patternify 's/\n/\r\n/' $1 $2
    }
fi

function __patternify {
    local source=$2
    local destination=$3
    if [[ -z $destination ]]; then
        destination=$(mktemp $2.XXXX)
    fi
    echo $source $destination

    if [[ -r $source ]] && [[ -w $destination ]]; then
        perl -p -e $1 < $source > $destination
    fi

    if [[ -z $3 ]]; then
        mv $destination $source
    fi
}

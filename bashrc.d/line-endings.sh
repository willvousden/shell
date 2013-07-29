if [[ ! -x $(which unix2dos) ]] && [[ -x $(which perl) ]]; then
    function dos2unix {
        __patternify 's/\r$//' "$1" "$2"
    }
fi

if [[ ! -x $(which unix2dos) ]] && [[ -x $(which perl) ]]; then
    function unix2dos {
        __patternify 's/\n/\r\n/' "$1" "$2"
    }
fi

function __patternify {
    local source=$2
    local destination=$3
    if [[ -z $destination ]]; then
        destination=$(mktemp "$2.XXXX")
    fi

    if [[ -r $source ]] && [[ -w $destination ]]; then
        perl -p -e $1 < "$source" > "$destination"
    fi

    if [[ -z $3 ]]; then
        local mode=$(stat --format %a "$source")
        mv "$destination" "$source"
        chmod $mode "$source"
    fi
}

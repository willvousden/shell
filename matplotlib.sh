colours=(456BA3 CA8000 7B9F16 D4400F 7161A1 B15700 4086B4 E6AC00 954A8B 838700 D23211 4769C3 DF8800 A94169 2CA455)

verlte() {
    [ "$1" = "$(echo -e "$1\n$2" | sort -V | head -n1)" ]
}

verlt() {
    [ "$1" = "$2" ] && return 1 || verlte $1 $2
}

version=$(python -c 'import matplotlib; print(matplotlib.__version__)' 2> /dev/null)
if verlt "$version" 1.5; then
    list=$(printf '%s, ' "${colours[@]}" | sed 's/, $//')
    cat <<FOO
axes.color_cycle    : $list
FOO
else
    list=$(printf "'%s', " "${colours[@]}" | sed 's/, $//')
    cat <<FOO
axes.prop_cycle    : cycler('color', [$list])
FOO
fi
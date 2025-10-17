function history_range() {
    if [ $# -ne 2 ]
    then
        echo "Usage: $funcstack[1] <start> <end>"
        return
    fi
    history | sed -n "$1,$2p"
}

function history_near() {
    default_size="10"
    if [ $# -lt 1 ]
    then
        echo "Usage: $funcstack[1] <target> <range = $default_size>"
        return
    fi
    if [ $# -gt 2 ]
    then
        echo "Usage: $funcstack[1] <target> <range = $default_size>"
        return
    fi
    size=${2-$default_size}

    start=$(expr $1 - $size)
    end=$(expr $1 + $size)
    history_range $start $end
}
__omz_tangerie_utils="${0:a:h}"

fpath+=($__omz_tangerie_utils/funcs)

function tangerie::reload() {
    local f
    for f ($__omz_tangerie_utils/modules/*.zsh) . $f

    local fs=($__omz_tangerie_utils/funcs/*(:t))
    unfunction $fs &> /dev/null
    autoload -Uz $fs
}

function tangerie::update() {
    pushd -q "$__omz_tangerie_utils"
    git pull
    popd -q
}

tangerie::reload
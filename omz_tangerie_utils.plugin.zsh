set -x
__omz_tangerie_utils="${0:a:h}"

fpath+=($__omz_tangerie_utils/funcs)

function tangerie::reload() {
    local f
    for f ($__omz_tangerie_utils/modules/*.zsh) . $f

    local fs=($__omz_tangerie_utils/funcs/*(:t))
    unfunction $fs &> /dev/null
    autoload -Utz $fs
}

function tangerie::update() {
    builtin cd "$__omz_tangerie_utils"
    git pull
    cd $OLDPWD
}

tangerie::reload
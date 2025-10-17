__omz_tangerie_utils="${0:a:h}"
local f
for f ($__omz_tangerie_utils/modules/*.zsh)  . $f
unset f

fpath+=($__omz_tangerie_utils/funcs)

function tangerie::reload() {
    local fs=($__omz_tangerie_utils/funcs/*(:t))
    unfunction $fs &> /dev/null
    autoload -Utz $fs
}

tangerie::reload
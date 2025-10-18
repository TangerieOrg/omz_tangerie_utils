emulate -L zsh
which nvm &>/dev/null && return

NVM_DIR=${NVM_DIR:-"$HOME/.nvm"}

[ ! -d "$NVM_DIR" ] && return

local _nvm_commands=($NVM_DIR/versions/node/*/bin/*(r:t))
_nvm_commands=(${(u)_nvm_commands})

_lazy_nvm_commands=(nvm)
for ex in $_nvm_commands; do
    [[ ${commands[(Ie)$ex]} ]] || _lazy_nvm_commands+=($ex)
done

unset _nvm_commands


function _lazy_nvm_load {
    local _nvm_completion

    unfunction $_lazy_nvm_commands

    # eval "function $_lazy_nvm_commands {
    #     nvm use --silent &> /dev/null
    #     which \$0 &>/dev/null || \$0 \$@
    #     local LAZY_NVM_CMD=\$NVM_BIN/\$0
    #     if [[ -f \$LAZY_NVM_CMD ]]; then
    #         \$LAZY_NVM_CMD \$@
    #     else
            
    #     fi
    # }"

    unset _lazy_nvm_commands
    unfunction _lazy_nvm_load
    
    . "$NVM_DIR/nvm.sh"
    nvm use --silent &> /dev/null
    
    echo Using node $(node -v)

    # Load nvm bash completion
    for _nvm_completion in "$NVM_DIR/bash_completion" "$NVM_HOMEBREW/etc/bash_completion.d/nvm"; do
        if [[ -f "$_nvm_completion" ]]; then
            # Load bashcompinit
            autoload -U +X bashcompinit && bashcompinit
            # Bypass compinit call in nvm bash completion script. See:
            # https://github.com/nvm-sh/nvm/blob/4436638/bash_completion#L86-L93
            ZSH_VERSION= source "$_nvm_completion"
            break
        fi
    done
}


eval "function $_lazy_nvm_commands { 
    _lazy_nvm_load
    \$0 \$@
}"

shift _lazy_nvm_commands
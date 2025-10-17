which nvm &>/dev/null && return

if [[ -z "$NVM_DIR" ]]; then
    export NVM_DIR="$HOME/.nvm"
fi

_lazy_nvm_commands=( 
    nvm
    npm 
    node 
    npx 
    qwen 
    claude 
    ccr 
    yarn 
    yarnpkg
    pnpm
    pnpx
    node-gyp
    corepack
)

function _lazy_nvm_load {
    local _nvm_completion
    
    unfunction $_lazy_nvm_commands
    _lazy_nvm_commands=${_lazy_nvm_commands:1}
    
    \. "$NVM_DIR/nvm.sh"
    
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

    eval "function $_lazy_nvm_commands {
        nvm use --silent &> /dev/null
        \$NVM_BIN/\$0 \$@
    }"

    unfunction _lazy_nvm_load
    unset _lazy_nvm_commands
}

eval "function $_lazy_nvm_commands { 
    _lazy_nvm_load
    \$0 \$@
}"
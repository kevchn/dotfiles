# Scripts #################################
# Autojump (cd that remembers)
[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh

# Paths ###################################
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

# Zinit ###################################
# Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zinit-zsh/z-a-rust \
    zinit-zsh/z-a-as-monitor \
    zinit-zsh/z-a-patch-dl \
    zinit-zsh/z-a-bin-gem-node

# Prompt
zinit ice wait'!0' atload'promptinit; prompt scala2' lucid
zinit light psprint/zprompts

# Additional completions
zinit ice wait blockf atpull'zinit creinstlal -q .' lucid
zinit light zsh-users/zsh-completions

# Syntax highlighting
zinit ice wait atinit'zpcompinit; zpcdreplay' lucid
zinit light zdharma/fast-syntax-highlighting

# Autosuggestions
zinit ice wait atload'_zsh_autosuggest_start' lucid
zinit light zsh-users/zsh-autosuggestions
ZSH_AUTOSUGGEST_USE_ASYNC=1

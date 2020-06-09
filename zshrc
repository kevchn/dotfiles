
### Added by Zplugin's installer
source '/Users/kevinchen/.zplugin/bin/zplugin.zsh'
autoload -Uz _zplugin
(( ${+_comps} )) && _comps[zplugin]=_zplugin
### End of Zplugin installer's chunk

# Prompt
zplugin ice wait'!0' atload'promptinit; prompt scala2' lucid
zplugin light psprint/zprompts

# Additional completions
zplugin ice wait blockf atpull'zplugin creinstlal -q .' lucid
zplugin light zsh-users/zsh-completions

# Syntax highlighting
zplugin ice wait atinit'zpcompinit; zpcdreplay' lucid
zplugin light zdharma/fast-syntax-highlighting

# Autosuggestions
zplugin ice wait atload'_zsh_autosuggest_start' lucid
zplugin light zsh-users/zsh-autosuggestions
ZSH_AUTOSUGGEST_USE_ASYNC=1

# Autojump (cd that remembers)
[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh

# Path
export PATH=$PATH:~/.emacs.d/bin
### End of Zinit's installer chunk
### End of Zinit's installer chunk
### End of Zinit's installer chunk
### End of Zinit's installer chunk

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

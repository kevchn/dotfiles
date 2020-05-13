
### Added by Zplugin's installer
source '/Users/kev/.zplugin/bin/zplugin.zsh'
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

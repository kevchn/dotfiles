# Neeva Setup AWS ########################
export NAMESPACE=kevin

# Alias ##################################
function kc () {
  kubectl --namespace ${NAMESPACE} $*
}

function awsprod () {
  pushd ~/Code/neeva;
  eval $(go run neeva.co/cmd/prodaccess aws shell --eval);
  eval $(./setup_dev.sh setup);
  popd
}

function awsssh () {
  echo "Setting up SSH key and AWS shell"
  ssh-add ~/.ssh/kevin-ec2-east1.pem;
  eval $(go run neeva.co/cmd/prodaccess aws shell --eval)
}

alias "awsutil"="USER=kevin awsutil"

alias ctags="`brew --prefix`/bin/ctags"

# Scripts #################################
# Autojump (cd that remembers)
[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh

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

# NVM
NVM_DIR="$HOME/.nvm"
if [ -d $NVM_DIR/versions/node ]; then
  NODE_GLOBALS=(`find $NVM_DIR/versions/node -maxdepth 3 \( -type l -o -type f \) -wholename '*/bin/*' | xargs -n1 basename | sort | uniq`)
fi
NODE_GLOBALS+=("nvm")
load_nvm () {
  for cmd in "${NODE_GLOBALS[@]}"; do unset -f ${cmd} &>/dev/null; done
  [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
  nvm use 2> /dev/null 1>&2 || true
  export NVM_LOADED=1
}
for cmd in "${NODE_GLOBALS[@]}"; do
  if ! which ${cmd} &>/dev/null; then
    eval "${cmd}() { unset -f ${cmd} &>/dev/null; [ -z \${NVM_LOADED+x} ] && load_nvm; ${cmd} \$@; }"
  fi
done

# Pyenv
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

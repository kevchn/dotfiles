# Neeva Env Vars #########################
export NEEVA_USER=kevin
export NAMESPACE=kevin
export KUBECONFIG=~/Code/neeva/production/instances/dev-us-west-2/eks/kubeconfig

export NEEVA_KAFKA_TLS_CERT_FILE="$(dirname $(dirname "${KUBECONFIG}"))/kubernetes/pubsub/tls.crt"
export NEEVA_KAFKA_TOPIC_PREFIX="$NAMESPACE-"
export NEEVA_KAFKA_BROKERS="localhost:29090,localhost:29091,localhost:29092"
export NEEVA_SCHEMA_REGISTRY="localhost:8082"

export NEEVA_MYSQL_HOST="localhost"

# Alias ##################################
alias grafana="kubectl -n monitoring port-forward service/grafana 3000"

function listening() {
  if [[ $# -eq 0 ]]; then
      sudo lsof -iTCP -sTCP:LISTEN -n -P
  elif [[ $# -eq 1 ]]; then
      sudo lsof -iTCP -sTCP:LISTEN -n -P | grep -i --color $1
  else
      echo "Usage: listening [pattern]"
  fi
}

function kc () {
  kubectl --namespace ${NAMESPACE} $*
}

# Authenticates
function a () {
  eval $(go run neeva.co/cmd/prodaccess aws shell --eval --verbose)
}

# Set up env variables
function setupdev () {
  eval $(./setup_dev.sh --namespace $NAMESPACE setup)
}

function clusternotebook () {
  setup_dev.sh --namespace=${NAMESPACE} spark notebook
}

# Update stack with new pods, run every week
function newpods () {
  eval $(./setup_dev.sh --namespace $NAMESPACE setup); kubectl -n $NAMESPACE delete -f production/kubernetes/redis; ./setup_dev.sh --namespace $NAMESPACE kube;
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

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

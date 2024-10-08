# Path to your oh-my-zsh installation.
ZDD=${ZDOTDIR:-$HOME}
export ZSH="${ZDD}/oh-my-zsh"

# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="robbyrussell"
#ZSH_THEME="agnoster"

ENABLE_CORRECTION="true"

plugins=(
  docker
  docker-compose
  git
  golang
  vi-mode
  zsh-autosuggestions
  zsh-nvm
  direnv
)
source $ZSH/oh-my-zsh.sh

## get System.d compatible environments and export them for session
[ -d ~/.config/environment.d ] && \
  set -o allexport && \
  source ~/.config/environment.d/*.conf && \
  set +o allexport || \
  export \
    EDITOR=vim \
    VISUAL=$EDITOR \
;

# source aliases
[ -f ~/.config/aliases ] && source ~/.config/aliases

# Lines configured by zsh-newuser-install
HISTFILE=$ZDD/.history
HISTSIZE=1000
SAVEHIST=1000
setopt autocd extendedglob notify
unsetopt beep
bindkey -e

# The following lines were added by compinstall
zstyle :compinstall filename "$ZDD/.zshrc"

autoload -Uz compinit
compinit

# load syntax highlighting
[ -f $ZSH/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ] && source $ZSH/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh || \
[ -f /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ] && source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# add ~/.local/bin to PATH
[ -d ~/.local/bin ] && export PATH=${PATH}:${HOME}/.local/bin

# source JetBrains config
[ -f ~/.config/JetBrains/jetbrainsrc ] && source ~/.config/JetBrains/jetbrainsrc

[ -d ~/.dotnet ] && export PATH=$HOME/.dotnet:$PATH

[ -d ~/.config/go/bin ] && export PATH=$PATH:$HOME/.config/go/bin

if [ -d ~/.npm-global/bin ]; then
  export PATH=${PATH}:${HOME}/.npm-global/bin
fi

# rootless docker
if [[ -f ~/.config/systemd/user/docker.service || -f /usr/lib/systemd/user/docker.service ]]
then
  export DOCKER_HOST=unix://$XDG_RUNTIME_DIR/docker.sock
  export PATH=~/.local/bin:$PATH
fi

# vim mode
bindkey -v

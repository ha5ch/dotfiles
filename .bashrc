#
# ~/.bashrc
#
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

#PS1='[\u@\h \W]\$ '
PS1="\[$(tput setaf 7)\][\[$(tput setaf 2)\]\u\[$(tput setaf 7)\]@\[$(tput setaf 4)\]\h\[$(tput setaf 3)\]\[$(tput bold)\] \W\[$(tput sgr0)\]]\\$ \[$(tput sgr0)\]"

## get System.d compatible environments and export them for session
[ -d ~/.config/environment.d ] && \
  set -o allexport && \
  . ~/.config/environment.d/*.conf && \
  set +o allexport || \
  export \
    EDITOR=vim \
    VISUAL=$EDITOR \
;
## source aliases
[ -f ~/.config/aliases ] && . ~/.config/aliases || \
  alias \
    ls='ls --color=auto' \
    ll='ls -hl' \
    la='ll -A' \
;

# add ~/.local/bin to PATH
[ -d ~/.local/bin ] && export PATH=${PATH}:${HOME}/.local/bin

# source JetBrains config
[ -f ~/.config/JetBrains/jetbrainsrc ] && source ~/.config/JetBrains/jetbrainsrc
export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

[ -d ~/.config/environment.d ] && \
  set -o allexport && \
  . ~/.config/environment.d/*.conf && \
  set +o allexport || \
  export \
    EDITOR=vim \
    VISUAL=$EDITOR \
;

# Added by Toolbox App
if [ -d "$HOME/.local/share/JetBrains/Toolbox/scripts" ]; then
  export PATH="$PATH:$HOME/.local/share/JetBrains/Toolbox/scripts"
fi


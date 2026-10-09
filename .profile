[ -d ~/.config/environment.d ] && \
  set -o allexport && \
  . ~/.config/environment.d/*.conf && \
  set +o allexport || \
  export \
    EDITOR=vim \
    VISUAL=$EDITOR \
;

# ssh-agent socket customization
# only use default user ssh-agent when no gcr (gnome keyring) is available
# see also ~/.config/systemd/user/ssh-agent.service.d/no-gcr.conf
# and      ~/.config/systemd/user-environment-generators/50-ssh-auth-sock
if [ -z "$SSH_AUTH_SOCK" ]; then
  for s in "$XDG_RUNTIME_DIR/gcr/ssh" "$XDG_RUNTIME_DIR/ssh-agent.socket"; do
    [ -S "$s" ] && export SSH_AUTH_SOCK="$s" && break
  done
fi

# Added by Toolbox App
if [ -d "$HOME/.local/share/JetBrains/Toolbox/scripts" ]; then
  export PATH="$PATH:$HOME/.local/share/JetBrains/Toolbox/scripts"
fi


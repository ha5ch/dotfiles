[ -d ~/.config/environment.d ] && \
  set -o allexport && \
  . ~/.config/environment.d/*.conf && \
  set +o allexport || \
  export \
    EDITOR=vim \
    VISUAL=$EDITOR \
;

# rootless docker
if [[ -f ~/.config/systemd/user/docker.service || -f /usr/lib/systemd/user/docker.service ]]
then
  echo "set DOCKER_HOST"
  export DOCKER_HOST=unix://$XDG_RUNTIME_DIR/docker.sock
  export PATH=~/.local/bin:$PATH
fi

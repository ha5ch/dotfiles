[ -d ~/.config/environment.d ] && \
  set -o allexport && \
  . ~/.config/environment.d/*.conf && \
  set +o allexport || \
  export \
    EDITOR=vim \
    VISUAL=$EDITOR \
;

# rootless docker
[ -f ~/.config/systemd/user/docker.service ] && {
  export DOCKER_HOST=unix:///run/user/`id -u`/docker.sock
  export PATH=~/.local/bin:$PATH
}

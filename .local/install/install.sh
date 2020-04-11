#/bin/sh

## install my dotfiles on your system

REPO=
LOCAL_REPO="${1:-$HOME/.local/dotfiles.git}" && LOCAL_REPO="${LOCAL_REPO%/}"
LOCAL_BKP=${LOCAL_REPO%/}.bkp

command -v git > /dev/null 2>&1 || { 
  echo "could not find git! please install git and run script again"
  exit 1
}

alias dotfiles="/usr/bin/git --git-dir=$LOCAL_REPO --work-tree=$HOME"

[ -d $LOCAL_REPO ] && {
  read -p "'${LOCAL_REPO}' already exists, do you want to replace it [y,N]? " CHOICE
  CHOICE=${CHOICE:-n}; CHOICE=${CHOICE:0:1}
  [ "${CHOICE,,}" == "y" ] && {
    rm -rf $LOCAL_REPO
    echo $LOCAL_REPO > $LOCAL_REPO/../.gitignore
    git clone --bare $REPO $LOCAL_REPO
    echo yes 
  } || {
    dotfiles stash
    dotfiles pull
  }
}

dotfiles checkout > /dev/null 2>&1
[ $? != 0 ] && {
  echo "Create backup of already existing dotfiles..."
  [ ! -d $LOCAL_BKP ] && mkdir -p $LOCAL_BKP
  dotfiles checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} $LOCAL_BKP/{}
  dotfiles checkout > /dev/null 2>&1
} || {
  echo "Checked out dotfiles..."
}

dotfiles config --local status.showUntrackedFiles no

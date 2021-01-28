#/bin/bash

## install my dotfiles on your system

REPO="https://github.com/Rigbin/dotfiles.git"
LOCAL_REPO="${1:-$HOME/.local/dotfiles.git}" && LOCAL_REPO="${LOCAL_REPO%/}"
LOCAL_BKP=${LOCAL_REPO%/}.bkp

clone_dotfiles() {
  [ ! -d $LOCAL_REPO ] && mkdir -p $LOCAL_REPO 
  echo "$LOCAL_REPO" > "$LOCAL_REPO/../.gitignore"
  git clone --bare $REPO $LOCAL_REPO > /dev/null 2>&1
  echo "Cloned dotfiles into $LOCAL_REPO ..."
}

dotfiles() {
  /usr/bin/git --git-dir="$LOCAL_REPO" --work-tree="$HOME" $@
}

ohmyzsh() {
  if [ ! -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom} ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    rm ~/.zshrc*
  fi
  if [ ! -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-nvm ]; then
    git clone https://github.com/lukechilds/zsh-nvm ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-nvm
  fi 
  if [ ! -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
  fi 
  source $HOME/.config/zsh/.zshrc
}

tmuxtheme() {
  if [ ! -d $HOME/.config/tmux/tmux-themepack ]; then
    git clone https://github.com/jimeh/tmux-themepack.git $HOME/.config/tmux/tmux-themepack
  fi 
}

command -v git > /dev/null 2>&1 || { 
  echo "could not find git! please install git and run script again"
  exit 1
}

[ -d $LOCAL_REPO ] && {
  read -p "'${LOCAL_REPO}' already exists, do you want to replace it [y,N]? " CHOICE
  CHOICE=${CHOICE:-n}; CHOICE=${CHOICE:0:1}
  [ "${CHOICE,,}" == "y" ] && {
    rm -rf $LOCAL_REPO
    clone_dotfiles
  } || {
    dotfiles stash
    dotfiles pull
  }
} || {
  clone_dotfiles
}

dotfiles checkout > /dev/null 2>&1
[ $? != 0 ] && {
  echo "Create backup of already existing dotfiles..."
  #[ ! -d $LOCAL_BKP ] && mkdir -p $LOCAL_BKP
  dotfiles checkout 2>&1 | egrep "\s+\." | awk {'gsub(/^[ \t]+/,"");print $0'} | xargs -I{} sh -c "[ -e \"{}\" ] && tar -uvhf \"$LOCAL_BKP.tar\" \"{}\" ; rm -r \"{}\""
  dotfiles checkout #> /dev/null 2>&1
} || {
  echo "Checked out dotfiles..."
}

dotfiles config --local status.showUntrackedFiles no
unset -f clone_dotfiles
[ -f $HOME/README.md ] && {
  dotfiles update-index --assume-unchanged $HOME/README.md
  rm $HOME/README.md
}

ohmyzsh
unset -f ohmyzsh

tmuxtheme
unset -f tmuxtheme

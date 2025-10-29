#!/bin/bash

### Install/Pre-Config script for gnome desktop
### Download/Prepare Themes, Icons, Extensions, ...

while getopts ait OPT; do
  case $OPT in
    a) 
      RUN_THEMES="true"
      RUN_ICONS="true"
      ;;
    i)
      RUN_ICONS="true"
      ;;
    t)
      RUN_THEMES="true"
      ;;
  esac
done

THEMES=(
  #https://github.com/EliverLara/Juno.git
  #https://github.com/EliverLara/Nordic.git
  https://github.com/vinceliuice/Colloid-gtk-theme.git
)
ICONS=(
  https://github.com/vinceliuice/Tela-icon-theme.git
)


## directory where this script is located
DIR=`cd -P "$( dirname "$BASH_SOURCE[0]" )" >/dev/null 2>&1 && pwd`


function themes {
  echo --------------- THEMES ---------------
  THEMES_INST=${INSTALL_HOME:-${DIR}}/themes
  THEMES_HOME=${THEMES_HOME:-$HOME/.local/share/themes}

  [ ! -d $THEMES_INST ] && mkdir -p $THEMES_INST
  [ ! -d $THEMES_HOME ] && mkdir -p $THEMES_HOME

  for THEME in ${THEMES[@]}
  do
    THEME_DIR=`echo $THEME | sed -En "s/.+?\\/([^\\/\\.]+?)\.git$/\1/p"`
    [ -d $THEMES_INST/$THEME_DIR ] && {
      cd $THEMES_INST/$THEME_DIR
      echo UPDATE $THEME IN $THEMES_INST/$THEME_DIR
      git pull
      [ -f $THEMES_INST/$THEME_DIR/install.sh ] && {
        ## TODO: this options currently only work for Colloid!
        $THEMES_INST/$THEME_DIR/install.sh -d $THEMES_HOME -t green -c dark --tweaks rimless
        $THEMES_INST/$THEME_DIR/install.sh -d $THEMES_HOME -t green -c light --tweaks rimless
      }
    } || {
      cd $THEMES_INST
      echo CLONE $THEME INTO $THEMES_INST/$THEME_DIR
      git clone $THEME $THEME_DIR
      [ -f $THEMES_INST/$THEME_DIR/install.sh ] && {
        ## TODO: this options currently only work for Colloid!
        $THEMES_INST/$THEME_DIR/install.sh -d $THEMES_HOME -t green -c dark --tweaks rimless
      } || {
        ln -sf $THEMES_INST/$THEME_DIR $THEMES_HOME/$THEME_DIR
      } 
    }
  done
}

function icons {
  echo --------------- ICONS ---------------
  ICONS_INST=${INSTALL_HOME:-${DIR}}/icons
  ICONS_HOME=${ICONS_HOME:-$HOME/.local/share/icons}

  [ ! -d $ICONS_INST ] && mkdir -p $ICONS_INST
  [ ! -d $ICONS_HOME ] && mkdir -p $ICONS_HOME

  for ICON in ${ICONS[@]}
  do
    GHASH=""
    ICON_DIR=`echo $ICON | sed -En "s/.+?\/([A-Za-z-]+?)\.git$/\1/p"`
    [ -d $ICONS_INST/$ICON_DIR ] && {
      cd $ICONS_INST/$ICON_DIR
      GHASH=`git rev-parse --short HEAD`
      echo GHASH=$GHASH
      echo UPDATE $ICON IN $ICONS_INST/$ICON_DIR
      git pull
    } || {
      cd $ICONS_INST
      echo CLONE $ICON INTO $ICONS_INST/$ICON_DIR
      git clone $ICON $ICON_DIR
    }
    [ -f $ICONS_INST/$ICON_DIR/install.sh ] && {
      if [ "$GHASH" != "`git rev-parse --short HEAD`" ]
      then
        $ICONS_INST/$ICON_DIR/install.sh grey
      else
        echo everything up to date in $ICON_DIR...
      fi
    } || {
      ln -sf $ICONS_INST/$ICON_DIR $ICONS_HOME/$ICON_DIR
    }
  done
}

if [[ "$RUN_THEMES" == "true" ]]
then
  themes
fi
if [[ "$RUN_ICONS" == "true" ]]
then
  icons
fi

unset themes
unset icons


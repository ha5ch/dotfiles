# My personal dotfiles

In this repository you can find my personal used `dotfiles` on a Linux system.
At the current point I use [Arch Linux](https://archlinux.org/) as preferred distro, but they should work distro independent.

Used software/tools:
* Shell: [ZSH](https://wiki.archlinux.org/index.php/zsh)
  * [oh-my-zsh](https://ohmyz.sh/)
* Terminal: [alacritty](https://github.com/alacritty/alacritty)
  * [tmux](https://github.com/tmux/tmux/wiki)
* DE: [Gnome](https://www.gnome.org/)
* Editors:
  * [vim](https://www.vim.org/)
  * [vscode](https://code.visualstudio.com/)
* [git](https://git-scm.com/)

## Install
You can easily install it with the provided [install-script](.local/install/install.sh). But keep in mind that it will maybe override some dotfiles on your system!

```console
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ha5ch/dotfiles/main/.local/install/install.sh)"
```

## TODOs
* ~~automatically install/manage used gnome themes/icons~~
* automatically install/manage used gnome extensions
  * [gTile](https://github.com/gTile/gTile)
  * [Swticher](https://github.com/daniellandau/switcher)
  * [Unite](https://github.com/hardpixel/unite-shell)
  * [Vitals](https://github.com/corecoding/Vitals)
  * ...

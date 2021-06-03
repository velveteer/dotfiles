The accumulation of years of trials and errors. 

### Current Tools

* OS: Arch Linux
* Terminal: kitty + tmux
* Text editor: neovim
* Shell: zsh 
* Window Manager: sway
* Launcher: wofi
* Status bar: i3status

### Install

You need GNU Stow installed. I use it to manage symlinks to files in this repo (assumed to be in `~/dotfiles`).

Follow Xero's lead on using `stow`: https://github.com/xero/dotfiles#installing

1. `cd`
2. `git clone https://github.com/velveteer/dotfiles`
3. `cd dotfiles`
4. run `stow zsh` to install zsh, `stow vim` to install vim/neovim, etc. `stow -D` to uninstall by name

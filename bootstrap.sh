#!/usr/bin/zsh

dir=~/dotfiles 
files=(config fonts vimrc tmux.conf Xresources zshrc zprofile zpreztorc)

# change to the dotfiles directory
echo "Changing to the $dir directory"
cd $dir
echo "...done"

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks 
for file in $files; do
    echo "Creating symlink to $file in home directory."
    ln -s $dir/$file ~/.$file
    echo "...done"
done

# install prezto
git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"

# install vundle and bundles
git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
vim +BundleInstall +qall

# install Powerline for zsh
ln -s $dir/powerline-shell/powerline-shell.py ~/powerline-shell.py

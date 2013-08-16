filetype off
syntax on
colorscheme molokai
set tabstop=4
set expandtab
set shiftwidth=4
set shiftround
set autoindent
set backspace=indent,eol,start
set encoding=utf-8
set termencoding=utf-8
set laststatus=2

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'tpope/vim-fugitive'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'scrooloose/syntastic'
Bundle 'Lokaltog/vim-powerline'
Bundle 'davidhalter/jedi-vim'

filetype plugin indent on

filetype off
syntax on
colo herald 
set tabstop=4
set expandtab
set shiftwidth=4
set shiftround
set autoindent
set backspace=indent,eol,start
set encoding=utf-8
set laststatus=2
au FileType html setl sw=2 sts=2 et
au BufRead,BufNewFile *.ex,*.exs setfiletype elixir

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'tpope/vim-fugitive'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'scrooloose/syntastic'
Bundle 'Lokaltog/vim-powerline'
Bundle 'jimenezrick/vimerl'
Bundle 'elixir-lang/vim-elixir'

filetype plugin indent on
let g:Powerline_symbols = 'unicode'

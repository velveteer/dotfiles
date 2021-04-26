" vim: set foldmethod=marker foldlevel=0:
" VIM-PLUG BLOCK {{{
" ============================================================================

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

Plug 'godlygeek/tabular'
Plug 'wincent/terminus'
Plug 'henrik/vim-indexed-search'
Plug 'vim-airline/vim-airline'
Plug 'Konfekt/FastFold'
Plug 'mhinz/vim-signify'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'jwhitley/vim-matchit'
Plug 'w0rp/ale'
Plug 'luochen1990/rainbow'
Plug 'easymotion/vim-easymotion'
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
Plug 'posva/vim-vue', { 'for': 'vue' }
Plug 'leafgarland/typescript-vim', { 'for': 'typescript' }
Plug 'JulesWang/css.vim', { 'for': 'css' }
Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }
Plug 'neovimhaskell/haskell-vim', { 'for': 'haskell' }
Plug 'raichoo/purescript-vim', { 'for': 'purescript' }
Plug 'fatih/vim-go', { 'for': 'go' }
Plug 'rust-lang/rust.vim', { 'for': 'rust' }
Plug 'LnL7/vim-nix', { 'for': 'nix' }
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'mileszs/ack.vim'
Plug 'hashivim/vim-terraform', { 'for': 'terraform' }
Plug 'phaazon/gruvbox'

" Add plugins to &runtimepath
call plug#end()

" }}}
" ============================================================================
" BASIC SETTINGS {{{
" ============================================================================

if (has("termguicolors"))
  set termguicolors
endif

set background=dark
colorscheme gruvbox
highlight Conceal ctermbg=NONE guibg=NONE

filetype plugin indent on          " Load plugins according to detected filetype.
syntax on                          " Enable syntax highlighting.
set autoindent                     " Indent according to previous line.
set expandtab                      " Use spaces instead of tabs.
set softtabstop =2                 " Tab key indents by 2 spaces.
set shiftwidth  =2                 " >> indents by 2 spaces.
set shiftround                     " >> indents to next multiple of 'shiftwidth'.
set backspace   =indent,eol,start  " Make backspace work as you would expect.
set hidden                         " Switch between buffers without having to save first.
set laststatus  =2                 " Always show statusline.
set display     =lastline          " Show as much as possible of the last line.
set showcmd                        " Show already typed keys when more are expected.
set incsearch                      " Highlight while searching with / or ?.
set hlsearch                       " Keep matches highlighted.
set ttyfast                        " Faster redrawing.
set lazyredraw                     " Only redraw when necessary.
set splitbelow                     " Open new windows below the current window.
set splitright                     " Open new windows right of the current window.
set nocursorline                   " (OFF) Find the current line quickly.
set wrapscan                       " Searches wrap around end-of-file.
set report      =0                 " Always report changed lines.
set synmaxcol   =200               " Only highlight the first 200 columns.
set number                         " Yeah line numbers
set timeoutlen  =1000              " Remove delay when changing modes
set ttimeoutlen =0
set list                           " Show non-printable characters.
set updatetime  =100

if has('multi_byte') && &encoding ==# 'utf-8'
  let &listchars = 'tab:▸ ,extends:❯,precedes:❮,nbsp:±'
else
  let &listchars = 'tab:> ,extends:>,precedes:<,nbsp:.'
endif

" Annoying temporary files
set backupdir=/tmp//,.
set directory=/tmp//,
set noswapfile

" Stores undo state even when files are closed (in undodir)
set undodir=$HOME/.vim/undo
set undofile

" Use ``indent`` based folding
set foldmethod=indent

" Disable all folds on file open until `zc` or `zM` etc is used
set nofoldenable

" Don't display the current mode (Insert, Visual, Replace)
" in the status line. This info is already shown in the
" Airline status bar.
set noshowmode

" Start scrolling before cursor gets to the edge
set scrolloff=5
set sidescrolloff=15
set sidescroll=1

" Use Unix as the standard file type
set ffs=unix,dos,mac

" Set local settings per project root in .vimlocal
silent! so .vimlocal

" Ignore certain files and folders when globbing
set wildignore+=*.o,*.obj,*.bin,*.dll,*.exe
set wildignore+=*/.git/*,*/.svn/*,*/__pycache__/*,*/build/**
set wildignore+=*.pyc
set wildignore+=*.DS_Store
set wildignore+=*.aux,*.bbl,*.blg,*.brf,*.fls,*.fdb_latexmk,*.synctex.gz,*.pdf

" }}}
" ============================================================================
" MAPPINGS {{{
" ============================================================================

let mapleader = "\<Space>"

" Fast saving
nmap <leader>w :w!<cr>

" Binding for fzf files in current dir
map ; :Files<CR>

" Set paste
map <leader>pp :setlocal paste!<cr>

" Remap VIM 0 to first non-blank character
map 0 ^

" No Ex mode (see :help Q)
nnoremap Q <nop>

" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

" Close the current buffer
map <leader>bd :bdelete<cr>

" Close all the buffers
map <leader>ba :1,1000 bd!<cr>

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Move up and down on physical lines
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

" Switch buffers
nnoremap <silent> H :bp<CR>
nnoremap <silent> L :bn<CR>

" Tabularize
vmap a= :Tabularize /=<CR>
vmap a; :Tabularize /::<CR>
vmap a- :Tabularize /-><CR>
vmap a` :Tabularize /<-<CR>
vmap a. :Tabularize /.=<CR>

" When completion menu is shown, use <cr> to select an item
" and do not add an annoying newline. Otherwise, <enter> is what it is.
" For more info , see https://goo.gl/KTHtrr and https://goo.gl/MH7w3b
inoremap <expr> <cr> ((pumvisible())?("\<C-Y>"):("\<cr>"))
" Use <esc> to close auto-completion menu
inoremap <expr> <esc> ((pumvisible())?("\<C-e>"):("\<esc>"))

" Edit and reload init.vim quickly
nnoremap <silent> <leader>ev :edit $MYVIMRC<cr>
nnoremap <silent> <leader>sv :silent update $MYVIMRC <bar> source $MYVIMRC <bar>
    \ echomsg "Nvim config successfully reloaded!"<cr>

" TEXT MANIPULATION 
nmap <leader>x( <Plug>Delete-surrounding-(
nmap     <Plug>Delete-surrounding-( mzdi(va(p`zh
nmap <leader>x[ <Plug>Delete-surrounding-[
nmap     <Plug>Delete-surrounding-[ mzdi[va[p`zh
nmap <leader>x{ <Plug>Delete-surrounding-{
nmap     <Plug>Delete-surrounding-{ mzdi{va{p`zh

nmap <leader>( <Plug>Surround-word-with-(
nnoremap <Plug>Surround-word-with-( mzdiwi(<esc>pa)<esc>`zl
nmap <leader>[ <Plug>Surround-word-with-[
nnoremap <Plug>Surround-word-with-[ mzdiwi[<esc>pa]<esc>`zl
nmap <leader>{ <Plug>Surround-word-with-{
nnoremap <Plug>Surround-word-with-{ mzdiwi{<esc>pa}<esc>`zl


" }}}
" ============================================================================
" FUNCTIONS {{{
" ----------------------------------------------------------------------------
" Todo
" ----------------------------------------------------------------------------
function! s:todo() abort
  let entries = []
  for cmd in ['git grep -n -e TODO -e FIXME -e XXX 2> /dev/null',
            \ 'grep -rn -e TODO -e FIXME -e XXX * 2> /dev/null']
    let lines = split(system(cmd), '\n')
    if v:shell_error != 0 | continue | endif
    for line in lines
      let [fname, lno, text] = matchlist(line, '^\([^:]*\):\([^:]*\):\(.*\)')[1:3]
      call add(entries, { 'filename': fname, 'lnum': lno, 'text': text })
    endfor
    break
  endfor

  if !empty(entries)
    call setqflist(entries)
    copen
  endif
endfunction
command! Todo call s:todo()

" }}}
" ============================================================================
" PLUGINS {{{
" ============================================================================

" Enable rainbow parentheses
let g:rainbow_active = 1

" Use silver searcher instead of ack
let g:ackprg = 'ag --nogroup --nocolor --column'

" ALE Settings
let g:ale_lint_on_save = 1
let g:ale_linters = {'haskell': ['hlint']}
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

" ----------------------------------------------------------------------------
" airline
" ----------------------------------------------------------------------------

let g:airline#extensions#tabline#enabled = 1 " Enable the list of buffers
let g:airline#extensions#tabline#fnamemod = ':t' " Show the filename
let g:airline#extensions#tabline#fnamecollapse = 0
let g:airline#extensions#tabline#tab_nr_type = 1 " Show tab number
let g:airline#extensions#tabline#buffer_nr_show = 0
let g:airline#extensions#ale#enabled = 1 " ALE
let g:airline_highlighting_cache = 1
let g:airline_theme = 'gruvbox'
let g:airline_powerline_fonts = 0

" }}}
" ============================================================================
" AUTOCMD {{{
" ============================================================================

" Utility function to delete trailing white space
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc

" use it on saving 
augroup whitespace
  autocmd!
  autocmd BufWrite *.js,*.vue,*.hs,*.purs,*.ts :call DeleteTrailingWS()
augroup END

" Return to last edit position when opening files (You want this!)
augroup last_edit
  autocmd!
  autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif
augroup END

augroup vimrc
  autocmd!

  " File types
  au BufNewFile,BufRead Dockerfile* set filetype=dockerfile

  " http://vim.wikia.com/wiki/Highlight_unwanted_spaces
  au BufNewFile,BufRead,InsertLeave * silent! match ExtraWhitespace /\s\+$/
  au InsertEnter * silent! match ExtraWhitespace /\s\+\%#\@<!$/

  " Unset paste on InsertLeave
  au InsertLeave * silent! set nopaste

  " Automatic rename of tmux window
  if exists('$TMUX') && !exists('$NORENAME')
    au BufEnter * call system('tmux rename-window '.expand('%:t:S'))
    au VimLeave * call system('tmux set-window automatic-rename on')
  endif

  " Remove auto-comments
  au FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

augroup END

" More accurate syntax highlighting? (see `:h syn-sync`)
augroup accurate_syn_highlight
    autocmd!
    autocmd BufEnter * :syntax sync fromstart
augroup END

" }}}
" ============================================================================
" LANGUAGE SPECIFICS {{{
" ============================================================================

let g:haskell_tabular = 1
let g:ale_linters = {'haskell': ['hlint']}
let g:ale_haskell_ghc_options = '-fno-code -v0 -isrc'
let g:haskell_conceal_wide = 1
let g:haskell_conceal_bad = 1
let g:haskell_indent_case = 2
set tags=tags;/,codex.tags;/

augroup haskell
  autocmd!
  au FileType haskell nnoremap <buffer> <leader>? :call ale#cursor#ShowCursorDetail()<cr>
augroup END

" Haskell import sorting
noremap <silent> <Leader>si V:s/\v[^(]*\(\zs.*\ze\)/\=join(sort(split(submatch(0), '\v(\([^)]*)@<!\s*,\s*')), ', ')<CR>:noh<CR>


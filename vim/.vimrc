" vim: set foldmethod=marker foldlevel=0:
" VIM-PLUG BLOCK {{{
" ============================================================================

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

" tmux
Plug 'tpope/vim-tbone'

" Undo tree
Plug 'simnalamburt/vim-mundo'

" Tab aligning
Plug 'godlygeek/tabular'

" terminus (terminal support enhancements)
Plug 'wincent/terminus'

" Indexed search
Plug 'henrik/vim-indexed-search'

" Airline for statusbar
Plug 'vim-airline/vim-airline'

" Fix folding speed
Plug 'Konfekt/FastFold'

" git in Vim
Plug 'airblade/vim-gitgutter'

" Heuristically set buffer options
Plug 'tpope/vim-sleuth'

" Surround
Plug 'tpope/vim-surround'

" EasyMotion -- jump to words
Plug 'Lokaltog/vim-easymotion'

" Comments
Plug 'tpope/vim-commentary'

" Match everything with %
Plug 'jwhitley/vim-matchit'

" Syntax checking
Plug 'w0rp/ale'

" Javascript
Plug 'pangloss/vim-javascript'
Plug 'posva/vim-vue', { 'for': 'vue' }
Plug 'heavenshell/vim-jsdoc'
Plug 'leafgarland/typescript-vim'

" CSS
Plug 'groenewege/vim-less', { 'for': 'less' }
Plug 'JulesWang/css.vim'

" HTML
Plug 'plasticboy/vim-markdown'

" Clojure
Plug 'tpope/vim-classpath', { 'for': 'clojure' }
Plug 'guns/vim-clojure-static', { 'for': 'clojure' }
Plug 'guns/vim-sexp', { 'for': 'clojure' }
Plug 'tpope/vim-sexp-mappings-for-regular-people', { 'for': 'clojure' }

" RAINBOWS
Plug 'luochen1990/rainbow'

" Haskell
Plug 'neovimhaskell/haskell-vim', { 'for': 'haskell' }
" Plug 'enomsg/vim-haskellConcealPlus', { 'for': 'haskell' }

" Purescript
Plug 'raichoo/purescript-vim', { 'for': 'purescript' }
Plug 'FrigoEU/psc-ide-vim', { 'for': 'purescript' }
Plug 'vim-syntastic/syntastic', { 'for': 'purescript' }

" Go
Plug 'fatih/vim-go', { 'for': 'go' }

" Rust
Plug 'rust-lang/rust.vim', { 'for': 'rust' }

" fzf
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Nix
Plug 'LnL7/vim-nix'

" Terraform
Plug 'hashivim/vim-terraform'

" Color Schemes
Plug 'tyrannicaltoucan/vim-deep-space'

" Add plugins to &runtimepath
call plug#end()

" }}}
" ============================================================================
" BASIC SETTINGS {{{
" ============================================================================

let $NVIM_TUI_ENABLE_TRUE_COLOR = 1

filetype plugin indent on          " Load plugins according to detected filetype.
syntax on                          " Enable syntax highlighting.

set background=dark
set termguicolors
let g:deepspace_italics=1
colorscheme deep-space
let g:airline_theme = 'deep_space'

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

" }}}
" ============================================================================
" MAPPINGS {{{
" ============================================================================

let mapleader = "\<Space>"

" Show undo tree
nmap <silent> <leader>u :MundoToggle<CR>

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

" ALE Settings
let g:airline#extensions#ale#enabled = 1
let g:ale_lint_on_save = 1
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

" Set this. Airline will handle the rest.
let g:airline#extensions#ale#enabled = 1

" ----------------------------------------------------------------------------
" <leader>t | vim-tbone
" ----------------------------------------------------------------------------
function! s:tmux_send(dest) range
  call inputsave()
  let dest = empty(a:dest) ? input('To which pane? ') : a:dest
  call inputrestore()
  silent call tbone#write_command(0, a:firstline, a:lastline, 1, dest)
endfunction
for m in ['n', 'x']
  let gv = m == 'x' ? 'gv' : ''
  execute m."noremap <silent> <leader>tt :call <SID>tmux_send('')<cr>".gv
  execute m."noremap <silent> <leader>th :call <SID>tmux_send('.left')<cr>".gv
  execute m."noremap <silent> <leader>tj :call <SID>tmux_send('.bottom')<cr>".gv
  execute m."noremap <silent> <leader>tk :call <SID>tmux_send('.top')<cr>".gv
  execute m."noremap <silent> <leader>tl :call <SID>tmux_send('.right')<cr>".gv
  execute m."noremap <silent> <leader>ty :call <SID>tmux_send('.top-left')<cr>".gv
  execute m."noremap <silent> <leader>to :call <SID>tmux_send('.top-right')<cr>".gv
  execute m."noremap <silent> <leader>tn :call <SID>tmux_send('.bottom-left')<cr>".gv
  execute m."noremap <silent> <leader>t. :call <SID>tmux_send('.bottom-right')<cr>".gv
endfor

" ----------------------------------------------------------------------------
" airline
" ----------------------------------------------------------------------------

let g:airline#extensions#tabline#enabled = 1 " Enable the list of buffers
let g:airline#extensions#tabline#fnamemod = ':t' " Show the filename
let g:airline#extensions#tabline#fnamecollapse = 0
let g:airline#extensions#tabline#tab_nr_type = 1 " Show tab number
let g:airline#extensions#tabline#buffer_nr_show = 0

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

augroup purescript
  " autocmd!
  " au FileType purescript nmap <leader>fm :set foldmethod=manual<CR>zE<CR>
  " au FileType purescript nmap <leader>fe :set foldmethod=expr<CR>
  " au FileType purescript set foldexpr=PureScriptFoldLevel(v:lnum)
  " au FileType purescript set conceallevel=1
  " au FileType purescript set concealcursor=nvc
  " au FileType purescript syn keyword purescriptForall forall conceal cchar=∀
  " function! PureScriptFoldLevel(l)
  "   return getline(a:l) =~ "^import"
  " endfunction
augroup END

augroup vue
  autocmd! 
  au FileType vue syntax sync fromstart
augroup END

autocmd FileType haskell nnoremap <buffer> <leader>? :call ale#cursor#ShowCursorDetail()<cr>

" }}}
" ============================================================================
" LANGUAGE SPECIFICS {{{
" ============================================================================

let g:haskell_tabular = 1
let g:ale_linters = {'haskell': ['hlint']}
let g:ale_haskell_ghc_options = '-fno-code -v0 -isrc'

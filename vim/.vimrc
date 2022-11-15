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
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'mhinz/vim-signify'
Plug 'tpope/vim-surround'
Plug 'easymotion/vim-easymotion'
Plug 'jwhitley/vim-matchit'
Plug 'luochen1990/rainbow'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'jeffkreeftmeijer/vim-numbertoggle'
Plug 'mcauley-penney/tidy.nvim'
Plug 'junegunn/vim-easy-align'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'w0rp/ale'
Plug 'mileszs/ack.vim'
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
Plug 'hashivim/vim-terraform', { 'for': 'terraform' }
Plug 'nvim-lualine/lualine.nvim'
Plug 'phaazon/gruvbox'
Plug 'rebelot/kanagawa.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'mcauley-penney/tidy.nvim'
" neo-tree
Plug 'nvim-lua/plenary.nvim'
Plug 'MunifTanjim/nui.nvim'
Plug 'nvim-neo-tree/neo-tree.nvim', { 'branch': 'v2.x' }

" Add plugins to &runtimepath
call plug#end()

" }}}
" ============================================================================
" BASIC SETTINGS {{{
" ============================================================================

set background=dark
colorscheme kanagawa
set number
" Indent according to previous line.
set autoindent
" Use spaces instead of tabs.
set expandtab
" Tab key indents by 2 spaces.
set softtabstop=2
" >> indents by 2 spaces.
set shiftwidth=2
" >> indents to next multiple of 'shiftwidth'.
set shiftround

" Stores undo state even when files are closed (in undodir)
set undodir=$HOME/.vim/undo
set undofile

" Annoying temporary files
set backupdir=/tmp//,.
set directory=/tmp//,
set noswapfile

" Use ``indent`` based folding
set foldmethod=syntax

" Disable all folds on file open until `zc` or `zM` etc is used
set nofoldenable

" Start scrolling before cursor gets to the edge
set scrolloff=5
set sidescrolloff=15
set sidescroll=1

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

" neo-tree
nnoremap \| :Neotree reveal<cr>
nnoremap gd :Neotree float reveal_file=<cfile> reveal_force_cwd<cr>
nnoremap <leader>b :Neotree toggle show buffers right<cr>
nnoremap <leader>s :Neotree float git_status<cr>

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

" }}}
" ============================================================================
" AUTOCMD {{{
" ============================================================================

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
let g:haskell_indent_case = 2
set tags=tags;/,codex.tags;/

augroup haskell
  autocmd!
  au FileType haskell nnoremap <buffer> <leader>? :call ale#cursor#ShowCursorDetail()<cr>
augroup END

" Haskell import sorting
noremap <silent> <Leader>si V:s/\v[^(]*\(\zs.*\ze\)/\=join(sort(split(submatch(0), '\v(\([^)]*)@<!\s*,\s*')), ', ')<CR>:noh<CR>

au FileType markdown vmap <Leader><Bslash> :EasyAlign*<Bar><Enter>

lua << END
require('lualine').setup {
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'buffers'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  extensions = {'neo-tree', 'fzf'}
}
require('tidy').setup()
END

"------------------------------------------------------------
" New stuff I'm trying out

" Bash like tab completion for file names on new file open
set wildmode=longest,list,full
set wildmenu

" NERDTree starts up when no files are specified
" autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

"------------------------------------------------------------
" Leader Mappings
nmap <space> <leader>
nnoremap <Leader>w :w<CR>
nnoremap <Leader>q :x<CR>

" Show docs
noremap <leader>d :call <SID>show_documentation()<CR>

" Toggle NERDTree
noremap <leader>t :NERDTreeToggle<CR>

" Toggle Gitblame
noremap <leader>b :Gblame<CR>

nnoremap <C-p> :GFiles<CR>
nnoremap <C-m> :GFiles?<CR>

"------------------------------------------------------------
" General
set t_Co=256
syntax on
filetype plugin indent on
set number
set linebreak
set showbreak=+++
set textwidth=80
set showmatch
set visualbell
set hlsearch
set smartcase
set ignorecase
set incsearch
set autoindent
set smartindent
set smarttab
set softtabstop=2
set shiftwidth=2
set encoding=utf-8
set expandtab

" Advanced
set ruler
set undolevels=1000
set backspace=indent,eol,start

" Highlight Color
set hlsearch
hi Search ctermbg=DarkRed
hi Search ctermfg=White

" Cursor Line
set cursorline
hi CursorLine gui=underline cterm=underline

" Splits
nnoremap <C-J> <C-W>j
nnoremap <C-K> <C-W>k
nnoremap <C-L> <C-W>l
nnoremap <C-H> <C-W>h
set splitbelow
set splitright

" Whitespace
highlight BadWhitespace ctermbg=red guibg=red
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

"------------------------------------------------------------
" Plugins
call plug#begin('~/.vim/plugged')
Plug 'vim-airline/vim-airline' | Plug 'vim-airline/vim-airline-themes'
Plug 'universal-ctags/ctags' | Plug 'craigemery/vim-autotag'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'preservim/nerdtree'
Plug 'christoomey/vim-tmux-navigator'
Plug 'dag/vim-fish'
Plug 'tpope/vim-fugitive'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'chriskempson/base16-vim'
Plug 'psf/black', { 'branch': 'stable' }
Plug 'fisadev/vim-isort'
Plug 'airblade/vim-gitgutter'
call plug#end()

" Color theme
let base16colorspace=256
colorscheme base16-tomorrow-night

" Ctags
set tags=tags;

" Intellisense faster linting
set updatetime=100

" Tmux navigator
let g:tmux_navigator_save_on_switch = 2

" Fugitive status line (git)
set statusline+=%{FugitiveStatusline()}

" Fish
autocmd FileType fish compiler fish
autocmd FileType fish setlocal textwidth=79

if &shell =~# 'fish$'
  set shell=sh
endif

"------------------------------------------------------------
" Golang (vim-go)

" Run goimports along gofmt on each save     
let g:go_fmt_command = "goimports"

" Automatically get signature/type info for object under cursor
let g:go_auto_type_info = 1

" Making vim-go use gopls language server (don't need this. using coc.nvim for
" autocomplete for everything. gopls for specific go compilation/debugging
" let g:go_def_mode='gopls'
" let g:go_info_mode='gopls'

" disable vim-go :GoDef short cut (gd)
" this is handled by coc.nvim LanguageClient [LC]
let g:go_def_mapping_enabled = 0

"------------------------------------------------------------
" Python

" Black fmt on save
autocmd BufWritePre *.py execute ':Black'
autocmd BufWritePre *.py execute ':Isort'

" Highlighting
let python_highlight_all=1

" Indentation
au BufNewFile,BufRead *.py
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set textwidth=120 |
    \ set expandtab |
    \ set autoindent

"------------------------------------------------------------
" C++
au BufNewFile,BufRead *.cc
    \ set tabstop=2 |
    \ set softtabstop=2 |
    \ set shiftwidth=2 |
    \ set textwidth=120 |
    \ set expandtab |
    \ set autoindent

"------------------------------------------------------------
" coc.nvim for language servers

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Show docs
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

"-------------------------------------------------------------
" Install VimPlug

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif


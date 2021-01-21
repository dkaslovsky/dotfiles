set nocompatible
filetype plugin indent on

syntax on
set encoding=utf-8

set shell=/bin/zsh
 
"use jk for escape
inoremap jk <ESC>

"clipboard
if system('uname -s') == "Darwin\n"
    set clipboard=unnamed "macos
else
    set clipboard=unnamedplus "linux
endif

set modelines=0 "don't read modelines

"scrolling
"set ttyfast
"set scrolloff=3 "center cursor

"tabs
set tabstop=4
set expandtab
set smartindent
set autoindent
set shiftwidth=4

"search
set hlsearch
set incsearch
set ignorecase
set smartcase
nnoremap jk :noh<CR><CR>

set number
"set relativenumber
set ruler
set laststatus=2
set showmode
set showcmd
set visualbell
set t_Co=256
set background=dark
set cursorline
highlight CursorLine cterm=NONE ctermbg=234 ctermfg=NONE
highlight LineNr ctermfg=grey

"set spell spelllang=en_us

" No arrows for now
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

au BufNewFile,BufRead /private/**/gopass** setlocal noswapfile nobackup noundofile

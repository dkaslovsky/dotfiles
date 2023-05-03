set nocompatible
filetype plugin indent on

syntax on
set encoding=utf-8

set shell=/bin/zsh
 
"remapeescape
inoremap ;; <ESC>

"set timeoutlen=250 ttimeoutlen=0

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
nnoremap ;; :noh<CR>

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

"insert blank lines
"https://vi.stackexchange.com/questions/3875/how-to-insert-a-newline-without-leaving-normal-mode
"nnoremap <silent> oo :<C-u>call append(line("."),   repeat([""], v:count1))<CR>
"nnoremap <silent> OO :<C-u>call append(line(".")-1, repeat([""], v:count1))<CR>
nnoremap <c-p> @="m`o\eg``"<cr>
nnoremap <c-n> @="m`O\eg``k"<cr>

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

" gopass - don't leak secrets - vim on MacOS
autocmd BufNewFile,BufRead /private/**/gopass** setlocal noswapfile nobackup noundofile viminfo=""


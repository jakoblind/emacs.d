set nowrap
set linebreak
set showcmd
set ruler

set cursorline

set background=dark
syntax on
colorscheme ir_black 

set number

set shiftwidth=4
set tabstop=4
set softtabstop=4
set expandtab

set nocompatible
set modelines=0

set encoding=utf-8
set scrolloff=3
set autoindent
set showmode
set showcmd
set hidden
set wildmenu
set wildmode=list:longest
set visualbell
set cursorline
set ttyfast
set ruler
set backspace=indent,eol,start
set laststatus=2
set relativenumber

let mapleader = ","

set ignorecase
set smartcase

set incsearch
set showmatch
set hlsearch
nnoremap <leader><space> :noh<cr>
nnoremap <tab> %
vnoremap <tab> %

set wrap
set textwidth=79
set formatoptions=qrn1
set colorcolumn=85

" highlight non text chars
highlight NonText guifg=#4a4a59

" save on lost foucs
" au FocusLost * :wa

" open .vimrc in new split window
nnoremap <leader>ev <C-w><C-v><C-l>:e $MYVIMRC<cr>

" SPLIT WINDOWS
" open new and swich focus
nnoremap <leader>w <C-w>v<C-w>l
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

command NE NERDTreeToggle

" Init
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

if empty(glob('~/.vim/colors/apprentice.vim'))
    silent !curl -fLo ~/.vim/colors/apprentice.vim --create-dirs
        \ https://raw.githubusercontent.com/romainl/Apprentice/master/colors/apprentice.vim
endif

" Important
set nocompatible
let &t_Co=256
colorscheme apprentice

" Plugins
call plug#begin('~/.vim/plugged')
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'scrooloose/syntastic'
Plug 'rust-lang/rust.vim'
call plug#end()

" General
set history=1000
set ffs=unix,dos,mac
set isk+=_,$,@,%,# " Remove these characters from word dividers
set nosol

" Vim UI
set backspace=2 " Normal backspace
set cmdheight=1 " Set command bar line to 1 high
set cursorline
set list " Show tabs
set listchars=tab:>-,trail:- " Mark tabs and trailing whitespace
set lz " LazyRedraw
set mouse=a " Allow mouse use
set noerrorbells
set number " Line numbers
set report=0
set shortmess=atI " Shorten messages
set so=10
set whichwrap+=<,>,h,l  " Let backspace and cursor keys wrap
let g:airline_powerline_fonts = 1
let g:airline_theme='bubblegum'

" Cues
set incsearch
set laststatus=2
set nohlsearch
set novisualbell
set showmatch " Highlight matching brackets

" Indent fixes
set ai
set cindent
set copyindent
set nosi
set shiftwidth=4
set softtabstop=4
set tabstop=4
filetype plugin indent on

" Text related
set completeopt=menu,longest,preview
set expandtab
set ignorecase
set nowrap
set preserveindent
set shiftround
set smartcase


au BufRead,BufNewFile *.rb,*.erb set tabstop=2
au BufRead,BufNewFile *.rb,*.erb set shiftwidth=2
au BufRead,BufNewFile *.rb,*.erb set softtabstop=2
au FileType python set omnifunc=pythoncomplete#Complete
au FileType c set omnifunc=ccomplete#Complete

syntax on

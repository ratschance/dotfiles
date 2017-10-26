" Init
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

if empty(glob('~/.vim/colors/apprentice.vim'))
    silent !curl -fLo ~/.vim/colors/apprentice.vim --create-dirs
        \ https://raw.githubusercontent.com/romainl/Apprentice/master/colors/apprentice.vim
endif

if empty(glob('~/.vim/colors/solarized8_dark.vim'))
    silent !curl -fLo ~/.vim/colors/solarized8_dark.vim --create-dirs
        \ https://raw.githubusercontent.com/lifepillar/vim-solarized8/master/colors/solarized8_dark.vim
endif

" Important
set nocompatible
let &t_Co=256
"set background=dark
colorscheme solarized8_dark

" Plugins
call plug#begin('~/.vim/plugged')
Plug 'airblade/vim-gitgutter'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'rust-lang/rust.vim'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-fugitive'
Plug 'w0rp/ale'
call plug#end()

" General
set history=1000
set ffs=unix,dos,mac
set isk+=_,$,@,%,# " Remove these characters from word dividers
set nosol
imap jk <Esc>

" Vim UI
set backspace=2 " Normal backspace
set cmdheight=1 " Set command bar line to 1 high
set cursorline
set list " Show tabs
set listchars=tab:>·,trail:· " Mark tabs and trailing whitespace
set lz " LazyRedraw
set mouse=a " Allow mouse use
set noerrorbells
set report=0
set rnu " Relative line numbers
set shortmess=atI " Shorten messages
set so=10
set whichwrap+=<,>,h,l  " Let backspace and cursor keys wrap

" Cues
set incsearch
set laststatus=2
set nohlsearch
set novisualbell
set showmatch " Highlight matching brackets

" Wildmenu
set wildmenu
set wildmode=list:longest,full
set wildignore=*.o,*~,.git

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

" Lightline
" Next few functions from github.com/statico/dotfiles
let g:lightline = {
            \ 'colorscheme': 'jellybeans',
            \ 'active': {
            \   'left': [['mode', 'paste'], ['filename', 'modified']],
            \   'right': [['lineinfo'], ['percent', 'filetype'], ['readonly', 'linter_warnings', 'linter_errors', 'linter_ok']]
            \ },
            \ 'component_expand': {
            \   'linter_warnings': 'LightlineLinterWarnings',
            \   'linter_errors': 'LightlineLinterErrors',
            \   'linter_ok': 'LightlineLinterOK'
            \ },
            \ 'component_type': {
            \   'readonly': 'error',
            \   'linter_warnings': 'warning',
            \   'linter_errors': 'error'
            \ },
            \}

function! LightlineLinterWarnings() abort
    let l:counts = ale#statusline#Count(bufnr(''))
    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_non_errors = l:counts.total - l:all_errors
    return l:counts.total == 0 ? '' : printf('%d ◆', all_non_errors)
endfunction

function! LightlineLinterErrors() abort
    let l:counts = ale#statusline#Count(bufnr(''))
    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_non_errors = l:counts.total - l:all_errors
    return l:counts.total == 0 ? '' : printf('%d Ж', all_errors)
endfunction

function! LightlineLinterOK() abort
    let l:counts = ale#statusline#Count(bufnr(''))
    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_non_errors = l:counts.total - l:all_errors
    return l:counts.total == 0 ? '✓ ' : ''
endfunction

autocmd User ALELint call lightline#update()

"Ale
let g:ale_sign_warning='◆'
let g:ale_sign_error='Ж'
highlight link ALEWarningSign String
highlight link ALEErrorSign Title

"GitGutter
let g:gitgutter_sign_added='·'
let g:gitgutter_sign_modified='·'
let g:gitgutter_sign_removed='·'
let g:gitgutter_sign_modified_removed='·'


au BufRead,BufNewFile *.rb,*.erb set tabstop=2
au BufRead,BufNewFile *.rb,*.erb set shiftwidth=2
au BufRead,BufNewFile *.rb,*.erb set softtabstop=2
au BufRead,BufNewFile *.adoc set filetype=asciidoc
au FileType python set omnifunc=pythoncomplete#Complete
au FileType c set omnifunc=ccomplete#Complete

command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)

syntax on

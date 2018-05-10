" Init
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

if empty(glob('~/.vim/colors/apprentice.vim'))
    silent !curl -fLo ~/.vim/colors/apprentice.vim --create-dirs
        \ https://raw.githubusercontent.com/romainl/Apprentice/master/colors/apprentice.vim
endif

if empty(glob('~/.vim/colors/solarized.vim'))
    silent !curl -fLo ~/.vim/colors/solarized.vim --create-dirs
        \ https://raw.githubusercontent.com/altercation/vim-colors-solarized/master/colors/solarized.vim
endif

" Important
set nocompatible
let &t_Co=256
set background=dark
colorscheme solarized

" Plugins
call plug#begin('~/.vim/plugged')
Plug 'airblade/vim-gitgutter'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'majutsushi/tagbar'
Plug 'rust-lang/rust.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-fugitive'
Plug 'w0rp/ale'
call plug#end()

" General
set history=1000
set ffs=unix,dos,mac
set isk+=_,$,@,%,# " Remove these characters from word dividers
set nosol
imap jk <Esc> " Rapidly hitting jk in insert mode will act as esc

" Vim UI
set backspace=2 " Normal backspace
set cmdheight=1 " Set command bar line to 1 high
set cursorline
set list " Show whitespace
set listchars=tab:>·,trail:· " Mark tabs and trailing whitespace
set lz " LazyRedraw
set mouse=a " Allow mouse use
set noerrorbells
set report=0
set nu " Absolute line numbers
set rnu " Relative line numbers for all but current line
set shortmess=atI " Shorten messages
set so=10
set whichwrap+=<,>,h,l  " Let backspace and cursor keys wrap
let &colorcolumn="80,".join(range(120,999),",")

"window settings
nmap <silent> <Up> :wincmd k<CR>
nmap <silent> <Down> :wincmd j<CR>
nmap <silent> <Left> :wincmd h<CR>
nmap <silent> <Right> :wincmd l<CR>

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
set autoindent
set expandtab
set copyindent
set preserveindent
set shiftwidth=4
set softtabstop=4
set tabstop=4
filetype plugin indent on

" Text related
set completeopt=menu,longest,preview
set ignorecase
set nowrap
set shiftround
set smartcase

"spelling
if has("spell")
    au BufRead,BufNewFile *.adoc,*.asciidoc,*.md set spell
    set spelllang=en_us
    set spellfile=~/.vimspell.add  " Extra dictionary for user defined words

    " highlight spell errors
    highlight SpellErrors ctermfg=Red cterm=underline term=reverse
    highlight SpellBad ctermfg=NONE ctermbg=NONE cterm=underline,bold
    highlight SpellCap ctermfg=NONE ctermbg=NONE cterm=underline,bold
    highlight SpellLocal ctermfg=NONE ctermbg=NONE cterm=underline,bold
    highlight MatchParen cterm=bold ctermfg=NONE ctermbg=NONE

    set sps=best,10
    set omnifunc=ccomplete#Complete
endif

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
    return l:counts.total == 0 ? '' : printf('%d ✗', all_errors)
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
let g:ale_sign_error='✗'
highlight link ALEWarningSign String
highlight link ALEErrorSign Title

"GitGutter
let g:gitgutter_sign_added='·'
let g:gitgutter_sign_modified='·'
let g:gitgutter_sign_removed='·'
let g:gitgutter_sign_modified_removed='·'

"NerdCommenter
let g:NERDSpaceDelims = 1
let g:NERDCompactSexyComs = 1
let g:NERDCommentEmptyLines = 1

"NerdTree
map <C-n> :NERDTreeToggle<CR>

"TagBar
map <F8> :TagbarToggle<CR>

au BufRead,BufNewFile *.rb,*.erb set tabstop=2 shiftwidth=2 softtabstop=2
au BufRead,BufNewFile *.py set tabstop=4 shiftwidth=4 softtabstop=4
au BufRead,BufNewFile *.c,*.h,*.dts,*.dtsi set noet " Tabs by default in these files
au BufRead,BufNewFile *.adoc set filetype=asciidoc
au BufWritePost *.adoc silent !adoc.py <afile>:p

syntax on

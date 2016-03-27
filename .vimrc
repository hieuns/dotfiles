"--------------------------------- VUNDLE --------------------------------------

set nocompatible
filetype off

set runtimepath+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-fugitive'                     " git interface
Plugin 'scrooloose/nerdtree'                    " file system
Plugin 'nvie/vim-flake8'                        " python syntax checker
Plugin 'vim-scripts/indentpython.vim'
Plugin 'scrooloose/syntastic'
Plugin 'davidhalter/jedi-vim'                   " auto-completion stuff
Plugin 'manhhomienbienthuy/candy.vim'           " Colors!!!
Plugin 'bling/vim-airline'                      " Status line
Plugin 'tpope/vim-rails'                        " Rails.vim
Plugin 'kchmck/vim-coffee-script'               " Coffeescript
Plugin 'slim-template/vim-slim'                 " Slim template
call vundle#end()

"------------------------------ CUSTOMIZATION ----------------------------------

filetype plugin indent on                       " enables file type detection
set backspace=indent,eol,start                  " make backspaces more powerful
let NERDTreeIgnore=[
    \ '\.pyc$',
    \ '\~$',
    \ '__pycache__',
    \ '.git'
    \ ]                                         " ignore files in NERDTree
set noswapfile                                  " I don't like swap files
set number                                      " turn on numbering
set viminfo=                                    " don't use or save .viminfo
set laststatus=2                                " Show status line
set hlsearch                                    " highlight for search
set scrolloff=5                                 " keep 5 lines around the cursor
set splitbelow                                  " Open new split panes to bottom
set splitright                                  " Open new split panes to right

"-------------------------------- CUSTOM KEYBOARD ------------------------------

" unset the last search pattern
nnoremap <F3> :noh<CR>
" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
" F2 before pasting to preserve indentation
set pastetoggle=<F2>

"------------------------------- VISUAL DISPLAY --------------------------------

if &t_Co < 256
  set t_Co=256
endif

if has('gui_running')
  colorscheme candy
  set guioptions-=T                             " Remove tool bar
  set mouse=                                    " Do not use mouse
  if has("gui_macvim")
    set guifont=Menlo:h15
  else
    set guifont=Droid\ Sans\ Mono\ 11           " Set font
  endif
endif

set fillchars=                                  " Remove chars in split line
highlight VertSplit
    \ cterm=None
    \ ctermbg=lightblue                         " Change splitline color
highlight LineNr ctermfg=darkgrey               " line number coloring

"------------------------------ INDENT & FORMAT --------------------------------

set expandtab                                   " spaces for indents
set tabstop=8
set softtabstop=2
set shiftwidth=2
set textwidth=80
set fileformat=unix                             " Use UNIX (\n) line endings.
set encoding=utf-8                              " Default file encode UTF-8
set autoindent                                  " Keep indentation level

highlight BadWhitespace
    \ ctermbg=red
    \ guibg=red                                 " Display bad whitespace
match BadWhitespace /^\t\+/                     " Flag tabs at the beginning
match BadWhitespace /\s\+$/                     " Flag trailing whitespace

let python_highlight_all=1                      " For full syntax highlighting
syntax enable

"--------------------- SETTING FOR SPECIFIC LANGUAGE ---------------------------

let g:syntastic_python_python_exec='python3'    " Python 3 syntastic
autocmd FileType python,vim setlocal
    \ shiftwidth=4
    \ softtabstop=4
autocmd FileType python setlocal textwidth=79   " Python PEP 8
autocmd BufNewFile,BufRead *.md set
    \ filetype=markdown                         " .md file is markdown
autocmd FileType markdown setlocal
    \ textwidth=72
    \ spell
    \ spelllang=en,vi                           " Check spell

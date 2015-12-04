"--------------------------------- VUNDLE --------------------------------------

set nocompatible
filetype off

set runtimepath+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

" git interface
Plugin 'tpope/vim-fugitive'

" filesystem
Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'kien/ctrlp.vim'

" html
Plugin 'isnowfy/python-vim-instant-markdown'
Plugin 'jtratner/vim-flavored-markdown'
Plugin 'suan/vim-instant-markdown'
Plugin 'nelstrom/vim-markdown-preview'

" python sytax checker
Plugin 'nvie/vim-flake8'
Plugin 'vim-scripts/Pydiction'
Plugin 'vim-scripts/indentpython.vim'
Plugin 'scrooloose/syntastic'

" auto-completion stuff
" Plugin 'klen/python-mode'
Plugin 'Valloric/YouCompleteMe'
Plugin 'klen/rope-vim'
" Plugin 'davidhalter/jedi-vim'
Plugin 'ervandew/supertab'

" code folding
Plugin 'tmhedberg/SimpylFold'

" Colors!!!
Plugin 'altercation/vim-colors-solarized'
Plugin 'jnurmine/Zenburn'

" Status line
Plugin 'bling/vim-airline'

" Rails.vim
Plugin 'tpope/vim-rails'

" Coffeescript
Plugin 'kchmck/vim-coffee-script'

call vundle#end()

"------------------------------ CUSTOMIZATION ----------------------------------

filetype plugin indent on                       " enables filetype detection
set backspace=indent,eol,start                  " make backspaces more powerfull
set foldmethod=indent                           " Folding based on indentation
let g:SimpylFold_docstring_preview=1            " view docstring when folding
let g:ycm_autoclose_preview_window_after_completion=1             " autocomplete
let NERDTreeIgnore=['\.pyc$', '\~$', '__pycache__', '.git']       " ignore files
set noswapfile                                  " I don't like swap files
set number                                      " turn on numbering
set viminfo=                                    " don't use or save .viminfo
set laststatus=2                                " Show status line
set hlsearch                                    " highlight for search
set scrolloff=5                                 " keep 5 lines around the cursor

"-------------------------------- CUSTOM KEYBOARD ------------------------------

" use space to open folds
nnoremap <space> za
" unsets the last search pattern
nnoremap <F3> :noh<CR>

let mapleader=" "
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>

"------------------------------- VISUAL DISPLAY --------------------------------

set t_Co=256
if has('gui_running')
    set background=dark
    colorscheme solarized
endif
call togglebg#map("<F5>")
" colorscheme zenburn
" set guifont=Monaco:h14

highlight LineNr ctermfg=darkgrey               " line number coloring
let g:airline_theme='light'                     " set theme for vim-airline
highlight Folded ctermbg=blue                   " color of folded code

"------------------------------ INDENT & FORMAT --------------------------------

set expandtab             " spaces for indents
set tabstop=2
set softtabstop=2
set shiftwidth=2
set textwidth=80
set fileformat=unix       " Use UNIX (\n) line endings.
set encoding=utf-8        " Set the default file encoding to UTF-8
set autoindent            " Keep indentation level from previous line

" display bad whitespace is desired
highlight BadWhitespace ctermbg=red guibg=red
match BadWhitespace /^\t\+/   " Display tabs at the beginning of a line as bad
match BadWhitespace /\s\+$/   " Make trailing whitespace be flagged as bad

" For full syntax highlighting:
let python_highlight_all=1
syntax enable

"----------------------------- SETTING FOR PYTHON ------------------------------

autocmd FileType python setlocal
    \ tabstop=4
    \ shiftwidth=4
    \ softtabstop=4
    \ textwidth=79                                                " Python PEP 8
let g:pydiction_location='~/.vim/bundle/Pydiction/complete-dict'  " Pydiction
let g:syntastic_python_python_exec='python3'                      " Py3syntastic

" python with virtualenv support
py << EOF
import os
import sys
import vim
if 'VIRTUAL_ENV' in os.environ:
    base = os.environ['VIRTUAL_ENV']
    sys.path.insert(0, base)
    old_os_path = os.environ['PATH']
    os.environ['PATH'] = os.path.join(base, 'bin') + os.pathsep + old_os_path
    if sys.platform == 'win32':
        site_packages = os.path.join(base, 'Lib', 'site-packages')
    else:
        site_packages = os.path.join(
            base, 'lib', 'python%s' % sys.version[:3], 'site-packages')
    prev_sys_path = list(sys.path)
    import site
    site.addsitedir(site_packages)
    sys.real_prefix = sys.prefix
    sys.prefix = base
    # Move the added items to the front of the path:
    new_sys_path = []
    for item in list(sys.path):
        if item not in prev_sys_path:
            new_sys_path.append(item)
            sys.path.remove(item)
    sys.path[:0] = new_sys_path
EOF

"-------------------------- SETTING FOR MARKDOWN -------------------------------

autocmd BufNewFile,BufRead *.md set filetype=markdown     " .md is markdown file
autocmd FileType markdown setlocal textwidth=72           " line length is 72

"------------------------- SETTING FOR SHELL SCRIPT ----------------------------

autocmd FileType sh setlocal
    \ shiftwidth=4
    \ tabstop=4
    \ softtabstop=4                                 " Indent for shell scripting

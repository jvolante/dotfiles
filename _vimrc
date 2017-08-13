" get out of vi-compatible mode and don't use local .vimrc
set noexrc
set nocompatible

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" PLUGINS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use a different pluggins directory on Windows vs. Linux
if has("win32") || has("win64")
    "Be pretty on Windows
    set renderoptions=type:directx,geom:1,renmode:5,taamode:1
    call plug#begin('~/vimfiles/bundle')
else
    set antialias " Be pretty
    call plug#begin('~/.vim/bundle')
endif

if v:version >= 704 || has('nvim')
    Plug 'valloric/youcompleteme'
    Plug 'sirver/ultisnips'
    Plug 'honza/vim-snippets'
endif

if v:version >= 800 || has('nvim')
    Plug 'w0rp/ale'
endif

Plug 'bling/vim-bufferline'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-fugitive'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'easymotion/vim-easymotion'
Plug 'terryma/vim-multiple-cursors'
Plug 'xuyuanp/nerdtree-git-plugin'
Plug 'airblade/vim-gitgutter'
Plug 'majutsushi/tagbar'
Plug 'bling/vim-airline'
Plug 'sjl/gundo.vim'
Plug 'junegunn/goyo.vim'
Plug 'tyrannicaltoucan/vim-quantum'
Plug 'junegunn/vim-easy-align'

call plug#end() " required
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" END PLUGINS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let base16colorspace=256
filetype indent plugin on       " Filetype specific indents
syntax on                       " Filetype specific syntax highlighting
set t_Co=256                    " Set terminal color depth
set whichwrap=b,s,h,l,<,>,~,[,] " Everything wraps
set encoding=utf-8              " Be 21st century
set nu                          " show line numbers
set hidden                      " Treat tabs like other editors
set showcmd                     " Show multiple commands in command line
set hlsearch                    " Highlight search
set ignorecase                  " Ignore the case of search
set smartcase                   " Only care about case if there are caps
set autoindent                  " Automatically indent
set backspace=indent,eol,start  " Back space is more intuitive
set mouse=a                     " Allow use of mouse
set ttymouse=xterm2             " Makes mouse work in everything
set cursorline                  " Highlight current line
set shiftwidth=4                " Tab width
set softtabstop=4               " Tab width
set incsearch                   " Start searching when you start typing
set showcmd                     " Show matching brackets
set expandtab                   " No real tabs(spaces instead)
set scrolloff=2                 " Screen automatically scrolls with cursor
set lazyredraw                  " Redraw only when needed
set foldmethod=syntax           " Fold based on syntax elemetnts (like most editors)
set noshowmode                  " Don't do what Airline already does for us
set list                        " Enable listchars

" Sometimes I need to use an old crappy vim (work) so be ready for that
if v:version >= 704
    set breakindent             " Make wrapped lines indent to the same position
endif

" How to render non printable characters
set listchars=nbsp:¬,extends:»,precedes:«

" Make the Statusline nice
let g:bufferline_echo = 0

if has('gui_running')
    set guifont=Operator_Mono_Light:h11:cANSI " Set the font
    let g:quantum_italics=1  " Italic comments

    "hide toolbars and sidebar
    set guioptions-=m  "remove menu bar
    set guioptions-=T  "remove toolbar
    set guioptions-=r  "remove right-hand scroll bar
    set guioptions-=L  "remove left-hand scroll bar
else
    let g:gruvbox_italic=0   " Fixes gruvbox comment highlight issue
    let g:quantum_italics=0  " Fixes quantum comment highlight issue
    let g:molokai_original=1 " Fixes molokai colors

    " Make line numbers a light grey that's easier to see
    autocmd! ColorScheme * highlight LineNr ctermfg=grey
endif

" Set up the colorscheme
set background=dark
let g:airline_theme='quantum'
colorscheme quantum

" Automatically blow away trailing whitespace on certian filetypes
autocmd Filetype c,cpp,java,php,js autocmd BufWritePre <buffer> %s/\s\+$//e

" For some reason whenever I try to do a write I always have a W instead of w
command W w
command Wq wq

" Remap leader to ','
let mapleader=","

" Easy spit navigation
nnoremap <C-h> <C-W>h
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-l> <C-W>l

" Remap no hlsearch to space
nnoremap <leader><space> :nohlsearch<CR>

" Shortcut for pasting yanked words without overwriting buffer
nnoremap <leader>p ciw<C-r>0<ESC>

" Copy/paste to clipboard in gvim. May not work on all OS's
nnoremap <leader>gy "+y
nnoremap <leader>gp "+gP

" Move vertically by visual line instead of line number
nnoremap j gj
nnoremap k gk

" Easyalign
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" Gundo
nnoremap <F5> :GundoToggle<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" CtrlP stuff
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" See buffers
nmap <leader>pb :CtrlPBuffer<cr>
" See buffers and file system
nmap <leader>pm :CtrlPMixed<cr>
" See most recently used files
nmap <leader>pr :CtrlPMRU<cr>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" End ctrlP stuff
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" Ultisnips stuff
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
try
    let g:UltiSnipsExpandTrigger="<C-f>"
    let g:UltiSnipsJumpForwardTrigger="<C-v>"
    let g:UltiSnipsJumpBackwardTrigger="<C-c>"

    let g:UltisnipsEditSplit="vertical"
catch
endtry
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" End Ultisnips stuff
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" YouCompleteMe stuff
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
try
    let g:ycm_python_binary_path = 'python'
    let g:ycm_seed_identifiers_with_syntax = 1
catch
endtry
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" End YouCompleteMe stuff
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"NerdTree stuff ----------------------------------------------------------------
"auto open NERDTree on startup
"autocmd vimenter * NERDTree
"start focus in other window
"autocmd vimenter * wincmd p
"autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
"exit vim if nerdtree is the last window
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
"open nerdtree in the pwd
autocmd BufEnter * if &ft !~ '^nerdtree$' | silent! lcd %:p:h | endif
"map nerdTree to ctrl-b
map <C-b> :NERDTreeToggle<CR>

" Git stuff for nerdtree
let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "?",
    \ "Staged"    : "?",
    \ "Untracked" : "?",
    \ "Renamed"   : "?",
    \ "Unmerged"  : "-",
    \ "Deleted"   : "?",
    \ "Dirty"     : "?",
    \ "Clean"     : "??",
    \ "Unknown"   : "?"
    \ }

"end nerdtree ------------------------------------------------------------------

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set up ALE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
try
    packloadall
    silent! helptags ALL
    let g:airline#extensions#ale#enabled = 1
catch
endtry

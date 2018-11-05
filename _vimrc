" Get out of vi-compatible mode and don't use local .vimrc
set noexrc
set nocompatible

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" PLUGINS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has("win32") || has("win64")
    " Be pretty on Windows
    set renderoptions=type:directx,geom:1,renmode:5,taamode:1

    " Use a different pluggins directory on Windows vs. Linux
    call plug#begin('~/vimfiles/bundle')
else
    if !has('nvim')
        set antialias " Be pretty
    endif

    if !isdirectory("/tmp/vim-undo-dir")
        call mkdir("/tmp/vim-undo-dir", "", 0770)
    endif

    " Undo files are stored away from working files
    set undodir=/tmp/vim-undo-dir

    " Use a different pluggins directory on Windows vs. Linux
    call plug#begin('~/.vim/bundle')
endif

Plug 'tpope/vim-eunuch'             " Some Unix commands on the Vim CLI
Plug 'tpope/vim-fugitive'           " Git integration
Plug 'ctrlpvim/ctrlp.vim'           " Ctrlp like in modern editors
Plug 'easymotion/vim-easymotion'    " Better motions for complex operations
Plug 'terryma/vim-multiple-cursors' " For Atom/VsCode like multi cursor mode
Plug 'mhinz/vim-signify'            " For Git diff in the gutter
Plug 'majutsushi/tagbar'            " For IDE like jump to function/class def
Plug 'bling/vim-airline'            " Better statusline
Plug 'junegunn/vim-easy-align'      " Auto align on characters (eg =)
Plug 'tpope/vim-commentary'         " Comment toggling hotkeys
Plug 'hdima/python-syntax'          " Better python syntax highlighting
Plug 'tmhedberg/simpylfold'         " Better syntax based folding in python
Plug 'rhysd/vim-color-spring-night' " spring-night colorscheme
Plug 'tyrannicaltoucan/vim-quantum' " quantum colorscheme
Plug 'justinmk/vim-sneak'           " The sneak motion (2 char f)
Plug 'travisjeffery/vim-auto-mkdir' " Automatically create directories
Plug '907th/vim-auto-save'          " Autosave on edit
Plug 'linkinpark342/xonsh-vim'      " Xonsh syntax higlighting

if has('python3') || has('python')
    Plug 'sjl/gundo.vim'            " Full tree based undo in vim
endif

if v:version >= 800 || has('nvim')
    Plug 'w0rp/ale'                 " Asynchronous linting

    if has('python3')
        Plug 'shougo/deoplete.nvim' " Asynchronous autocomplete
        Plug 'sirver/ultisnips'     " Snippet framework for autocomplete
        Plug 'honza/vim-snippets'   " Snippets for vimscript
    endif
endif

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
set cursorline                  " Highlight current line
set shiftwidth=4                " Tab width
set softtabstop=4               " Tab width
set tabstop=4                   " Tab width
set incsearch                   " Start searching when you start typing
set showcmd                     " Show matching brackets
set expandtab                   " No real tabs(spaces instead)
set smarttab                    " Shiftwidth is separate from softtabstop
set scrolloff=5                 " Screen automatically scrolls with cursor
set lazyredraw                  " Redraw only when needed
set foldmethod=syntax           " Fold based on syntax elemetnts
set noshowmode                  " Don't do what Airline already does for us
set undofile                    " Persist undo tree between runs
set autoread                    " Automatically reload file if it changes
let g:auto_save=1               " Autosave files

if !has('nvim')
    set ttymouse=xterm2             " Makes mouse work in everything
endif

" Ignore a bunch of not human readable stuff from autocomplete
set wildignore+=*/.git/*,*.swp,*.pkl

if v:version >= 800 || has('nvim')
    " When a line wraps keep the current indent
    set breakindent
endif

if v:version >= 703 || has('nvim')
    " Line at 80 characters
    autocmd BufEnter * set colorcolumn=81
    " On current buffer only
    autocmd BufLeave * set colorcolumn=
endif

" Make the Statusline nice
let g:bufferline_echo = 0

set background=dark
if has('gui_running')
    set guifont=Fira\ Code\ weight=453\ 12 " Set the font
    "let g:quantum_italics=1  " Italic comments

    "hide toolbars and sidebar
    set guioptions-=m  "remove menu bar
    set guioptions-=T  "remove toolbar
    set guioptions-=r  "remove right-hand scroll bar
    set guioptions-=L  "remove left-hand scroll bar
endif

colorscheme spring-night " Set the colorscheme

" Automatically blow away trailing whitespace on certian filetypes
"autocmd Filetype c,cpp,java,php,js,python autocmd BufWritePre <buffer> %s/\s\+$//e

" For some reason whenever I try to do a write I always have a W instead of w
" Surround these with try/catch so it doesn't complain when I source .vimrc
try
    command W w
    command Wq wq
catch
endtry

" Remap leader to ','
let mapleader=","

" Easy spit navigation
nnoremap <C-h> <C-W>h
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-l> <C-W>l

" Clipboard yank and paste
nnoremap <leader>y "+y
nnoremap <leader>p "+p

" Y works in a more consistent fashion
nnoremap Y y$

" Remap no hlsearch to space
nnoremap <leader><space> :nohlsearch<CR>

" Shortcut for replacing the word we are over with yanked words
nnoremap <leader>p ciw<C-r>0<ESC>

" Copy/paste to clipboard in gvim. May not work on all OS's
nnoremap <leader>gy "+y
nnoremap <leader>gp "+gP

" Tagbar
nmap <F8> :TagbarToggle<CR>

" Easyalign
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" Gundo
nnoremap <leader>u :GundoToggle<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" CtrlP stuff
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" See buffers
nmap <leader>pb :CtrlPBuffer<cr>
" See buffers and file system
nmap <leader>pm :CtrlP<cr>
" See most recently used files
nmap <leader>pr :CtrlPMRU<cr>

" Default to mixed mode
let g:ctrlp_cmd='CtrlPMixed'

" Ignore certain stuff
let g:ctrlp_custom_ignore={
    \ 'dir': '\.git$\|\.hg$\|\.svn$\|\.yardoc\|public\/images\|public\/system|data\|log\|tmp$',
    \ 'file': '\.exe$\|\.so$\|\.lib$\|\.dat$'
    \ }

" if RipGrep is available, use it because it is faster than grep
if executable('rg')
    set grepprg=rg\ --color=never
    let g:ctrlp_user_command = 'rg %s --files --color=never --glob ""'
    let g:ctrlp_use_caching = 5000
endif
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" End CtrlP stuff
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
" Set up ALE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
try
    packloadall
    "silent! helptags ALL
    let g:ale_lint_delay=500 " Trying to fix performance issues
    let g:airline#extensions#ale#enabled = 0
    let g:ale_python_flake8_executable = 'python3'
    let g:ale_python_flake8_options = '-m flake8 --ignore=E501'
    let g:ale_set_balloons = 0 " Disable obnoxious hovering tooltips
catch
endtry
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" End ALE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set up sneak
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" End sneak
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set up airline
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:airline#extensions#hunks#enabled = 0
let g:airline_powerline_fonts = 1
let g:airline_left_sep = ''
let g:airline_right_sep = ''
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" End airline
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set up multiple-cursors
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


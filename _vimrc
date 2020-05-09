""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Michael Rogers .vimrc
"  - Used with terminal vim, gvim, and neovim-qt on Windows
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim Plugins with Vim-Plug - run PlugInstall and PlugClean
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin('~/.vim/plugged')
    " General functionality
    Plug 'preservim/nerdtree'           " File browser 
    Plug 'dreadnaut/vim-bargreybars'    " Fix gvim fullscreen white border
    Plug 'tpope/vim-surround'           " Surround operator
    Plug 'tpope/vim-commentary'         " Comment operator (gcc)
    Plug 'tpope/vim-repeat'             " Make . better for plugins
    Plug 'junegunn/vim-easy-align'      " Easily align stuff 
    Plug 'godlygeek/tabular'            " Another alignment tool
    Plug 'panozzaj/vim-autocorrect'     " Fix common typos

    " Aesthetic
    Plug 'morhetz/gruvbox'              " Colorscheme gruvbox
    Plug 'vim-airline/vim-airline'      " Fancy statusline
    Plug 'junegunn/goyo.vim'            " Distraction-free writing

    " Python specific
    Plug 'vim-python/python-syntax'     " Better python syntax
    Plug 'vim-scripts/indentpython.vim' " Better python autoindent
    Plug 'nvie/vim-flake8'              " Python linting on F7
    Plug 'tmhedberg/SimpylFold'         " Better python folding

    " Markdown specific 
    Plug 'vimwiki/vimwiki'               " vimwiki
    Plug 'gpanders/vim-medieval'         " Run code blocks to fill others
    Plug 'masukomi/vim-markdown-folding' " Folding for md files 
    Plug 'mzlogin/vim-markdown-toc'      " Generate TOC with :GenTocGFM
    Plug 'ferrine/md-img-paste.vim'      " Paste image into md
    Plug 'iamcco/markdown-preview.vim'   " Preview Markdowns

    " Other
    Plug 'vim-jp/vim-cpp'               " Better c/cpp syntax
call plug#end()


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General Settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has('gui_running')
    colorscheme gruvbox
else
    colorscheme desert
endif

syntax on                       " Highlight syntax
set scrolloff=4                 " Always have at least 4 lines
set autoread                    " Automatically load external file changes
set wildmenu                    " Set command menu autocomplete
set vb t_vb=                    " No annoying beeping
set laststatus=2                " StatusLine
set updatetime=500              " Write swap file after 500ms
set relativenumber              " Relative number lines
set number                      " Show current line number
set textwidth=79                " Lines 79 characters long
set backspace=indent,eol,start  " Use traditional backspaces
set clipboard=unnamed           " Use system clipboard
set pythonthreedll=python37.dll " Add python3 support to gvim
set tabstop=4                   " 4 spaces default
set softtabstop=4
set shiftwidth=4
set expandtab                   " Spaces replace tabs
set autoindent                  " Autoindent new line
set splitbelow                  " Open splits below
set splitright                  " Open splits to the right
set fileencoding=utf-8          " utf-8 files

set guicursor=i-c:ver18-Search  " Custom cursor
set guicursor=o:block-Search
set guicursor=r:hor15-Search
set guicursor=a:blinkwait0      " No cursor blinking

set fillchars+=vert:\           " Empty dividers for nicer looking splits
hi LineNr guibg=bg
hi foldcolumn guibg=bg
hi VertSplit guibg=bg guifg=bg

set foldmethod=expr             " Fold based on syntax of language

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Keybindings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Map leader
let mapleader = ","

" Ctrl+S to save
" map <C-S> :call popup_dialog('Continue? y/n', #{
"                 \ filter: 'popup_filter_yesno',})<CR>

" Ctrl+Q to close
map <C-Q> :q<CR>

" Space to toggle folds
nnoremap <space> za

" Exit modes with chord
inoremap jk <ESC>
inoremap kj <ESC>
cnoremap jk <ESC>
cnoremap kj <ESC>
tnoremap jk <C-\><C-n>
tnoremap kj <C-\><C-n>

" More terminal interaction
tnoremap <C-S> <C-\><C-n>

" Navigate tabs with H and L
nnoremap H gT
nnoremap L gt

" Move between wrapped lines easily by remapping j and k
nnoremap <expr> j v:count ? 'j' : 'gj'
nnoremap <expr> k v:count ? 'k' : 'gk'

" Move between splits with ctrl hjkl
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" c then ctrl hjkl opens a new blank split
nnoremap c<C-J> :bel sp new<CR>
nnoremap c<C-K> :abo sp new<CR>
nnoremap c<C-L> :rightb vsp new<CR>
nnoremap c<C-H> :lefta vsp new<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Autocommands
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Automatic line wrapping
set wrap
augroup nowraps
    autocmd BufNewFile,BufRead *.html setlocal nowrap
    autocmd BufNewFile,BufRead *.bat setlocal nowrap
augroup END

" Some files need 2 space tabs
augroup auto_tabs
    au BufNewFile,BufRead *.js, *.html, *.css
        \ set tabstop=2
        \ set softtabstop=2
        \ set shiftwidth=2
augroup END

" F5 To Run/Compile Stuff
augroup run_compiles_vim
    au BufEnter,BufNew *.py map <F5> :term python -i % <CR>
    au BufEnter,BufNew *.py map <F4> :silent ! python % <CR>
    au BufEnter,BufNew *.c map <F5> :term gcc -o %< % <CR>
    au BufEnter,BufNew *.cpp map <F5> :term g++ -o %< % <CR>
    au BufEnter,BufNew *.tex map <F5> :call CompileTex() <CR>
    au BufEnter,BufNew *.nec map <F5> :call RunNEC() <CR>
    au BufEnter,BufNew _vimrc map <F5> :source ~/_vimrc <CR>
    au BufEnter,BufNew _gvimrc map <F5> :source ~/_gvimrc <CR>
    au BufEnter,BufNew *.wiki map <F5> :VimwikiAll2HTML <CR>
augroup END

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Functions
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Compile LaTeX to PDF and delete logs
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! CompileTex()
    let cmd = "silent !cd \"" . expand('%:p:h') .  "\""
    let cmd .= " & pdflatex \"" . expand('%:t') . "\""
    let cmd .= " & @echo off"
    let cmd .= " & del " . expand('%:t:r') . ".log"
    let cmd .= " & del " . expand('%:t:r') . ".aux"
    let cmd .= " & del " . expand('%:t:r') . ".out"
    let cmd .= " & echo \"PDF Generated\""
    execute cmd
endfunction

" Run NEC file
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! RunNEC()
    let cmd = "!cd \"" . expand('%:p:h') .  "\""
    let cmd .= " & (echo " . expand('%:t')
    let cmd .= " & echo " . expand('%:t:r') . ".dat)"
    let cmd .= " | nec2dxs1K5.exe"
    execute cmd
endfunction

" Fullscreen mode with external dll, toggled with F11
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! ToggleFullScreen()
    if has('win32')
        :call libcallnr("gvimfullscreen.dll", "ToggleFullScreen", 0)
    endif
endfunction
map <silent> <F11> <Esc>:call ToggleFullScreen()<CR>

" Auto increment names for version control (not currently used)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! IncName(dir,ext)
    let fns = split(globpath(a:dir,expand('%:r')."_v".'*.'.a:ext),'\n')
    return expand('%:r') . "_v" . repeat(0,4-len(len(fns))).len(fns).'.'.a:ext
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin Settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Easy Align Settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap ga <Plug>(EasyAlign)
xmap ga <Plug>(EasyAlign)

" NERDTree Settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <silent> <C-f> :NERDTreeToggle<CR>
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
let g:NERDTreeQuitOnOpen = 1

" Goyo Settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:goyo_width = 79
let g:goyo_height = 75
let g:goyo_linenr = 0

" Markdown settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup md-acmd
    autocmd FileType markdown set foldexpr=NestedMarkdownFolds()
augroup END
nmap <buffer><silent> <leader>p :call mdip#MarkdownClipboardImage()<CR>


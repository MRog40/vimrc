call plug#begin('~/vimfiles/plugged')
Plug 'davur/vim-visualstudiodark'
Plug 'rafi/awesome-vim-colorschemes'
call plug#end()

syntax on                       " Highlight syntax
set scrolloff=5                 " Always have at least 5 lines
set autoread                    " Automatically load external file changes
set ignorecase                  " case-insensitive search by default (add \C)
set hls                         " Highlight search results
set wildmenu                    " Set command menu autocomplete
set vb t_vb=                    " No annoying beeping
set laststatus=2                " StatusLine
set updatetime=500              " Write swap file after 500ms
set number                      " Show current line number
set relativenumber              " Relative number lines
set nowrap                      " Don't wrap lines by default
set textwidth=0                 " Lines \inf characters long
set backspace=indent,eol,start  " Use traditional backspaces
set clipboard=unnamed           " Use system clipboard
set tabstop=4                   " 4 spaces default
set softtabstop=4
set shiftwidth=4
set nocompatible                " Reduntant I think
set expandtab                   " Spaces replace tabs
set autoindent                  " Autoindent new line
set splitbelow                  " Open splits below
set splitright                  " Open splits to the right
set fileencoding=utf-8          " utf-8 files
set fileformat=dos

set guicursor=a:blinkwait0      " No cursor blinking

set foldmethod=indent   
set foldnestmax=10
set nofoldenable
set foldlevel=2
set foldopen-=search
set fml=0

set encoding=utf-8
set hidden
set updatetime=300

" Move between splits with ctrl hjkl
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
tnoremap <C-J> <C-W>N<C-W><C-J>
tnoremap <C-K> <C-W>N<C-W><C-K>
tnoremap <C-L> <C-W>N<C-W><C-L>
tnoremap <C-H> <C-W>N<C-W><C-H>

" c then ctrl hjkl opens a new blank split
nnoremap c<C-J> :bel sp new<CR>
nnoremap c<C-K> :abo sp new<CR>
nnoremap c<C-L> :rightb vsp new<CR>
nnoremap c<C-H> :lefta vsp new<CR>

" Exit terminal input mode with esc
tnoremap <Esc> <C-W>N

set statusline=
set statusline +=\ %n\ %*            "buffer number
set statusline +=%{&ff}%*            "file format
set statusline +=%y%*                "file type
set statusline +=\ %<%F%*            "full path
set statusline +=%m%*                "modified flag
set statusline +=%=%5l%*             "current line
set statusline +=/%L%*               "total lines
set statusline +=%4v\ %*             "virtual column number
set statusline +=0x%04B\ %*          "character under cursor

set t_Co=256
set t_ut=
colorscheme visualstudiodark
set termguicolors

map <F5> :w<CR>:call RunCscsAsync('<C-R>%')<CR>

function! RunCscsAsync(file_name)
    let start_time = localtime()
    exec 'silent !start /min cmd /c "cscs '.a:file_name.' > test/out.cs 2>&1 & vim --servername '.v:servername.' --remote-expr "RunCscsCallbackAsync('."'".a:file_name."', ".l:start_time.")\" & exit"
endfunction

function! RunCscsCallbackAsync(file_name, start_time)
    checktime
    redraw!
    echomsg "Ran '".a:file_name."' in ".(localtime() - a:start_time)."s"
endfunction

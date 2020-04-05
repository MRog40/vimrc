" Michael Rogers .vimrc

" Highlight syntax
syntax on

" Color Scheme
hi VertSplit ctermfg=White ctermbg=Black
hi StatusLine ctermfg=White ctermbg=Black
hi StatusLineNC ctermfg=White ctermbg=Black

hi TabLineFill gui=NONE guibg=#181A1F guifg=#181A1F cterm=NONE term=NONE ctermfg=gray ctermbg=black
hi TabLine gui=NONE guibg=#181A1F guifg=#888888 cterm=NONE term=NONE ctermfg=gray ctermbg=black
hi TabLineSel gui=NONE guibg=#181A1F guifg=#CCCCCC cterm=NONE term=NONE ctermfg=blue ctermbg=black

syntax enable

" Number lines
set number
set tw=80

" Wrap lines
set wrap
autocmd BufNewFile,BufRead *.html setlocal nowrap

" Use spaces instead of tabs and autoindent
set tabstop=4
set shiftwidth=4
set expandtab
set autoindent

" Use traditional backspaces
set backspace=indent,eol,start

" Use system clipboard for default register
set clipboard=unnamed

" Highlight search terms
set incsearch

" Ctrl+S to save
map <C-S> :w <CR>

" Exit insert mode with keys
inoremap <esc> <nop>
inoremap jk <ESC>
inoremap kj <ESC>

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

" Open splits to the left and right, more natural
set splitbelow
set splitright

set fileencoding=utf8

" F5 To Run/Compile Stuff
augroup run_compiles
    au BufEnter,BufNew *.py map <F5> :term python % <CR>
    au BufEnter,BufNew *.c map <F5> :term gcc -o %< % <CR>
    au BufEnter,BufNew *.cpp map <F5> :term g++ -o %< % <CR>
    au BufEnter,BufNew *.tex map <F5> :call CompileTex() <CR>
    au BufEnter,BufNew *.nec map <F5> :call RunNEC() <CR>
augroup END

" F4 To Reload vimrc
map <F4> :source $MYVIMRC <CR>

" F3 To Sync to Git
map <F3> :term sync.bat <CR>

" Auto increment names for version control
function! IncName(dir,ext)
    let fns = split(globpath(a:dir,expand('%:r')."_v".'*.'.a:ext),'\n')
    return expand('%:r') . "_v" . repeat(0,4-len(len(fns))).len(fns).'.'.a:ext
    endfunction

" Compile LaTeX to PDF and delete logs
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
function! RunNEC()
    let cmd = "!cd \"" . expand('%:p:h') .  "\""
    let cmd .= " & (echo \"" . expand('%:t') . "\""
    let cmd .= " & echo \"" . expand('%:t:r') . ".dat\")"
    let cmd .= " | nec2dxs1K5.exe"
    execute cmd
endfunction

" Open files with the LF file browser
function! LF()
    let temp = tempname()
        exec 'silent !lf -selection-path=' . shellescape(temp)
    if !filereadable(temp)
        redraw!
        return
        endif
        let names = readfile(temp)
    if empty(names)
        redraw!
        return
        endif
        exec 'edit ' . fnameescape(names[0])
        for name in names[1:]
        exec 'argadd ' . fnameescape(name)
        endfor
        redraw!
endfunction
command! -bar LF call LF()

" Kite Python Autocomplete Settings
" let g:kite_tab_complete=1
" let g:kite_documentation_continual=1
"set completeopt+=menuone   " show the popup menu even when there is only 1 match
"set completeopt+=noinsert  " don't insert any text until user chooses a match
"set completeopt-=longest   " don't insert the longest common text
"set completeopt+=preview
set belloff+=ctrlg  " if vim beeps during completion
let g:kite_previous_placeholder = '<C-P>'
let g:kite_next_placeholder = '<C-N>'
set statusline=%<%f\ %h%m%r%{kite#statusline()}%=%-14.(%l,%c%V%)\ %P
set laststatus=2  " always display the status line

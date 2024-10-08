set hlsearch
set incsearch
set ignorecase smartcase
set nu
set hidden " change buffer without saving buffer.
" ';' means recursive upward search
set tag=tags;
set path=$PWD/**
set wildmenu " tab completion (visually fancy)
set suffixesadd+=.py,.sh " file extension for `gf`
" replace grep with rg
set grepprg=rg\ --vimgrep\ --smart-case\ --follow
set nocompatible
syntax on

" Tab configuration {{{
" Only do this part when compiled with support for autocommands.
if has("autocmd")
    " Use filetype detection and file-based automatic indenting.
    filetype plugin indent on

    " Use actual tab chars in Makefiles.
    autocmd FileType make set tabstop=8 shiftwidth=8 softtabstop=0 noexpandtab
endif

" For everything else, use a tab width of 4 space chars.
set tabstop=4       " The width of a TAB is set to 4.
                    " Still it is a \t. It is just that
                    " Vim will interpret it to be having
                    " a width of 4.
set shiftwidth=4    " Indents will have a width of 4.
set softtabstop=4   " Sets the number of columns for a TAB.
set expandtab       " Expand TABs to spaces.
" }}}

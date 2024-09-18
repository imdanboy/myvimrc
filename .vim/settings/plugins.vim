" vim-plugin automatic installation
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'justinmk/vim-sneak'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'preservim/nerdtree'
Plug 'preservim/tagbar'
Plug 'jeffkreeftmeijer/vim-numbertoggle'
Plug 'vimwiki/vimwiki'
Plug 'sheerun/vim-polyglot'
Plug 'tmhedberg/SimpylFold'
Plug 'zyedidia/vim-snake'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'sillybun/vim-repl'
call plug#end()

" Airline {{{
"Automatically displays all buffers when there's only one tab open.
let g:airline#extensions#tabline#enabled = 1
" }}}

" Vimwiki {{{
" color scheme for vimwiki header
highlight VimwikiHeader1 term=bold cterm=bold ctermfg=DarkRed
highlight VimwikiHeader2 term=bold cterm=bold ctermfg=DarkGreen
highlight VimwikiHeader3 term=bold cterm=bold ctermfg=DarkYellow
highlight VimwikiHeader4 term=bold cterm=bold ctermfg=DarkBlue
highlight VimwikiHeader5 term=bold cterm=bold ctermfg=DarkMagenta
highlight VimwikiHeader6 term=bold cterm=bold ctermfg=DarkCyan

let g:vimwiki_list = [
      \ {'path': '~/vimwiki', 'nested_syntaxes': {'python': 'python', 'c++': 'cpp', 'bash': 'bash'}},
      \ {'path': '~/Projects/icloud/vimwiki/', 'syntax': 'markdown', 'ext': 'md'}
    \ ]
let g:vimwiki_global_ext = 0 " make sure vimwiki doesn't own all .md files
" }}}


" vim-repl {{{
let g:repl_program = {
            \   'python': 'ipython',
            \   'default': 'zsh',
            \   'vim': 'vim -e',
            \   }
let g:repl_ipython_version = '8'
" }}}

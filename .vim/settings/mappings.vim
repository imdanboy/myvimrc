inoremap jk <Esc>
" [mapping] %:h -> %% (filename tap completion)
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'
map <space> <leader>
nnoremap <leader>ev :vsplit $MYVIMRC<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>
iabbrev @@ imdanboy@gmail.com
nnoremap <leader>tn :set relativenumber!<CR>
" NerdTree {{{
nnoremap <leader>t :NERDTreeToggle<CR>
"nnoremap <leader>f :NERDTreeFind<CR>
nnoremap <leader>n :NERDTreeFocus<CR>
" }}}
" Tagbar {{{
nmap <F8> :TagbarToggle<CR>
" }}}
" Fzf {{{
nnoremap <C-x>b :Buffers<CR>
nnoremap <silent> <C-f> :Files<CR>
nnoremap <silent> <leader>f :Rg<CR>
" }}}
" Vimwiki {{{
" original mapping (with option key) not work in mac
nnoremap <leader><left> <Plug>VimwikiTableMoveColumnLeft
nnoremap <leader><right> <Plug>VimwikiTableMoveColumnRight
" }}}
" Chinese language learning {{{
vnoremap <leader>cp "*y
nnoremap <leader>pc :call EchoPinyin2(getreg('*'))<CR>
nnoremap <leader>o :normal o<Esc>cc
nnoremap <leader>pp :call EchoPinyin2(expand('<cword>'))<CR>
nnoremap <leader>po :call OpenDict(expand('<cword>'))<CR>
nnoremap <leader>pl :call TextToSpeech(expand('<cword>'))<CR>
" }}}
" vim-repl {{{
nnoremap <leader>r :REPLToggle<Cr>
" }}}

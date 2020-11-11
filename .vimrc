set nocompatible              " be iMproved, required
filetype off                  " required

set encoding=utf-8

call plug#begin()

Plug 'ctrlpvim/ctrlp.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-haml'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-fugitive'
Plug 'jiangmiao/auto-pairs'
Plug 'zxqfl/tabnine-vim'
Plug 'vim-ruby/vim-ruby'
Plug 'zeis/vim-kolor'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'shougo/deoplete.nvim'
Plug 'janko-m/vim-test'
Plug 'tpope/vim-endwise'
Plug 'kassio/neoterm'

call plug#end()

" Show hidden files on NERDTree
let NERDTreeShowHidden = 1
let NERDTreeIgnore = ['\DS_Store$']

" Toogle NERDTree with Ctrl+n
map <C-n> :NERDTreeToggle<CR>

" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1

" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1

" Set color scheme
syntax on
colorscheme kolor

" vim kolor
let g:kolor_italic=1
let g:kolor_bold=1

" Identation setup
set expandtab
set shiftwidth=2
set softtabstop=2

" Line number
set number
" set relativenumber

" Set backspace
set backspace=indent,eol,start

" Save content to default register to paste multiple times
xnoremap p pgvy

" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

" bind K to grep word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

" bind \ (backward slash) to grep shortcut
command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!

nnoremap \ :Ag<SPACE>

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Resize window
if bufwinnr(1)
  map + <C-W>>
  map - <C-W><
  map ± <C-W>=
endif

" Trim whitespaces
fun! TrimWhitespace()
  let l:save = winsaveview()
  %s/\s\+$//e
  call winrestview(l:save)
endfun

" Run before end
autocmd BufWritePre * :call TrimWhitespace()

" Syntastic config
set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

" Highlight search results
:set hlsearch
autocmd InsertEnter * :let @/=""
autocmd InsertLeave * :let @/=""

" four space tabs for JS
autocmd Filetype javascript setlocal ts=2 sts=2 sw=2

autocmd BufNewFile,BufRead *.etl
      \ set filetype=ruby

" ctrl p use silver searcher
let g:ctrlp_user_command = 'ag %s -l --hidden --nocolor -g ""'
let g:ctrlp_use_caching = 0

" run tests
map <Leader>t :TestFile<CR>
map <Leader>r :TestNearest<CR>

" Airline theme
let g:airline_theme='deus'
let g:airline_powerline_fonts = 1

" Deoplete
let g:deoplete#enable_at_startup = 1

" Vim test
tnoremap <ESC> <C-\><C-n>

let test#strategy = "neovim"
let test#neovim#term_position = "belowright"

"""""""""""""""""""""
" Terminal Settings "
"""""""""""""""""""""

" Window navigation function
" Make ctrl-h/j/k/l move between windows and auto-insert in terminals
func! s:mapMoveToWindowInDirection(direction)
    func! s:maybeInsertMode(direction)
        stopinsert
        execute "wincmd" a:direction

        if &buftype == 'terminal'
            startinsert!
        endif
    endfunc

    execute "tnoremap" "<silent>" "<C-" . a:direction . ">"
                \ "<C-\\><C-n>"
                \ ":call <SID>maybeInsertMode(\"" . a:direction . "\")<CR>"
    execute "nnoremap" "<silent>" "<C-" . a:direction . ">"
                \ ":call <SID>maybeInsertMode(\"" . a:direction . "\")<CR>"
endfunc
for dir in ["h", "j", "l", "k"]
  call s:mapMoveToWindowInDirection(dir)
endfor

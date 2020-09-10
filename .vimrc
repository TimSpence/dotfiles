"
" original: https://gist.githubusercontent.com/simonista/8703722/raw/d08f2b4dc10452b97d3ca15386e9eed457a53c61/.vimrc
"
" also OMG https://dougblack.io/words/a-good-vimrc.html
"
" https://nvie.com/posts/how-i-boosted-my-vim/
"
" https://www.barbarianmeetscoding.com/blog/2018/10/24/exploring-vim-setting-up-your-vim-to-be-more-awesome-at-vim

" Don't try to be vi compatible
set nocompatible

filetype off

syntax on

filetype plugin indent on

" ui
set number
set ruler
set showcmd
set wildmenu
set showmatch

" search
set incsearch
set hlsearch



" leader
let mapleader=","
nnoremap <leader><space> :nohlsearch<CR>


" encoding
set encoding=utf-8

" formatting
set wrap
set textwidth=79

" download vim-plug if missing
if empty(glob("~/.vim/autoload/plug.vim"))
  silent! execute '!curl --create-dirs -fsSLo ~/.vim/autoload/plug.vim https://raw.github.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * silent! PlugInstall
endif

" plug
call plug#begin('~/.vim/plugged')

Plug 'powerline/powerline'
Plug 'sjl/badwolf'
Plug 'thoughtbot/vim-rspec'
Plug 'tomasr/molokai'
Plug 'vim-scripts/bash-support.vim'

call plug#end()

" colors
" colorscheme badwolf
colorscheme molokai
let g:badwolf_darkgutter = 1
let g:badwolf_tabline = 3


set rtp+=/usr/local/lib/python3.6/site-packages/powerline/bindings/vim
set laststatus=2
set t_Co=256

" run rspecs in vim
let g:rspec_runner = "os_x_iterm"
map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>


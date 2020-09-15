" directory management
let vimplugdir='~/.vim/plugged'
let vimautoloaddir='~/.vim/autoload'

if empty(glob(vimautoloaddir . '/plug.vim'))
  execute 'silent !curl -fLo ' . vimautoloaddir . '/plug.vim --create-dirs ' .
  \ 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall
endif

if empty(glob(vimplugdir))
  execute 'silent !mkdir -p ' . vimplugdir
endif

" centralized temp directories
if empty(glob('~/.vim/tmp/swap'))
  silent !mkdir -p ~/.vim/tmp/swap ~/.vim/tmp/backup ~/.vim/tmp/undo
endif

" apply these settings before loading sensible defaults
set nocompatible
filetype off
filetype plugin indent off

call plug#begin(vimplugdir)
  " sensible vim defaults
  Plug 'tpope/vim-sensible'

  " color schemes
  Plug 'flazz/vim-colorschemes'

  " nice colors, a little buggy though
  Plug 'kyoz/purify', { 'rtp': 'vim' }

  " popular color scheme
  Plug 'morhetz/gruvbox'

  Plug 'preservim/nerdtree'

call plug#end()

" start with dark bg
set background=dark

" editor settings
set list                           " mark unprintable characters in insert mode
set number                         " number lines
set cursorline                     " it's nice

" format settings
set nowrap                         " disable auto wrap of long lines
set expandtab                      " if saved, expands tabs to spaces
set tabstop=4
set shiftwidth=4                   " use 4 spaces for auto indenting
set shiftround

" backup/undo/history
set undolevels=100                 " undo last 100
set undodir=~/.vim/tmp/undo/
set undofile
set directory=~/.vim/tmp/swap/     " swap directory
set backupdir=~/.vim/tmp/backup/
set backup
set writebackup

" colors
set t_Co=256
colorscheme gruvbox
" save some lists to toggle through
" let nowcolors='breeze earth aqua gothic'
" let interestingcolors='simple_dark papercolor inkpot nightshimmer tender zenburn papercolor'

" use a better leader key
let mapleader=","

" start nerdtree
autocmd VimEnter * NERDTree
nnoremap <Leader>n :NERDTreeToggle<CR>

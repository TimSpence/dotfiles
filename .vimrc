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

call plug#end()

" editor settings
set list                           " mark unprintable characters in insert mode
set number                         " number lines

" backup/undo/history
set undolevels=100                 " undo last 100
set undodir=~/.vim/tmp/undo/
set undofile
set directory=~/.vim/tmp/swap/     " swap directory
set backupdir=~/.vim/tmp/backup/
set backup
set writebackup

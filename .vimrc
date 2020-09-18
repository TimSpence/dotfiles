" directory management
"
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

  " Make status bar easy on the eyes
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'

  " Aesthetic writing experience
  Plug 'junegunn/goyo.vim'

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
if (has("termguicolors"))
    set termguicolors
endif
set t_Co=256
try
    colorscheme gruvbox
catch
    colorscheme desert
endtry

" save some lists to toggle through
" let nowcolors='breeze earth aqua gothic'
" let interestingcolors='simple_dark papercolor inkpot nightshimmer tender zenburn papercolor'

" use a better leader key
let mapleader=" "

" Use airline instead of powerline
let g:airline_theme='gruvbox'
let g:airline_powerline_fonts=1
if !exists("g:airline_symbols")
  let g:airline_symbols = {}
endif
let g:airline_symbols.space = "\ua0"
" let g:airline_extensions=['tabline']           " uncomment to only load specific extensions
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#formatter='unique_tail'
let g:airline#extensions#tabline#show_buffers=1

" start nerdtree open if no file specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
nnoremap <Leader>n :NERDTreeToggle<CR>
map <Leader>h :bprevious<CR>
map <Leader>l :bnext<CR>

" automagically reload .vimrc
autocmd bufwritepost .vimrc source $MYVIMRC

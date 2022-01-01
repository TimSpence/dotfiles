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

  Plug 'chr4/nginx.vim'

  " git integration
  Plug 'tpope/vim-fugitive'

  " ansible syntax
  Plug 'pearofducks/ansible-vim'

  " terraform syntax
  Plug 'hashivim/vim-terraform'

  " manage surrounding chars
  Plug 'tpope/vim-surround'

  " .tmux.conf
  Plug 'tmux-plugins/vim-tmux'

  " Search
  Plug 'junegunn/fzf'
  Plug 'junegunn/fzf.vim'

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

  Plug 'trusktr/seti.vim'

  Plug 'preservim/nerdtree' | Plug 'Xuyuanp/nerdtree-git-plugin'

  " preserve location when reopening
  Plug 'farmergreg/vim-lastplace'

  " preview markdown in browser
  Plug 'PratikBhusal/vim-grip'

  " what is even life without emoji
  Plug 'junegunn/vim-emoji'

  " initialize files from templates
  Plug 'tibabit/vim-templates'

  " control moOde audio
  Plug 'TimSpence/vim-moode'

  " Persist sessions
  Plug 'tpope/vim-obsession'

  " Docker syntax
  Plug 'ekalinin/Dockerfile.vim'

  " Relative linenumbers
  Plug 'jeffkreeftmeijer/vim-numbertoggle'

  " Jinja
  Plug 'Glench/Vim-Jinja2-Syntax'

  " Ctags preview
  Plug 'preservim/tagbar'

call plug#end()

set completefunc=emoji#complete

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

"    " color support
"    if (has("termguicolors"))
    "    set termguicolors
"    endif
"    set t_Co=256

" colorscheme styling
set background=dark
let g:gruvbox_bold=1
let g:gruvbox_italic=0
let g:gruvbox_contrast_light='medium'
let g:gruvbox_contrast_dark='hard'
let g:gruvbox_improved_strings=0

try
    colorscheme gruvbox
catch
    colorscheme desert
endtry

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

let g:ansible_goto_role_paths = './roles,../_common/roles'

function! FindAnsibleRoleUnderCursor()
    if exists("g:ansible_goto_role_paths")
        let l:role_paths = g:ansible_goto_role_paths
    else
        let l:role_paths = "./roles"
    endif
    let l:tasks_main = expand("<cfile>") .  "/tasks/main.yml"
    let l:found_role_path = findfile(l:tasks_main, l:role_paths)
    if l:found_role_path == ""
        echo l:tasks_main . " not found"
    else
        execute "edit " .  fnameescape(l:found_role_path)
    endif
endfunction

au BufEnter,BufNewFile */*.yml nnoremap <leader>gr :call FindAnsibleRoleUnderCursor()<CR>

" start nerdtree open if no file specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
nnoremap <Leader>n :NERDTreeToggle<CR>
nnoremap <Leader>t :TagbarToggle<CR>
let NERDTreeShowHidden=1

map <Leader>h :bprevious<CR>
map <Leader>l :bnext<CR>

" search config
nnoremap <silent> <leader>o :Files<CR>
nnoremap <silent> <leader>O :Files!<CR>

" Function keys
map <f1> :Help<CR>

" Automagically reload .vimrc
" Disabled because it crashes on some terminals
" autocmd bufwritepost .vimrc source $MYVIMRC

" load machine-specific config last
if filereadable(glob("~/.vimrc.local"))
    source ~/.vimrc.local
endif

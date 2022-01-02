""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Manage temp directories.  Download and install Plugged if not
" already installed.
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let vimplugdir='~/.config/nvim/plugged'
let vimautoloaddir='~/.config/nvim/autoload'

if empty(glob(vimautoloaddir . '/plug.vim'))
  execute 'silent !curl -fLo ' . vimautoloaddir . '/plug.vim --create-dirs ' .
  \ 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall
endif

if empty(glob(vimplugdir))
  execute 'silent !mkdir -p ' . vimplugdir
endif

if empty(glob('~/.config/nvim/tmp/swap'))
  silent !mkdir -p ~/.config/nvim/tmp/swap ~/.config/nvim/tmp/backup ~/.config/nvim/tmp/undo
endif

set undolevels=100
set undodir=~/.config/nvim/tmp/undo/
set undofile
set directory=~/.config/nvim/tmp/swap/
set backupdir=~/.config/nvim/tmp/backup/
set backup
set writebackup

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Load plugins
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin(vimplugdir)
  "
  " sensible vim defaults
  "
  Plug 'tpope/vim-sensible'
  Plug 'farmergreg/vim-lastplace'

  "
  " syntax, formatting, etc...
  "
  Plug 'chr4/nginx.vim'
  Plug 'pearofducks/ansible-vim'
  Plug 'hashivim/vim-terraform'
  Plug 'ekalinin/Dockerfile.vim'
  Plug 'Glench/Vim-Jinja2-Syntax'
  Plug 'tibabit/vim-templates'
  Plug 'junegunn/vim-emoji'
  Plug 'tmux-plugins/vim-tmux'

  "
  " command automation, etc...
  "
  Plug 'tpope/vim-obsession'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-fugitive'
  Plug 'PratikBhusal/vim-grip'
  Plug 'preservim/nerdtree' | Plug 'Xuyuanp/nerdtree-git-plugin'
  Plug 'preservim/tagbar'

  " Search
  Plug 'junegunn/fzf'
  Plug 'junegunn/fzf.vim'

  "
  " Appearance, colors, etc...
  "
  Plug 'jeffkreeftmeijer/vim-numbertoggle'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'flazz/vim-colorschemes'
  Plug 'kyoz/purify', { 'rtp': 'vim' }
  Plug 'morhetz/gruvbox'

  " Aesthetic writing experience
  Plug 'junegunn/goyo.vim'

  Plug 'trusktr/seti.vim'
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

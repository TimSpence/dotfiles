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

set undolevels=100
set undofile
set backup

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

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Configure NerdTree
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" start nerdtree open if no file specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
let NERDTreeShowHidden=1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Ansible role navigation
"  TO DO: delete this. Use tags instead
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Key bindings
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let mapleader=" "
nnoremap <Leader>n :NERDTreeToggle<CR>
map <Leader>h :bprevious<CR>
map <Leader>l :bnext<CR>
nnoremap <silent> <leader>o :Files<CR>
nnoremap <silent> <leader>O :Files!<CR>
map <f1> :Help<CR>
map <f8> :TagbarToggle<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" editor settings
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set list                           " mark unprintable characters in insert mode
set number                         " number lines
set cursorline                     " it's nice
set nowrap                         " disable auto wrap of long lines
" TO DO: try out smarttab and smart indent
set expandtab                      " if saved, expands tabs to spaces
set tabstop=4
set shiftwidth=4                   " use 4 spaces for auto indenting
set shiftround

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" colorschemes, themes
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" TO DO:
" this was broken in vim, so test it in neovim
"" color support
"if (has("termguicolors"))
"  set termguicolors
"endif
"set t_Co=256

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

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" misc
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set completefunc=emoji#complete

" TO DO:
" test this in neovim
" Automagically reload .vimrc
" Disabled because it crashes on some terminals
" autocmd bufwritepost .vimrc source $MYVIMRC

if filereadable(glob("~/.config/nvim/init.vim.local"))
    source ~/.config/nvim/init.vim.local
endif

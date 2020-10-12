if [ -f ~/.shell_aliases ]; then
  source ~/.shell_aliases
fi

export BAT_PAGER='less -RF'
FZF_OS_X_EXCLUDE='--exclude Library'
FD_OPTIONS="--follow --hidden --exclude .git ${FZF_OS_X_EXCLUDE}"

export FZF_DEFAULT_OPTS=" \
    --bind='ctrl-d:half-page-down' \
    --bind='ctrl-u:half-page-up' \
    --bind='f2:toggle-preview' \
    --border \
    --height 40% \
    --info=inline \
    --layout=reverse \
    --multi \
    --preview='bat --style=numbers --color=always {} 2>/dev/null | head -300' \
    --preview-window='right:wrap'
    "
export FZF_DEFAULT_COMMAND="fd --type file ${FD_OPTIONS}"
export FZF_CTRL_T_COMMAND="fd ${FD_OPTIONS}"
export FZF_ALT_C_COMMAND="fd --type d ${FD_OPTIONS}"

# Use fd (https://github.com/sharkdp/fd) instead of the default find
# command for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
    fd --hidden --follow --exclude ".git" . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
    fd --type d --hidden --follow --exclude ".git" . "$1"
}

export RIPGREP_CONFIG_PATH="${HOME}/.config/ripgrep"

# History control
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory
setopt hist_ignore_dups

# bindings
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# zinit
source ~/.zinit/bin/zinit.zsh
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

zinit ice compile'(pure|async).zsh' pick'async.zsh' src'pure.zsh' ver'3d379f1138af82f41a0a31c12428dd449bafed9c'
zinit light TimSpence/pure

zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-completions

zinit light zlsun/solarized-man

zinit light zsh-users/zsh-history-substring-search
zinit light zsh-users/zsh-syntax-highlighting

if ! command -v dircolors >/dev/null 2>&1; then
 alias dircolors='gdircolors'
fi
zinit ice atclone"dircolors -b LS_COLORS > c.zsh" atpull'%atclone' pick"c.zsh" nocompile'!'
zinit light trapd00r/LS_COLORS

# Pure prompt
fpath+=$HOME/.zinit/plugins/TimSpence---pure
autoload -U promptinit; promptinit
prompt pure
# change defaults
zstyle :prompt:pure:path color cyan

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# TO DO: ensure PATH includes ~/.fzf/bin

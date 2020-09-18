if [ -f ~/.shell_aliases ]; then
  source ~/.shell_aliases
fi

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
fpath+=$HOME/.zinit/plugins/sindresorhus---pure
autoload -U promptinit; promptinit
prompt pure
# change defaults
zstyle :prompt:pure:path color cyan

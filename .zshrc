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

# zplug
# https://github.com/zplug/zplug
if [ -d ~/.zplug ]; then
  source ~/.zplug/init.zsh

  zplug "mafredi/zsh-async", from:github
  zplug "TimSpence/pure", use:pure.zsh, from:github, as:theme, at:d16b94d006ebf2541ad5981abbc7e2ef97d09060
  zplug "zlsun/solarized-man"
  zplug "joel-porquet/zsh-dircolors-solarized"

  zplug "zsh-users/zsh-autosuggestions"
  zplug "zsh-users/zsh-completions"

  # these have to be at end of .zshrc, and in this order
  zplug "zsh-users/zsh-syntax-highlighting", defer:2
  zplug "zsh-users/zsh-history-substring-search"

  zplug load # --verbose
fi

# Pure prompt
# https://github.com/TimSpence/pure
fpath+=$HOME/.zplug/repos/TimSpence/pure
autoload -U promptinit; promptinit
prompt pure
# change defaults
zstyle :prompt:pure:path color cyan

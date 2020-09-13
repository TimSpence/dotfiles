if [ -f ~/.shell_aliases ]; then
  source ~/.shell_aliases
fi

# History control
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory
setopt hist_ignore_dups

# zplug
# https://github.com/zplug/zplug
if [ -d ~/.zplug ]; then
  source ~/.zplug/init.zsh

  zplug "mafredi/zsh-async", from:github, use:async.zsh
  zplug "sindresorhus/pure", use:pure.zsh, from:github, as:theme

  zplug "zsh-users/zsh-completions"
  zplug "zsh-users/zsh-syntax-highlighting", defer:2

  zplug load # --verbose
fi

# Pure prompt
# https://github.com/sindresorhus/pure
if [ -d ~/.zsh/pure ]; then
  fpath+=$HOME/.zsh/pure
  autoload -U promptinit; promptinit
  prompt pure

  # change defaults
  zstyle :prompt:pure:path color cyan
fi

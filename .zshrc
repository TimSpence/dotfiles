if [ -f ~/.shell_aliases ]; then
  source ~/.shell_aliases
fi

# History control
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory
setopt hist_ignore_dups


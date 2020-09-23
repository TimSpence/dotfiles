# Setup fzf
# ---------
if [[ ! "$PATH" == */Users/tim/.fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/Users/tim/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/Users/tim/.fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/Users/tim/.fzf/shell/key-bindings.zsh"

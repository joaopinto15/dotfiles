# If not running interactively, don't do anything (leave this at the top of this file)
[[ $- != *i* ]] && return

# All the default Omarchy aliases and functions
# (don't mess with these directly, just overwrite them here!)
source ~/.local/share/omarchy/default/bash/rc

# Reload bash
r() {
  source ~/.bashrc
}

# Auto-start tmux when opening an interactive terminal
if command -v tmux >/dev/null 2>&1 &&
  [ -z "$TMUX" ] &&
  [[ $- == *i* ]]; then
  tmux attach -t main || tmux new -s main
fi

# Development aliases
alias task='go-task' # task script language
alias y=yadm         # yadm dotfiles manager
alias k='kubectl'    # kubectl tool for kubernetes

source <(kubectl completion bash) # kubectl completions
complete -o default -F __start_kubectl

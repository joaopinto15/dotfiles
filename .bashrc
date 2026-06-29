# If not running interactively, don't do anything (leave this at the top of this file)
[[ $- != *i* ]] && return

# All the default Omarchy aliases and functions
# (don't mess with these directly, just overwrite them here!)
source ~/.local/share/omarchy/default/bash/rc

# Reload bash
r() {
  source ~/.bashrc
}
# Neovim aliases
alias zed=zeditor
alias vim=nvim

# Development aliases
alias task='go-task' # task script language
alias y=yadm         # yadm dotfiles manager
alias k='kubectl'    # kubectl tool for kubernetes

